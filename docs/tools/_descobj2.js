// 第二批物体变量表补丁：补齐 _descobj.js 漏掉的 12 个物体。
// 变量均逐条对照 objects/<name>/Create_0.gml 的真实赋值整理，含默认值。
module.exports = {
  'world': {
    hot: true,
    d: '引擎的全局总控物件 —— persistent 为 true（跨房间常驻）、visible 为 false、无父物体无精灵，全局只此一个。整个引擎由它串起来，要改全局行为先来这里：① Game Start 事件里初始化全部 9 个子系统（Anim / Shop / Input / Item / Storage / Encounter / BGM / Dialog / Demo）、写入默认键位（确认 = Enter 与 Z、取消 = Shift 与 X、菜单 = Ctrl 与 C、方向键），再创建 camera / fader / border / closed_captions 四个常驻单例，最后 room_goto_next() 进入游戏；② Step 事件里每帧驱动 Time_Step / Anim_Step / BGM_Step 三大系统，顺带累加存档里的游玩秒数、处理跳帧，并监听 F2 重开游戏、F4 切换全屏；③ Game End 事件里反向反初始化各子系统，CleanUp 里释放 global.surface_gui。它还持有 blur_strength / classic_ui / Panel / kr 等一批全局开关。',
    v: [
      ['_time', '秒计时累加器（内部）。Step 里每帧加上 global.delta_time_factor，累计满 1 秒（GAME_FPS 帧）就清零，并给存档里的游玩时间 FLAG_STATIC_TIME 加 1。'],
      ['_frame_skip', '跳帧计数器（内部）。记录自上次真正渲染以来累积了多少帧，达到 Game_GetFrameSkip() 的阈值就渲染一帧并清零。'],
      ['_frame_skipped', '已跳过的帧总数（内部保留字段，当前主循环未使用）。'],
      ['global.blur_strength', '全局模糊强度，数组 [横向, 纵向]。两个分量分别控制横、竖方向的模糊量，默认 [0,0] 即不模糊。'],
      ['global.blur_amount', '全局模糊程度，与 blur_strength 配合使用，默认 0。'],
      ['global.classic_ui', '是否启用经典 UI 布局，默认 0（新版）。改成 1 可切回老式界面。'],
      ['global.Panel', 'FIGHT 攻击条使用的外观物件（见 Battle_SetMenuFightPanel），默认 battle_menu_fight_knife。换成别的物件即可改攻击条造型。'],
      ['global.kr', '是否启用 KR（业报）机制，默认 1。为假时 Player_SetKr() 不会写入任何值。'],
      ['global.surface_gui', 'GUI 层渲染用的 surface，创建时尺寸 640×480，物件 CleanUp 时被 surface_free() 释放。']
    ]
  },
  'battle_enemy': {
    v: [
      ['depth', '绘制深度。创建时设为 DEPTH_BATTLE.ENEMY，保证敌人画在战斗框之上、UI 之下。'],
      ['_enemy_slot', '本敌人占用的敌人槽位编号，默认 -1 表示尚未分配。回合结算、血条显示、攻击归属都靠它来对应到具体的敌人。']
    ]
  },
  'battle_button_act': {
    v: [
      ['_button_slot', '本按钮在战斗菜单里的槽位序号，ACT 固定为 1。父物体 battle_button 依据这个序号决定按钮摆在哪、以及何时算作被选中。']
    ]
  },
  'battle_button_fight': {
    v: [
      ['_button_slot', '本按钮在战斗菜单里的槽位序号，FIGHT 固定为 0，也就是最左边那一个。父物体据此摆位并处理高亮。']
    ]
  },
  'battle_button_item': {
    v: [
      ['_button_slot', '本按钮在战斗菜单里的槽位序号，ITEM 固定为 2。父物体据此摆位，Step 事件里再用它判断当前是否被选中。']
    ]
  },
  'battle_button_mercy': {
    v: [
      ['_button_slot', '本按钮在战斗菜单里的槽位序号，MERCY 固定为 3，也就是最右边那一个。父物体据此摆位并处理高亮。']
    ]
  },
  'battle_menu_fight_anim_knife': {
    v: [
      ['depth', '绘制深度。创建时被设为 DEPTH_BATTLE.UI，保证挥刀动画盖在战斗框之上。'],
      ['image_speed', '帧动画播放速度，创建时设为 1，表示每帧推进一帧动画。']
    ]
  },
  'battle_menu_fight_hp_bar': {
    v: [
      ['depth', '绘制深度，创建时设为 DEPTH_BATTLE.UI_HIGH，压在普通 UI 之上。'],
      ['enemy_slot', '本血条对应第几个敌人，默认 -1 表示尚未指定，需要外部赋值为敌人槽位。'],
      ['width', '血条的像素宽度，默认 101。'],
      ['hp_max', '该敌人的最大生命值，默认 0，用于换算血条填充比例。'],
      ['hp', '该敌人当前生命值，默认 0。它除以 hp_max 决定血条画多长。']
    ]
  },
  'battle_menu_fight_knife': {
    v: [
      ['_dir', '挥刀方向，创建时从 DIR.LEFT 与 DIR.RIGHT 中随机取一个，决定刀从哪一侧扫入。'],
      ['_input_acceptable', '当前是否还接受玩家的瞄准输入，默认 true，砍出去之后会置为 false。'],
      ['_aim_x', '瞄准线当前所在的横坐标，会随 Aim 动画来回移动。'],
      ['_aim_image', '瞄准线使用的动画编号，用于在瞄准动画之间切换。']
    ]
  },
  'char_sans': {
    v: [
      ['char_id', '角色编号，Sans 固定为 1，供需要区分角色的场合使用。'],
      ['dir_locked', '是否锁死朝向，默认 false。置为 true 后角色不会因为玩家输入转向。'],
      ['res_idle_sprite', '待机精灵表，按 DIR.UP / DOWN / LEFT / RIGHT 四个方向分别指定。左右两侧共用同一张向右的图。'],
      ['res_move_sprite', '行走精灵表，同样按四个方向分别指定，用于角色移动时播放。'],
      ['text', '该角色首次交互时显示的对话文本，支持换表情、换字体、换颜色、语音等控制标记。']
    ]
  },
  'shop_dialog': {
    v: [
      ['title', '标题栏内容索引，默认 -1 表示不显示标题。'],
      ['title_blend', '标题栏的混色颜色，默认 c_white。'],
      ['text', '正文内容索引，默认 -1 表示不显示正文。'],
      ['next_dialog', '下一段对话跳转到的对象，默认 noone 表示它是最后一段。']
    ]
  },
  'shop_dialog_typer': {
    v: [
      ['depth', '绘制深度，创建时设为 DEPTH_BATTLE.UI_HIGH，保证字幕压在商店画面之上。'],
      ['visible', '是否可见，创建时先置 false，等打字机就绪后再显示。'],
      ['text_offset_x', '文字相对本物体位置的横向偏移，默认 0。'],
      ['text_offset_y', '文字相对本物体位置的纵向偏移，默认 0。'],
      ['fast', '是否快速打字模式，默认 false。置 true 时文字会一次性全部显示。'],
      ['text', '当前要逐字打出的字幕内容，默认空字符串。'],
      ['_inst', '内部持有的打字机实例，创建时用 instance_create_depth 生成并保存，后续由它负责逐字显示。']
    ]
  },
  'trigger': {
    v: [
      ['user_char', '触发者对象索引，默认 -1 表示尚未绑定。只有匹配的角色走进来才会触发。'],
      ['_triggered', '本次碰撞是否已经触发过，默认 false，用来避免玩家站在触发区里被反复触发。'],
      ['_collided_previous', '上一帧是否处于碰撞状态，默认 false，用于检测「刚进入」的那一瞬间。']
    ]
  },
  'trigger_shop': {
    v: [
      ['user_char', '触发者对象索引，覆盖父类默认值，默认 0 表示任意角色都可触发。'],
      ['target_shop_id', '要打开的商店 ID，默认 0。'],
      ['target_landmark', '目标地标索引，默认 -1 表示原地处理不传送。'],
      ['fade_in_time', '进入商店时淡入的持续帧数，默认 20。'],
      ['fade_in_color', '淡入时遮罩的颜色，默认 c_black。'],
      ['fade_out_time', '离开商店时淡出的持续帧数，默认 20。'],
      ['fade_out_color', '淡出时遮罩的颜色，默认 c_black。'],
      ['bgm_fade', '商店切换时是否对背景音乐做淡入淡出，默认 false。'],
      ['bgm_fade_time', '背景音乐淡入淡出的持续帧数，默认 20。'],
      ['warp_wait', '传送前等待的帧数，默认 0。'],
      ['player_dir', '传送后玩家面朝的方向，默认 -1 表示不改朝向。']
    ]
  }
};
