// 物体变量与关联表：依据源码 Create_0.gml 实地提取
// 只写源码里真实存在的变量
module.exports = {
  battle: {
    v: [
      ['_state / _state_next', '当前战斗状态与下一状态（BATTLE_STATE 枚举值）'],
      ['_enemy[0~2] / _enemy_object[0~2]', '三个敌人槽位的实例与物体'],
      ['_enemy_name[0~2]', '敌人显示名，用 Battle_SetEnemyName 改'],
      ['_enemy_spareable[0~2]', '敌人是否可饶恕（菜单里名字会变黄）'],
      ['_enemy_def[0~2]', '敌人防御力，参与伤害计算'],
      ['_enemy_action_number[0~2] / _enemy_action_name[槽,序]', '每个敌人的 ACT 选项数量与名称'],
      ['_enemy_center_pos_x/y[0~2]', '敌人中心点，FIGHT 瞄准与 ACT 指向都用它'],
      ['_menu / _menu_choice_*', '当前菜单页与各子菜单的光标位置'],
      ['_dialog[0~1]', '两栏对话框实例（line2 决定用哪栏）'],
      ['_turn_info[?]', '本回合的键值信息表，用 Battle_SetTurnInfo 写'],
      ['_hp / _kr / _heal / damage', '战斗内玩家血量、业报值、治疗量与结算伤害'],
    ],
    rel: [['相关函数', [
      ['Battle_GetState / Battle_SetState', '读写战斗状态'],
      ['Battle_SetEnemy / Battle_RemoveEnemy', '增删敌人槽位'],
      ['Battle_SetMenu / Battle_SetDialog', '控制菜单与对话'],
    ]]],
  },

  battle_enemy: {
    rel: [['事件对应表（User Event → 枚举）', [
      ['event_user(10)', 'INIT —— 敌人创建时，在这里设名字、属性'],
      ['event_user(11)', 'TURN_PREPARATION —— 回合准备，做引导文本'],
      ['event_user(12)', 'TURN_START —— 回合开始，生成第一波弹幕'],
      ['event_user(13)', 'TURN_END —— 回合结束，清理或续接弹幕'],
      ['event_user(14)', 'MENU_SWITCH —— 玩家在菜单里换页'],
      ['event_user(15)', 'ACT_START —— 玩家选了某个 ACT'],
      ['event_user(16)', 'ITEM_USE —— 玩家使用了物品'],
      ['event_user(17)', 'FIGHT_START —— 玩家在 FIGHT 里瞄准了你'],
      ['event_user(18)', 'FIGHT_END —— 挥刀判定结束，扣血在这之后'],
      ['event_user(19)', 'SPARE —— 玩家饶恕了你'],
      ['event_user(20)', 'DEATH —— 敌人死亡'],
      ['event_user(21)', 'MERCY —— 玩家在 MERCY 里操作'],
      ['event_user(22)', 'DIALOG_END —— 对话播完'],
      ['event_user(23)', 'RESULT —— 战斗结算'],
    ]]],
  },

  battle_bullet: {
    v: [
      ['type', '伤害类型 0~4：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性'],
      ['length', '骨头长度（像素），仅骨骼类使用'],
      ['angle / _angle', '显示角度与内部角度'],
      ['hspeed / vspeed / speed / direction', '运动速度（运动会自动乘 delta_time_factor）'],
      ['duration', '存活帧数，-1 = 永久'],
      ['auto_destroy', '回合结束时是否自动销毁'],
      ['out', '是否允许飞出战斗框边界仍活动'],
      ['disposable', '一次性弹幕：碰到灵魂就消失'],
      ['follow / follow_board / follow_angle / follow_target', '跟随系统，让弹幕跟着战斗框或某个实例转'],
      ['follow_x / follow_y', '绕指定点旋转'],
      ['rotate', '每帧自身旋转速度'],
      ['point_at / angle_offset', '尖端朝向与角度偏移'],
      ['path_function', '绑定的路径函数，可用于自定义运动轨迹'],
    ],
  },

  battle_bullet_bone: {
    v: [
      ['length', '骨头长度，默认 20'],
      ['point', '1 = 用 spr_bone_1（带尖端）；0 = 用 spr_bone'],
      ['type', '伤害类型'],
      ['rotate', '旋转速度'],
      ['out', '是否允许飞出战斗框'],
    ],
  },

  battle_bullet_arrow: {
    v: [
      ['scale', '缩放倍数，默认 0.5'],
      ['extra_angle', '张开角，默认 30'],
      ['range / _distance', '射程与初始距离，默认 500'],
      ['_speed / _direction', '飞行速度与方向'],
      ['type', '伤害类型'],
    ],
  },

  battle_bullet_bone_3d: {
    v: [
      ['anglex / angley / anglez', '绕三轴的当前角度'],
      ['angxs / angys / angzs', '绕三轴的角度增量（旋转速度）'],
      ['scalex / scaley / scalez', '三轴缩放'],
      ['shape', '形状：0 立方体 / 1 正四面体 / 2 正八面体 / 3 正十二面体 / 4 正二十面体'],
      ['gap', '中间留空宽度，默认 40'],
      ['vert_list / edge_list', '顶点与棱的缓存表，改形状时由内部函数维护'],
      ['enable', '是否参与绘制'],
    ],
  },

  battle_bullet_gb: {
    v: [
      ['blaster', '龙骨炮结构体（方向、速度、贴图、坐标、缩放、颜色、透明度）'],
      ['state', '内部状态机：待机 → 转向 → 蓄力 → 发射 → 退出'],
      ['time_move', '转位移动的帧数，默认 30'],
      ['time_delay', '蓄力停顿的帧数，默认 16'],
      ['time_blast', '激光持续帧数，默认 10'],
      ['time_stay', '发射后停留帧数'],
      ['target_x / target_y / target_angle', '瞄准目标点与角度'],
      ['charge_sound / blast_sound', '是否播放蓄力音与发射音'],
      ['destroy', '标记为待销毁'],
    ],
  },

  battle_platform: {
    v: [
      ['width', '平台宽度，默认 48'],
      ['sticky', '1 = 站上去后随平台一起移动'],
      ['bounce', 'true = 踩上去会弹跳'],
      ['angle', '平台倾斜角度'],
      ['duration', '存活帧数，-1 = 永久'],
    ],
  },

  battle_soul: {
    v: [
      ['moveable', '1 = 玩家可操作移动；0 = 锁定（被弹幕击退时用）'],
      ['index', '灵魂模式编号，对应不同子物体'],
      ['follow_board', '是否跟随战斗框旋转'],
      ['_inv', '无敌帧计数，受伤后短暂免伤'],
      ['light_size', '灵魂周围光晕的大小'],
      ['init_alpha / image_blend', '初始透明度与染色'],
      ['global.moving', '全局标记：灵魂本帧是否在移动（类型 1/2 弹幕靠它判定）'],
    ],
  },

  battle_board: {
    v: [
      ['x / y', '战斗框中心坐标，默认 BATTLE_BOARD.X / .Y'],
      ['up / down / left / right', '以中心为原点向四边延伸的距离（不是宽高）'],
      ['angle / _angle', '战斗框旋转角与内部角'],
      ['color_bg / alpha_bg', '战斗框内底色与透明度（打雷、闪白用）'],
      ['color_frame / alpha_frame', '边框颜色与透明度'],
      ['edge', '是否显示边缘描边（受 classic_ui 影响）'],
      ['mainboard', '主战斗框实例，多框叠加时用'],
      ['_surface / _surface_mask 等', '用于旋转与遮罩的多个 surface，改绘制时要小心'],
    ],
  },

  battle_turn: {
    v: [
      ['start', '本回合起始时刻（帧计数）'],
      ['time', '本回合已经过的帧数'],
    ],
  },

  battle_button: {
    v: [
      ['_button_slot', '按钮位置编号（0~3 = FIGHT/ACT/ITEM/MERCY）'],
      ['alpha', '透明度，用于高亮当前选中按钮'],
    ],
  },

  battle_damage: {
    v: [
      ['damage', '要显示的数字'],
      ['color', '数字颜色，默认 c_red'],
      ['display_time', '停留帧数，默认 GAME_FPS（约 1 秒）'],
      ['bar_visible', '是否同时显示血条动画'],
      ['bar_hp_max / bar_hp_original / bar_hp_target', '血条上限、起始值与目标值'],
      ['bar_width / bar_duration', '血条宽度与滚动时长，默认 100 / 45'],
      ['gra / vsp', '重力与垂直速度，控制数字上飘'],
      ['alarm[0]', '存活倒计时，触发后自动销毁'],
    ],
  },

  battle_fader: {
    v: [
      ['color', '黑幕颜色，默认 c_black'],
      ['alpha', '当前透明度，0 = 全透明，1 = 全黑'],
    ],
  },

  text_typer: {    v: [
      ['text', '要显示的完整字符串（带 {color} {speed} 等标签）'],
      ['_line', '当前所在行'],
      ['_speed / _char_per_frame', '打字速度与每帧出字数'],
      ['_char / _char_proc', '当前正在打的字与进度'],
      ['_skippable / _skipping', '是否允许按键跳过、是否正在跳过'],
      ['_paused / _instant', '暂停与瞬显标记'],
      ['_voice / _voice_single', '逐字音效与指定音效'],
      ['_choice / _choice_x / _choice_y', '选项模式的光标与选项坐标'],
      ['_choice_switch_key', '切换选项用的按键，默认左右'],
      ['_font / _scale_x / _scale_y', '字体与缩放'],
      ['_shadow / _outline / _color_*', '描影、描边与各级颜色'],
      ['_alpha / _rainbow', '整体透明度与彩虹特效强度'],
    ],
  },

  battle_dialog_enemy: {
    v: [
      ['text', '气泡里要显示的文字'],
      ['dir', '气泡尖角朝向：DIR.LEFT / RIGHT / UP / DOWN'],
      ['show_spike / wide_spike', '是否显示尖角、尖角是否加宽'],
      ['up / down / left / right', '气泡四边相对锚点的延伸距离'],
      ['template', '气泡样式模板编号'],
      ['text_offset_x / text_offset_y', '文字相对气泡的偏移'],
      ['fast', 'true = 文字瞬显（不逐字打）'],
      ['_inst', '内部创建的 text_typer 实例'],
    ],
  },

  ui_dialog: {
    v: [
      ['_top', '对话框是否显示在角色上方（角色靠下时为 true）'],
      ['_inst', '内部打字机实例'],
      ['_choose_enable', '是否进入选项模式'],
      ['_choose', '当前选中的选项序号'],
      ['_choose_soul', '选项光标的灵魂样式编号'],
      ['_choice', '选项文本数组'],
      ['_surface_text', '用于绘制文字的 surface（640×480）'],
    ],
  },

  battle_menu_fight: {
    v: [
      ['x / y', '自动对齐到 battle_board 的中心'],
      ['（子物体）_anim_knife / _knife / _hp_bar', '挥刀动画、刀本体、玩家血条分别由这三个子物体负责'],
    ],
    rel: [['FIGHT 流程的三个回调', [
      ['event_user(10)', 'ANIM —— 播放挥刀动画'],
      ['event_user(11)', 'AIM —— 瞄准条移动阶段'],
      ['event_user(12)', 'DAMAGE —— 判定命中并给出伤害'],
    ]]],
  },

  char_player: {
    v: [
      ['char_id', '角色编号（多角色存档时用来区分）'],
      ['_moveable_dialog / _moveable_menu / _moveable_save', '对话中 / 菜单中 / 存档时是否允许移动'],
      ['_moveable_warp / _moveable_shop / _moveable_encounter', '切房间 / 商店中 / 遭遇动画时是否允许移动'],
      ['_moveable_box', '被箱子推动时是否允许移动'],
      ['moveable', '总开关，false 时玩家完全无法操作'],
      ['res_idle_sprite[方向] / res_move_sprite[方向]', '四个方向的待机与行走贴图'],
    ],
  },

  char: {
    v: [
      ['char_id', '角色编号，-1 = 未注册'],
      ['dir', '当前朝向，取值 DIR.UP / DOWN / LEFT / RIGHT'],
      ['dir_locked', 'true = 锁定朝向（演出时用）'],
      ['talking / interacting', '是否正在对话、交互状态'],
      ['move[方向] / move_speed[方向]', '四个方向的移动输入与速度（默认 2）'],
      ['collision / _collision_list', '是否参与碰撞、碰撞检测列表'],
      ['res_idle_* / res_move_* / res_talk_*', '待机、行走、对话三套动画资源（贴图 / 帧 / 速度 / 翻转）'],
    ],
  },

  char_save: {
    v: [
      ['res_idle_speed[角度]', '四个朝向的待机动画速度'],
      ['res_move_speed[角度]', '四个朝向的行走动画速度'],
      ['res_talk_speed[角度]', '四个朝向的对话动画速度'],
      ['（存档行为）', '具体存档 / 读档 / 回标题逻辑在 Step 与 Other 事件里'],
    ],
  },

  trigger_warp: {
    v: [
      ['target_room', '目标房间 asset，-1 = 不切房间'],
      ['target_landmark', '目标房间内的落点标记编号'],
      ['fade_in_time / fade_in_color', '进入时的黑幕时长与颜色（默认 20 帧 / 黑）'],
      ['fade_out_time / fade_out_color', '离开时的黑幕时长与颜色'],
      ['bgm_fade / bgm_fade_time', '是否淡出 BGM 及时长'],
      ['warp_wait', '触发前的等待帧数'],
      ['player_dir', '传送后玩家朝向，-1 = 保持原样'],
      ['user_char', '允许触发该传送的角色编号，0 = 不限'],
    ],
  },

  encounter_anim: {
    v: [
      ['_encounter', '要进入的遭遇ID'],
      ['_exclam', '是否播放「惊讶！」感叹号'],
      ['_quick', 'true = 跳过动画直接进战斗'],
      ['_soul_x / _soul_y', '灵魂的初始位置（默认 48 / 454）'],
      ['_draw_soul / _draw_player / _draw_black', '各绘制阶段的开关'],
      ['_flash', '闪白强度'],
    ],
  },

  shop: {
    v: [
      ['_index', '当前光标在主列表的位置'],
      ['_index_buy / _index_sell', '买 / 卖分支的光标位置'],
      ['_choice_state', '当前处于哪一步（选物品 / 确认 / 结算）'],
      ['_pre_index / _pre_index_buy / _pre_index_sell', '上一步的光标位置，用于返回时还原'],
      ['_exit_index', '「离开」选项的位置'],
      ['border_x1/y1/x2/y2 / border_width', '商店边框的绘制范围与粗细'],
      ['width_text / width_heart / height_text', '文字列宽、心形光标宽、行高'],
      ['menu_divide_x / state_info_y', '菜单分割线 X 与状态栏 Y'],
    ],
  },

  shop_host: {
    v: [
      ['host_sprite', '店主立绘贴图'],
      ['menu_text / encounter_text', '菜单提示文本与见面语'],
      ['shop_item[0~3]', '货架上的四件商品'],
      ['buy_before_text / buy_after_text / buy_false_text', '购买前 / 成功 / 钱不够 的文本'],
      ['sold_available', '是否启用「已售出」状态'],
      ['sold_*_text', '售出后各阶段文本'],
      ['dialog_init[0~3] / dialog[0~3]', '四段对话的初始与当前内容'],
      ['exit_text', '离开时的告别语'],
    ],
  },

  demo_recorder: {
    v: [
      ['_buffer', '记录输入的缓冲区'],
      ['_frame_number', '当前记录到第几帧'],
      ['_seed', '随机数种子，回放时要还原'],
      ['_paused', '是否暂停录制'],
      ['_icon_show_tick', '录制图标的显示计时'],
    ],
  },

  demo_player: {
    v: [
      ['_buffer', '待回放的数据缓冲区'],
      ['_seed', '要还原的随机种子'],
      ['_input_number', '输入种类的数量'],
      ['_input_list', '要回放的输入列表'],
      ['_frame_number / _frame_current', '总帧数与当前帧'],
      ['_paused', '是否暂停回放'],
      ['_fps', '回放帧率'],
    ],
  },

  closed_captions: {
    v: [
      ['_x / _y', '字幕区中心坐标，默认 320 / 400'],
      ['_up / _down / _left / _right', '字幕底框四边延伸距离'],
      ['_color / _alpha / _alpha_base', '底色、当前透明度与基础透明度（默认 0.6）'],
      ['_queue_text / _queue_duration', '待播字幕队列与各自的时长'],
      ['_list_inst / _list_time', '正在显示的字幕实例与剩余时间'],
      ['_list_destroy_inst / _list_destroy_time', '待销毁列表，避免边遍历边删'],
      ['_showed / _up_previous', '显示状态与上一帧的 _up（用于平滑过渡）'],
    ],
  },

  'char_save_extra': { v: [] },
};
