// 第六轮：按用户要求，删除教程「引擎的启动流程」及其后全部章节，教程仅保留「引擎速览」
// 同步修改：教程页导语、引擎速览内文引用、_verify.js 教程断言、_TODO.md 交接笔记
// 全程 Node utf8；先备份；双解析器交叉验证；写回后重读断言。日志写 _tut_trim.txt
const fs = require('fs');
const path = require('path');

const DOCS = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const HTML = DOCS + 'index.html';
const VERIFY = DOCS + 'tools/_verify.js';
const TODO = DOCS + '_TODO.md';
const LOGP = DOCS + 'tools/_tut_trim.txt';

const lines = [];
function log(x) { lines.push(x); console.log(x); }

// ---------- 0. 备份 ----------
const BAK_HTML = DOCS + '_bak7-index.html';
const BAK_VERIFY = DOCS + 'tools/_verify.js.bak';
const BAK_TODO = DOCS + '_TODO.md.bak';
fs.copyFileSync(HTML, BAK_HTML);
fs.copyFileSync(VERIFY, BAK_VERIFY);
fs.copyFileSync(TODO, BAK_TODO);
log('备份完成: _bak7-...html / _verify.js.bak / _TODO.md.bak');

// ---------- 1. 解析 TUT_SECTIONS（双解析器交叉验证） ----------
let html = fs.readFileSync(HTML, 'utf8');
const oldBytes = Buffer.byteLength(html);
const lineRe = /^const TUT_SECTIONS = (.*)$/m;
const mA = html.match(lineRe);
if (!mA) throw new Error('TUT_SECTIONS not found (line regex)');
const arrA = JSON.parse(mA[1].replace(/;\s*$/, ''));

const START = 'const TUT_SECTIONS = ';
const start = html.indexOf(START + '[') + START.length;
let depth = 0, inStr = false, esc = false, end = -1;
for (let i = start; i < html.length; i++) {
  const ch = html[i];
  if (esc) { esc = false; continue; }
  if (inStr) {
    if (ch === '\\') esc = true;
    else if (ch === '"') inStr = false;
    continue;
  }
  if (ch === '"') inStr = true;
  else if (ch === '[' || ch === '{') depth++;
  else if (ch === ']' || ch === '}') { depth--; if (depth === 0) { end = i; break; } }
}
if (end < 0) throw new Error('parser B: 括号未配平，拒绝写入');
const arrB = JSON.parse(html.slice(start, end + 1));
if (JSON.stringify(arrA) !== JSON.stringify(arrB)) throw new Error('双解析器结果不一致，拒绝写入');
log('双解析器交叉验证一致，章节数 = ' + arrA.length);
if (arrA.length !== 14) throw new Error('预期 14 节，实际 ' + arrA.length + '，拒绝写入');
log('原章节: ' + arrA.map(x => x.h).join(' | '));

// ---------- 2. 精简 ----------
if (arrA[0].h !== '引擎速览') throw new Error('第 1 节不是「引擎速览」: ' + arrA[0].h);
const ov = arrA[0];

// 2a. lead 修正（原文提到「后面的教程」，删完只剩一节）
const LEAD_OLD = '先花三分钟认识项目里有什么、代码怎么组织，后面的教程都会用到这些概念。';
const LEAD_NEW = '先花三分钟认识项目里有什么、代码怎么组织，后面的写法都建立在这些概念上。';
if (ov.lead !== LEAD_OLD) throw new Error('lead 原文不匹配: ' + ov.lead);
ov.lead = LEAD_NEW;

// 2b. body 中对已删章节的引用：world「下节详述」→ 指向物体页
if (!ov.body.includes('（下节详述）')) throw new Error('未找到「（下节详述）」');
ov.body = ov.body.replace('（下节详述）', '（详见「物体」页的 world）');

const newArr = [ov];
log('保留章节: ' + newArr.map(x => x.h).join(' | '));

// ---------- 3. 写回 HTML ----------
html = html.replace(lineRe, 'const TUT_SECTIONS = ' + JSON.stringify(newArr) + ';');

// 3b. 教程页导语去掉「启动流程」表述
const DESC_OLD = '本教程讲清引擎的整体结构与启动流程；各系统的具体写法见「示例」页，函数与物体细节见「函数」「物体」页。';
const DESC_NEW = '本教程讲清引擎的整体结构；各系统的具体写法见「示例」页，函数与物体细节见「函数」「物体」页。';
if (!html.includes(DESC_OLD)) throw new Error('教程导语原文不匹配');
html = html.replace(DESC_OLD, DESC_NEW);

fs.writeFileSync(HTML, html, { encoding: 'utf8' });
const newBytes = Buffer.byteLength(fs.readFileSync(HTML, 'utf8'));
log('HTML 写回: ' + oldBytes + ' -> ' + newBytes + ' bytes（删了 13 节，缩减属预期）');

// ---------- 4. 写回后重读断言 ----------
const html2 = fs.readFileSync(HTML, 'utf8');
const m2 = html2.match(lineRe);
if (!m2) throw new Error('写回后 TUT_SECTIONS not found');
const arr2 = JSON.parse(m2[1].replace(/;\s*$/, ''));
if (arr2.length !== 1) throw new Error('写回后章节数 != 1: ' + arr2.length);
if (arr2[0].h !== '引擎速览') throw new Error('写回后首节不是「引擎速览」');
if (arr2[0].body.includes('下节详述')) throw new Error('「下节详述」残留');
if (html2.includes('引擎的启动流程')) throw new Error('「引擎的启动流程」残留于 HTML');
if (html2.includes('整体结构与启动流程')) throw new Error('导语旧文残留');
log('重读断言通过: 章节数=1, 仅「引擎速览」, 无残留引用');

// ---------- 5. _verify.js 断言同步 ----------
let vf = fs.readFileSync(VERIFY, 'utf8');
const V_OLD1 = "  ['教程含「引擎的启动流程」章节', hTut.includes('引擎的启动流程')],";
const V_NEW1 = "  ['教程只保留「引擎速览」一节', hTut.includes('引擎速览') && !hTut.includes('引擎的启动流程')],";
const V_OLD2 = "  ['教程章节数 >= 14', HTML_TUT_COUNT >= 14],";
const V_NEW2 = "  ['教程章节数 == 1', HTML_TUT_COUNT === 1],";
if (!vf.includes(V_OLD1)) throw new Error('_verify.js 断言1原文不匹配');
if (!vf.includes(V_OLD2)) throw new Error('_verify.js 断言2原文不匹配');
vf = vf.replace(V_OLD1, V_NEW1).replace(V_OLD2, V_NEW2);
fs.writeFileSync(VERIFY, vf, { encoding: 'utf8' });
log('_verify.js 断言已同步（教程==1 节）');

// ---------- 6. _TODO.md 交接笔记同步 ----------
let td = fs.readFileSync(TODO, 'utf8');
const T1_OLD = '> 状态：**已完成（2026-09-21 第五轮：内容充分性 —— 变量表逐条写全 + 补讲引擎启动流程）** · 最后更新：2026-09-21';
const T1_NEW = '> 状态：**已完成（2026-09-21 第六轮：教程精简 —— 按用户要求删除「引擎的启动流程」及其后全部章节，仅保留「引擎速览」）** · 最后更新：2026-09-21';
const T2_OLD = '教程 **14 节**（`TUT_SECTIONS` 数据驱动）';
const T2_NEW = '教程 **1 节**（`TUT_SECTIONS` 数据驱动）';
const T3_OLD = '- `教程含「引擎的启动流程」章节`';
const T3_NEW = '- ~~`教程含「引擎的启动流程」章节`~~（第六轮已删该断言，现为「教程只保留「引擎速览」一节」）';
const T4_OLD = '- `教程章节数 >= 14`';
const T4_NEW = '- ~~`教程章节数 >= 14`~~（第六轮已删该断言，现为「教程章节数 == 1」）';
const ANCHOR = '## 交付物（均在 `docs/`）';
const T5_NEW = [
  '## 第六轮（2026-09-21）：教程精简',
  '',
  '按用户要求，删除教程「引擎的启动流程」一节及其后全部章节，**教程仅保留第 1 节「引擎速览」**（14 → 1 节）。同步修改：教程页导语（去掉「启动流程」表述）、引擎速览内文对已删章节的引用（「下节详述」→「详见「物体」页的 world」）、`_verify.js` 两条教程断言。脚本：`tools/_tut_trim.js`（自动备份 `_bak7-…html` / `_verify.js.bak` / `_TODO.md.bak`）。',
  '',
].join('\n') + ANCHOR;
[T1_OLD, T2_OLD, T3_OLD, T4_OLD, ANCHOR].forEach((k, i) => { if (!td.includes(k)) throw new Error('_TODO.md 锚点' + (i + 1) + '不匹配: ' + k); });
td = td.replace(T1_OLD, T1_NEW).replace(T2_OLD, T2_NEW).replace(T3_OLD, T3_NEW).replace(T4_OLD, T4_NEW).replace(ANCHOR, T5_NEW);
fs.writeFileSync(TODO, td, { encoding: 'utf8' });
log('_TODO.md 已同步');

log('ALL OK');
fs.writeFileSync(LOGP, lines.join('\n'), { encoding: 'utf8' });
