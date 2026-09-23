// 变量说明覆盖率检查：源码变量 vs _vardict.js
// 输出 tools/_varcheck.txt
const fs = require('fs');
const P = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/tools/';
const vars = JSON.parse(fs.readFileSync(P + '_objvars.json', 'utf8'));
const D = require(P + '_vardict.js');

const missing = [];
let total = 0, hit = 0;
for (const [obj, arr] of Object.entries(vars)) {
  for (const v of arr) {
    total++;
    const byObj = D.byObj[obj + '|' + v.n];
    const byName = D.shared[v.n];
    if (byObj || byName) hit++;
    else missing.push({ obj, n: v.n, v: v.v, note: v.note });
  }
}
const L = [];
L.push('变量说明覆盖率');
L.push('总变量条目: ' + total);
L.push('已覆盖: ' + hit);
L.push('未覆盖: ' + missing.length + '（唯一名 ' + new Set(missing.map(m => m.n)).size + '）');
L.push('');
L.push('--- 未覆盖明细（按物体）---');
const byObj = {};
missing.forEach(m => (byObj[m.obj] = byObj[m.obj] || []).push(m));
Object.entries(byObj).sort((a, b) => b[1].length - a[1].length).forEach(([o, arr]) => {
  L.push('');
  L.push('=== ' + o + ' (' + arr.length + ') ===');
  arr.forEach(m => L.push('  ' + m.n + ' = ' + m.v + (m.note ? '   // ' + m.note : '')));
});
fs.writeFileSync(P + '_varcheck.txt', L.join('\n'), 'utf8');
console.log('总 ' + total + ' | 已覆盖 ' + hit + ' | 未覆盖 ' + missing.length + '（唯一名 ' + new Set(missing.map(m => m.n)).size + '）');
