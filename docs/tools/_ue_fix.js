// User Event 编号口径修正（源码实证）：
//   Battle_CallEnemyEvent 用 event_user(枚举值) 直调 → IDE 里的 User Event 编号 = BATTLE_ENEMY_EVENT 枚举值（0~13）
//   .yy 事件文件名 Other_10~Other_23（GMS2 规则 Other_10 = User Event 0），此前手册把文件号当成了 User Event 编号（10~23），全库修正。
// 涉及：manual-api.js（enemyEvents 表 14 条编号 / battle_enemy 卡 / battle_enemy_test 卡 / snippets 2 条）+ 手册 HTML 教程速览表格
const fs = require('fs');
const vm = require('vm');

const DOCS = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const APIP = DOCS + 'manual-api.js';
const HTML = DOCS + 'UNDERTALE-Engine-Ultra-手册.html';
const LOGP = DOCS + 'tools/_ue_fix.txt';

const lines = [];
function log(x) { lines.push(x); console.log(x); }

// ---------- 0. 备份 ----------
fs.copyFileSync(APIP, DOCS + '_bak10-manual-api.js');
fs.copyFileSync(HTML, DOCS + '_bak10-UNDERTALE-Engine-Ultra-手册.html');
log('备份完成: _bak10-manual-api.js / _bak10-...html');

// ---------- 1. manual-api.js：载入 → 内存改 ----------
const ctx = { window: {} };
vm.createContext(ctx);
vm.runInContext(fs.readFileSync(APIP, 'utf8'), ctx, { filename: 'manual-api.js' });
const API = ctx.window.API;
if (!API || !API.enemyEvents || !API.objects || !API.snippets) throw new Error('API 结构异常');

// 1a. enemyEvents 14 条编号：10~23 → 0~13
if (API.enemyEvents.length !== 14) throw new Error('enemyEvents 数量异常: ' + API.enemyEvents.length);
API.enemyEvents.forEach((row, i) => {
  if (row[1] !== String(10 + i)) throw new Error('enemyEvents[' + i + '] 编号异常: ' + row[1] + '（预期 ' + (10 + i) + '）');
  row[1] = String(i);
});
log('enemyEvents 14 条编号: 10~23 -> 0~13');

// 1b. battle_enemy 卡描述
const be = API.objects.find(o => o.n === 'battle_enemy');
if (!be || !be.d || !be.d.includes('User Event 10~23')) throw new Error('battle_enemy 卡原文不匹配');
be.d = '所有敌人的父物体。事件通过 User Event 0~13 回调，与 BATTLE_ENEMY_EVENT 枚举一一对应：IDE 里的 User Event 编号 = 枚举值（INIT=0 … BOARD_RESETTING_END=13），对应 .yy 事件文件 Other_10~Other_23。';

// 1c. battle_enemy_test 卡描述 + 变量表说明（与源码核对：UE8 生成 turn_test，并非「打印与断言」）
const bet = API.objects.find(o => o.n === 'battle_enemy_test');
if (!bet || !bet.d || !bet.d.includes('调试样例')) throw new Error('battle_enemy_test 卡原文不匹配');
bet.d = '引擎自带的演示敌人，继承自 battle_enemy，无精灵、无自有变量。它在 User Event 8（TURN_PREPARATION_START）里每回合生成 turn_test 演示物体：矩形战斗框 + 蓝色灵魂，回合里按空格 / 左 Alt / 小键盘 0 分别体验骨头长度动画、紫色灵魂轨道、龙骨炮齐射。引擎默认遭遇 0 的 enemy_0 就是它，Encounter_Start(0) 即可直接跑通遭遇战。';
if (!bet.v || !bet.v[0] || !bet.v[0][1].includes('打印与断言')) throw new Error('battle_enemy_test 变量表原文不匹配');
bet.v[0][1] = '无自有变量；仅有的逻辑是 User Event 8（TURN_PREPARATION_START）里生成 turn_test 演示物体';
log('battle_enemy / battle_enemy_test 卡片已按源码修正');

// 1d. snippets 两条代码片段的注释编号
const ef = API.snippets.enemyFull, cb = API.snippets.customBullet;
const efPairs = [
  ['User Event 10 · INIT', 'User Event 0 · INIT'],
  ['User Event 18 · TURN_PREPARATION_START', 'User Event 8 · TURN_PREPARATION_START'],
  ['User Event 20 · TURN_START', 'User Event 10 · TURN_START'],
  ['User Event 21 · TURN_END', 'User Event 11 · TURN_END'],
];
const cbPairs = [
  ['User Event 10 · SOUL_COLLISION', 'User Event 0 · SOUL_COLLISION'],
  ['User Event 11 · TURN_END', 'User Event 1 · TURN_END'],
];
efPairs.forEach(([a, b], i) => { if (!ef.includes(a)) throw new Error('enemyFull 锚点' + i + '缺失: ' + a); });
cbPairs.forEach(([a, b], i) => { if (!cb.includes(a)) throw new Error('customBullet 锚点' + i + '缺失: ' + a); });
API.snippets.enemyFull = efPairs.reduce((s, [a, b]) => s.replace(a, b), ef);
API.snippets.customBullet = cbPairs.reduce((s, [a, b]) => s.replace(a, b), cb);
log('snippets.enemyFull / customBullet 编号已修正');

// ---------- 2. 回写 manual-api.js ----------
const out = 'window.API = ' + JSON.stringify(API, null, 3) + ';\n';
fs.writeFileSync(APIP, out, { encoding: 'utf8' });
log('manual-api.js 回写: ' + Buffer.byteLength(out) + ' bytes');

// 2b. 重读断言
const ctx2 = { window: {} };
vm.createContext(ctx2);
vm.runInContext(fs.readFileSync(APIP, 'utf8'), ctx2, { filename: 'manual-api.js(reread)' });
const A2 = ctx2.window.API;
if (A2.enemyEvents[0][1] !== '0' || A2.enemyEvents[13][1] !== '13') throw new Error('重读: enemyEvents 编号不对');
const joined = JSON.stringify(A2);
['User Event 10~23', '枚举值 + 10', 'User Event 10 · INIT', 'User Event 18', 'User Event 20', 'User Event 21', '打印与断言'].forEach(k => {
  if (joined.includes(k)) throw new Error('重读: 旧口径残留: ' + k);
});
if (!A2.objects.find(o => o.n === 'battle_enemy').d.includes('User Event 0~13')) throw new Error('重读: battle_enemy 卡未更新');
log('manual-api.js 重读断言通过');

// ---------- 3. HTML 教程速览表格同步 ----------
let html = fs.readFileSync(HTML, 'utf8');
const lineRe = /^const TUT_SECTIONS = (.*)$/m;
const mA = html.match(lineRe);
if (!mA) throw new Error('TUT_SECTIONS not found');
const arrA = JSON.parse(mA[1].replace(/;\s*$/, ''));
const start = html.indexOf('const TUT_SECTIONS = [') + 'const TUT_SECTIONS = '.length;
let depth = 0, inStr = false, esc = false, end = -1;
for (let i = start; i < html.length; i++) {
  const ch = html[i];
  if (esc) { esc = false; continue; }
  if (inStr) { if (ch === '\\') esc = true; else if (ch === '"') inStr = false; continue; }
  if (ch === '"') inStr = true;
  else if (ch === '[' || ch === '{') depth++;
  else if (ch === ']' || ch === '}') { depth--; if (depth === 0) { end = i; break; } }
}
if (end < 0) throw new Error('括号未配平');
if (JSON.stringify(JSON.parse(html.slice(start, end + 1))) !== JSON.stringify(arrA)) throw new Error('双解析器不一致');
if (arrA.length !== 1 || arrA[0].h !== '引擎速览') throw new Error('教程结构异常');

const UE_OLD = '在 User Event 10~23 里写回合逻辑';
const UE_NEW = '在 User Event 0~13 里写回合逻辑';
if (!arrA[0].body.includes(UE_OLD)) throw new Error('教程速览原文不匹配');
arrA[0].body = arrA[0].body.replace(UE_OLD, UE_NEW);
html = html.replace(lineRe, 'const TUT_SECTIONS = ' + JSON.stringify(arrA) + ';');
fs.writeFileSync(HTML, html, { encoding: 'utf8' });

const html2 = fs.readFileSync(HTML, 'utf8');
const arr2 = JSON.parse(html2.match(lineRe)[1].replace(/;\s*$/, ''));
if (!arr2[0].body.includes(UE_NEW) || arr2[0].body.includes(UE_OLD)) throw new Error('HTML 重读断言失败');
log('教程速览表格 User Event 编号已同步');
log('ALL OK');
fs.writeFileSync(LOGP, lines.join('\n'), { encoding: 'utf8' });
