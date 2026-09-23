// 图片外置迁移：
// 1) 两张 data URI GIF 解码落盘 docs/img/*.gif
// 2) manual-examples.js 的 b 换成相对路径
// 3) HTML imgBlock() 加 img/ 路径分支（+ lazy）
// 4) _verify.js 断言同步
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_img_ext.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 1. 抽图 ----------
const exPath = BASE + 'manual-examples.js';
const tmpBak = BASE + '_tmp-manual-examples.js';
fs.copyFileSync(exPath, tmpBak);

let ex = fs.readFileSync(exPath, { encoding: 'utf8' });
const marker = 'data:image/gif;base64,';
let n = count(ex, marker);
if (n !== 2) die('data URI GIF 数量 != 2（实际 ' + n + '），中止');
if (!fs.existsSync(BASE + 'img')) fs.mkdirSync(BASE + 'img');

const names = ['img/ex1-battle-turn_test.gif', 'img/ex2-act-menu-dialog.gif'];
for (let i = 0; i < 2; i++) {
  const start = ex.indexOf(marker);
  const vStart = start + marker.length;
  const vEnd = ex.indexOf('"', vStart);
  const b64 = ex.slice(vStart, vEnd);
  const buf = Buffer.from(b64, 'base64');
  if (buf.length < 1000) die('第 ' + (i + 1) + ' 张图解码过小，中止');
  fs.writeFileSync(BASE + names[i], buf);
  out('落盘 ' + names[i] + ' (' + buf.length + ' B)');
  // 替换该处 data URI 为路径（只替换这一个 b 值）
  ex = ex.slice(0, start) + names[i] + ex.slice(vEnd);
}
if (count(ex, marker) !== 0) die('data URI 未清零，中止');

fs.writeFileSync(exPath, ex, { encoding: 'utf8' });

// ---------- 2. vm 验证 ----------
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
const sandbox = { window: {} };
vm.createContext(sandbox);
try { vm.runInContext(ex2, sandbox); } catch (e) { die('vm 解析失败: ' + e.message); }
const EXS = sandbox.window.EXAMPLES;
if (!Array.isArray(EXS) || EXS.length !== 2) die('EXAMPLES 数量 != 2');
for (let i = 0; i < 2; i++) {
  const img = EXS[i].code.find(c => c.lang === 'img');
  if (!img || !/^img\//.test(img.b)) die('第 ' + (i + 1) + ' 篇 img 块路径不对: ' + (img && img.b));
}
if (ex2.length > 100000) die('文件仍偏大（' + ex2.length + 'B），疑似未瘦身');
out('manual-examples.js: 两处 b 已换为相对路径，文件 ' + ex2.length + ' B（原 ~2.9MB）');

// ---------- 3. HTML imgBlock() 改造 ----------
const htmlPath = BASE + 'UNDERTALE-Engine-Ultra-手册.html';
let h = fs.readFileSync(htmlPath, { encoding: 'utf8' });
const fnRe = /function imgBlock\(b\)\{[\s\S]*?\}/;
const fm = h.match(fnRe);
if (!fm || count(h, 'function imgBlock(b){') !== 1) die('imgBlock 函数定位失败，中止');
out('旧 imgBlock: ' + fm[0]);
if (!fm[0].includes('data:image') || !fm[0].includes('imgph')) die('imgBlock 旧体不含预期分支，中止');
const fnNew = 'function imgBlock(b){ if(/^data:image\\//.test(b)) return \'<img class="imgpic" loading="lazy" src="\'+b+\'" alt="">\'; if(/^img\\//.test(b)) return \'<img class="imgpic" loading="lazy" src="\'+esc(b)+\'" alt="">\'; return \'<div class="imgph">\'+esc(b||\'截图 / GIF 待补\')+\'</div>\'; }';
h = h.replace(fnRe, fnNew);
fs.writeFileSync(htmlPath, h, { encoding: 'utf8' });
const h2 = fs.readFileSync(htmlPath, { encoding: 'utf8' });
if (!h2.includes('loading="lazy" src="\'+esc(b)') || !h2.includes('if(/^img\\//.test(b))')) die('HTML 写回重读断言失败');
out('HTML: imgBlock 支持 img/ 相对路径 + lazy，data URI 分支保留兼容');

// ---------- 4. _verify.js 断言同步 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const aOld = "  ['示例画面块渲染正常（真图）', hEx.includes('imgpic') && hEx.includes('data:image/gif;base64')],";
if (count(v, aOld) !== 1) die('_verify 画面块断言锚点不唯一，中止');
const aNew = "  ['示例画面块渲染正常（外链图）', hEx.includes('imgpic') && (hEx.match(/<img class=\"imgpic\" loading=\"lazy\" src=\"img\\//g) || []).length === 2],\n  ['示例图片文件已落盘', ['img/ex1-battle-turn_test.gif','img/ex2-act-menu-dialog.gif'].every(f => fs.existsSync(path + f))],";
v = v.replace(aOld, aNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('示例图片文件已落盘')) die('_verify 写回断言失败');
out('_verify.js: 画面块断言改为外链图 ×2 + 文件落盘检查');

fs.unlinkSync(tmpBak);
out('临时备份已删除');
out('ALL OK');
fs.writeFileSync(BASE + 'tools/_img_ext.txt', LOG.join('\n'), { encoding: 'utf8' });
