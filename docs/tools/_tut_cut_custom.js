// 第八轮追加：按用户要求，删除「引擎速览」末尾的「改造入口：*_Custom」段落与「核心心法」tip
const fs = require('fs');

const DOCS = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const HTML = DOCS + 'index.html';
const LOGP = DOCS + 'tools/_tut_cut_custom.txt';

const lines = [];
function log(x) { lines.push(x); console.log(x); }

// ---------- 0. 备份 ----------
const BAK = DOCS + '_bak8-index.html';
fs.copyFileSync(HTML, BAK);
log('备份完成: _bak8-...html');

// ---------- 1. 双解析器解析 TUT_SECTIONS ----------
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
if (arrA.length !== 1 || arrA[0].h !== '引擎速览') throw new Error('预期教程仅 1 节「引擎速览」，实际不符');

// ---------- 2. 锚点定位 + 截断 ----------
const body = arrA[0].body;
const anchorIdx = body.indexOf('<h4>改造入口');
if (anchorIdx < 0) throw new Error('未找到「<h4>改造入口」锚点');
// 向前吃掉紧邻的空白，让截断点落在上一段 </p> 之后
let cut = anchorIdx;
while (cut > 0 && (body[cut - 1] === '\n' || body[cut - 1] === ' ' || body[cut - 1] === '\r' || body[cut - 1] === '\t')) cut--;
const tail = body.slice(anchorIdx);
// 截断前先验明 tail 确实是要删的两块且位于末尾
if (!tail.includes('核心心法')) throw new Error('tail 缺「核心心法」，锚点异常');
if (!tail.includes('*_Custom</code> 系列脚本')) throw new Error('tail 缺 *_Custom 段，锚点异常');
if (tail.slice(-6) !== '</div>') throw new Error('tail 末尾不是 </div>，截断点不在文末: ' + JSON.stringify(tail.slice(-30)));
if (tail.indexOf('核心心法') < tail.indexOf('</h4>')) throw new Error('「核心心法」出现在 h4 之前，结构异常');

const removed = body.slice(cut);
arrA[0].body = body.slice(0, cut).replace(/\s+$/, '');
log('已删除片段字节数: ' + Buffer.byteLength(removed));
log('删除片段开头: ' + JSON.stringify(removed.slice(0, 60)));
log('删除片段结尾: ' + JSON.stringify(removed.slice(-60)));
log('保留 body 结尾: ' + JSON.stringify(arrA[0].body.slice(-60)));

// ---------- 3. 写回 ----------
html = html.replace(lineRe, 'const TUT_SECTIONS = ' + JSON.stringify(arrA) + ';');
fs.writeFileSync(HTML, html, { encoding: 'utf8' });
const newBytes = Buffer.byteLength(fs.readFileSync(HTML, 'utf8'));
log('HTML 写回: ' + oldBytes + ' -> ' + newBytes + ' bytes');

// ---------- 4. 写回后重读断言 ----------
const html2 = fs.readFileSync(HTML, 'utf8');
const m2 = html2.match(lineRe);
if (!m2) throw new Error('写回后 TUT_SECTIONS not found');
const arr2 = JSON.parse(m2[1].replace(/;\s*$/, ''));
if (arr2.length !== 1) throw new Error('写回后章节数 != 1');
['改造入口', '核心心法', '_Custom', 'Macro_Game', '事件驱动的黑箱', 'Battle_SetTurnInfo'].forEach(k => {
  if (arr2[0].body.includes(k)) throw new Error('残留关键词: ' + k);
});
if (!arr2[0].body.includes('数据层：四级存储')) throw new Error('误删：数据层段落丢失');
if (!arr2[0].body.endsWith('</p>')) throw new Error('body 结尾异常');
log('重读断言通过: 两块已删净，其余内容完好');
log('ALL OK');
fs.writeFileSync(LOGP, lines.join('\n'), { encoding: 'utf8' });
