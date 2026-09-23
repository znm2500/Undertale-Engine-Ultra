// 把「战斗画面 · turn_test」img 块删除，GIF 挪到「进战斗后会发生什么」text 块之后
// （用户澄清：GIF 是「进战斗后会发生什么」的动图，独立块标题不成立）
const fs = require('fs');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_img_move.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

const exPath = BASE + 'manual-examples.js';
let ex = fs.readFileSync(exPath, { encoding: 'utf8' });

// ---------- 备份 ----------
fs.copyFileSync(exPath, BASE + '_bak16-manual-examples.js');
out('备份完成: _bak16-manual-examples.js');

// ---------- 1. 捕获并删除 img 块整行 ----------
const imgHead = '    { t: "战斗画面 · turn_test", lang: "img", b: "data:image/gif;base64,';
if (count(ex, imgHead) !== 1) die('img 块锚点不唯一/不存在，中止');
const iStart = ex.indexOf(imgHead);
const iEnd = ex.indexOf('" },', iStart);
if (iEnd < 0) die('img 块结束锚点未找到，中止');
const iLineEnd = iEnd + 4; // 含 '" },'
// 吃掉行尾换行（\r\n 或 \n）
let iAfter = iLineEnd;
if (ex[iAfter] === '\r') iAfter++;
if (ex[iAfter] === '\n') iAfter++;
const imgLine = ex.slice(iStart, iLineEnd); // 不含换行
if (!imgLine.endsWith('" },')) die('img 块捕获异常，中止');
// 换新标题
const imgLineNew = imgLine.replace('t: "战斗画面 · turn_test"', 't: "进战斗后会发生什么 · 动图"');
if (!imgLineNew.includes('进战斗后会发生什么 · 动图')) die('标题替换失败，中止');

ex = ex.slice(0, iStart) + ex.slice(iAfter);
if (count(ex, 'data:image/gif;base64,') !== 0) die('删除后仍有 data URI 残留，中止');
out('原 img 块已删除（GIF data URI 已捕获）');

// ---------- 2. 在 text 块之后插入 ----------
const textEnd = '  这个示例只负责验证「遭遇战流程」，敌人本体怎么写是下一步的事。` },';
if (count(ex, textEnd) !== 1) die('text 块结束锚点不唯一，中止');
ex = ex.replace(textEnd, textEnd + '\n' + imgLineNew);

fs.writeFileSync(exPath, ex, { encoding: 'utf8' });
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
if (count(ex2, 'data:image/gif;base64,') !== 1) die('写回后 data URI 数量 != 1，中止');
if (!ex2.includes('进战斗后会发生什么 · 动图')) die('写回后新标题缺失，中止');
if (ex2.includes('战斗画面 · turn_test')) die('写回后旧标题残留，中止');
// 顺序断言：text 结束锚点在 img 块之前
if (ex2.indexOf(textEnd) > ex2.indexOf('进战斗后会发生什么 · 动图')) die('插入顺序错误，中止');
out('img 块已插入「进战斗后会发生什么」text 块之后（标题：进战斗后会发生什么 · 动图），重读断言通过');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_img_move.txt', LOG.join('\n'), { encoding: 'utf8' });
