// 生成「物体全量目标清单」：91 个物体的分组、父物体、实例变量、介绍来源
// 输出 tools/_plan-obj.json / tools/_plan-obj.txt
const fs = require('fs');
const vm = require('vm');
const ROOT = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/';
const DOC = ROOT + 'docs/';
const OROOT = ROOT + 'objects/';

const dirs = fs.readdirSync(OROOT, { withFileTypes: true })
  .filter(e => e.isDirectory()).map(e => e.name).sort();

// ---- 手册现有条目 ----
const sb = { window: {}, console }; vm.createContext(sb);
vm.runInContext(fs.readFileSync(DOC + 'manual-api.js', 'utf8'), sb);
const A = sb.window.API;
const manMap = new Map();
A.objects.forEach(o => {
  String(o.n).split('/').map(s => s.trim()).filter(Boolean).forEach(n => {
    if (!manMap.has(n)) manMap.set(n, o);
  });
});

// ---- 父物体（.yy 不是严格 JSON，用正则提） ----
function parentOf(name) {
  for (const f of fs.readdirSync(OROOT + name)) {
    if (!f.endsWith('.yy')) continue;
    const t = fs.readFileSync(OROOT + name + '/' + f, 'utf8');
    const m = t.match(/"parentObjectId"\s*:\s*\{[^}]*?"name"\s*:\s*"([^"]+)"/);
    if (m && m[1]) return m[1];
  }
  return null;
}

// ---- 实例变量（Create_0.gml 顶格赋值） ----
function varsOf(name) {
  const p = OROOT + name + '/Create_0.gml';
  if (!fs.existsSync(p)) return [];
  const out = [];
  for (const raw of fs.readFileSync(p, 'utf8').split(/\r?\n/)) {
    const L = raw.trim();
    if (!L || L.startsWith('//')) continue;
    // 顶格 var 声明也收，但主要收实例变量赋值
    const m = L.match(/^([a-zA-Z_][\w]*(?:\.[\w]+)?)\s*=\s*(.+?);\s*(?:\/\/\s*(.*))?$/);
    if (m && !['var', 'self'].includes(m[1]) && !m[1].startsWith('_')) {
      out.push({ n: m[1], v: m[2].slice(0, 60), c: (m[3] || '').trim() });
    }
  }
  return out;
}

// ---- 分组推断 ----
// 人工归组修正表：优先级高于现有条目与自动推断。
// world 物体是 persistent 全局单例 / 引擎总入口，属核心系统而非「地图与商店」。
const GROUP_OVERRIDE = {
  world: 'core',
};
function guessGroup(n) {
  if (/^battle_soul|^soul_/.test(n)) return 'soul';
  if (/^battle_bullet|^bone_|^bullet/.test(n)) return 'bullet';
  if (/^battle_death|^shaker$|^fader$|^camera$|^battle_fader/.test(n)) return 'fx';
  if (/^battle_(board|turn|enemy|button|damage|menu|dialog|result|bg|ui)|^block|^turn_test|^battle_enemy_test|^battle$/.test(n)) return 'core';
  if (/^(ui_|menu$|logo$|gameover|hint_|exclamation|face|border$|battle_ui|closed_captions|text_typer|demo_)/.test(n)) return 'ui';
  if (/^char|^trigger|^shop|^encounter|^block_corner/.test(n)) return 'world';
  return 'ui';
}
// 分组 id → 显示用 id。分组 id 原为 world，与物体 world 同名易混淆，改名 map。
const GROUP_RENAME = { world: 'map' };
const fixG = g => GROUP_RENAME[g] || g;

const items = dirs.map(n => {
  const e = manMap.get(n);
  return {
    name: n,
    group: fixG(GROUP_OVERRIDE[n] || (e ? e.g : guessGroup(n))),
    parent: parentOf(n),
    vars: varsOf(n),
    desc: (e && e.d) ? e.d : null,
    hadEntry: !!e,
  };
});

fs.writeFileSync(DOC + 'tools/_plan-obj.json', JSON.stringify(items, null, 1), 'utf8');

const byG = {};
items.forEach(i => (byG[i.group] = byG[i.group] || []).push(i));
const L = [];
L.push('物体全量清单');
L.push('  总数: ' + items.length);
L.push('  已有条目: ' + items.filter(i => i.hadEntry).length);
L.push('  待撰写: ' + items.filter(i => !i.hadEntry).length);
L.push('');
for (const g of Object.keys(byG).sort()) {
  L.push('========== ' + g + ' (' + byG[g].length + ') ==========');
  for (const it of byG[g]) {
    L.push((it.desc ? '  [有] ' : '  [缺] ') + it.name.padEnd(32) +
      ' 父=' + (it.parent || '—') + '  变量=' + it.vars.length);
    if (!it.desc) {
      it.vars.slice(0, 14).forEach(v => L.push('        · ' + v.n + ' = ' + v.v + (v.c ? '   // ' + v.c : '')));
    }
  }
}
fs.writeFileSync(DOC + 'tools/_plan-obj.txt', L.join('\n'), 'utf8');
console.log('物体', items.length, '| 已有', items.filter(i => i.hadEntry).length, '| 待写', items.filter(i => !i.hadEntry).length);
