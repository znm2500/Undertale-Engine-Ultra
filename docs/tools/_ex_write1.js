// 新示例：用自带 battle_enemy_test 跑通遭遇战（编号口径 = User Event 0~13，修正后）
// 同步把 _verify.js 三条空态断言改回有数据断言
const fs = require('fs');

const DOCS = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const EX = DOCS + 'manual-examples.js';
const VERIFY = DOCS + 'tools/_verify.js';
const LOGP = DOCS + 'tools/_ex_write1.txt';

const lines = [];
function log(x) { lines.push(x); console.log(x); }

// ---------- 0. 备份 ----------
fs.copyFileSync(EX, DOCS + '_bak10-manual-examples.js');
fs.copyFileSync(VERIFY, DOCS + 'tools/_verify.js.bak2');
log('备份完成: _bak10-manual-examples.js / _verify.js.bak2');

// ---------- 1. 写新示例 ----------
const DATA = `/* =========================================================================
   UT/DR — UNDERTALE Engine Ultra  ·  可玩示例集
   2026-09-22 重写第 1 篇。条目结构：
   { id, title, level(入门/进阶/实用/必读), scene, files:[{t,b}], code:[{t,b,lang}] }
   ========================================================================= */
window.EXAMPLES = [

/* ==================== 1. 用自带示例敌人跑通遭遇战 ==================== */
{
  id: "ex_encounter_battle_enemy_test",
  title: "用自带示例敌人跑通遭遇战（battle_enemy_test）",
  level: "入门",
  scene: "不改一行敌人逻辑，用引擎自带的 battle_enemy_test 跑通「地图触发 → 遭遇动画 → 战斗 → 回到地图」全流程，顺便看懂遭遇战是怎么注册的。",
  files: [
    { t: "新建物体 obj_encounter_trigger", b: \`Parent 设为 trigger —— 引擎会在玩家碰到它时自动调用它的 User Event 0
Sprite 可以不设（隐形触发区），拖一个到示例地图 room_area_0 的通道上\` }
  ],
  code: [
    { t: "注册遭遇 · Encounter_Custom.gml（引擎已经替你写好）", lang: "gml", b: \`// scripts/Encounter_Custom/Encounter_Custom.gml —— 引擎默认内容就是这行：
function Encounter_Custom() {
    Encounter_Set(0, -1, battle_enemy_test, -1,
        "* {effect 0}You {effect 1}encoun{effect 2}tered nothing!", -1);
}

// 展开成完整参数是这样（后 6 个可省略，默认值见注释）：
// Encounter_Set(
//     id,                        // 遭遇编号，>=0；同号重复注册会覆盖旧配置
//     enemy_0,                   // 敌人物体 1
//     enemy_1, enemy_2,          // 敌人物体 2 / 3，没有就填 -1
//     menu_dialog,               // 进战斗时的菜单台词，{effect N} 是文字特效标记
//     bgm,                       // 战斗 BGM，-1 = 不播（默认）
//     menu_mercy_flee_enabled,   // MERCY 菜单能否「逃跑」，默认 true
//     pause_bgm,                 // 进战斗时暂停地图 BGM，默认 true
//     quick,                     // 快速遭遇，默认 false
//     soul_x, soul_y             // 灵魂初始位置，默认 48, 454
// );\` },
    { t: "User Event 0 · Trigger —— 触发战斗", lang: "gml", b: \`// obj_encounter_trigger 的 User Event 0（父物体 trigger 在玩家碰撞时自动调用）
_triggered = true;      // 必须写：标记已触发，否则遭遇动画期间每步都会重复触发
Encounter_Start(0);     // 进入 0 号遭遇，默认带遭遇动画和感叹号

// Encounter_Start(id, anim = true, exclam = true)
//   anim = false 时跳过演出直接切战斗房；战斗结束会自动回到触发前的房间。\` },
    { t: "进战斗后会发生什么", lang: "text", b: \`battle_enemy_test 自己只写了一个事件：

  TURN_PREPARATION_START（User Event 8）
      每回合准备阶段生成一个 turn_test 演示物体 —— 矩形战斗框 + 蓝色灵魂。

  战斗里的按键玩法（全部来自 turn_test）：
      空格      生成一根半透明骨头，长度由 Animator 关键帧驱动，来回伸缩
      左 Alt    切成紫色灵魂，沿预设轨道点移动
      小键盘 0  在随机位置召唤龙骨炮（Gaster Blaster）齐射

  它没写 User Event 0（INIT），所以敌人名字、数值都是默认值 ——
  这个示例只负责验证「遭遇战流程」，敌人本体怎么写是下一步的事。\` },
    { t: "换成你自己的敌人", lang: "gml", b: \`// Encounter_Custom.gml 里新增一个遭遇（编号避开已占用的 0）：
Encounter_Set(1, obj_my_enemy, -1, -1,
    "* You feel a chill down your spine!",
    /* BGM 资源名 */ -1, true, true, false);

// 触发改成新编号即可：
// Encounter_Start(1);

// 敌人物体怎么写（名字 / ACT / 弹幕）：
//   Parent 设为 battle_enemy，按 BATTLE_ENEMY_EVENT 枚举在 User Event 0~13 里写逻辑
//   （IDE 里的 User Event 编号 = 枚举值：INIT=0 … BOARD_RESETTING_END=13）。
// 完整事件表见「物体」页的 battle_enemy 卡片。\` }
  ]
}
];
`;
fs.writeFileSync(EX, DATA, { encoding: 'utf8' });
log('manual-examples.js 写入 1 个示例（ex_encounter_battle_enemy_test，入门）');

// ---------- 2. _verify.js：空态断言 → 有数据断言 ----------
let vf = fs.readFileSync(VERIFY, 'utf8');
const V_OLD_DETAIL = "const hOne = view('示例详情 ex_enemy_patrol', 'curExLv=\"all\";curEx=\"ex_enemy_patrol\";renderExamples()');";
const V_NEW_DETAIL = "const hOne = view('示例详情 ex_encounter_battle_enemy_test', 'curExLv=\"all\";curEx=\"ex_encounter_battle_enemy_test\";renderExamples()');";
const pairs = [
  ["  ['示例视图 空态正常', hEx.includes('没有匹配的条目')],",
   "  ['示例视图 有内容', hEx.length > 500 && hEx.includes('battle_enemy_test')],"],
  ["  ['示例分级标题为 0（已清空）', (hEx.match(/class=\"exgrt\"/g) || []).length === 0],",
   "  ['示例分级标题为 1（仅入门）', (hEx.match(/class=\"exgrt\"/g) || []).length === 1],"],
  ["  ['示例详情 空态回落正常', hOne.includes('没有匹配的条目')],",
   "  ['示例详情 有返回链接与代码', hOne.includes('返回示例列表') && hOne.includes('Encounter_Start')],"],
  [V_OLD_DETAIL, V_NEW_DETAIL],
];
pairs.forEach(([a, b], i) => {
  if (!vf.includes(a)) throw new Error('_verify.js 锚点' + (i + 1) + '不匹配: ' + a);
  vf = vf.replace(a, b);
});
fs.writeFileSync(VERIFY, vf, { encoding: 'utf8' });
log('_verify.js 三条断言 + 详情渲染目标已更新');

// ---------- 3. 重读断言 ----------
const ex2 = fs.readFileSync(EX, 'utf8');
if (!ex2.includes('window.EXAMPLES = [') || !ex2.includes('ex_encounter_battle_enemy_test')) throw new Error('重读: 示例数据异常');
if (ex2.includes('`') === false) throw new Error('重读: 模板字符串缺失（数据结构异常）');
const vf2 = fs.readFileSync(VERIFY, 'utf8');
if (vf2.includes('ex_enemy_patrol') || vf2.includes('没有匹配的条目')) throw new Error('重读: 旧断言残留');
log('重读断言通过');
log('ALL OK');
fs.writeFileSync(LOGP, lines.join('\n'), { encoding: 'utf8' });
