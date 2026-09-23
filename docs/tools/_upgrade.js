// 给 manual-api.js 的函数条目补 p（参数表）字段
// 做法：载入 → 内存中修改 → 序列化回文件（绝不做正则替换）
const fs = require('fs');
const vm = require('vm');
const path = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const log = (...a) => LOG.push(a.join(' '));

// --- 源码 @arg 表 ---
const srcArgs = new Map();
fs.readFileSync(path + '_srcargs.txt', 'utf8').split('\n').forEach(l => {
  const m = l.match(/^(\S+)\s+<=\s+(.+)$/);
  if (m) srcArgs.set(m[1], m[2]);
});

const DICT = require('./_paramdict.js');

// 把 arg 名字转成一行 [名称, 类型, 说明]
function argRow(rawArg) {
  const optional = rawArg.startsWith('*') || rawArg.endsWith('*');
  const name = rawArg.replace(/^\*+/, '').replace(/\*+$/, '').trim();
  const key = name.replace(/\s+/g, '');
  const hit = DICT[key];
  if (hit) {
    const row = hit.slice();
    // 展示名不带源码里的可选标记 *
    row[0] = String(row[0]).replace(/\*+$/, '').trim();
    if (optional && !row[1].includes('可选')) row[1] = row[1] + '（可选）';
    return row;
  }
  // 通用兜底
  return [name, '—', optional ? '可选参数' : '见源码'];
}

// 条目 n → 候选函数名（处理 "A / B / C" 合并写法与前缀继承）
function candidates(n) {
  const raw = String(n).replace(/\(.*?\)/g, '').trim();
  const parts = raw.split('/').map(s => s.trim()).filter(Boolean);
  const full = parts[0];
  const prefix = (full.match(/^([A-Za-z]+_)/) || [])[1] || '';
  const names = [full];
  parts.slice(1).forEach(p => {
    const clean = p.replace(/\*+$/, '').trim();
    if (/^[A-Z]/.test(clean) && !clean.includes('_')) names.push(prefix + clean);
    else names.push(clean);
  });
  return names;
}

// --- 载入数据 ---
const apiSrc = fs.readFileSync(path + 'manual-api.js', 'utf8');
const sandbox = { console };
sandbox.window = sandbox;
vm.createContext(sandbox);
vm.runInContext(apiSrc, sandbox);
const API = sandbox.API;

let added = 0, skipped = 0;
const reports = [];

API.functions.forEach(f => {
  if (f.p) { skipped++; return; }          // 已有 p，保持不动
  const names = candidates(f.n);
  const rows = [];
  names.forEach(nm => {
    const spec = srcArgs.get(nm);
    if (!spec) return;
    // "a,b,c" 切分，但 "enemy_obj/inst" 这种内部斜杠要保住
    const args = spec.split(',').map(s => s.trim()).filter(Boolean);
    args.forEach(a => rows.push(argRow(a)));
  });
  if (!rows.length) { skipped++; return; }

  // 去重（同一名字可能重复出现）
  const seen = new Set();
  const uniq = rows.filter(r => {
    const k = r[0] + '|' + r[1];
    if (seen.has(k)) return false;
    seen.add(k); return true;
  });
  // 两列 vs 三列：若存在有意义的类型就用三列
  const hasType = uniq.some(r => r[1] && r[1] !== '—' && !/^（可选）$/.test(r[1]));
  f.p = hasType ? uniq.map(r => [r[0], r[1], r[2]]) : uniq.map(r => [r[0], r[2]]);
  added++;
  reports.push(f.n + ' -> ' + f.p.length + ' 行');
});

log('补 p 字段: ' + added + ' 条');
log('跳过: ' + skipped + ' 条');
log('');
reports.forEach(r => log('  ' + r));

// --- 序列化回写 ---
// manual-api.js 首行是 window.API = {...}; 我们用 JSON + 少量整形重建
const header = '/* eslint-disable */\n// Undertale-Engine-Ultra 手册数据 · 自动生成 + 手工维护\n// 结构见 _TODO.md\n';
const body = 'window.API = ' + JSON.stringify(API, null, 1) + ';\n';

fs.writeFileSync(path + '_upgrade-report.txt', LOG.join('\n'), 'utf8');
fs.writeFileSync(path + 'manual-api.js', header + body, { encoding: 'utf8' });
console.log('added', added, 'skipped', skipped);
