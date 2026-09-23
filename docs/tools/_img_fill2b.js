// 重填第 2 篇 ACT 动图（上轮填入后文件被外部工具用旧缓冲覆盖，img 块回到占位）
// 同时给 _verify.js 加「无待补占位」断言防回退
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const GIF = 'C:/Users/Weaver/Desktop/屏幕录制 2026-09-22 115229.gif';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_img_fill2b.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 读 GIF ----------
let buf;
try { buf = fs.readFileSync(GIF); } catch (e) { die('读 GIF 失败: ' + e.message); }
if (buf.length < 1000) die('GIF 过小(' + buf.length + 'B)，疑似读取错误，中止');
const uri = 'data:image/gif;base64,' + buf.toString('base64');
out('GIF 读取成功: ' + buf.length + ' bytes → base64 ' + uri.length + ' chars');

// ---------- 替换（不落备份文件：本轮无其他改动，失败即中止原文件未写） ----------
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
const imgs = EXS.map(e => e.code.find(c => c.lang === 'img'));
if (imgs.some(b => !b || b.b.indexOf('data:image/gif;base64,') !== 0)) die('有 img 块未填真图');
if (ex2.includes('待补')) die('仍有「待补」占位残留');
const langs = EXS[1].code.map(c => c.lang).join(',');
if (langs !== 'gml,gml,gml,text,img') die('第 2 篇 lang 序列不对: ' + langs);
out('vm 载入验证通过：两篇 img 块均为真图，无占位残留');

// ---------- _verify.js 加防回退断言 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const aOld = "  ['示例画面块渲染正常（真图）', hEx.includes('imgpic') && hEx.includes('data:image/gif;base64')],";
if (count(v, aOld) !== 1) die('_verify 画面块断言锚点不唯一，中止');
const aNew = aOld + "\n  ['示例无待补占位残留', !hEx.includes('待补') && !hEx.includes('画面占位')],";
v = v.replace(aOld, aNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('示例无待补占位残留')) die('_verify 写回断言失败');
out('_verify.js: 加断言「示例无待补占位残留」');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_img_fill2b.txt', LOG.join('\n'), { encoding: 'utf8' });
