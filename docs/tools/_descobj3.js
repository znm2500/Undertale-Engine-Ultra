// 第三批物体介绍：补齐「变量很多但介绍过薄」的物件。
// 判定依据：介绍字数 vs 实际变量数 / 代码量的落差（text_typer 74 变量仅 39 字、battle 46 变量仅 41 字）。
module.exports = {
  'text_typer': {
    d: '引擎的文本渲染与打字机核心 —— 对话框、商店文本、菜单、字幕全都复用这一个物件。它接收带控制标记的文本（如 {color `white`}、{speed 2}、{face 1}、{pause}、{define ...}），先解析成逐字数据（_char_data_list）与控制指令表（_list_cmd），再按 _char_per_frame 的节奏逐字打印。除普通的逐字显示外，它还支持水平 / 垂直两种排版方向（_type_dir）、打字音效与语音（_voice）、按键跳过（_skippable / _skipping）、瞬间全显（_instant）、文本内嵌选项（_choice 系列）、文本宏（_map_macro）、与表情物件联动（_face），以及彩虹字、阴影、描边等文字特效。想改对话的观感与节奏，基本都在这里。'
  },
  'battle': {
    d: '战斗系统的总控物件 —— 整场战斗的状态机、菜单、回合与结算全都由它持有。它按 BATTLE_STATE 推进流程：MENU（选 FIGHT / ACT / ITEM / MERCY）→ DIALOG（菜单提示或对话）→ TURN_PREPARATION（敌人生成与准备）→ IN_TURN（弹幕回合）→ BOARD_RESETTING（战斗框复位）→ RESULT（结算）。敌人通过 User Event 往 _turn_info 里写行动参数，它再读出来执行；玩家的 ATK / DEF / SPD 在本回合的临时增减存在 _player_temp_* 里，回合结束即失效。所有 Battle_Set* / Battle_Get* 系列函数读写的就是它的这些内部变量。'
  },
  'closed_captions': {
    d: '全屏字幕系统 —— 把当前播放的音效与语音以文字形式显示在屏幕下方，方便听障玩家。它用两个队列（_queue_text / _queue_duration）接收待显示的字幕，用四个列表跟踪已经创建的字幕实例与各自的剩余时间，并在字幕更新时做淡入淡出。字幕区域的四边界与基准透明度（_up / _down / _left / _right / _color / _alpha_base）都可以调。'
  },
  'char_player': {
    d: '玩家的角色物件 —— 继承自 char，是你在世界里操控的那个人。它登记好四个方向的待机与行走精灵（res_idle_sprite / res_move_sprite），并额外持有一组 _moveable_* 开关：分别控制「对话中 / 菜单打开时 / 存档界面 / 传送中 / 商店里 / 遭遇动画中 / 物品框打开时」这七种场景下玩家能否移动。想让玩家在看剧情时乖乖站住，改这些开关即可，不必禁用整个物件。'
  },
  'trigger_shop': {
    d: '进店触发器 —— 继承自 trigger，放在地图上某个位置。玩家走进去时依次执行：淡入黑幕（fade_in_time / fade_in_color）、按 target_shop_id 打开对应商店、离开时淡出（fade_out_time / fade_out_color），并可选择让 BGM 一起淡出（bgm_fade / bgm_fade_time）。相较基类，它还支持跳转到指定地标（target_landmark）与设定传送后玩家的朝向（player_dir）。'
  },
  'battle_damage': {
    d: '伤害数字与血条 —— 打在敌人身上时弹出的那个红色数字，以及敌人血量的动态条都由它绘制。数字会做弹跳动画（yscale / gra / vsp 控制下落的物理），血条则从 bar_hp_original 平滑动画到 bar_hp_target，时长由 bar_duration 决定，中途实际显示的中间值存在 _bar_hp。停留时间由 display_time 控制；不想要血条，把 bar_visible 关掉即可。'
  },
  'shop_dialog': {
    d: '商店里的一段对话数据 —— 它本身不画东西，只是一个纯数据结构，被商店系统读来渲染。title 是标题栏内容索引、text 是正文内容索引（-1 表示该项不显示），title_blend 控制标题的混色颜色，next_dialog 指向下一段（noone 表示这是最后一段）。店主通过 Shop_SetDialog() 生成这些数据。'
  },
  'ui_box': {
    d: '通用物品框界面 —— 显示「获得 / 失去物品」或「查看某个容器」时弹出的那个方框。它有自己的一套状态机（_state）与模式选择（_choice_mode，浏览 / 操作），内部用四个子实例分别渲染物品栏与物品框的列表和条目（_inst_inventory / _inst_box / _inst_item_*），最后用 _inst_finish 显示「完成」提示，展开宽度由 _show_width 驱动。'
  },
  'shop_host': {
    d: '商店店主的数据容器 —— 一个纯数据物件，把某位店主要说的话和要卖的东西集中登记：打招呼（encounter_text）、菜单提示（menu_text）、购买前后（buy_before_text / buy_after_text）、买不起或背包已满（buy_false_text），以及是否支持卖东西（sold_available）和卖出各阶段的文本。host_sprite 是立绘，shop_item 是商品列表。商店系统读它来渲染整个界面。'
  },
  'battle_dialog_enemy': {
    d: '敌人对话框 —— 战斗中敌人说话时弹在敌人旁边的那个带尖角的框。它把文本交给内部的打字机实例逐字打印（_inst），并按 dir 决定框子朝哪边伸尖角（show_spike），wide_spike 可切换加宽版。四边界（up / down / left / right）与文字偏移（text_offset_x / text_offset_y）都可调，用来适配不同体型的敌人。'
  },
  'demo_player': {
    d: '录像回放器 —— 把一份录制好的操作录像逐帧重放出来，用于做开场演示或调试复现。它按录制时的随机种子（_seed）还原随机数，从 _input_list 里逐帧取出玩家输入喂给输入系统，同时维护当前帧号（_frame_current）与总帧数（_frame_number）。播放期间会在角落显示一个指示图标（_icon_show_tick 计时）。配合 demo_recorder 使用。'
  },
  'demo_recorder': {
    d: '操作录像机 —— 把玩家的输入与随机种子记录下来存进缓冲区（_buffer），供 demo_player 之后回放。它统计已录制的帧数（_frame_number），并维护一个显示中的录制指示图标（_icon_show_tick）。录制内容不含画面、只含输入与种子，所以体积很小、且回放结果完全可复现。'
  },
  'fader': {
    d: '全屏淡入淡出遮罩 —— 一个铺满屏幕的纯色矩形，用来做转场黑屏或白闪。color 决定颜色，alpha 决定不透明度（0 = 完全透明，1 = 完全不遮）。引擎提供 Fader_Fade() 等函数驱动它做淡入淡出，一般不需要手动改这两个变量。'
  },
  'exclamation': {
    d: '感叹号提示 —— 触发遭遇战时敌人头顶弹出来的那个「！」。它会在 time 帧内播放出现动画后停留，_time 记录已经显示了多久。默认不自动推进动画（image_speed 为 0），由事件逐帧控制，方便和其他演出对齐。'
  },
  'battle_menu_item_scrollbar': {
    d: '物品栏滚动条 —— ITEM 菜单右侧那条用来表示「还有很多物品」的竖条。它按背包物品总数（NUMBER）决定要画几段，yd 是它的纵向基准位置，yy 数组保存每一段的纵坐标，上下两端由 yy1 / yy2 界定；经典 UI 模式下会改为居中排布。透明度和能否被操作分别由 alpha 与 moveable 控制。'
  },
  'encounter_anim': {
    d: '遭遇战开场动画 —— 进入战斗前那段「屏幕变黑 + 灵魂飞入 + 玩家淡出」的转场演出。它按 _encounter 读取遭遇数据，用一组 _draw_* 开关分阶段控制绘制内容（灵魂、玩家、黑幕），_soul_x / _soul_y 是灵魂的起始位置，_exclam 决定是否先弹感叹号，_quick 可切到快速版演出。'
  },
  'ui_save': {
    d: '存档界面 —— 保存 / 读取存档时显示的那个面板，展示玩家名字、LV、游玩时间与当前房间。它有一套简单的状态机（_state）与选项索引（_choice / _choice_soul），用六个文本子实例分别显示各项信息（_inst_name / _inst_lv / _inst_time / _inst_room / _inst_save / _inst_return），展开宽度由 _show_width 驱动。'
  },
  'shop': {
    d: '商店系统的总控界面 —— 从进店打招呼、浏览商品、选择买卖到结算退店，整个流程都在这里。它用一套状态机（_state，取自 SHOP_STATE）推进，维护商品列表索引（_index / _index_buy / _index_sell）与上一帧索引以便检测选中变化（_pre_index*），并用五个打字机实例分别渲染左侧列表、右侧详情、信息栏与两行状态栏（_typer_left / _typer_right / _typer_info / _typer_state_0 / _typer_state_1）。界面的边框与文字坐标都由一组几何变量决定（border_x1 到 border_y2、menu_divide_x、state_info_y、buy_info_*），改它们就能调整商店版面。'
  },
  'menu': {
    d: '主菜单 —— 游戏开始与暂停时出现的菜单，涵盖开始游戏、继续、设置、重置，以及新档的命名与确认流程。它用一个 _mode 区分大模式（标题 / 命名 / 确认），并为菜单里每一行文字各持有一个文本实例（_inst_begin / _inst_continue / _inst_settings / _inst_lv / _inst_time / _inst_room / _inst_reset 等）。命名界面额外维护选中的字母与命令（_choice_naming_*），确认界面则用一组 _confirm_* 控制名字预览的位置、缩放与旋转。'
  },
  'ui_menu': {
    d: '暂停菜单界面 —— 按菜单键弹出的面板，包含角色状态、物品栏与手机三个页签。它登记了三页各自的选项索引（_choice / _choice_item / _choice_phone）与光标位置（_choice_*_soul），并为每页的子面板与文本条目各持有一个实例（_inst_menu / _inst_item / _inst_stat_0 / _inst_stat_1 / _inst_phone 等）。三个子面板的展开宽度与销毁倒计时分别存在 _show_width 与 _destroy_time 数组里。'
  },
  'bone_box': {
    d: '盒形骨墙 —— 用四面骨墙围出一块可活动区域的经典弹幕。它先登记四条边的端点坐标（x1 / x2 / y1 / y2），再按战斗框当前角度重算出实际绘制用的折线端点（xx1 到 xx4、yy1 到 yy4），所以战斗框旋转时骨墙也能跟着贴合。circle 可切换成圆形布局，follow_board 决定是否跟随战斗框位移，duration 是存活帧数。'
  },
  'bone_circle': {
    d: '环形骨弹幕 —— 把骨头沿一个椭圆均匀排成一圈。size_x / size_y 是椭圆的横向与纵向半径，number 是骨头根数，extra_angle 给每根骨头加额外的角度偏移。整圈还能整体旋转：rot 是起始角度，rott 是每帧的旋转速度，roting 控制是否持续旋转。'
  },
  'trigger_warp': {
    d: '传送触发器 —— 继承自 trigger，放在地图上用于切换房间。玩家碰到时按 target_room 跳到目标房间，并可指定落点地标（target_landmark）与到达后的朝向（player_dir）；转场用淡入淡出完成（fade_in_time / fade_in_color / fade_out_time / fade_out_color），也能让 BGM 一起淡出（bgm_fade / bgm_fade_time）。warp_wait 是传送前额外等待的帧数。'
  },
  'shop_host_test': {
    d: '商店店主的测试用例 —— 演示如何用最少的代码配出一位能说会卖的店主：把招呼语、菜单提示、买卖前后的台词，以及各种「钱不够 / 背包已满」的失败文本逐条填好，再指明要卖的商品（shop_item）与是否收购（sold_available），最后用 Shop_SetDialog() 组装出一段带颜色的对话。想新建店主，照抄这个物件的填法即可。'
  },
  'battle_soul_purple': {
    d: '紫魂模式 —— 灵魂被限制在几条虚线轨道上移动，只能沿轨道滑动、不能自由飞行。它用 x_on / y_on 记录当前吸附在哪条横 / 竖轨道上，用 x_index / y_index 保存轨道索引；遇到十字路口时用 cross_start / cross_target / cross_step 描述从哪跳到哪、已经走了几步。moving_direction 表示在轨道上的移动方向。'
  }
};
