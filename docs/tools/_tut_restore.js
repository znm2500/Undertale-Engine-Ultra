// 教程修复：从 _bak3（13 章完整备份）恢复被截断丢失的 12 章，与当前「启动流程」章合并为 14 章。
// 用法：node docs/tools/_tut_restore.js --dry  （只打印替换上下文）
//       node docs/tools/_tut_restore.js        （真正写回）
const fs = require('fs');
const P = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const DRY = process.argv.includes('--dry');

// 双解析器：括号配平 + 朴素 '];'，两者必须一致，否则中止（防止再次截断）
function parseArray(html, label) {
  const KEY = 'const TUT_SECTIONS = [';
  const i = html.indexOf(KEY);
  if (i < 0) throw new Error(label + ': 找不到 TUT_SECTIONS');
  const start = i + KEY.length - 1;
  // 括号配平
  let depth = 0, end = -1, inStr = false, esc = false;
  for (let k = start; k < html.length; k++) {
    const c = html[k];
    if (inStr) { if (esc) esc = false; else if (c === '\\') esc = true; else if (c === '"') inStr = false; continue; }
    if (c === '"') { inStr = true; continue; }
    if (c === '[' || c === '{') depth++;
    else if (c === ']' || c === '}') { depth--; if (depth === 0) { end = k; break; } }
  }
  if (end < 0) throw new Error(label + ': 括号未闭合');
  const arr = JSON.parse(html.slice(start, end + 1));
  // 朴素解析交叉验证
  const j = html.indexOf('];', i);
  if (j !== end) throw new Error(label + ': 两种解析器结尾不一致（naive ' + (j - i) + ' vs scan ' + (end - i) + '）—— 文件可能含内嵌 ];，拒绝处理');
  const arr2 = JSON.parse(html.slice(start, j + 1));
  if (arr.length !== arr2.length) throw new Error(label + ': 两种解析器章节数不一致');
  return { arr, start, end };
}

const curHtml = fs.readFileSync(P + 'UNDERTALE-Engine-Ultra-手册.html', 'utf8');
const bak3 = fs.readFileSync(P + '_bak3-UNDERTALE-Engine-Ultra-手册.html', 'utf8');
const cur = parseArray(curHtml, '当前');
const old = parseArray(bak3, '_bak3');

console.log('当前章节数:', cur.arr.length, '|', cur.arr.map(s => s.h).join(' / '));
console.log('_bak3 章节数:', old.arr.length, '|', old.arr.map(s => s.h).join(' / '));

// 重建：[当前引擎速览(已修术语), 当前启动流程, ..._bak3 除引擎速览外的 12 章]
const restored = [cur.arr[0], cur.arr[1], ...old.arr.slice(1)];
// 防御：若 _bak3 里也有启动流程章（不应该），去重
const seen = new Set();
const dedup = restored.filter(s => { if (seen.has(s.h)) { console.log('丢弃重复章节:', s.h); return false; } seen.add(s.h); return true; });
console.log('重建后章节数:', dedup.length, '|', dedup.map(s => s.h).join(' / '));
if (dedup.length < 14) throw new Error('重建后不足 14 章，中止');

// 恢复章节的术语修正（这些章节来自术语修正之前），先打印所有命中供人工过目
let fixCount = 0;
const fixed = dedup.map((s, i) => {
  if (i < 2) return s; // 前 2 章来自当前文件，已修
  const str = JSON.stringify(s);
  if (!str.includes('面板')) return s;
  // 打印上下文
  (str.match(/.{0,22}面板.{0,22}/g) || []).forEach(h => console.log('  [' + s.h + ']', h));
  const walk = o => {
    if (typeof o === 'string') { fixCount += (o.match(/面板/g) || []).length; return o.split('战斗面板').join('战斗框').split('面板').join('战斗框'); }
    if (Array.isArray(o)) return o.map(walk);
    if (o && typeof o === 'object') { const r = {}; for (const k in o) r[k] = walk(o[k]); return r; }
    return o;
  };
  return walk(s);
});
console.log('恢复章节内 面板→战斗框:', fixCount, '处');

if (DRY) { console.log('（dry 模式，未写回）'); process.exit(0); }

// 写回：替换当前文件的数组字面量
fs.copyFileSync(P + 'UNDERTALE-Engine-Ultra-手册.html', P + '_bak5-UNDERTALE-Engine-Ultra-手册.html');
const html2 = curHtml.slice(0, cur.start) + JSON.stringify(dedup) + curHtml.slice(cur.end + 1);
fs.writeFileSync(P + 'UNDERTALE-Engine-Ultra-手册.html', html2, { encoding: 'utf8' });

// 自检：用 verify 同款朴素解析再读一遍
const check = parseArray(fs.readFileSync(P + 'UNDERTALE-Engine-Ultra-手册.html', 'utf8'), '写回后');
console.log('写回后章节数:', check.arr.length, '| 大小', (fs.statSync(P + 'UNDERTALE-Engine-Ultra-手册.html').size / 1024).toFixed(1), 'KB');
if (check.arr.length !== dedup.length) throw new Error('写回后章节数不符！');
console.log('OK');
