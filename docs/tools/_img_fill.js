// 示例画面占位 → 真图：把 ex_encounter_battle_enemy_test 的 img 占位块
// 换成用户桌面 GIF（屏幕录制 2026-09-22 010222.gif）的 base64 data URI
// 注意：manual-examples.js 是带注释/模板字符串的 JS，不能 JSON.stringify 回写，
//       必须精确锚点替换（先断言唯一）。
const fs = require('fs');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const GIF = 'C:/Users/Weaver/Desktop/屏幕录制 2026-09-22 010222.gif';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_img_fill.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 读 GIF → data URI ----------
let buf;
try { buf = fs.readFileSync(GIF); } catch (e) { die('读 GIF 失败: ' + e.message); }
if (buf.length < 1000) die('GIF 过小(' + buf.length + 'B)，疑似读取错误，中止');
const uri = 'data:image/gif;base64,' + buf.toString('base64');
out('GIF 读取成功: ' + buf.length + ' bytes → base64 ' + uri.length + ' chars');

// ---------- 备份 ----------
fs.copyFileSync(BASE + 'manual-examples.js', BASE + '_bak15-manual-examples.js');
fs.copyFileSync(BASE + 'tools/_verify.js', BASE + 'tools/_verify.js.bak6');
out('备份完成: _bak15-manual-examples.js / _verify.js.bak6');

// ---------- manual-examples.js 替换 ----------
const exPath = BASE + 'manual-examples.js';
let ex = fs.readFileSync(exPath, { encoding: 'utf8' });

const bOld = 'battle_enemy_test 的战斗画面：矩形战斗框 + 蓝色灵魂（截图 / GIF 待补）';
const tOld = '画面占位 · 战斗中的 turn_test';
if (count(ex, bOld) !== 1) die('占位 b 锚点不唯一，中止');
if (count(ex, tOld) !== 1) die('占位 t 锚点不唯一，中止');

const lineOld = '{ t: "' + tOld + '", lang: "img", b: "' + bOld + '" }';
if (count(ex, lineOld) !== 1) die('整行锚点不唯一，中止');
const lineNew = '{ t: "战斗画面 · turn_test", lang: "img", b: "' + uri + '" }';
ex = ex.replace(lineOld, lineNew);

fs.writeFileSync(exPath, ex, { encoding: 'utf8' });
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
if (!ex2.includes('data:image/gif;base64,') || ex2.includes(bOld) || ex2.includes(tOld)) {
  die('manual-examples.js 写回重读断言失败');
}
out('manual-examples.js: 占位块已替换为真图 data URI（标题改「战斗画面 · turn_test」），重读断言通过');

// ---------- _verify.js 断言更新 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const vOld = "  ['示例画面占位渲染正常', hEx.includes('imgph')],";
if (count(v, vOld) !== 1) die('_verify 断言锚点不唯一，中止');
const vNew = "  ['示例画面块渲染正常（真图）', hEx.includes('imgpic') && hEx.includes('data:image/gif;base64')],";
v = v.replace(vOld, vNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('data:image/gif;base64')) die('_verify 写回断言失败');
out('_verify.js: 断言改为「示例画面块渲染正常（真图）」');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_img_fill.txt', LOG.join('\n'), { encoding: 'utf8' });
