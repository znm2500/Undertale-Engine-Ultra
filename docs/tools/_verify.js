// 手册校验 v2：含 Examples 分级筛选的渲染验证
const fs = require('fs');
const vm = require('vm');
const path = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const out = [];
const log = (...a) => out.push(a.join(' '));

const html = fs.readFileSync(path + 'UNDERTALE-Engine-Ultra-手册.html', 'utf8');
const apiSrc = fs.readFileSync(path + 'manual-api.js', 'utf8');
const exSrc = fs.readFileSync(path + 'manual-examples.js', 'utf8');

// ---------- 1. 编码 / 符号 / 语法 ----------
log('== 编码 ==');
log('HTML FFFD:', (html.match(/\uFFFD/g) || []).length, '| BOM:', html.charCodeAt(0) === 0xFEFF);
log('API  FFFD:', (apiSrc.match(/\uFFFD/g) || []).length, '| EX FFFD:', (exSrc.match(/\uFFFD/g) || []).length);
const mojibake = ['鈻', '锟斤', '璁', '鐨', '涓', '浣犲', '鏄', '鎴', '鐢', '鈥', '锛'];
const hit = mojibake.filter(w => html.includes(w) || apiSrc.includes(w) || exSrc.includes(w));
log('GBK 乱码特征:', hit.length ? hit.join(',') : '无');

log('');
log('== 符号 ==');
log('★ 残留 -> HTML:', (html.match(/★/g) || []).length, '| API:', (apiSrc.match(/★/g) || []).length, '| EX:', (exSrc.match(/★/g) || []).length);

log('');
log('== 语法 ==');
const scripts = [...html.matchAll(/<script(?![^>]*\bsrc=)[^>]*>([\s\S]*?)<\/script>/gi)].map(m => m[1]);
let okAll = true;
scripts.forEach((s, i) => { try { new vm.Script(s); } catch (e) { okAll = false; log('  内联块', i, '错误:', e.message); } });
log('内联脚本(' + scripts.length + '块):', okAll ? '通过' : '失败');

// ---------- 2. 装载数据 ----------
const sandbox = { console };
sandbox.window = sandbox;
vm.createContext(sandbox);
vm.runInContext(apiSrc, sandbox);
vm.runInContext(exSrc, sandbox);
const API = sandbox.API, EXAMPLES = sandbox.EXAMPLES;

log('');
log('== 数据 ==');
log('functions:', API.functions.length, '| categories:', API.categories.length,
    '| objects:', API.objects.length, '| objectsGroups:', API.objectsGroups.length,
    '| snippets:', Object.keys(API.snippets).length,
    '| enemyEvents:', API.enemyEvents.length, '| boneTypes:', API.boneTypes.length,
    '| EXAMPLES:', EXAMPLES.length);

// ---------- 3. 渲染验证：跑真实的内联渲染函数 ----------
// 从 HTML 抽出内联脚本，注入最小 DOM stub，逐一调用四个渲染函数
const inline = scripts[0];

function makeStub() {
  const store = {};
  const el = (id) => (store[id] = store[id] || {
    id, innerHTML: '', style: {}, dataset: {},
    classList: { add() {}, remove() {}, toggle() {}, contains() { return false; } },
    querySelectorAll: () => [], querySelector: () => null, addEventListener() {}, blur() {},
    parentElement: null, appendChild() {}, value: '',
  });
  return { store, el };
}

const { store, el } = makeStub();

const doc = {
  getElementById: (id) => el(id),
  querySelectorAll: () => [],
  querySelector: () => null,
  addEventListener() {},
  createElement: () => el('tmp'),
};
const win = {
  innerWidth: 1200,
  scrollTo() {},
  addEventListener() {},
  document: doc,
  API, EXAMPLES,
  encodeURIComponent, decodeURIComponent,
};

const ctx = {
  window: win, document: doc, console,
  API, EXAMPLES,
  encodeURIComponent, decodeURIComponent,
  atob: (s) => Buffer.from(s, 'base64').toString('binary'),
  btoa: (s) => Buffer.from(s, 'binary').toString('base64'),
  navigator: { clipboard: { writeText() {} } },
  setTimeout, clearTimeout,
};
ctx.globalThis = ctx;
vm.createContext(ctx);

log('');
log('== 渲染 ==');
try {
  vm.runInContext(inline, ctx);
  log('内联脚本执行: 通过');
} catch (e) {
  log('内联脚本执行失败:', e.message);
}

const view = (name, code) => {
  try {
    vm.runInContext(code, ctx);
    const h = store.wrap ? store.wrap.innerHTML : '';
    log(name + ': OK  长度=' + h.length);
    return h;
  } catch (e) {
    log(name + ': 失败 -> ' + e.message);
    return '';
  }
};

const hTut = view('教程视图', 'switchView("tutorial")');

// 教程章节数（直接从 HTML 内联的 TUT_SECTIONS 数组解析）
const HTML_TUT_COUNT = (() => {
  const i = html.indexOf('const TUT_SECTIONS = [');
  if (i < 0) return 0;
  const j = html.indexOf('];', i);
  if (j < 0) return 0;
  const raw = html.slice(i + 'const TUT_SECTIONS = '.length, j + 1);
  try { return JSON.parse(raw).length; } catch (e) { return -1; }
})();
const hEx  = view('示例视图(全部)', 'curExLv="all";curEx=null;renderExamples()');
const hApi = view('函数视图', 'curCat="all";renderAPI()');
const hObj = view('物体视图', 'curObj="all";renderObjects()');

// 示例各分级
log('');
log('== 示例分级渲染 ==');
const EX_LEVELS = ['入门', '进阶', '实用', '必读'];
EX_LEVELS.forEach(lv => {
  const h = view('  示例·' + lv, 'curExLv="' + lv + '";curEx=null;renderExamples()');
  const n = EXAMPLES.filter(e => e.level === lv).length;
  const found = (h.match(/class="sec ex"/g) || []).length;
  log('    -> 期望 ' + n + ' 条, 实际 ' + found + ' 条 ' + (n === found ? '✓' : '✗'));
});

// 单篇详情
const hOne = view('示例详情 ex_encounter_battle_enemy_test', 'curExLv="all";curEx="ex_encounter_battle_enemy_test";renderExamples()');
const hOne2 = view('示例详情 ex_enemy_test_acts', 'curExLv="all";curEx="ex_enemy_test_acts";renderExamples()');
const hOne3 = view('示例详情 ex_item_heal_potion', 'curExLv="all";curEx="ex_item_heal_potion";renderExamples()');

// ---------- 4. 渲染产物检查 ----------
log('');
log('== 产物检查 ==');
const checks = [
  ['教程视图 有内容', hTut.length > 500],
  ['教程只保留「引擎速览」一节', hTut.includes('引擎速览') && !hTut.includes('引擎的启动流程')],
  ['教程章节数 == 1', HTML_TUT_COUNT === 1],
  ['教程引擎版本 v2.0.1', hTut.includes('ENGINE_VERSION v2.0.1') && !html.includes('ENGINE_VERSION v1.4.0')],
  ['示例视图 有内容', hEx.length > 500 && hEx.includes('battle_enemy_test')],
  ['示例分级标题为 1（均为入门）', (hEx.match(/class="exgrt"/g) || []).length === 1],
  ['示例画面块渲染正常（外链图）', hEx.includes('imgpic') && (hEx.match(/<img class="imgpic" loading="lazy" src="img\//g) || []).length === 3],
  ['示例图片文件已落盘', ['img/ex1-battle-turn_test.gif','img/ex2-act-menu-dialog.gif','img/ex3-battle-use-medicine.gif'].every(f => fs.existsSync(path + f))],
  ['示例无 base64 图片残留', !hEx.includes('data:image')],
  ['示例全部 有筛选栏', hEx.includes('class="apibar"')],
  ['示例全部 无 undefined', !hEx.includes('undefined')],
  ['函数视图 有 449 条', (hApi.match(/class="api"/g) || []).length === 449],
  ['函数视图 无真实 undefined 泄漏', !/<td>undefined<\/td>|>undefined<|="undefined"/.test(hApi)],
  ['物体视图 有 91 条', (hObj.match(/class="ob"/g) || []).length === 91],
  ['物体视图 有 6 分组', (hObj.match(/class="obgrp"/g) || []).length === 6],
  ['物体视图 无 undefined', !hObj.includes('undefined')],
  ['物体视图 变量表 >= 90', (hObj.match(/<table class="pt">/g) || []).length >= 90],
  ['物体视图 无合并名 /', !/class="ob"[^>]*>[\s\S]{0,200}?<h4>[^<]*\//.test(hObj)],
  ['示例2 详情 有属性与ACT', hOne2.includes('Battle_SetEnemyDEF') && hOne2.includes('BATTLE_MENU_CHOICE_BUTTON')],
  ['示例2 有 turn_test 准备步骤', hOne2.includes('先注释掉 turn_test')],
  ['示例3 详情 有药品与战斗链路', hOne3.includes('CustomItem_Medicine') && hOne3.includes('InvokeItemUse')],
  ['示例3 详情 无 undefined', !hOne3.includes('undefined')],
  ['示例2 详情 无 undefined', !hOne2.includes('undefined')],
  ['示例详情 有返回链接与代码', hOne.includes('返回示例列表') && hOne.includes('Encounter_Start')],
  ['示例详情 无 undefined', !hOne.includes('undefined')],
  ['四个视图均无 ★', ![hTut, hEx, hApi, hObj, hOne].some(s => s.includes('★'))],
];
checks.forEach(([n, ok]) => log((ok ? '  ✓ ' : '  ✗ ') + n));

// ---------- 4.5 图标接线 ----------
log('');
log('== 图标 ==');
const iconLinks = [...html.matchAll(/<link[^>]*rel="icon"[^>]*>/g)].map(m => m[0]);
const hasPNG = iconLinks.filter(t => /^data:image\/png;base64,[A-Za-z0-9+/=]+$/.test((t.match(/href="([^"]+)"/) || [])[1] || ''));
log('link rel=icon 标签: ' + iconLinks.length + ' 个（内联 PNG: ' + hasPNG.length + '）');
const brandTag = (html.match(/<div class="brand"[^>]*>[\s\S]*?<\/div>/) || [''])[0];
const iconUtil = [
  ['存在 favicon link', iconLinks.length >= 1],
  ['favicon 为内联 PNG', hasPNG.length >= 1],
  ['含 16x16 尺寸声明', /sizes="16x16"/.test(html)],
  ['含 32x32 尺寸声明', /sizes="32x32"/.test(html)],
  ['含 apple-touch-icon', /rel="apple-touch-icon"/.test(html)],
  ['品牌区有图标 img', /<img class="brandico"/.test(brandTag)],
  ['品牌图标走像素渲染', /\.brandico\{[^}]*image-rendering:pixelated/.test(html)],
  ['favicon.png 已落盘', fs.existsSync(path + 'favicon.png')],
];
iconUtil.forEach(([n, ok]) => log((ok ? '  ✓ ' : '  ✗ ') + n));

// ---------- 5. 中文 UI ----------
log('');
log('== 中文 UI ==');
const noCode = html.replace(/<script[\s\S]*?<\/script>/gi, ' ').replace(/<style[\s\S]*?<\/style>/gi, ' ');
const visTexts = [...noCode.matchAll(/>([^<>]+)</g)].map(m => m[1].trim()).filter(Boolean);
const engVis = visTexts.filter(t => /[A-Za-z]{3,}/.test(t));
log('静态可见英文文本:', engVis.length ? engVis.join(' | ') : '无（仅引擎名可选）');
for (const w of ['Tutorials', 'Examples', 'Functions', 'Objects', 'All', 'Previous', 'Next', 'Type to search']) {
  const spec = new RegExp('>\\s*' + w + '\\s*<');
  if (spec.test(html)) log('  ⚠ 可见英文 UI 残留:', w);
}
log('（无 ⚠ 即通过）');

// ---------- 6. 介绍质量 ----------
log('');
log('== 唯一性 ==');
const objNames = API.objects.map(o => o.n);
const dupObjs = objNames.filter((n, i) => objNames.indexOf(n) !== i);
log('重复物体条目: ' + dupObjs.length + (dupObjs.length ? ' -> ' + dupObjs.join(', ') : ''));
const fnNames = API.functions.map(f => f.n);
const dupFns = fnNames.filter((n, i) => fnNames.indexOf(n) !== i);
log('重复函数条目: ' + dupFns.length + (dupFns.length ? ' -> ' + dupFns.join(', ') : ''));

log('');
log('== 参数表 / 变量表覆盖 ==');
log('函数带参数表: ' + API.functions.filter(f => f.p && f.p.length).length + ' / ' + API.functions.length);
log('函数已确认无参数: ' + API.functions.filter(f => f.p && !f.p.length).length);
log('物体带变量表: ' + API.objects.filter(o => o.v && o.v.length).length + ' / ' + API.objects.length);
log('物体带关联表: ' + API.objects.filter(o => o.rel && o.rel.length).length + ' / ' + API.objects.length);
log('物体无任何表格: ' + API.objects.filter(o => !(o.v && o.v.length) && !(o.rel && o.rel.length)).length);
log('物体条目名含合并斜杠: ' + API.objects.filter(o => o.n.includes('/')).length);

// 覆盖率硬断言（数据层）
const OBJVARS = JSON.parse(fs.readFileSync(path + 'tools/_objvars.json', 'utf8'));
const covChecks = [
  ['每个函数都有介绍', API.functions.every(f => (f.d || '').trim().length > 0)],
  ['每个函数都有参数表字段(p)', API.functions.every(f => Array.isArray(f.p))],
  ['函数 = 带参数表 + 无参数', API.functions.filter(f => f.p.length).length + API.functions.filter(f => !f.p.length).length === API.functions.length],
  ['每个物体都有介绍', API.objects.every(o => (o.d || '').trim().length > 0)],
  ['每个物体都有变量表或关联表', API.objects.every(o => (o.v && o.v.length) || (o.rel && o.rel.length))],
  // 内容深度：源码变量必须逐条写进变量表
  ['变量表覆盖全部源码变量', API.objects.every(o => {
    const names = new Set((o.v || []).map(r => String(r[0]).trim()));
    return (OBJVARS[o.n] || []).every(w => names.has(String(w.n).trim()));
  })],
  // 内容深度：变量多的物体，介绍不能太薄（防止「表很全、介绍一句话」）
  ['变量>=10 的物体介绍均 >=60 字', API.objects.every(o => ((OBJVARS[o.n] || []).length < 10) || (o.d || '').trim().length >= 60)],
  // 防复发：合并行（如「x / y」）与全部组成变量的单行并存 = 冗余
  ['变量表无冗余合并行', API.objects.every(o => !(o.v || []).some(r => {
    const n = String(r[0]).trim();
    if (!n.includes(' / ')) return false;
    const names = new Set((o.v || []).map(x => String(x[0]).trim()));
    const parts = n.split('/').map(s => s.trim().replace(/ 等$/, ''));
    return parts.length > 1 && parts.every(p => names.has(p));
  }))],
  // 防复发：术语打磨规则重复叠加会产生「战斗战斗框」
  ['无「战斗战斗」叠加', !JSON.stringify(API).includes('战斗战斗')],
];
covChecks.forEach(([n, ok]) => log((ok ? '  ✓ ' : '  ✗ ') + n));

log('');
log('== 介绍质量 ==');
const badF = API.functions.filter(f => !(f.d || '').trim() || (f.d || '').trim().length < 18 || (f.d || '').trim() === f.n);
const badO = API.objects.filter(o => !(o.d || '').trim() || (o.d || '').trim().length < 29);
log('函数不合格:', badF.length, badF.slice(0, 5).map(f => f.n).join(','));
log('物体不合格:', badO.length, badO.slice(0, 5).map(o => o.n).join(','));
log('hot 标记: 函数', API.functions.filter(f => f.hot).length, '| 物体', API.objects.filter(o => o.hot).length);

// ---------- 7. 新增组件存在性 ----------
log('');
log('== Examples 分类接线 ==');
const wiring = [
  ['状态 curExLv', /curExLv\s*=\s*'all'/.test(html)],
  ['EX_LEVELS 常量', /const EX_LEVELS\s*=/.test(html)],
  ['渲染分级 chip', /onclick="pickExLv\(\\'/ .test(html) || html.includes("onclick=\\\"pickExLv")],
  ['pickExLv 函数', /function pickExLv/.test(html)],
  ['侧栏 data-exlv', /data-exlv/.test(html)],
  ['侧栏点击绑定', /querySelectorAll\('\[data-exlv\]'\)/.test(html)],
  ['CSS .exgrp', /\.exgrp\{/.test(html)],
  ['CSS .exgrt', /\.exgrt\{/.test(html)],
  ['侧栏逐篇标题项', html.includes('class="item exitem" data-exid=')],
  ['侧栏逐篇渲染', /EXAMPLES\.forEach\(e=>\{[^}]*exitem/.test(html)],
  ['CSS .exitem', /\.exitem\{/.test(html)],
  ['搜索重置分级', /curView==='examples' && \(curExLv!=='all' \|\| curEx\)/.test(html)],
  ['搜索收敛空分组', /querySelectorAll\('\.exgrp'\)/.test(html)],
  ['搜索恢复示例视图', /curView==='examples'\) renderExamples\(\)/.test(html)],
];
wiring.forEach(([n, ok]) => log((ok ? '  ✓ ' : '  ✗ ') + n));

fs.writeFileSync(path + '_verify.txt', out.join('\n'), { encoding: 'utf8' });
console.log('done');
