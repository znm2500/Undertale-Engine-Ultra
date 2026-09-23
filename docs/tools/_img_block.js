// 示例新增「画面块」能力：lang:"img" 的 code 块 → 占位虚线框 / base64 图片
// （用户约定：写示例时需要游戏画面的地方先放占位，截图/GIF 由用户后续提供，转 base64 填入）
const fs = require('fs');

const DOCS = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const HTML = DOCS + 'index.html';
const EX = DOCS + 'manual-examples.js';
const VERIFY = DOCS + 'tools/_verify.js';
const LOGP = DOCS + 'tools/_img_block.txt';

const lines = [];
function log(x) { lines.push(x); console.log(x); }

// ---------- 0. 备份 ----------
fs.copyFileSync(HTML, DOCS + '_bak12-index.html');
fs.copyFileSync(EX, DOCS + '_bak11-manual-examples.js');
fs.copyFileSync(VERIFY, DOCS + 'tools/_verify.js.bak3');
log('备份完成: _bak12-...html / _bak11-manual-examples.js / _verify.js.bak3');

// ---------- 1. HTML 三处修改 ----------
let html = fs.readFileSync(HTML, 'utf8');

// 1a. CSS：.tip b 规则后插入占位框 / 图片样式
const CSS_OLD = '.tip b{color:var(--tx);font-weight:500}';
const CSS_NEW = CSS_OLD + '\n' +
  '.imgph{border:1px dashed #3a4757;border-radius:4px;padding:34px 20px;text-align:center;color:var(--tx3);font-size:13.5px;background:rgba(255,255,255,.02)}\n' +
  '.imgpic{max-width:100%;display:block;margin:6px auto 0;border-radius:4px}';
if (!html.includes(CSS_OLD)) throw new Error('CSS 锚点不匹配');
if (html.includes('.imgph')) throw new Error('.imgph 已存在，避免重复插入');
html = html.replace(CSS_OLD, CSS_NEW);

// 1b. 工具函数：code() 之后插入 imgBlock()
const FN_OLD = "function code(t){return '<pre><code>'+hl(t)+'</code></pre>';}";
const FN_NEW = FN_OLD + '\n' +
  'function imgBlock(b){\n' +
  '  if(/^data:image\\//.test(b)) return \'<img class="imgpic" src="\'+b+\'" alt="">\';\n' +
  '  return \'<div class="imgph">\'+esc(b||\'截图 / GIF 待补\')+\'</div>\';\n' +
  '}';
if (!html.includes(FN_OLD)) throw new Error('code() 函数锚点不匹配');
if (html.includes('function imgBlock')) throw new Error('imgBlock 已存在');
html = html.replace(FN_OLD, FN_NEW);

// 1c. secHtml：code 块渲染分支加 img
const SEC_OLD = "(c.lang==='gml' ? code(c.b) : '<pre><code>'+esc(c.b)+'</code></pre>')+'</div>').join('')+";
const SEC_NEW = "(c.lang==='gml' ? code(c.b) : (c.lang==='img' ? imgBlock(c.b) : '<pre><code>'+esc(c.b)+'</code></pre>'))+'</div>').join('')+";
if (!html.includes(SEC_OLD)) throw new Error('secHtml 锚点不匹配');
html = html.replace(SEC_OLD, SEC_NEW);

fs.writeFileSync(HTML, html, { encoding: 'utf8' });
log('HTML: CSS(.imgph/.imgpic) + imgBlock() + secHtml img 分支 已插入');

// 1d. 重读断言
const html2 = fs.readFileSync(HTML, 'utf8');
['.imgph{', '.imgpic{', 'function imgBlock', "c.lang==='img' ? imgBlock(c.b)"].forEach(k => {
  if (!html2.includes(k)) throw new Error('重读缺失: ' + k);
});
log('HTML 重读断言通过');

// ---------- 2. manual-examples.js：给现有示例补一个画面占位 ----------
let ex = fs.readFileSync(EX, 'utf8');
const EX_OLD = '  这个示例只负责验证「遭遇战流程」，敌人本体怎么写是下一步的事。` },';
const EX_NEW = EX_OLD + '\n' +
  '    { t: "画面占位 · 战斗中的 turn_test", lang: "img", b: "battle_enemy_test 的战斗画面：矩形战斗框 + 蓝色灵魂（截图 / GIF 待补）" },';
if (!ex.includes(EX_OLD)) throw new Error('示例锚点不匹配');
if (ex.includes('lang: "img"')) throw new Error('img 块已存在');
ex = ex.replace(EX_OLD, EX_NEW);
fs.writeFileSync(EX, ex, { encoding: 'utf8' });
const ex2 = fs.readFileSync(EX, 'utf8');
if (!ex2.includes('lang: "img"')) throw new Error('示例占位块未写入');
log('示例 ex_encounter_battle_enemy_test 已插入画面占位块（lang:"img"）');

// ---------- 3. _verify.js：新增占位渲染断言 ----------
let vf = fs.readFileSync(VERIFY, 'utf8');
const V_OLD = "  ['示例分级标题为 1（仅入门）', (hEx.match(/class=\"exgrt\"/g) || []).length === 1],";
const V_NEW = V_OLD + '\n' + "  ['示例画面占位渲染正常', hEx.includes('imgph')],";
if (!vf.includes(V_OLD)) throw new Error('_verify.js 锚点不匹配');
if (vf.includes('imgph')) throw new Error('imgph 断言已存在');
vf = vf.replace(V_OLD, V_NEW);
fs.writeFileSync(VERIFY, vf, { encoding: 'utf8' });
log('_verify.js 已加断言「示例画面占位渲染正常」');

log('ALL OK');
fs.writeFileSync(LOGP, lines.join('\n'), { encoding: 'utf8' });
