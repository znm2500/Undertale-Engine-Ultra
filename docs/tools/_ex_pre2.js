// 示例第 2 篇：加「先注释掉 turn_test」准备块（code 首位），files 说明同步
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_ex_pre2.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 备份 ----------
fs.copyFileSync(BASE + 'manual-examples.js', BASE + '_bak20-manual-examples.js');
out('备份完成: _bak20-manual-examples.js');

// ---------- 1. manual-examples.js ----------
const exPath = BASE + 'manual-examples.js';
let ex = fs.readFileSync(exPath, { encoding: 'utf8' });

// 1a. code 数组首位插入准备块
const codeAnchor = '  code: [\n    { t: "User Event 0 · INIT';
if (count(ex, codeAnchor) !== 1) die('code 数组开头锚点不唯一，中止');
const frag = fs.readFileSync(BASE + 'tools/_ex2c_prep.txt', { encoding: 'utf8' });
ex = ex.replace(codeAnchor, '  code: [\n' + frag + ',\n    { t: "User Event 0 · INIT');

// 1b. files 说明同步（UE8 不再「不动」）
const filesOld = 'battle_enemy_test 已有的 UE8（生成 turn_test）不动，另加两个事件：\nUser Event 0（INIT）设置敌人属性并注册行动选项，User Event 5（MENU_END）写行动对话。';
if (count(ex, filesOld) !== 1) die('files 锚点不唯一，中止');
const filesNew = '本篇要动 battle_enemy_test 三个地方：先注释掉 UE8 里的 turn_test 生成\n（不然每回合都冒弹幕，没法安心看对话），再加两个事件 ——\nUser Event 0（INIT）设置敌人属性并注册行动选项，User Event 5（MENU_END）写行动对话。';
ex = ex.replace(filesOld, filesNew);

fs.writeFileSync(exPath, ex, { encoding: 'utf8' });

// ---------- 2. vm 载入验证 ----------
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
const sandbox = { window: {} };
vm.createContext(sandbox);
try { vm.runInContext(ex2, sandbox); } catch (e) { die('vm 解析失败: ' + e.message); }
const EXS = sandbox.window.EXAMPLES;
if (!Array.isArray(EXS) || EXS.length !== 2) die('EXAMPLES 数量 != 2');
const e2 = EXS[1];
const langs = (e2.code || []).map(c => c.lang).join(',');
if (langs !== 'gml,gml,gml,text,img') die('lang 序列不对: ' + langs);
if (e2.code[0].t.indexOf('先注释掉 turn_test') < 0) die('准备块标题不对');
if (e2.code[0].b.indexOf('// instance_create_depth(0,0,0,turn_test)') < 0) die('准备块缺注释行');
if (e2.code[0].b.indexOf('instance_create_depth(0,0,0,turn_test)\n') < 0) die('准备块缺原文行');
if (e2.files[0].b.indexOf('先注释掉 UE8') < 0) die('files 未同步');
out('vm 载入验证通过：准备块在 code 首位（lang 序列 gml,gml,gml,text,img），files 已同步');

// ---------- 3. _verify.js 加断言 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const aOld = "  ['示例2 详情 无 undefined', !hOne2.includes('undefined')],";
if (count(v, aOld) !== 1) die('_verify 示例2 断言锚点不唯一，中止');
const aNew = "  ['示例2 有 turn_test 准备步骤', hOne2.includes('先注释掉 turn_test')],\n" + aOld;
v = v.replace(aOld, aNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('示例2 有 turn_test 准备步骤')) die('_verify 写回断言失败');
out('_verify.js: 加断言「示例2 有 turn_test 准备步骤」');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_ex_pre2.txt', LOG.join('\n'), { encoding: 'utf8' });
