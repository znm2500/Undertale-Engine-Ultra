// 变量表修复（2026-09-21）：
// 1) 清除术语修正打磨规则重复叠加产生的「战斗战斗…」
// 2) 处理「合并行」与「单变量行」并存的冗余：
//    - 合并行说明含增量信息（默认值/警示/对应关系）→ 追加到各组成变量的单行说明，再删合并行
//    - 纯概括合并行 → 直接删
// 合并行只存在于旧数据表（old.v），不在 _apply 加载的字典（D2=_descobj*.js）里，删除后重跑管线不会复活。
// 运行：node docs/tools/_fix_vrows.js
const fs = require('fs');
const P = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';

fs.copyFileSync(P + 'manual-api.js', P + '_bak6-manual-api.js');

global.window = {};
require(P + 'manual-api.js');
const A = window.API;

// ---- 1. 清「战斗战斗」叠加 ----
let cleanCount = 0;
function destack(s) {
  if (typeof s !== 'string') return s;
  let out = s, guard = 0;
  while (s.includes('战斗战斗') && guard++ < 10) { s = s.split('战斗战斗').join('战斗'); }
  if (out !== s) cleanCount++;
  return s;
}
function walkStr(o) {
  if (typeof o === 'string') return destack(o);
  if (Array.isArray(o)) return o.map(walkStr);
  if (o && typeof o === 'object') { for (const k in o) o[k] = walkStr(o[k]); }
  return o;
}
A.functions.forEach(walkStr);
A.objects.forEach(walkStr);
A.objectsGroups.forEach(walkStr);
A.categories.forEach(walkStr);

// ---- 2. 合并行处置 ----
const HAS_INFO = /默认|小心|避免|还原|对齐|读自|维护|打雷|累计|一一对应|相对|过渡|由内部函数/;
let merged = 0, deleted = 0;
const mergeLog = [], delLog = [];
A.objects.forEach(o => {
  if (!o.v) return;
  const keep = [];
  const names = () => new Set(keep.map(r => String(r[0]).trim()));
  for (const r of o.v) {
    const n = String(r[0]).trim();
    if (!n.includes(' / ')) { keep.push(r); continue; }
    const parts = n.split('/').map(s => s.trim().replace(/ 等$/, ''));
    if (parts.length < 2 || !parts.every(p => names().has(p))) { keep.push(r); continue; }
    const desc = String(r[1] || '');
    if (HAS_INFO.test(desc)) {
      // 并入各组成行
      parts.forEach(p => {
        const row = keep.find(x => String(x[0]).trim() === p);
        if (row && !String(row[1]).includes(desc)) row[1] = String(row[1]) + '；' + desc;
      });
      merged++;
      mergeLog.push(o.n + ' | ' + n);
    } else {
      deleted++;
      delLog.push(o.n + ' | ' + n);
    }
  }
  o.v = keep;
});

fs.writeFileSync(P + 'manual-api.js',
  '/* eslint-disable */\n// Undertale-Engine-Ultra 手册数据 · 自动生成 + 人工维护 · 结构见 _TODO.md\nwindow.API = ' + JSON.stringify(A, null, 1) + ';\n', { encoding: 'utf8' });

console.log('「战斗战斗」清理字段数:', cleanCount);
console.log('合并行：并入单行', merged, '处 | 直接删除', deleted, '处');
console.log('-- 并入明细 --'); mergeLog.forEach(x => console.log('  +', x));
console.log('-- 删除明细 --'); delLog.forEach(x => console.log('  -', x));

// 自检
const left = JSON.stringify(A).match(/战斗战斗/g);
const dupRows = [];
A.objects.forEach(o => {
  if (!o.v) return;
  const names = new Set(o.v.map(r => String(r[0]).trim()));
  o.v.forEach(r => {
    const n = String(r[0]).trim();
    if (!n.includes(' / ')) return;
    const parts = n.split('/').map(s => s.trim().replace(/ 等$/, ''));
    if (parts.length > 1 && parts.every(p => names.has(p))) dupRows.push(o.n + ':' + n);
  });
});
console.log('残留「战斗战斗」:', left ? left.length : 0, '| 残留冗余合并行:', dupRows.length);
