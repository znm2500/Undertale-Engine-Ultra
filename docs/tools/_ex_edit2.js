// 示例第 2 篇修订：加「设置敌人属性」内容，level 进阶 -> 入门
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_ex_edit2.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- 备份 ----------
fs.copyFileSync(BASE + 'manual-examples.js', BASE + '_bak18-manual-examples.js');
fs.copyFileSync(BASE + 'tools/_verify.js', BASE + 'tools/_verify.js.bak8');
out('备份完成: _bak18-manual-examples.js / _verify.js.bak8');

// ---------- 1. manual-examples.js 五处替换 ----------
const exPath = BASE + 'manual-examples.js';
let ex = fs.readFileSync(exPath, { encoding: 'utf8' });
const rep = (oldS, newS, tag) => {
  if (count(ex, oldS) !== 1) die('锚点不唯一/未找到 [' + tag + ']，中止');
  ex = ex.replace(oldS, newS);
  out('替换 OK: ' + tag);
};

// 1a. level
rep('  level: "进阶",', '  level: "入门",', 'level');

// 1b. title
rep('title: "给 battle_enemy_test 加行动选项和行动对话（ACT）",',
    'title: "给 battle_enemy_test 设置属性、行动选项和行动对话",', 'title');

// 1c. scene
rep('scene: "第 1 篇里 battle_enemy_test 没写 INIT，ACT 菜单是空的。这一篇给它补上：注册 3 个行动选项，按玩家的选择返回行动对话，再让「讨好」两次变可饶恕 —— 顺便看清「菜单 → 对话 → 回合」是怎么自动衔接的。",',
    'scene: "第 1 篇里 battle_enemy_test 没写 INIT，名字数值都是默认值、ACT 菜单是空的。这一篇在 INIT 里把敌人属性（名字 / 防御）和行动选项一次配齐，再按玩家的选择返回行动对话，让「讨好」两次变可饶恕 —— 顺便看清「菜单 → 对话 → 回合」是怎么自动衔接的。",', 'scene');

// 1d. files 说明行
rep('User Event 0（INIT）注册行动选项，User Event 5（MENU_END）写行动对话。',
    'User Event 0（INIT）设置敌人属性并注册行动选项，User Event 5（MENU_END）写行动对话。', 'files');

// 1e. INIT 块整块替换（片段文件）
const frag = fs.readFileSync(BASE + 'tools/_ex2b_init.txt', { encoding: 'utf8' });
const iStartStr = '    { t: "User Event 0 · INIT —— 注册行动选项"';
if (count(ex, iStartStr) !== 1) die('INIT 块起点锚点不唯一，中止');
const iStart = ex.indexOf(iStartStr);
const iEndMark = '` },';
const iEnd = ex.indexOf(iEndMark, iStart);
if (iEnd < 0) die('INIT 块结束锚点未找到，中止');
ex = ex.slice(0, iStart) + frag + ex.slice(iEnd + iEndMark.length);
out('替换 OK: INIT 块整块');

// 1f. 「检查」对话 DEF 数值与设置保持一致
rep('Battle_SetDialog("* battle_enemy_test —— ATK 0 DEF 0\\n* 引擎自带的测试敌人，只负责验证遭遇战。");',
    'Battle_SetDialog("* battle_enemy_test —— ATK 0 DEF 1\\n* 引擎自带的测试敌人，只负责验证遭遇战。");', 'case0');

fs.writeFileSync(exPath, ex, { encoding: 'utf8' });

// ---------- 2. vm 载入验证 ----------
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
const sandbox = { window: {} };
vm.createContext(sandbox);
try { vm.runInContext(ex2, sandbox); } catch (e) { die('vm 解析失败: ' + e.message); }
const EXS = sandbox.window.EXAMPLES;
if (!Array.isArray(EXS) || EXS.length !== 2) die('EXAMPLES 数量 != 2');
const e2 = EXS[1];
if (e2.id !== 'ex_enemy_test_acts') die('id 不对');
if (e2.level !== '入门') die('level != 入门: ' + e2.level);
if (e2.title.indexOf('设置属性') < 0) die('title 未更新');
if (e2.code[0].b.indexOf('Battle_SetEnemyDEF') < 0) die('INIT 块缺 Battle_SetEnemyDEF');
if (e2.code[0].b.indexOf('敌人属性') < 0) die('INIT 块缺属性注释');
if (e2.code[1].b.indexOf('DEF 1') < 0) die('case0 对话未同步 DEF 1');
out('vm 载入验证通过：EXAMPLES=2、level=入门、属性内容已进 INIT 块');

// ---------- 3. _verify.js 断言更新 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const gOld = "  ['示例分级标题为 2（入门+进阶）', (hEx.match(/class=\"exgrt\"/g) || []).length === 2],";
if (count(v, gOld) !== 1) die('_verify 分级断言锚点不唯一，中止');
const gNew = "  ['示例分级标题为 1（均为入门）', (hEx.match(/class=\"exgrt\"/g) || []).length === 1],";
v = v.replace(gOld, gNew);
const cOld = "  ['示例2 详情 有返回链接与 ACT', hOne2.includes('返回示例列表') && hOne2.includes('BATTLE_MENU_CHOICE_BUTTON')],";
if (count(v, cOld) !== 1) die('_verify 示例2 断言锚点不唯一，中止');
const cNew = "  ['示例2 详情 有属性与ACT', hOne2.includes('Battle_SetEnemyDEF') && hOne2.includes('BATTLE_MENU_CHOICE_BUTTON')],";
v = v.replace(cOld, cNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('示例分级标题为 1（均为入门）')) die('_verify 写回断言失败');
out('_verify.js: 分级断言改「1（均为入门）」、示例2 断言加 Battle_SetEnemyDEF');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_ex_edit2.txt', LOG.join('\n'), { encoding: 'utf8' });
