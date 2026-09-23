// 第九轮：按用户要求清空示例数据（待重写）
// 1) manual-examples.js -> window.EXAMPLES = []（原 14 个示例备份 _bak9）
// 2) _verify.js 三条示例断言改为空态断言
// 3) _TODO.md 状态行 + 交付物表 + 新增第九轮小节
const fs = require('fs');

const DOCS = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const EX = DOCS + 'manual-examples.js';
const VERIFY = DOCS + 'tools/_verify.js';
const TODO = DOCS + '_TODO.md';
const LOGP = DOCS + 'tools/_ex_clear.txt';

const lines = [];
function log(x) { lines.push(x); console.log(x); }

// ---------- 1. 备份并清空 manual-examples.js ----------
const BAK = DOCS + '_bak9-manual-examples.js';
fs.copyFileSync(EX, BAK);
const oldSize = Buffer.byteLength(fs.readFileSync(EX, 'utf8'));
const NEW_EX = [
  '/* =========================================================================',
  '   UT/DR — UNDERTALE Engine Ultra  ·  可玩示例集',
  '   2026-09-21 第九轮：示例数据已按用户要求清空，待重新编写。',
  '   原 14 个示例完整备份于 _bak9-manual-examples.js。',
  '   手册的示例页渲染代码、筛选栏、侧栏入口均原样保留，EXAMPLES 为空时自动显示',
  '   「没有匹配的条目」空态，不会报错。重写时按 _bak9 里的条目结构填回本文件即可：',
  '   { id, title, level(入门/进阶/实用/必读), scene, files:[{t,b}], code:[{t,b,lang}] }',
  '   ========================================================================= */',
  'window.EXAMPLES = [];',
  '',
].join('\n');
fs.writeFileSync(EX, NEW_EX, { encoding: 'utf8' });
log('manual-examples.js: ' + oldSize + ' -> ' + Buffer.byteLength(NEW_EX) + ' bytes（原文件备份 _bak9）');

// ---------- 2. _verify.js 断言同步 ----------
let vf = fs.readFileSync(VERIFY, 'utf8');
const pairs = [
  ["  ['示例全部 有内容', hEx.length > 2000],",
   "  ['示例视图 空态正常', hEx.includes('没有匹配的条目')],"],
  ["  ['示例全部 有 4 个分级小标题', (hEx.match(/class=\"exgrt\"/g) || []).length === 4],",
   "  ['示例分级标题为 0（已清空）', (hEx.match(/class=\"exgrt\"/g) || []).length === 0],"],
  ["  ['示例详情 有返回链接', hOne.includes('返回示例列表')],",
   "  ['示例详情 空态回落正常', hOne.includes('没有匹配的条目')],"],
];
pairs.forEach(([a, b], i) => {
  if (!vf.includes(a)) throw new Error('_verify.js 断言' + (i + 1) + '原文不匹配: ' + a);
  vf = vf.replace(a, b);
});
fs.writeFileSync(VERIFY, vf, { encoding: 'utf8' });
log('_verify.js 三条示例断言已改为空态断言');

// ---------- 3. _TODO.md 同步 ----------
fs.copyFileSync(TODO, DOCS + '_TODO.md.bak2');
let td = fs.readFileSync(TODO, 'utf8');
const tdLines = td.split('\n');
let nStatus = 0, nExRow = 0;
for (let i = 0; i < tdLines.length; i++) {
  if (tdLines[i].includes('第八轮：教程精简 ——') && tdLines[i].startsWith('> 状态：')) {
    tdLines[i] = '> 状态：**已完成（2026-09-21 第九轮：清空示例数据 —— 按用户要求删除全部 14 个示例，待重新编写；教程此前已精简为仅「引擎速览」一节）** · 最后更新：2026-09-21';
    nStatus++;
  }
  if (tdLines[i].includes('`docs/manual-examples.js`')) {
    tdLines[i] = '| `docs/manual-examples.js` | 已清空 | **示例数据待重写**（`window.EXAMPLES = []`；原 14 个示例备份于 `_bak9-manual-examples.js`，渲染代码与筛选 UI 原样保留，空数据自动显示空态） |';
    nExRow++;
  }
}
if (nStatus !== 1) throw new Error('_TODO.md 状态行匹配数异常: ' + nStatus);
if (nExRow !== 1) throw new Error('_TODO.md 示例表行匹配数异常: ' + nExRow);
td = tdLines.join('\n');
const R9 = [
  '## 第九轮（2026-09-21）：清空示例数据',
  '',
  '按用户要求删除示例页全部 14 个示例（`manual-examples.js` → `window.EXAMPLES = []`），**待重新编写**。原数据完整备份于 `_bak9-manual-examples.js`；手册的示例页渲染代码、分级筛选、侧栏入口原样保留，空数据时自动显示「没有匹配的条目」。`_verify.js` 三条示例断言同步改为空态断言（示例视图空态正常 / 分级标题为 0 / 详情空态回落）。重写时按 `_bak9` 的条目结构填回即可。',
  '',
].join('\n');
const anchor9 = '## 第八轮（2026-09-21）：教程精简';
if (!td.includes(anchor9)) throw new Error('_TODO.md 第八轮锚点不匹配');
td = td.replace(anchor9, R9 + anchor9);
fs.writeFileSync(TODO, td, { encoding: 'utf8' });
log('_TODO.md 状态行/交付物表/第九轮小节已同步');

// ---------- 4. 写回后重读断言 ----------
const ex2 = fs.readFileSync(EX, 'utf8');
if (!ex2.includes('window.EXAMPLES = [];')) throw new Error('写回后 EXAMPLES 置空缺失');
const vf2 = fs.readFileSync(VERIFY, 'utf8');
if (vf2.includes('hEx.length > 2000') || vf2.includes('length === 4]') || vf2.includes('返回示例列表')) throw new Error('_verify.js 旧断言残留');
log('重读断言通过');
log('ALL OK');
fs.writeFileSync(LOGP, lines.join('\n'), { encoding: 'utf8' });
