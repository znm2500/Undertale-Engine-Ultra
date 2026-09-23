// 为「待写介绍」的函数提取源码函数体样本，便于准确撰写介绍
// 输出 tools/_bodies.txt
const fs = require('fs');
const ROOT = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/';
const DOC = ROOT + 'docs/';
const SROOT = ROOT + 'scripts/';
const OROOT = ROOT + 'objects/';

const plan = JSON.parse(fs.readFileSync(DOC + 'tools/_plan-fn.json', 'utf8'));
const todo = plan.filter(p => !p.desc);

// 建立 脚本名 -> 源码 缓存
const srcCache = new Map();
function loadScript(file) {
  if (srcCache.has(file)) return srcCache.get(file);
  let s = null;
  try { s = fs.readFileSync(SROOT + file, 'utf8'); } catch (e) { s = ''; }
  srcCache.set(file, s);
  return s;
}

function bodyOf(src, name, kind, memName) {
  const target = kind === 'method' ? memName : name;
  const re = new RegExp((kind === 'method' ? '^[ \\t]+' : '^') + 'function\\s+' + target + '\\s*\\(', 'm');
  const m = re.exec(src);
  if (!m) return '(未找到)';
  const lines = src.slice(m.index).split(/\r?\n/).slice(0, 9);
  return lines.map(l => '      ' + l.trim()).filter((l, i) => i === 0 || l.trim()).join('\n');
}

const L = [];
L.push('待撰写介绍的函数：' + todo.length);
L.push('');
for (const p of todo) {
  L.push('### ' + p.name + '   [' + p.cat + ']   ' + p.file);
  if (p.params.length) L.push('   参数: ' + p.params.join(', '));
  const src = loadScript(p.file);
  L.push(bodyOf(src, p.name, p.kind, p.memName));
  L.push('');
}
fs.writeFileSync(DOC + 'tools/_bodies.txt', L.join('\n'), 'utf8');
console.log('已提取', todo.length, '个函数的源码样本');
