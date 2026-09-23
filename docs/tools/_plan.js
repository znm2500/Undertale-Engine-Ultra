// 生成「函数全量目标清单」：每个全局函数/结构体方法的分类、签名、参数、介绍来源
// 输出 tools/_plan-fn.json（供人工撰写介绍）+ tools/_plan-fn.txt（可读版）
const fs = require('fs');
const vm = require('vm');
const ROOT = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/';
const DOC = ROOT + 'docs/';

// ---------- 1. 源码：全局函数（顶格）----------
const sig = JSON.parse(fs.readFileSync(DOC + 'tools/_sig.json', 'utf8'));
const glob = new Map(sig.map(r => [r.name, r]));

// ---------- 2. 源码：结构体方法（缩进 function）----------
const SROOT = ROOT + 'scripts/';
const methods = [];
for (const d of fs.readdirSync(SROOT)) {
  const p = SROOT + d;
  if (!fs.statSync(p).isDirectory()) continue;
  for (const g of fs.readdirSync(p).filter(f => f.endsWith('.gml'))) {
    const src = fs.readFileSync(p + '/' + g, 'utf8');
    // 每个文件先建一份「函数名 -> ///@arg 列表」映射（含缩进方法；@arg 可能用 argument[N] 而签名为空）
    const argDoc = new Map();
    let pend = null;
    for (const raw of src.split(/\r?\n/)) {
      const L = raw.trim();
      const am = L.match(/^\/\/\/\s*@arg\s+(.+)$/);
      if (am) { (pend = pend || []).push(am[1].trim()); continue; }
      const fm = L.match(/^function\s+([A-Za-z_][A-Za-z0-9_]*)/);
      if (fm) { if (pend && !argDoc.has(fm[1])) argDoc.set(fm[1], pend); pend = null; continue; }
      if (L && !L.startsWith('///') && !L.startsWith('//')) pend = null;
    }
    // 找到 struct 顶层定义的位置，取其后的缩进 function
    const re = /^[ \t]+function\s+([A-Za-z_][A-Za-z0-9_]*)\s*\(([^)]*)\)/gm;
    let m;
    while ((m = re.exec(src)) !== null) {
      const sigP = m[2].split(',').map(s => s.trim()).filter(Boolean)
        .map(s => s.replace(/\s*=\s*[\s\S]*$/, '').trim()).filter(Boolean);
      const docA = argDoc.get(m[1]) || [];
      methods.push({
        name: m[1], file: d + '/' + g,
        // @arg 优先：有些方法签名留空、真实参数只写在 @arg 里
        params: (docA.length ? docA : sigP),
        sigParams: sigP,
      });
    }
  }
}
// 方法归属哪个类型：按脚本名推断
function methodOwner(file) {
  const base = file.split('/')[0];
  const ex = {
    Anim_Init: 'Animator', CustomItem_Bandage: 'ItemTypeSimple', CustomItem_Dice: 'ItemTypeSimple',
    CustomItem_FadedRibbon: 'ItemTypeSimple', CustomItem_PhoneToriel: 'ItemTypeSimple',
    CustomItem_Stick: 'ItemTypeSimple', CustomItem_ToyKnife: 'ItemTypeSimple',
    Inventory: 'Inventory', ItemType: 'ItemType', RegisterManager: 'RegisterManager',
    Storage: 'StorageZone', StorageZone: 'StorageZone', Vector3: 'Vector3', Storage_Custom: 'StorageZone',
  };
  return ex[base] || base;
}
// 按「类型.方法」去重：同一接口的多个实现只保留一条（如各 CustomItem 的 OnUse）
const mset = new Map();
methods.forEach(m => {
  m.owner = methodOwner(m.file);
  const key = m.owner + '.' + m.name;
  if (!mset.has(key)) mset.set(key, m);
  else {
    const prev = mset.get(key);
    (prev.impls = prev.impls || [prev.file]).push(m.file);
  }
});
methods.length = 0;
mset.forEach(m => methods.push(m));

// ---------- 3. 手册现有条目 → 函数名到分类/介绍的映射 ----------
const sb = { window: {}, console }; vm.createContext(sb);
vm.runInContext(fs.readFileSync(DOC + 'manual-api.js', 'utf8'), sb);
const A = sb.window.API;

const catOf = new Map();   // 函数名 -> 分类id
const descOf = new Map();  // 函数名 -> 介绍（仅当条目=单函数时）
const exOf = new Map();
const ownerOf = new Map(); // 函数名 -> 所属条目原始名

A.functions.forEach(f => {
  const raw = String(f.n).replace(/\*+$/g, '').trim();
  const parts = raw.split('/').map(s => s.trim()).filter(Boolean);
  const names = [];
  if (parts.length) {
    const full = parts[0];
    const prefix = (full.match(/^([A-Za-z]+_)/) || [])[1] || '';
    names.push(full);
    parts.slice(1).forEach(pp => {
      const clean = pp.replace(/\*+$/g, '').trim();
      if (/^[A-Z]/.test(clean) && !clean.includes('_')) names.push(prefix + clean);
      else names.push(clean);
    });
  }
  names.forEach(n => {
    if (!/[A-Za-z]/.test(n)) return;
    if (!catOf.has(n)) catOf.set(n, f.c);
    ownerOf.set(n, raw);
    // 单函数条目才可沿用介绍
    if (names.length === 1) { descOf.set(n, f.d); if (f.ex) exOf.set(n, f.ex); }
  });
  // 合并条目里，第一个函数名如果等于 n 也视为"主函数"，介绍大致可用但需改写
});

// ---------- 4. 分类前缀规则（给全新函数用）----------
const PREFIX = [
  [/^Encounter_/, 'encounter'],
  [/^Battle_MakeBone|^Battle_MakeGB|^Battle_MakePlatform|^Battle_IsBullet|^Battle_CallBullet|^Makebonecircle/, 'bullet'],
  [/^Battle_(Get|Set|Is|Remove|Call)Soul|^Battle_CallSoul|^BlueSoul|^battle_soul/, 'soul'],
  [/^Battle_CreateBoard|^Battle_AddBoardVertex|^Battle_GetBoard|^Battle_IsBoard|^__Battle_/, 'board'],
  [/^Battle_(Get|Set|Is)Enemy|^Battle_RemoveEnemy|^Battle_CallEnemy|^Battle_Convert/, 'enemy'],
  [/^Battle_(Set|Get|Is)Dialog|^Battle_SetMenuDialog|^Battle_GetMenuDialog|^Dialog_|^TextTyper|^Battle_Dialog/, 'dialog'],
  [/^Battle_(Get|Set)Menu|^Battle_EndMenu|^Battle_IsMenu|^Battle_SetFleeable|^Battle_IsFleeable|^Battle_Reward|^Battle_GetReward|^Battle_GetMenuItem/, 'battlecore'],
  [/^Battle_/, 'battlecore'],
  [/^Player_/, 'player'],
  [/^(Item_|ItemType|Inventory|CustomItem|inventory)/, 'item'],
  [/^(Anim|Animator|Bezier|Shake_)/, 'anim'],
  [/^(Storage|File_)/, 'storage'],
  [/^Input_/, 'input'],
  [/^BGM_/, 'audio'],
  [/^(Fader|Camera_|Border_|CC_)/, 'ui'],
  [/^Shop_/, 'shop'],
  [/^Demo_/, 'misc'],
];

function guessCat(n) {
  for (const [re, c] of PREFIX) if (re.test(n)) return c;
  return 'misc';
}

// ---------- 5. 组装清单 ----------
const items = [];
for (const [n, r] of glob) {
  items.push({
    name: n, kind: 'global', file: r.file,
    params: (r.argDoc && r.argDoc.length ? r.argDoc : r.params),
    sigParams: r.params,
    cat: catOf.get(n) || guessCat(n),
    desc: descOf.get(n) || null,
    ex: exOf.get(n) || null,
    hadEntry: catOf.has(n),
    fromEntry: ownerOf.get(n) || null,
  });
}
for (const m of methods) {
  const key = m.owner + '.' + m.name;
  items.push({
    name: key, kind: 'method', owner: m.owner, memName: m.name, file: m.file,
    params: m.params, sigParams: m.sigParams,
    cat: guessCat(m.owner === 'Animator' ? 'Anim_' : m.owner),
    desc: null, ex: null,
    hadEntry: false, fromEntry: null,
  });
}
items.sort((a, b) => a.name.localeCompare(b.name));

fs.writeFileSync(DOC + 'tools/_plan-fn.json', JSON.stringify(items, null, 1), 'utf8');

// ---------- 6. 可读版 ----------
const byCat = {};
items.forEach(it => (byCat[it.cat] = byCat[it.cat] || []).push(it));
const L = [];
L.push('函数全量清单');
L.push('  全局函数: ' + items.filter(i => i.kind === 'global').length);
L.push('  结构体方法: ' + items.filter(i => i.kind === 'method').length);
L.push('  合计: ' + items.length);
L.push('  沿用现有介绍: ' + items.filter(i => i.desc).length);
L.push('  待撰写介绍: ' + items.filter(i => !i.desc).length);
L.push('');
for (const c of Object.keys(byCat).sort()) {
  L.push('========== ' + c + ' (' + byCat[c].length + ') ==========');
  for (const it of byCat[c].sort((a, b) => a.name.localeCompare(b.name))) {
    L.push((it.desc ? '  [有]' : '  [缺]') + ' ' + it.name +
      (it.params.length ? '  (' + it.params.length + '参数)' : '  (无参)') +
      (it.fromEntry && !it.desc ? '   <- 现属条目: ' + it.fromEntry : ''));
  }
}
fs.writeFileSync(DOC + 'tools/_plan-fn.txt', L.join('\n'), 'utf8');
console.log('全局', items.filter(i => i.kind === 'global').length,
  '| 方法', items.filter(i => i.kind === 'method').length,
  '| 合计', items.length,
  '| 待写介绍', items.filter(i => !i.desc).length);
