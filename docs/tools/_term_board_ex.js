// 术语修正 · 示例与教程版：
// 1) manual-examples.js —— 「面板」→「战斗框」（示例里全部是战斗框语境）
// 2) HTML 内联 TUT_SECTIONS —— 战斗面板→战斗框；global.Panel 行改为 FIGHT 攻击条
// 运行：node docs/tools/_term_board_ex.js
const fs = require('fs');
const P = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';

// ---------- 1. manual-examples.js ----------
{
  const p = P + 'manual-examples.js';
  let s = fs.readFileSync(p, 'utf8');
  const n = s.split('面板').length - 1;
  s = s.split('面板').join('战斗框');
  fs.writeFileSync(p, s, { encoding: 'utf8' });
  console.log('manual-examples.js 面板→战斗框:', n, '处');
}

// ---------- 2. HTML TUT_SECTIONS ----------
{
  const FILE = P + 'index.html';
  let html = fs.readFileSync(FILE, 'utf8');

  const KEY = 'const TUT_SECTIONS = [';
  const i = html.indexOf(KEY);
  if (i < 0) throw new Error('找不到 TUT_SECTIONS');
  const start = i + KEY.length - 1;
  let depth = 0, end = -1, inStr = false, esc = false;
  for (let k = start; k < html.length; k++) {
    const c = html[k];
    if (inStr) {
      if (esc) esc = false;
      else if (c === '\\') esc = true;
      else if (c === '"') inStr = false;
      continue;
    }
    if (c === '"') { inStr = true; continue; }
    if (c === '[' || c === '{') depth++;
    else if (c === ']' || c === '}') { depth--; if (depth === 0) { end = k; break; } }
  }
  if (end < 0) throw new Error('数组未闭合');

  const arr = JSON.parse(html.slice(start, end + 1));
  let n = 0;
  const hits = [];
  function walk(o, path) {
    if (typeof o === 'string') {
      if (o.includes('面板')) {
        o.split('面板').slice(1).forEach(()=>hits.push(path));
        o = o.split('战斗面板').join('战斗框').split('面板').join('战斗框');
        n++;
      }
      return o;
    }
    if (Array.isArray(o)) return o.map((v, k) => walk(v, path + '[' + k + ']'));
    if (o && typeof o === 'object') { const r = {}; for (const k in o) r[k] = walk(o[k], path + '.' + k); return r; }
    return o;
  }
  const out = walk(arr, '$');
  console.log('TUT_SECTIONS 含「面板」的字符串:', n, '处');
  hits.slice(0, 20).forEach(h => console.log('  ', h));
  // 展示每处修改的上下文供人工过目
  function diff(o, r, path) {
    if (typeof o === 'string') { if (o !== r) console.log('  [' + path + ']', o.slice(0, 60), '->', r.slice(0, 60)); return; }
    if (Array.isArray(o)) o.forEach((v, k) => diff(v, r[k], path + '[' + k + ']'));
    else if (o && typeof o === 'object') for (const k in o) diff(o[k], r[k], path + '.' + k);
  }
  diff(arr, out, '$');

  html = html.slice(0, start) + JSON.stringify(out) + html.slice(end + 1);
  fs.writeFileSync(FILE, html, { encoding: 'utf8' });
  console.log('HTML 已写回，大小 ' + (fs.statSync(FILE).size / 1024).toFixed(1) + ' KB');
}
