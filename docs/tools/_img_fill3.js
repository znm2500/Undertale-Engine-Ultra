// 示例第 3 篇画面占位 → 外链图（img/ 约定）：复制 GIF 到 docs/img/ + 替换占位块
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const GIF = 'C:/Users/Weaver/Desktop/屏幕录制 2026-09-23 224427.gif';
const DEST = BASE + 'img/ex3-battle-use-medicine.gif';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_img_fill3.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 复制 GIF ----------
let buf;
try { buf = fs.readFileSync(GIF); } catch (e) { die('读 GIF 失败: ' + e.message); }
if (buf.length < 1000) die('GIF 过小(' + buf.length + 'B)，疑似读取错误，中止');
fs.writeFileSync(DEST, buf);
out('GIF 已落盘 ' + DEST + ' (' + buf.length + ' B)');

// ---------- 替换占位块 ----------
const exPath = BASE + 'manual-examples.js';
let ex = fs.readFileSync(exPath, { encoding: 'utf8' });
const lineOld = '{ t: "画面占位 · 战斗中使用药水", lang: "img", b: "战斗 ITEM 菜单选中 Medicine 使用的画面（截图待补）" }';
if (count(ex, lineOld) !== 1) die('占位块锚点不唯一，中止');
const lineNew = '{ t: "战斗中使用药水", lang: "img", b: "img/ex3-battle-use-medicine.gif" }';
ex = ex.replace(lineOld, lineNew);
fs.writeFileSync(exPath, ex, { encoding: 'utf8' });

// ---------- vm 验证 ----------
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
const sandbox = { window: {} };
vm.createContext(sandbox);
try { vm.runInContext(ex2, sandbox); } catch (e) { die('vm 解析失败: ' + e.message); }
const EXS = sandbox.window.EXAMPLES;
if (!Array.isArray(EXS) || EXS.length !== 3) die('EXAMPLES 数量 != 3');
for (let i = 0; i < 3; i++) {
  const img = EXS[i].code.find(c => c.lang === 'img');
  if (!img || !/^img\//.test(img.b) || !fs.existsSync(BASE + img.b)) die('第 ' + (i + 1) + ' 篇 img 外链异常: ' + (img && img.b));
}
if (ex2.includes('待补') || ex2.includes('data:image')) die('仍有占位文字或 base64 残留');
out('vm 验证通过：三篇 img 块全部外链图且文件在盘，无占位/base64 残留');

// ---------- _verify.js：外链图计数 2 → 3 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const aOld = '(hEx.match(/<img class=\\"imgpic\\" loading=\\"lazy\\" src=\\"img\\\\//g) || []).length === 2]';
const aNew = '(hEx.match(/<img class=\\"imgpic\\" loading=\\"lazy\\" src=\\"img\\\\//g) || []).length === 3]';
if (count(v, aOld) !== 1) die('_verify 外链图计数锚点不唯一，中止');
v = v.replace(aOld, aNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('length === 3]')) die('_verify 写回断言失败');
out('_verify.js: 外链图计数 2 → 3');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_img_fill3.txt', LOG.join('\n'), { encoding: 'utf8' });
