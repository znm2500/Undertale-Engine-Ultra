/* =========================================================================
   UT/DR — UNDERTALE Engine Ultra  ·  可玩示例集
   2026-09-22 重写第 1 篇。条目结构：
   { id, title, level(入门/进阶/实用/必读), scene, files:[{t,b}], code:[{t,b,lang}] }
   ========================================================================= */
window.EXAMPLES = [

/* ==================== 1. 用自带示例敌人跑通遭遇战 ==================== */
{
  id: "ex_encounter_battle_enemy_test",
  title: "用自带示例敌人跑通遭遇战",
  level: "入门",
  scene: "不改一行敌人逻辑，用引擎自带的 battle_enemy_test 跑通「地图触发 → 遭遇动画 → 战斗 → 回到地图」全流程，顺便看懂遭遇战是怎么注册的。",
  files: [
    { t: "新建物体 obj_encounter_trigger", b: `Parent 设为 trigger —— 引擎会在玩家碰到它时自动调用它的 User Event 0
Sprite 可以不设（隐形触发区），拖一个到示例地图 room_area_0 的通道上` }
  ],
  code: [
    { t: "注册遭遇 · Encounter_Custom.gml（引擎已经替你写好）", lang: "gml", b: `// scripts/Encounter_Custom/Encounter_Custom.gml —— 引擎默认内容就是这行：
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
// );` },
    { t: "User Event 0 · Trigger —— 触发战斗", lang: "gml", b: `// obj_encounter_trigger 的 User Event 0（父物体 trigger 在玩家碰撞时自动调用）
_triggered = true;      // 必须写：标记已触发，否则遭遇动画期间每步都会重复触发
Encounter_Start(0);     // 进入 0 号遭遇，默认带遭遇动画和感叹号

// Encounter_Start(id, anim = true, exclam = true)
//   anim = false 时跳过演出直接切战斗房；战斗结束会自动回到触发前的房间。` },
    
    { t: "进战斗后会发生什么", lang: "img", b: "img/ex1-battle-turn_test.gif" },
    { t: "换成你自己的敌人", lang: "gml", b: `// Encounter_Custom.gml 里新增一个遭遇（编号避开已占用的 0）：
Encounter_Set(1, obj_my_enemy, -1, -1,
    "* You feel a chill down your spine!",
    /* BGM 资源名 */ -1, true, true, false);

// 触发改成新编号即可：
// Encounter_Start(1);

// 敌人物体怎么写（名字 / ACT / 弹幕）：
//   Parent 设为 battle_enemy，按 BATTLE_ENEMY_EVENT 枚举在 User Event 0~13 里写逻辑
//   （IDE 里的 User Event 编号 = 枚举值：INIT=0 … BOARD_RESETTING_END=13）。
// 完整事件表见「物体」页的 battle_enemy 卡片。` }
  ]
},

/* ==================== 2. 行动选项与行动对话 ==================== */
{
  id: "ex_enemy_test_acts",
  title: "给敌人设置属性、行动选项和行动对话",
  level: "入门",
  scene: "第 1 篇里 battle_enemy_test 没写 INIT，名字数值都是默认值、ACT 菜单是空的。这一篇在 INIT 里把敌人属性（名字 / 防御）和行动选项一次配齐，再按玩家的选择返回行动对话，让「讨好」两次变可饶恕 —— 顺便看清「菜单 → 对话 → 回合」是怎么自动衔接的。",
  files: [
    { t: "往 battle_enemy_test 加两个事件", b: `本篇要动 battle_enemy_test 三个地方：先注释掉 UE8 里的 turn_test 生成
（不然每回合都冒弹幕，没法安心看对话），再加两个事件 ——
User Event 0（INIT）设置敌人属性并注册行动选项，User Event 5（MENU_END）写行动对话。

正式做游戏时，这些代码应写在你自己的敌人物体里（Parent 设为 battle_enemy）；
直接写在 battle_enemy_test 上，只是为了沿用第 1 篇的遭遇练手。` }
  ],
  code: [
    { t: "准备 · 先注释掉 turn_test", lang: "gml", b: `// battle_enemy_test 的 User Event 8 · TURN_PREPARATION_START 原文就一行：
instance_create_depth(0,0,0,turn_test)

// 本篇只展示对话 —— 先把这行注释掉，不然每回合准备阶段
// 都会冒出弹幕演示（骨头 / 紫魂 / 龙骨炮），没法安心测 ACT：
// instance_create_depth(0,0,0,turn_test)

// 测完想玩弹幕了，取消注释即可恢复。` },
    { t: "User Event 0 · INIT —— 设置敌人属性 + 注册行动选项", lang: "gml", b: `// battle_enemy_test 的 User Event 0（INIT，敌人出场时调用一次）
// ---- 敌人属性 ----
Battle_SetEnemyName(1, "Test");   // 名字（战斗文本、ACT 目标处显示）
Battle_SetEnemyDEF(1, 1);                      // 防御力：越高，玩家一刀伤害越低
// 引擎没有敌人 HP / ATK 的设置项；敌人能否被饶恕由 Battle_SetEnemySpareable 控制

// ---- 行动选项 ----
Battle_SetEnemyActionNumber(1, 3);             // ACT 菜单一共 3 个选项
Battle_SetEnemyActionName(1, 0, "* 检查");
Battle_SetEnemyActionName(1, 1, "* 聊天");
Battle_SetEnemyActionName(1, 2, "* 讨好");

_spare_count = 0;    // 实例变量：「讨好」计数，MENU_END 里要用` },
    { t: "User Event 5 · MENU_END —— 按选择返回行动对话", lang: "gml", b: `// battle_enemy_test 的 User Event 5（MENU_END，玩家在菜单按确认后调用）
// ⚠ FIGHT / ITEM / MERCY 确认后同样会触发 MENU_END —— 必须先判断按钮！
if (Battle_GetMenuChoiceButton() != BATTLE_MENU_CHOICE_BUTTON.ACT) return;

switch (Battle_GetMenuChoiceAction()) {
    case 0:     // 「检查」
        Dialog_Add("* Test - ATK 0 - DEF 1&* 引擎自带的测试敌人，&  只负责验证遭遇战。");
        break;
    case 1:     // 「聊天」
        Dialog_Add("* 你试着和它聊了两句。&* 它只是安静地站在那里。");
        break;
    case 2:     // 「讨好」：讨好两次 → 变可饶恕
        _spare_count++;
        if (_spare_count >= 2) {
            Battle_SetEnemySpareable(1, true);   // 名字变黄，MERCY 菜单可以饶恕
            Dialog_Add("* 它看起来不想战斗了。");
        } else {
            Dialog_Add("* 你夸了它一句。它似乎有点开心。");
        }
        break;
}` },
    { t: "选完 ACT 之后发生了什么", lang: "text", b: `玩家确认行动后，引擎自动接力（源码：Battle_EndMenu → Battle_SetState）：

  ACT 菜单按确认
      ↓  引擎调用 MENU_END（User Event 5）—— 行动对话在这里用 Battle_SetDialog 给出
  进入 DIALOG —— 对话框打字机播放，同时触发 DIALOG_START（User Event 6）
      ↓  玩家按确认读完 → 引擎调用 DIALOG_END（User Event 7）
  自动进 TURN_PREPARATION —— battle_enemy_test 的 UE8 照常生成 turn_test
      ↓
  进 IN_TURN —— 弹幕回合开始

状态推进全部由引擎完成，MENU_END 里只需把对话写好；
行动的「副作用」（如变可饶恕）就是普通代码，写在对应的 case 里即可。` },
    { t: "ACT 菜单与行动对话", lang: "img", b: "img/ex2-act-menu-dialog.gif" }
  ]
},

/* ==================== 3. 自定义药品并在战斗中使用 ==================== */
{
  id: "ex_item_heal_potion",
  title: "自定义一瓶药水，在战斗里用上",
  level: "入门",
  scene: "引擎自带的绷带（CustomItem_Bandage）就是一篇活教材 —— 照它的样子造一瓶自己的药：写好「用」的逻辑，注册进物品表，再放进背包，战斗 ITEM 菜单里就能用了。继续沿用前两篇的 battle_enemy_test 配置练手，战斗流程一个字都不用写。",
  files: [
    { t: "新建 script CustomItem_Medicine", b: `药品不是一个物体，而是一个「物品类型」script ——
它描述这种东西的名字、查看说明、用了会发生什么。
一瓶药水 = 一个继承 ItemTypeSimple 的构造器，三五行就写完了。

IDE 里新建时建议挂在 Scripts/Item/CustomItems 组下
（引擎自带的绷带、骰子等范例都在这个组里）。` }
  ],
  code: [
    { t: "药品本体 · CustomItem_Medicine.gml", lang: "gml", b: `// 新建 script：CustomItem_Medicine
// ItemTypeSimple(名字, 查看说明) —— 名字和「查看」它自动处理，只写「使用」的逻辑
function CustomItem_Medicine() : ItemTypeSimple("Medicine", "* Medicine - Heals 20 HP&* Tastes like cinnamon.") constructor{
    _price_buy = 15;                  // 商店买入价（-1 = 不上架）
    _price_sell = 5;                  // 卖出价
    _shop_description = "Medicine";   // 商店列表里的一行简介

    function OnUse(inventory, index){
        Dialog_Add("* You ate the medicine."+Item_GetTextHeal(20));
        Dialog_Start();               // 开始播放对话（战斗会自动切到 DIALOG 状态）

        Player_Heal(20);              // 真正回血，战斗内会自动刷新 HP 条
        audio_play_sound(snd_item_heal, 0, false);   // 引擎自带回血音效

        inventory.Remove(index);      // 用掉：从背包移除
    }
}` },
    { t: "注册 + 发放（各加一行）", lang: "gml", b: `// ① 注册：Scripts/Item/Item_Custom —— Item_Custom() 的第一个大括号区里加：
#macro ITEM_MEDICINE "medicine"        // 宏当别名用，防止手滑写错 id
Item_GetTypeManager().Register(ITEM_MEDICINE, new CustomItem_Medicine());

// ② 发放：Scripts/Player/Player_CustomInitialData —— 尾部加（背包上限 8 格）：
Item_GetInventoryItems().Add(ITEM_MEDICINE);

// 同目录的 CustomItem_Bandage / CustomItem_Dice 是引擎自带的参考实现，
// 绷带就是治疗物品的活教材 —— 本示例就是照它的骨架写的。` },
    { t: "战斗里使用会发生什么", lang: "text", b: `ITEM 菜单确认后，引擎自动接力（源码：Battle_EndMenu → Inventory.InvokeItemUse）：

  ITEM 菜单选中药品按确认
      ↓  引擎调用药品的 OnUse(inventory, index)
  OnUse 里的对话文本 → 进入 DIALOG 状态打字机播放
      ↓  读完确认 → 自动进 TURN_PREPARATION
  敌人回合照常开始

Player_Heal 在战斗内会自动刷新 HP 条；
药品代码里没有任何战斗相关内容 —— 它只管「用」，流程引擎自己接。
和第 2 篇的行动对话走的是同一条 DIALOG 链路。` },
    { t: "战斗中使用药水", lang: "img", b: "img/ex3-battle-use-medicine.gif" }
  ]
}
];
