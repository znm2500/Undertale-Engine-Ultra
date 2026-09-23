// 写入示例第 2 篇：ex_enemy_test_acts（行动选项与行动对话）
// 片段文件方式插入（片段含反引号/换行，脚本只做锚点替换），vm 载入验证数据结构
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_ex_write2.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 备份 ----------
fs.copyFileSync(BASE + 'manual-examples.js', BASE + '_bak17-manual-examples.js');
fs.copyFileSync(BASE + 'tools/_verify.js', BASE + 'tools/_verify.js.bak7');
out('备份完成: _bak17-manual-examples.js / _verify.js.bak7');

// ---------- 1. manual-examples.js 插入第 2 篇 ----------
const exPath = BASE + 'manual-examples.js';
let ex = fs.readFileSync(exPath, { encoding: 'utf8' });
const frag = fs.readFileSync(BASE + 'tools/_ex2_fragment.txt', { encoding: 'utf8' });

// 锚点：第 1 篇条目结尾（files/code 数组闭合 + 条目闭合 + 数组闭合）
const anchor = '  ]\n}\n];';
if (count(ex, anchor) !== 1) die('插入锚点不唯一（注意行尾格式），中止');
const replacement = '  ]\n},\n\n' + frag + '\n];';
ex = ex.replace(anchor, replacement);

fs.writeFileSync(exPath, ex, { encoding: 'utf8' });

// ---------- 2. vm 载入验证数据结构 ----------
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
const sandbox = { window: {} };
vm.createContext(sandbox);
try { vm.runInContext(ex2, sandbox); } catch (e) { die('vm 解析失败: ' + e.message); }
const EXS = sandbox.window.EXAMPLES;
if (!Array.isArray(EXS) || EXS.length !== 2) die('EXAMPLES 数量 != 2，实际 ' + (EXS && EXS.length));
const e2 = EXS[1];
if (e2.id !== 'ex_enemy_test_acts') die('第 2 篇 id 不对: ' + e2.id);
if (e2.level !== '进阶') die('第 2 篇 level 不对: ' + e2.level);
const langs = (e2.code || []).map(c => c.lang);
if (langs.join(',') !== 'gml,gml,text,img') die('code 块 lang 序列不对: ' + langs.join(','));
for (const c of e2.code) {
  if (typeof c.b !== 'string' || !c.b.length) die('code 块 b 为空: ' + c.t);
  if (typeof c.t !== 'string' || !c.t.length) die('code 块 t 为空');
}
if (EXS[0].id !== 'ex_encounter_battle_enemy_test') die('第 1 篇 id 被破坏');
out('manual-examples.js: 第 2 篇已插入，vm 载入验证通过（EXAMPLES=2，lang 序列 gml,gml,text,img）');

// ---------- 3. _verify.js 断言更新 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });

// 3a. 分级断言 1 -> 2
const gOld = "  ['示例分级标题为 1（仅入门）', (hEx.match(/class=\"exgrt\"/g) || []).length === 1],";
if (count(v, gOld) !== 1) die('_verify 分级断言锚点不唯一，中止');
const gNew = "  ['示例分级标题为 2（入门+进阶）', (hEx.match(/class=\"exgrt\"/g) || []).length === 2],";
v = v.replace(gOld, gNew);

// 3b. hOne2 渲染
const hOneAnchor = "const hOne = view('示例详情 ex_encounter_battle_enemy_test', 'curExLv=\"all\";curEx=\"ex_encounter_battle_enemy_test\";renderExamples()');";
if (count(v, hOneAnchor) !== 1) die('_verify hOne 锚点不唯一，中止');
const hOneAdd = hOneAnchor + "\nconst hOne2 = view('示例详情 ex_enemy_test_acts', 'curExLv=\"all\";curEx=\"ex_enemy_test_acts\";renderExamples()');";
v = v.replace(hOneAnchor, hOneAdd);

// 3c. 新断言
const chkAnchor = "  ['示例详情 有返回链接与代码', hOne.includes('返回示例列表') && hOne.includes('Encounter_Start')],";
if (count(v, chkAnchor) !== 1) die('_verify 详情断言锚点不唯一，中止');
const chkAdd = "  ['示例2 详情 有返回链接与 ACT', hOne2.includes('返回示例列表') && hOne2.includes('BATTLE_MENU_CHOICE_BUTTON')],\n  ['示例2 详情 无 undefined', !hOne2.includes('undefined')],\n" + chkAnchor;
v = v.replace(chkAnchor, chkAdd);

fs.writeFileSync(verPath, v, { encoding: 'utf8' });
const v2 = fs.readFileSync(verPath, { encoding: 'utf8' });
if (!v2.includes('hOne2') || !v2.includes('示例分级标题为 2')) die('_verify 写回重读断言失败');
out('_verify.js: 分级断言改 2、hOne2 渲染、示例2 两条断言已加');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_ex_write2.txt', LOG.join('\n'), { encoding: 'utf8' });
