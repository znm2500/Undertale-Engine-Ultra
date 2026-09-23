// 精确提取每个物体的实例变量（顶格赋值，排除 enum / function / var / 局部）
// 输出 tools/_objvars.json + tools/_objvars.txt
const fs = require('fs');
const ROOT = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/';
const OROOT = ROOT + 'objects/';

const dirs = fs.readdirSync(OROOT, { withFileTypes: true })
  .filter(e => e.isDirectory()).map(e => e.name).sort();

const result = {};

for (const name of dirs) {
  const p = OROOT + name + '/Create_0.gml';
  if (!fs.existsSync(p)) { result[name] = []; continue; }
  const lines = fs.readFileSync(p, 'utf8').split(/\r?\n/);
  const out = [];
  const seen = new Set();
  let enumDepth = 0;

  for (const raw of lines) {
    const cm = raw.match(/\/\/\s*(.+)$/);
    const note = cm ? cm[1].trim() : '';
    const line = raw.replace(/\/\/.*$/, '');
    if (!line.trim()) continue;

    // enum 块：跳过整块
    if (/^\s*enum\s+[A-Za-z_]\w*\s*\{/.test(line)) { enumDepth++; continue; }
    if (enumDepth > 0) {
      if (/\}/.test(line)) enumDepth--;
      continue;
    }

    // 只取「顶格」（列 0 无缩进）的赋值行 —— Create 顶层实例变量都是顶格
    const m = line.match(/^([A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)?)\s*(\[[^\]]*\])?\s*=\s*([^=].*?);\s*$/);
    if (!m) continue;
    if (/^var$|^self$|^global$/.test(m[1])) continue;
    if (/^function\s/.test(line)) continue;
    // 排除方法定义： name = function(...)
    if (/^[A-Za-z_][A-Za-z0-9_]*\s*=\s*function\s*\(/.test(line)) continue;

    let key = m[1];
    const def = (m[3] || '').trim().slice(0, 50);
    // 排除 var/静态声明
    if (/^var\s/.test(line)) continue;
    // 只保留纯变量名或 global.xxx；其它 a.b 形式是给子实例的字段赋值，不算实例变量
    if (key.includes('.') && !key.startsWith('global.')) continue;

    if (seen.has(key)) continue;
    seen.add(key);
    out.push({ n: key, v: def, note: note });
  }
  result[name] = out;
}

fs.writeFileSync(ROOT + 'docs/tools/_objvars.json', JSON.stringify(result, null, 1), 'utf8');

// 汇总统计
const allNames = new Map();
let total = 0;
for (const [k, arr] of Object.entries(result)) {
  total += arr.length;
  arr.forEach(x => allNames.set(x.n, (allNames.get(x.n) || 0) + 1));
}
const L = [];
L.push('物体变量精确提取');
L.push('物体数: ' + dirs.length);
L.push('变量条目总数: ' + total + '（含跨物体重复）');
L.push('去重变量名: ' + allNames.size);
L.push('');
const top = [...allNames.entries()].sort((a, b) => b[1] - a[1]);
L.push('--- 复用度 >= 3 的变量名 ---');
top.filter(([, c]) => c >= 3).forEach(([n, c]) => L.push('  ' + String(c).padStart(3) + '  ' + n));
L.push('');
L.push('--- 每个物体的变量清单（含默认值 / 源码注释）---');
Object.entries(result).sort((a, b) => a[0].localeCompare(b[0]))
  .forEach(([k, arr]) => {
    L.push('');
    L.push('=== ' + k + ' (' + arr.length + ') ===');
    arr.forEach(x => L.push('  ' + x.n + ' = ' + x.v + (x.note ? '   // ' + x.note : '')));
  });
fs.writeFileSync(ROOT + 'docs/tools/_objvars.txt', L.join('\n'), 'utf8');

console.log('变量条目总数: ' + total + ' | 去重变量名: ' + allNames.size);
console.log('battle_bullet_bone_3d: ' + result['battle_bullet_bone_3d'].length + ' 个 -> ' + result['battle_bullet_bone_3d'].map(x => x.n).join(', '));
console.log('text_typer: ' + result['text_typer'].length + ' 个');
console.log('world: ' + result['world'].length + ' 个 -> ' + result['world'].map(x => x.n).join(', '));
