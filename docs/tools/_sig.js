// 扫描全部全局函数：真实签名参数 + ///@arg 说明 + 函数体首行注释
// 输出 tools/_sig.txt / tools/_sig.json
const fs = require('fs');
const nodePath = require('path');
const ROOT = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/';
const SCRIPT_ROOT = ROOT + 'scripts/';

// 从 '(' 之后开始配平，取回参数串（可跨行）
function extractParams(src, openIdx) {
  let depth = 0, out = '';
  for (let i = openIdx; i < src.length; i++) {
    const ch = src[i];
    if (ch === '(') { depth++; if (depth === 1) continue; }
    else if (ch === ')') { depth--; if (depth === 0) return out; }
    if (depth >= 1) out += ch;
  }
  return out;
}

// 按顶层逗号切分
function splitParams(s) {
  const out = [];
  let depth = 0, cur = '';
  for (const ch of s) {
    if ('([{'.includes(ch)) depth++;
    else if (')]}'.includes(ch)) depth--;
    if (ch === ',' && depth === 0) { out.push(cur); cur = ''; }
    else cur += ch;
  }
  out.push(cur);
  return out
    .map(x => x.replace(/\s*=\s*[\s\S]*$/, '').trim())   // 去默认值
    .map(x => x.trim())
    .filter(x => /^[A-Za-z_]/.test(x));
}

const dirs = fs.readdirSync(SCRIPT_ROOT);
const results = [];
const seen = new Set();

for (const d of dirs) {
  const p = nodePath.join(SCRIPT_ROOT, d);
  if (!fs.statSync(p).isDirectory()) continue;
  for (const g of fs.readdirSync(p).filter(f => f.endsWith('.gml'))) {
    const src = fs.readFileSync(nodePath.join(p, g), 'utf8');

    // ---- ///@arg 块归属 ----
    const argDoc = new Map();
    let pending = null;
    for (const raw of src.split(/\r?\n/)) {
      const L = raw.trim();
      const m = L.match(/^\/\/\/\s*@arg\s+(.+)$/);
      if (m) { (pending = pending || []).push(m[1].trim()); continue; }
      const fm = L.match(/^function\s+([A-Za-z_][A-Za-z0-9_]*)/);
      if (fm) { if (pending && !argDoc.has(fm[1])) argDoc.set(fm[1], pending); pending = null; continue; }
      if (L && !L.startsWith('///') && !L.startsWith('//')) pending = null;
    }

    // ---- 顶格 function 定义 ----
    const re = /^function\s+([A-Za-z_][A-Za-z0-9_]*)\s*\(/gm;
    let m;
    while ((m = re.exec(src)) !== null) {
      const name = m[1];
      if (seen.has(name)) continue;
      seen.add(name);
      const openIdx = m.index + m[0].length - 1;          // 指向 '('
      const params = splitParams(extractParams(src, openIdx));

      // 函数体首行注释
      let hint = '';
      const after = src.slice(openIdx, openIdx + 3000).split(/\r?\n/);
      for (let i = 1; i < Math.min(after.length, 24); i++) {
        const L = after[i].trim();
        if (L.startsWith('///')) { hint = L.replace(/^\/+\s*/, ''); break; }
        if (L.startsWith('//')) { hint = L.replace(/^\/+\s*/, ''); break; }
        if (L.startsWith('{') || /[;{]/.test(L)) { /* 继续找 */ }
      }

      results.push({
        name, file: d + '/' + g, params,
        argDoc: argDoc.get(name) || null,
        hint,
      });
    }
  }
}

results.sort((a, b) => a.name.localeCompare(b.name));
fs.writeFileSync(ROOT + 'docs/tools/_sig.json', JSON.stringify(results, null, 1), 'utf8');

const L = [];
L.push('全局函数总数: ' + results.length);
L.push('有真实参数: ' + results.filter(r => r.params.length).length);
L.push('无参数: ' + results.filter(r => !r.params.length).length);
L.push('有 @arg 说明: ' + results.filter(r => r.argDoc).length);
L.push('');
for (const r of results) {
  L.push('### ' + r.name + '  [' + r.file + ']');
  L.push('  参数: ' + (r.params.length ? r.params.join(', ') : '(无)'));
  if (r.argDoc) L.push('  @arg: ' + r.argDoc.join(' | '));
  if (r.hint) L.push('  注释: ' + r.hint);
}
fs.writeFileSync(ROOT + 'docs/tools/_sig.txt', L.join('\n'), 'utf8');
console.log('functions:', results.length,
  '| withParams:', results.filter(r => r.params.length).length,
  '| withArgDoc:', results.filter(r => r.argDoc).length);
