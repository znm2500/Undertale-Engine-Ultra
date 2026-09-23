// 示例第 2 篇画面占位 → 真图（ACT 菜单与行动对话）
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const GIF = 'C:/Users/Weaver/Desktop/屏幕录制 2026-09-22 115229.gif';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_img_fill2.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 读 GIF ----------
let buf;
try { buf = fs.readFileSync(GIF); } catch (e) { die('读 GIF 失败: ' + e.message); }
if (buf.length < 1000) die('GIF 过小(' + buf.length + 'B)，疑似读取错误，中止');
const uri = 'data:image/gif;base64,' + buf.toString('base64');
out('GIF 读取成功: ' + buf.length + ' bytes → base64 ' + uri.length + ' chars');

// ---------- 备份 ----------
fs.copyFileSync(BASE + 'manual-examples.js', BASE + '_bak21-manual-examples.js');
out('备份完成: _bak21-manual-examples.js');

// ---------- 替换占位块（整块等量替换，不涉及尾逗号） ----------
const exPath = BASE + 'manual-examples.js';
let ex = fs.readFileSync(exPath, { encoding: 'utf8' });
const lineOld = '{ t: "画面占位 · ACT 菜单与行动对话", lang: "img", b: "ACT 菜单展开 + 连续「讨好」两次后名字变黄（截图待补）" }';
if (count(ex, lineOld) !== 1) die('占位块锚点不唯一，中止');
const lineNew = '{ t: "ACT 菜单与行动对话", lang: "img", b: "' + uri + '" }';
ex = ex.replace(lineOld, lineNew);
fs.writeFileSync(exPath, ex, { encoding: 'utf8' });

// ---------- vm 载入验证 ----------
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
const sandbox = { window: {} };
vm.createContext(sandbox);
try { vm.runInContext(ex2, sandbox); } catch (e) { die('vm 解析失败: ' + e.message); }
const EXS = sandbox.window.EXAMPLES;
if (!Array.isArray(EXS) || EXS.length !== 2) die('EXAMPLES 数量 != 2');
const e2 = EXS[1];
const langs = (e2.code || []).map(c => c.lang).join(',');
if (langs !== 'gml,gml,gml,text,img') die('lang 序列不对: ' + langs);
const imgBlock = e2.code.find(c => c.lang === 'img');
if (!imgBlock || imgBlock.b.indexOf('data:image/gif;base64,') !== 0) die('img 块未填真图');
if (imgBlock.t !== 'ACT 菜单与行动对话') die('img 块标题未更新: ' + imgBlock.t);
if (e2.code.some(c => (c.b || '').indexOf('待补') >= 0)) die('仍有「待补」占位残留');
out('vm 载入验证通过：第 2 篇 img 块已填真图（标题「ACT 菜单与行动对话」），无占位残留');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_img_fill2.txt', LOG.join('\n'), { encoding: 'utf8' });
