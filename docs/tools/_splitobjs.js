// 拆分后的独立物体条目
// 依据：实际存在的物体目录 + .yy 里的 parentObjectId + 各物体事件文件
module.exports = [
  // ===== battle_button 家族 =====
  {
    n: 'battle_button', g: 'ui', t: '界面基类', hot: false,
    d: '主菜单四个按钮的基类。负责绘制、光标高亮与按下反馈；本身不参与菜单逻辑，实际用的是下面四个子物体。',
    v: [
      ['_button_slot', '按钮位置编号（0~3 = FIGHT / ACT / ITEM / MERCY）'],
      ['alpha', '透明度，当前选中的按钮会拉到 1，其余压暗'],
    ],
    rel: [['子物体', [
      ['battle_button_fight', 'FIGHT 按钮'],
      ['battle_button_act', 'ACT 按钮'],
      ['battle_button_item', 'ITEM 按钮'],
      ['battle_button_mercy', 'MERCY 按钮'],
    ]]],
  },
  { n: 'battle_button_fight', g: 'ui', t: '界面', d: 'FIGHT 按钮。贴图 spr_battle_button_fight，以 battle_button 为父物体继承光标与反馈逻辑。', },
  { n: 'battle_button_act', g: 'ui', t: '界面', d: 'ACT 按钮。贴图 spr_battle_button_act，以 battle_button 为父物体。', },
  { n: 'battle_button_item', g: 'ui', t: '界面', d: 'ITEM 按钮。贴图 spr_battle_button_item，以 battle_button 为父物体。', },
  { n: 'battle_button_mercy', g: 'ui', t: '界面', d: 'MERCY 按钮。贴图 spr_battle_button_mercy，以 battle_button 为父物体。', },

  // ===== battle_menu_fight 家族 =====
  {
    n: 'battle_menu_fight', g: 'ui', t: '界面', hot: true,
    d: 'FIGHT 攻击条的主控。创建时会自动对齐到 battle_board 中心，负责瞄准、挥刀与伤害结算三个阶段。',
    v: [
      ['x / y', '自动对齐到 battle_board 的中心点'],
    ],
    rel: [['FIGHT 三个阶段（User Event）', [
      ['event_user(10)', 'ANIM —— 播放挥刀动画'],
      ['event_user(11)', 'AIM —— 瞄准条左右移动阶段'],
      ['event_user(12)', 'DAMAGE —— 判定命中并显示伤害'],
    ]]],
  },
  { n: 'battle_menu_fight_anim_knife', g: 'ui', t: '界面', d: '挥刀动画的专用物件。只负责「刀挥下去」这一段演出，播放完毕即自行销毁，不参与瞄准与判定。', },
  {
    n: 'battle_menu_fight_knife', g: 'ui', t: '界面', hot: false,
    d: 'FIGHT 的刀本体。以 battle_menu_fight 为父物体，负责瞄准条的移动、按键判定与命中时机。',
  },
  { n: 'battle_menu_fight_hp_bar', g: 'ui', t: '界面', d: 'FIGHT 界面右下角的玩家 HP 条。命中后会播放血条从旧值滚到新值的动画，让扣血看得见。', },

  // ===== fader 家族 =====
  {
    n: 'fader', g: 'fx', t: '特效', hot: false,
    d: '通用全屏黑幕。地图切换、过场都能用，由 Fader_Fade 驱动淡入淡出。',
    v: [
      ['color', '黑幕颜色，默认 c_black'],
      ['alpha', '当前透明度，0 = 全透明，1 = 全黑'],
    ],
  },
  {
    n: 'battle_fader', g: 'fx', t: '特效',
    d: '战斗专用黑幕，层级由 DEPTH_BATTLE.FADER 决定，保证盖在战斗框与 UI 之上。',
    v: [
      ['color', '黑幕颜色，默认 c_black'],
      ['alpha', '当前透明度'],
    ],
  },

  // ===== char 家族 =====
  {
    n: 'char', g: 'world', t: '地图基类', hot: true,
    d: '地图角色的基类，负责移动、朝向、动画与碰撞。char_player / char_sans / char_save 都以它或它的子类为父物体。',
    v: [
      ['char_id', '角色编号，-1 = 未注册'],
      ['dir', '当前朝向，取值 DIR.UP / DOWN / LEFT / RIGHT'],
      ['dir_locked', 'true = 锁定朝向（演出用）'],
      ['talking / interacting', '是否正在对话、交互状态'],
      ['move[方向] / move_speed[方向]', '四方向移动输入与速度，默认 2'],
      ['collision / _collision_list', '是否碰撞、碰撞检测列表'],
      ['res_idle_* / res_move_* / res_talk_*', '待机 / 行走 / 对话三套动画资源'],
    ],
  },
  {
    n: 'char_player', g: 'world', t: '地图', hot: false,
    d: '玩家角色。默认贴图是 Frisk 四方向，父物体为 char。',
    v: [
      ['char_id', '玩家角色编号'],
      ['_moveable_dialog / _moveable_menu / _moveable_save', '对话中 / 菜单中 / 存档时能否移动'],
      ['_moveable_warp / _moveable_shop / _moveable_encounter', '切房间 / 商店中 / 遭遇动画时能否移动'],
      ['_moveable_box', '被推箱时能否移动'],
      ['moveable', '总开关，false = 完全锁死操作'],
    ],
  },
  { n: 'char_sans', g: 'world', t: '地图', d: '可互动 NPC 示例。父物体是 char_sign，用来演示「一个会说话的地图角色」怎么写。', },
  {
    n: 'char_save', g: 'world', t: '地图', hot: true,
    d: '存档点。玩家碰到后可存档、读档或返回标题，父物体为 char_sign。',
    v: [
      ['res_idle_speed[角度]', '四方向待机动画速度'],
      ['res_move_speed[角度]', '四方向行走动画速度'],
      ['res_talk_speed[角度]', '四方向对话动画速度'],
    ],
  },

  // ===== trigger 家族 =====
  {
    n: 'trigger', g: 'world', t: '地图基类', hot: false,
    d: '触发器的基类。放在地图上，玩家碰到即触发；trigger_warp / trigger_shop 都继承它。',
  },
  {
    n: 'trigger_warp', g: 'world', t: '地图',
    d: '房间切换触发器。踩上去后按配置淡入黑幕、可选淡出 BGM，再把玩家送进目标房间的落点标记，是地图串联的核心物件。',
    v: [
      ['target_room', '目标房间 asset，-1 = 不切房间'],
      ['target_landmark', '目标房间内的落点标记编号'],
      ['fade_in_time / fade_in_color', '进入时黑幕时长与颜色（默认 20 帧 / 黑）'],
      ['fade_out_time / fade_out_color', '离开时黑幕时长与颜色'],
      ['bgm_fade / bgm_fade_time', '是否淡出 BGM 及时长'],
      ['warp_wait', '触发前等待帧数'],
      ['player_dir', '传送后朝向，-1 = 保持原样'],
      ['user_char', '允许触发的角色编号，0 = 不限'],
    ],
  },
  { n: 'trigger_shop', g: 'world', t: '地图', d: '进入商店的触发器。碰到后打开指定商店，父物体为 trigger。', },

  // ===== shop 家族 =====
  {
    n: 'shop', g: 'world', t: '商店', hot: true,
    d: '商店主控。负责光标移动、买卖分支切换、价格结算与退出，是整套商店流程的中枢，其余三个 shop_ 物体都配合它工作。',
    v: [
      ['_index', '主列表光标位置'],
      ['_index_buy / _index_sell', '买 / 卖分支的光标位置'],
      ['_choice_state', '当前处于哪一步（选物品 / 确认 / 结算）'],
      ['_pre_index / _pre_index_buy / _pre_index_sell', '上一步光标位置，返回时还原'],
      ['_exit_index', '「离开」选项的位置'],
      ['border_x1/y1/x2/y2 / border_width', '商店边框范围与粗细'],
      ['menu_divide_x / state_info_y', '菜单分割线 X 与状态栏 Y'],
    ],
  },
  {
    n: 'shop_host', g: 'world', t: '商店',
    d: '店主配置。定义立绘、货架商品与各阶段的对话文案，通常做成多个物体来区分不同店主。',
    v: [
      ['host_sprite', '店主立绘贴图'],
      ['menu_text / encounter_text', '菜单提示文本与见面语'],
      ['shop_item[0~3]', '货架上的四件商品'],
      ['buy_before_text / buy_after_text / buy_false_text', '购买前 / 成功 / 钱不够的文本'],
      ['sold_available / sold_*_text', '是否启用「已售出」状态及其文本'],
      ['dialog_init[0~3] / dialog[0~3]', '四段对话的初始与当前内容'],
      ['exit_text', '离开时的告别语'],
    ],
    rel: [['店主事件（User Event）', [
      ['event_user(10~15)', '商店各阶段的回调：进入、选物品、购买、结算等，在这里改文案与判断'],
    ]]],
  },
  { n: 'shop_dialog', g: 'world', t: '商店', d: '商店的对话框容器，负责把 shop_host 里配好的文案显示出来。', },
  { n: 'shop_dialog_typer', g: 'world', t: '商店', d: '商店对话框专用的打字机，复用了主引擎的逐字显示逻辑，用于把店主的话逐字打出来。', },

  // ===== demo 家族 =====
  {
    n: 'demo_recorder', g: 'core', t: '系统',
    d: '输入录制器。把玩家的操作按帧写进缓冲区，同时记录随机种子，用于复现 bug 与做演示。',
    v: [
      ['_buffer', '记录输入的缓冲区'],
      ['_frame_number', '当前记录到第几帧'],
      ['_seed', '随机数种子，回放时必须还原'],
      ['_paused', '是否暂停录制'],
      ['_icon_show_tick', '录制图标显示计时'],
    ],
  },
  {
    n: 'demo_player', g: 'core', t: '系统',
    d: '输入回放器。读取 demo_recorder 的缓冲区，按帧重放操作并还原随机种子。',
    v: [
      ['_buffer', '待回放的数据缓冲区'],
      ['_seed', '要还原的随机种子'],
      ['_input_number', '输入种类数量'],
      ['_input_list', '要回放的输入列表'],
      ['_frame_number / _frame_current', '总帧数与当前帧'],
      ['_paused', '是否暂停回放'],
      ['_fps', '回放帧率'],
    ],
  },
];
