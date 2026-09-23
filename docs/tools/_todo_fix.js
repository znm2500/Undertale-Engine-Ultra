// 修正 _TODO.md 轮次编号：本轮实为第八轮（此前日志已有第六轮=术语修正、第七轮=合并行清理）
const fs = require('fs');
const TODO = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/_TODO.md';
const LOGP = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/tools/_todo_fix.txt';
const lines = [];
let td = fs.readFileSync(TODO, 'utf8');
const pairs = [
  ['2026-09-21 第六轮：教程精简', '2026-09-21 第八轮：教程精简'],
  ['## 第六轮（2026-09-21）：教程精简', '## 第八轮（2026-09-21）：教程精简'],
  ['（第六轮已删该断言，现为「教程只保留「引擎速览」一节」）', '（第八轮已删该断言，现为「教程只保留「引擎速览」一节」）'],
  ['（第六轮已删该断言，现为「教程章节数 == 1」）', '（第八轮已删该断言，现为「教程章节数 == 1」）'],
];
pairs.forEach(([a, b], i) => {
  if (!td.includes(a)) throw new Error('锚点' + (i + 1) + '不匹配: ' + a);
  td = td.replace(a, b);
});
fs.writeFileSync(TODO, td, { encoding: 'utf8' });
lines.push('轮次编号已修正: 第六轮 -> 第八轮（4 处）');
lines.push('ALL OK');
fs.writeFileSync(LOGP, lines.join('\n'), { encoding: 'utf8' });
