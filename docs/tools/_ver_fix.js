// 版本号修正：撤回 brandver 手册版本标注（上轮误解用户意图）
// 真实意图：教程正文「ENGINE_VERSION v1.4.0」→「ENGINE_VERSION v2.0.1」
// （源码 Macro_Engine.gml 已是 #macro ENGINE_VERSION "v2.0.1"，手册跟源码对齐）
const fs = require('fs');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_ver_fix.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 备份 ----------
fs.copyFileSync(BASE + 'UNDERTALE-Engine-Ultra-手册.html', BASE + '_bak14-UNDERTALE-Engine-Ultra-手册.html');
fs.copyFileSync(BASE + 'tools/_verify.js', BASE + 'tools/_verify.js.bak5');
fs.copyFileSync(BASE + 'tools/_tut_overview.js', BASE + 'tools/_tut_overview.js.bak');
fs.copyFileSync(BASE + '_TODO.md', BASE + '_TODO.md.bak4');
out('备份完成: _bak14-...html / _verify.js.bak5 / _tut_overview.js.bak / _TODO.md.bak4');

// ---------- 1. 手册 HTML ----------
const htmlPath = BASE + 'UNDERTALE-Engine-Ultra-手册.html';
let h = fs.readFileSync(htmlPath, { encoding: 'utf8' });
if (count(h, 'v1.4.0') !== 1) die('HTML 里 v1.4.0 出现次数不是 1，中止');

// 撤回 1: title
const tNew2 = '<title>UNDERTALE Engine Ultra 开发手册 v2.0.1</title>';
const tBack = '<title>UNDERTALE Engine Ultra 开发手册</title>';
if (count(h, tNew2) !== 1) die('title 撤回锚点不唯一，中止');
h = h.replace(tNew2, tBack);

// 撤回 2: brandver 行
const verLine = '\n    <div class="brandver">v2.0.1</div>';
if (count(h, verLine) !== 1) die('brandver 行撤回锚点不唯一，中止');
h = h.replace(verLine, '');

// 撤回 3: brandver CSS
const cssLine = '\n.brandver{padding:0 18px 10px;margin-top:-4px;font-size:11px;font-weight:400;color:var(--tx3);letter-spacing:.3px}';
if (count(h, cssLine) !== 1) die('brandver CSS 撤回锚点不唯一，中止');
h = h.replace(cssLine, '');

// 教程正文版本号
if (count(h, 'ENGINE_VERSION v1.4.0') !== 1) die('ENGINE_VERSION v1.4.0 锚点不唯一，中止');
h = h.replace('ENGINE_VERSION v1.4.0', 'ENGINE_VERSION v2.0.1');

fs.writeFileSync(htmlPath, h, { encoding: 'utf8' });
const h2 = fs.readFileSync(htmlPath, { encoding: 'utf8' });
if (h2.includes('brandver') || h2.includes('开发手册 v2.0.1') || h2.includes('ENGINE_VERSION v1.4.0') || !h2.includes('ENGINE_VERSION v2.0.1')) {
  die('HTML 写回重读断言失败');
}
if (h2.includes('v1.4.0')) die('HTML 里仍有残留 v1.4.0');
out('HTML: brandver 三处已撤回，教程 ENGINE_VERSION 已改 v2.0.1，重读断言通过');

// ---------- 2. _verify.js：删旧断言，加新断言 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const vOld = "  ['版本号 v2.0.1 已标注', html.includes('<div class=\"brandver\">v2.0.1</div>') && html.includes('开发手册 v2.0.1')],\n";
if (count(v, vOld) !== 1) die('_verify 旧断言锚点不唯一，中止');
v = v.replace(vOld, '');
const vAnchor = "  ['教程章节数 == 1', HTML_TUT_COUNT === 1],\n";
if (count(v, vAnchor) !== 1) die('_verify 新断言插入锚点不唯一，中止');
const vAdd = "  ['教程引擎版本 v2.0.1', hTut.includes('ENGINE_VERSION v2.0.1') && !html.includes('ENGINE_VERSION v1.4.0')],\n";
v = v.replace(vAnchor, vAnchor + vAdd);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
const v2 = fs.readFileSync(verPath, { encoding: 'utf8' });
if (v2.includes('brandver') || !v2.includes('教程引擎版本 v2.0.1')) die('_verify 写回重读断言失败');
out('_verify.js: 旧版本断言已删，新断言「教程引擎版本 v2.0.1」已加');

// ---------- 3. _tut_overview.js 模板（防管线重跑回退） ----------
const tplPath = BASE + 'tools/_tut_overview.js';
let tpl = fs.readFileSync(tplPath, { encoding: 'utf8' });
if (count(tpl, 'ENGINE_VERSION v1.4.0') !== 1) die('_tut_overview 模板锚点不唯一，中止');
tpl = tpl.replace('ENGINE_VERSION v1.4.0', 'ENGINE_VERSION v2.0.1');
fs.writeFileSync(tplPath, tpl, { encoding: 'utf8' });
if (!fs.readFileSync(tplPath, { encoding: 'utf8' }).includes('ENGINE_VERSION v2.0.1')) die('_tut_overview 写回断言失败');
out('_tut_overview.js 模板已同步 v2.0.1（防重跑回退）');

// ---------- 4. _TODO.md ----------
const todoPath = BASE + '_TODO.md';
let td = fs.readFileSync(todoPath, { encoding: 'utf8' });
if (count(td, 'v1.4.0') !== 1) die('_TODO.md 锚点不唯一，中止');
td = td.replace('Undertale 引擎 v1.4.0', 'Undertale 引擎 v2.0.1');
fs.writeFileSync(todoPath, td, { encoding: 'utf8' });
if (fs.readFileSync(todoPath, { encoding: 'utf8' }).includes('v1.4.0')) die('_TODO.md 写回断言失败');
out('_TODO.md 引擎版本描述已同步 v2.0.1');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_ver_fix.txt', LOG.join('\n'), { encoding: 'utf8' });
