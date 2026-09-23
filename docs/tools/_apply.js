// 把全量函数 / 物体数据合并进 manual-api.js
// 数据来源：tools/_plan-fn.json（函数清单）+ _desc.js（介绍）+ _paramdict*.js（参数说明）
//          tools/_plan-obj.json（物体清单）+ _descobj.js（介绍+变量表）
const fs = require('fs');
const vm = require('vm');
const ROOT = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/';
const DOC = ROOT + 'docs/';
const P = DOC + 'tools/';

const D1 = Object.assign({}, require(P + '_desc.js'), require(P + '_descfix.js'), require(P + '_descfix2.js'));
const D2 = Object.assign({}, require(P + '_descobj.js'), require(P + '_descobj2.js'), require(P + '_descobj3.js'));
const VD = require(P + '_vardict.js');                       // 变量说明字典（shared / byObj）
const OBJVARS = JSON.parse(fs.readFileSync(P + '_objvars.json', 'utf8'));   // 源码侧变量全集
const DICT = Object.assign({}, require(P + '_paramdict.js'), require(P + '_paramdict2.js'));
const planFn = JSON.parse(fs.readFileSync(P + '_plan-fn.json', 'utf8'));
const planOb = JSON.parse(fs.readFileSync(P + '_plan-obj.json', 'utf8'));

// ---- 现有数据 ----
const sb = { window: {}, console }; vm.createContext(sb);
vm.runInContext(fs.readFileSync(DOC + 'manual-api.js', 'utf8'), sb);
const API = sb.window.API;

// 函数名 -> 原条目（用于继承 ex / hot）
const oldByFn = new Map();
API.functions.forEach(f => {
  const raw = String(f.n).replace(/\*+$/g, '').trim();
  const parts = raw.split('/').map(s => s.trim()).filter(Boolean);
  if (!parts.length) return;
  const full = parts[0];
  const prefix = (full.match(/^([A-Za-z]+_)/) || [])[1] || '';
  [full, ...parts.slice(1).map(p => {
    const c = p.replace(/\*+$/g, '').trim();
    return (/^[A-Z]/.test(c) && !c.includes('_')) ? prefix + c : c;
  })].forEach(n => { if (!oldByFn.has(n)) oldByFn.set(n, f); });
});
const oldObjBy = new Map(API.objects.map(o => [String(o.n).trim(), o]));

// ---- 参数表生成 ----
function cleanArg(a) {
  return String(a).replace(/^\*+/, '').replace(/\*+$/, '').replace(/\s*=\s*[\s\S]*$/, '').trim();
}
// 把 "x,y,length,..." 这种整行 @arg 拆开
function expandArgs(list) {
  const out = [];
  for (const a of list) {
    const s = String(a).trim();
    // 含逗号且看起来是参数列表（无中文）才拆
    if (s.includes(',') && !/[\u4e00-\u9fa5]/.test(s)) {
      s.split(',').forEach(x => { const t = x.trim(); if (t) out.push(t); });
    } else out.push(s);
  }
  return out;
}
function argRow(rawArg) {
  const variadic = /\.\.\.\s*$/.test(String(rawArg));      // @arg 里的 "name..." 表示可传多个
  const optional = rawArg.startsWith('*') || rawArg.endsWith('*');
  const name = cleanArg(rawArg).replace(/\.\.\.\s*$/, '').trim();
  if (!name) return null;
  const key = name.replace(/\s+/g, '');
  const hit = DICT[key];
  if (hit) {
    const row = hit.slice();
    if (optional && !String(row[1]).includes('可选')) row[1] = row[1] + '（可选）';
    if (variadic && !String(row[2]).includes('多个')) row[2] = row[2] + ' 可一次传入多个。';
    return row;
  }
  if (variadic) return [name, '—', '可变参数，可一次传入多个'];
  return [name, '—', optional ? '可选参数' : '见源码'];
}
function buildParamTable(params) {
  const list = expandArgs(params || []);
  const rows = [];
  const seen = new Set();
  for (const a of list) {
    const r = argRow(a);
    if (!r) continue;
    if (seen.has(r[0])) continue;   // 同名参数只留一次
    seen.add(r[0]);
    rows.push(r);
  }
  return rows;
}
function buildSignature(name, params) {
  const list = expandArgs(params || []);
  if (!list.length) return name + '()';
  const parts = list.map(a => {
    const opt = a.startsWith('*') || a.endsWith('*');
    const n = cleanArg(a) || a;
    return opt ? '[' + n + ']' : n;
  });
  return name + '(' + parts.join(', ') + ')';
}

// ---- 重建 functions ----
const newFunctions = [];
for (const it of planFn) {
  const old = oldByFn.get(it.name);
  const d = D1[it.name] || it.desc || null;
  if (!d) { console.error('!! 缺介绍:', it.name); continue; }
  const e = {
    c: it.cat,
    n: it.name,
  };
  // 签名：始终以源码/ @arg 解析结果为准；仅当新解析为空参、而旧签名带内容时才回退沿用旧签名
  const built = buildSignature(it.kind === 'method' ? it.memName : it.name, it.params);
  const oldSame = old && String(old.n).trim() === it.name;
  if (oldSame && /\(\s*\)$/.test(built) && old.s && !/\(\s*\)$/.test(String(old.s))) e.s = old.s;
  else e.s = built;
  const p = buildParamTable(it.params);
  e.d = d;
  e.p = p;                       // 空数组 = 已确认无需参数
  if (old && old.ex) e.ex = old.ex;
  if (old && old.hot) e.hot = true;
  newFunctions.push(e);
}

// ---- 重建 objects ----
// 分组 id 规范化：world -> map（与物体 world 同名易混淆，见 _planobj.js）
const GROUP_RENAME = { world: 'map' };
API.objectsGroups.forEach(g => { if (GROUP_RENAME[g.id]) g.id = GROUP_RENAME[g.id]; });
const groupName = id => (API.objectsGroups.find(g => g.id === id) || {}).name || '';

// 变量说明查找：物体级 override 优先，其次共享字典
function varRowFor(objName, varName) {
  const byObj = VD.byObj[objName + '|' + varName];
  if (byObj) return [varName, byObj];
  if (VD.shared[varName]) return [varName, VD.shared[varName]];
  return null;
}

const newObjects = [];
for (const it of planOb) {
  const old = oldObjBy.get(it.name);
  const src = D2[it.name];
  const d = (src && src.d) || it.desc || null;
  if (!d) { console.error('!! 物体缺介绍:', it.name); continue; }
  const g = GROUP_RENAME[it.group] || it.group;
  const e = {
    g: g,
    n: it.name,
    t: groupName(g) || (old ? old.t : ''),
    d: d,
  };

  // ---- 变量表：手写表（说明最精细）∪ 源码变量全集（按字典补齐）----
  const hand = (src && src.v && src.v.length) ? src.v
             : ((old && old.v && old.v.length) ? old.v : []);
  const handMap = new Map(hand.map(r => [String(r[0]).trim(), r]));
  const rows = [], used = new Set();
  // 1) 按源码出现顺序铺开，保证与 Create_0.gml 一一对应
  for (const w of (OBJVARS[it.name] || [])) {
    const k = String(w.n).trim();
    if (used.has(k)) continue;
    const row = handMap.get(k) || varRowFor(it.name, k);
    if (row) { rows.push(row); used.add(k); }
  }
  // 2) 再把「源码里没有、但手写表里有」的条目补上（如仅在事件里出现的变量）
  for (const r of hand) {
    const k = String(r[0]).trim();
    if (!used.has(k)) { rows.push(r); used.add(k); }
  }
  if (rows.length) e.v = rows;

  if ((src && src.rel) || (old && old.rel)) e.rel = (src && src.rel) || old.rel;
  if ((src && src.hot) || (old && old.hot)) e.hot = true;
  newObjects.push(e);
}

// ---- 写回 ----
API.functions = newFunctions;
API.objects = newObjects;
delete API['_meta'];

const body = JSON.stringify(API, null, 1);
const out =
  '/* eslint-disable */\n' +
  '// Undertale-Engine-Ultra 手册数据 · 自动生成 + 手工维护\n' +
  '// 结构见 _TODO.md\n' +
  'window.API = ' + body + ';\n';
fs.writeFileSync(DOC + 'manual-api.js', out, 'utf8');

console.log('functions:', newFunctions.length,
  '| 带参数表:', newFunctions.filter(f => f.p.length).length,
  '| 无参数:', newFunctions.filter(f => !f.p.length).length);
console.log('objects:', newObjects.length,
  '| 带变量表:', newObjects.filter(o => o.v).length,
  '| 带关联表:', newObjects.filter(o => o.rel).length);
console.log('分类:', API.categories.length, '| 分组:', API.objectsGroups.length);
