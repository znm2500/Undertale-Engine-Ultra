// 写入示例第 3 篇：ex_item_heal_potion（自定义药品 + 战斗使用，入门）
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_ex_write3.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 开工核对：上轮改动是否被外部覆盖 ----------
const chk = fs.readFileSync(BASE + 'manual-examples.js', { encoding: 'utf8' });
for (const mark of ['img/ex1-battle-turn_test.gif', 'img/ex2-act-menu-dialog.gif', '先注释掉 turn_test']) {
  if (!chk.includes(mark)) die('上轮关键标记丢失 [' + mark + ']，文件疑被外部覆盖，先排查再继续');
}
out('开工核对通过：外链图 ×2、准备块均在');

// ---------- 备份 ----------
fs.copyFileSync(BASE + 'manual-examples.js', BASE + '_tmp-manual-examples.js');

// ---------- 插入第 3 篇（文件末尾，片段自带 /* === 3 === */ 头） ----------
const exPath = BASE + 'manual-examples.js';
let ex = fs.readFileSync(exPath, { encoding: 'utf8' });
const anchor = '\n  ]\n}\n];';
if (count(ex, anchor) !== 1) die('文件末尾锚点不唯一，中止');
const frag = fs.readFileSync(BASE + 'tools/_ex3_fragment.txt', { encoding: 'utf8' });
ex = ex.replace(anchor, '\n  ]\n},\n\n' + frag + '\n];');

fs.writeFileSync(exPath, ex, { encoding: 'utf8' });

// ---------- vm 载入验证 ----------
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
const sandbox = { window: {} };
vm.createContext(sandbox);
try { vm.runInContext(ex2, sandbox); } catch (e) { die('vm 解析失败: ' + e.message); }
const EXS = sandbox.window.EXAMPLES;
if (!Array.isArray(EXS) || EXS.length !== 3) die('EXAMPLES 数量 != 3，实际 ' + (EXS && EXS.length));
const e3 = EXS[2];
if (e3.id !== 'ex_item_heal_potion') die('第 3 篇 id 不对: ' + e3.id);
if (e3.level !== '入门') die('level != 入门');
const langs = e3.code.map(c => c.lang).join(',');
if (langs !== 'gml,gml,text,img') die('lang 序列不对: ' + langs);
if (e3.code[0].b.indexOf('CustomItem_Medicine') < 0 || e3.code[0].b.indexOf('Player_Heal(20)') < 0) die('药品本体缺关键代码');
if (e3.code[1].b.indexOf('Item_GetTypeManager().Register') < 0 || e3.code[1].b.indexOf('Add(ITEM_MEDICINE)') < 0) die('注册/发放块缺关键代码');
for (let i = 0; i < 2; i++) {
  const img = EXS[i].code.find(c => c.lang === 'img');
  if (!img || !/^img\//.test(img.b)) die('第 ' + (i + 1) + ' 篇 img 外链丢失');
}
if (e3.code.find(c => c.lang === 'img').b.indexOf('data:') === 0) die('第 3 篇不该用 base64');
out('vm 载入验证通过：EXAMPLES=3，lang 序列 gml,gml,text,img，前两篇外链图未受影响');

// ---------- _verify.js 断言更新 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });

// 1) hOne3 渲染（插在 hOne2 后）
const h2Anchor = "const hOne2 = view('示例详情 ex_enemy_test_acts', 'curExLv=\"all\";curEx=\"ex_enemy_test_acts\";renderExamples()');";
if (count(v, h2Anchor) !== 1) die('_verify hOne2 锚点不唯一，中止');
v = v.replace(h2Anchor, h2Anchor + "\nconst hOne3 = view('示例详情 ex_item_heal_potion', 'curExLv=\"all\";curEx=\"ex_item_heal_potion\";renderExamples()');");

// 2) 「无待补占位」改为「无 base64 图片残留」（第 3 篇合法存在占位）
const pOld = "  ['示例无待补占位残留', !hEx.includes('待补') && !hEx.includes('画面占位')],";
if (count(v, pOld) !== 1) die('_verify 占位断言锚点不唯一，中止');
const pNew = "  ['示例无 base64 图片残留', !hEx.includes('data:image')],";
v = v.replace(pOld, pNew);

// 3) 示例3 断言（插在示例2 断言后）
const c2Anchor = "  ['示例2 有 turn_test 准备步骤', hOne2.includes('先注释掉 turn_test')],";
if (count(v, c2Anchor) !== 1) die('_verify 示例2 断言锚点不唯一，中止');
const c2Add = c2Anchor + "\n  ['示例3 详情 有药品与战斗链路', hOne3.includes('CustomItem_Medicine') && hOne3.includes('InvokeItemUse')],\n  ['示例3 详情 无 undefined', !hOne3.includes('undefined')],";
v = v.replace(c2Anchor, c2Add);

fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('示例3 详情 有药品与战斗链路')) die('_verify 写回断言失败');
out('_verify.js: hOne3 渲染、占位断言改「无 base64 残留」、示例3 两条断言已加');

fs.unlinkSync(BASE + '_tmp-manual-examples.js');
out('临时备份已删除');
out('ALL OK');
fs.writeFileSync(BASE + 'tools/_ex_write3.txt', LOG.join('\n'), { encoding: 'utf8' });
