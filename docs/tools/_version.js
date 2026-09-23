// 第十轮补充：手册标注版本号 v2.0.1
// 位置：1) <title> 2) 侧栏品牌区下方独立一行 3) CSS 4) _verify.js 断言
const fs = require('fs');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);

const htmlPath = BASE + 'index.html';
const verPath = BASE + 'tools/_verify.js';

// ---------- 备份 ----------
fs.copyFileSync(htmlPath, BASE + '_bak13-index.html');
fs.copyFileSync(verPath, BASE + 'tools/_verify.js.bak4');
out('备份完成: _bak13-...html / _verify.js.bak4');

// ---------- HTML ----------
let h = fs.readFileSync(htmlPath, { encoding: 'utf8' });

// 1) title
const tOld = '<title>UNDERTALE Engine Ultra 开发手册</title>';
const tNew = '<title>UNDERTALE Engine Ultra 开发手册 v2.0.1</title>';
if ((h.match(new RegExp(tOld.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g')) || []).length !== 1) {
  out('FATAL: title 锚点不唯一，中止'); fs.writeFileSync(BASE + 'tools/_version.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1);
}
h = h.replace(tOld, tNew);

// 2) 品牌区下方加版本行
const bOld = '<div class="brand"><img class="brandico" src="favicon.png?h=f1f4dab2" alt=""><h1>UNDERTALE Engine Ultra</h1></div>';
const bNew = bOld + '\n    <div class="brandver">v2.0.1</div>';
if ((h.split(bOld).length - 1) !== 1) {
  out('FATAL: brand 锚点不唯一，中止'); fs.writeFileSync(BASE + 'tools/_version.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1);
}
h = h.replace(bOld, bNew);

// 3) CSS
const cOld = '.brand h1{font-size:13.5px;font-weight:500;color:var(--tx2);letter-spacing:.1px}';
const cNew = cOld + '\n.brandver{padding:0 18px 10px;margin-top:-4px;font-size:11px;font-weight:400;color:var(--tx3);letter-spacing:.3px}';
if ((h.split(cOld).length - 1) !== 1) {
  out('FATAL: CSS 锚点不唯一，中止'); fs.writeFileSync(BASE + 'tools/_version.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1);
}
h = h.replace(cOld, cNew);

// 写回 + 重读断言
fs.writeFileSync(htmlPath, h, { encoding: 'utf8' });
const h2 = fs.readFileSync(htmlPath, { encoding: 'utf8' });
if (!h2.includes(tNew) || !h2.includes('<div class="brandver">v2.0.1</div>') || !h2.includes('.brandver{')) {
  out('FATAL: HTML 写回重读断言失败，中止'); fs.writeFileSync(BASE + 'tools/_version.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1);
}
out('HTML: title + 侧栏版本行 + CSS 已插入，重读断言通过');

// ---------- _verify.js ----------
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const vOld = "  ['教程章节数 == 1', HTML_TUT_COUNT === 1],";
const vNew = vOld + "\n  ['版本号 v2.0.1 已标注', h.includes('<div class=\"brandver\">v2.0.1</div>') && h.includes('开发手册 v2.0.1')],";
if ((v.split(vOld).length - 1) !== 1) {
  out('FATAL: _verify 锚点不唯一，中止'); fs.writeFileSync(BASE + 'tools/_version.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1);
}
v = v.replace(vOld, vNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
const v2 = fs.readFileSync(verPath, { encoding: 'utf8' });
if (!v2.includes("brandver\">v2.0.1")) {
  out('FATAL: _verify 写回重读断言失败，中止'); fs.writeFileSync(BASE + 'tools/_version.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1);
}
out('_verify.js 已加断言「版本号 v2.0.1 已标注」');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_version.txt', LOG.join('\n'), { encoding: 'utf8' });
