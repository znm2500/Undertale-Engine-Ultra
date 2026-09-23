window.API = {
   "categories": [
      {
         "id": "encounter",
         "name": "遭遇配置",
         "desc": "定义一场战斗有哪些敌人、什么BGM"
      },
      {
         "id": "battlecore",
         "name": "战斗流程与状态",
         "desc": "战斗状态机、回合、菜单的控制"
      },
      {
         "id": "enemy",
         "name": "敌人",
         "desc": "敌人的注册、属性、行动与事件回调"
      },
      {
         "id": "bullet",
         "name": "弹幕与攻击",
         "desc": "骨骼、加斯特冲击波、平台等攻击生成"
      },
      {
         "id": "soul",
         "name": "灵魂 SOUL",
         "desc": "灵魂模式切换与属性"
      },
      {
         "id": "board",
         "name": "战斗框",
         "desc": "框尺寸、位移、形状与自绘战斗框"
      },
      {
         "id": "dialog",
         "name": "对话与文本",
         "desc": "对话框、打字机、文本框格式标签"
      },
      {
         "id": "player",
         "name": "玩家数据",
         "desc": "HP / LV / ATK / 物品栏 / 存档点数据"
      },
      {
         "id": "item",
         "name": "物品与背包",
         "desc": "物品类型注册、背包容器、使用回调"
      },
      {
         "id": "anim",
         "name": "动画补间",
         "desc": "Anim_Create 补间与 Animator 关键帧"
      },
      {
         "id": "storage",
         "name": "存档系统",
         "desc": "Static / Dynamic / Info / Temp 四级存储"
      },
      {
         "id": "input",
         "name": "输入系统",
         "desc": "键位绑定与按键状态查询"
      },
      {
         "id": "audio",
         "name": "音频 BGM",
         "desc": "背景音乐槽位管理"
      },
      {
         "id": "ui",
         "name": "界面与特效",
         "desc": "淡入淡出、震屏、边框、字幕"
      },
      {
         "id": "shop",
         "name": "商店",
         "desc": "商店注册与流程"
      },
      {
         "id": "misc",
         "name": "工具与宏",
         "desc": "数学工具、向量、注册器、宏定义"
      }
   ],
   "functions": [
      {
         "c": "board",
         "n": "__Battle_Iloop",
         "s": "__Battle_Iloop(_index, _list)",
         "d": "内部函数。把数组下标按长度取模并修正负数，让点集框的顶点索引能够首尾循环而不越界。",
         "p": [
            [
               "_index",
               "number",
               "内部：数组下标"
            ],
            [
               "_list",
               "array",
               "内部：数组"
            ]
         ]
      },
      {
         "c": "board",
         "n": "__Battle_RegisterBoard",
         "s": "__Battle_RegisterBoard(_board)",
         "d": "内部函数。把自绘战斗框登记进全局框表，并分配一个唯一编号（board_number），供后续遍历与拾取。",
         "p": [
            [
               "_board",
               "struct",
               "内部：框结构体"
            ]
         ]
      },
      {
         "c": "board",
         "n": "__Battle_RemoveBoard",
         "s": "__Battle_RemoveBoard(_board)",
         "d": "内部函数。从全局框表里摘除指定框，一般在框销毁时调用。",
         "p": [
            [
               "_board",
               "struct",
               "内部：框结构体"
            ]
         ]
      },
      {
         "c": "board",
         "n": "__Battle_RemoveBoardController",
         "s": "__Battle_RemoveBoardController(_controller)",
         "d": "内部函数。把框控制器从全局控制器表里摘除。控制器负责驱动框的位移与形变。",
         "p": [
            [
               "_controller",
               "struct",
               "内部：框控制器"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Anim_Create",
         "s": "Anim_Create(target, var_name, tween_type, ease_type, start, change, duration, delay, auto_destroy, single_speed, alone_exist, mode, repeat_count)",
         "d": "给任意变量创建一条补间动画。target 可以是 global / 实例 / 结构体 / 数组 / ds_map / ds_grid。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ],
            [
               "tween_type",
               "枚举",
               "补间曲线类型（ANIM_TWEEN）"
            ],
            [
               "ease_type",
               "枚举",
               "缓动方向（ANIM_EASE）"
            ],
            [
               "start",
               "number",
               "起始值"
            ],
            [
               "change",
               "number",
               "变化量"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "delay",
               "number（可选）",
               "延迟帧数"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出面板后自动销毁"
            ],
            [
               "single_speed",
               "bool",
               "true = 忽略时长按固定速度推进"
            ],
            [
               "alone_exist",
               "bool",
               "true = 同一目标上只允许存在一条补间"
            ],
            [
               "mode",
               "number",
               "补间模式"
            ],
            [
               "repeat_count",
               "number",
               "重复次数，-1 = 无限循环"
            ]
         ],
         "ex": "// 2秒内把面板高度从 65 拉到 200（30帧缓出）\nAnim_Create(battle_board, \"up\", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT,\n            65, 200 - 65, 30);\n\n// 全局模糊量归零\nAnim_Create(global, \"blur_amount\", 0, 0, 2, -2, 1, 20);\n\n// 死亡粒子：同时淡出+缩小\nAnim_Create(inst, \"image_alpha\", ANIM_TWEEN.LINEAR, ANIM_EASE.OUT, 1, -1, 40);\nAnim_Create(inst, \"image_xscale\", ANIM_TWEEN.QUAD, ANIM_EASE.OUT, 1, -1, 40);",
         "hot": true
      },
      {
         "c": "anim",
         "n": "Anim_CreateTarget",
         "s": "Anim_CreateTarget(target, var_name, tween_type, ease_type, start, target_value, duration, delay, auto_destroy, single_speed, alone_exist, mode, repeat_count)",
         "d": "同上，但第 6 个参数直接写【目标值】而不是变化量，更直观。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ],
            [
               "tween_type",
               "枚举",
               "补间曲线类型（ANIM_TWEEN）"
            ],
            [
               "ease_type",
               "枚举",
               "缓动方向（ANIM_EASE）"
            ],
            [
               "start",
               "number",
               "起始值"
            ],
            [
               "target_value",
               "number",
               "补间要到达的目标值"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "delay",
               "number（可选）",
               "延迟帧数"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出面板后自动销毁"
            ],
            [
               "single_speed",
               "bool",
               "true = 忽略时长按固定速度推进"
            ],
            [
               "alone_exist",
               "bool",
               "true = 同一目标上只允许存在一条补间"
            ],
            [
               "mode",
               "number",
               "补间模式"
            ],
            [
               "repeat_count",
               "number",
               "重复次数，-1 = 无限循环"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Anim_Destroy",
         "s": "Anim_Destroy(target, var_name)",
         "d": "销毁动画。不给 var_name 会销毁该 target 上所有动画。做「打断/重置」时必用。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ]
         ],
         "hot": true
      },
      {
         "c": "anim",
         "n": "Anim_GetValue",
         "s": "Anim_GetValue(TWEEN, EASE, TIME)",
         "d": "读取某条补间当前算出的值，用于外部逻辑引用动画进度。",
         "p": [
            [
               "TWEEN",
               "枚举",
               "补间曲线类型，取自 ANIM_TWEEN（LINEAR / SINE / QUAD / CUBIC / EXPO…）"
            ],
            [
               "EASE",
               "枚举",
               "缓动方向，取自 ANIM_EASE（IN / OUT / IN_OUT）"
            ],
            [
               "time",
               "number",
               "淡入淡出时长（帧）"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Anim_Init",
         "s": "Anim_Init()",
         "d": "初始化补间系统。会在此处注册 ANIM_TWEEN（缓动曲线）与 ANIM_EASE 两组枚举，并建好全局补间列表。游戏启动时调用一次即可。",
         "p": []
      },
      {
         "c": "anim",
         "n": "Anim_IsExists",
         "s": "Anim_IsExists(target, var_name)",
         "d": "查询某个「目标 + 变量」上是否还有补间在跑。重复起动画前先判断可以避免叠加。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Anim_SetSingleSpeed",
         "s": "Anim_SetSingleSpeed(target, var_name, single_speed)",
         "d": "调整某条补间的播放速度倍率，可以中途变快或变慢。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ],
            [
               "single_speed",
               "bool",
               "true = 忽略时长按固定速度推进"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Anim_Skip",
         "s": "Anim_Skip(target, var_name)",
         "d": "立刻跳到补间的终点并结束它。做「跳过动画」功能时用。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Anim_Step",
         "s": "Anim_Step()",
         "d": "每帧推进所有补间。内部已按 delta_time_factor 做帧率补偿，所以放在任意 Step 事件里调一次就够，不必自己乘速度。",
         "p": []
      },
      {
         "c": "anim",
         "n": "Anim_Uninit",
         "s": "Anim_Uninit()",
         "d": "卸载补间系统，释放全局补间列表与 Animator 数组。一般只在游戏退出或热重载时调用。",
         "p": []
      },
      {
         "c": "anim",
         "n": "Animator",
         "s": "Animator(tween_default, ease_default)",
         "d": "关键帧动画器。比 Anim_Create 更适合做多段复杂运动（如先上后右再下）。",
         "p": [
            [
               "tween_default",
               "枚举",
               "该 Animator 的默认补间曲线"
            ],
            [
               "ease_default",
               "枚举",
               "该 Animator 的默认缓动方向"
            ]
         ],
         "ex": "var a = new Animator(ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);\n\na.SetKeyframe(obj_enemy, \"x\",\n    [0.0, 320],              // 0% 处 x = 320\n    [0.5, 480],              // 50% 处 x = 480\n    [1.0, 320]);             // 100% 处回到 320\n\na.Play(90, 0, 1, ANIMATOR_PLAY_DIREATION.NORMAL, 1, 0, 0);",
         "hot": true
      },
      {
         "c": "anim",
         "n": "Animator_Delete",
         "s": "Animator_Delete(target, var_name)",
         "d": "从匹配的 Animator 上删除某条属性通道，Animator 本身保留、仍可继续加新关键帧。参数 var_name 省略时删掉该目标下所有通道。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator_Destroy",
         "s": "Animator_Destroy(target, var_name)",
         "d": "删掉整个 Animator 实例并从全局动画列表里摘掉它。与 Animator_Delete 的区别：Delete 只清通道，Destroy 连容器一起移除。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator_IsExist",
         "s": "Animator_IsExist(target, var_name)",
         "d": "查询是否存在匹配的 Animator。省略 var_name 时只按目标对象判断，给了就再比对该属性通道。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator.Continue",
         "s": "Continue()",
         "d": "恢复被 Pause 暂停的 Animator，沿用暂停前记录的速度。返回 false 说明它本来就在播放。",
         "p": []
      },
      {
         "c": "anim",
         "n": "Animator.DeleteKeyFrame",
         "s": "DeleteKeyFrame(target, var_name, progress...)",
         "d": "按模式定位并删除某个进度点上的关键帧。参数依次为通道、进度，可再跟多个进度。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ],
            [
               "progress",
               "0~1",
               "播放进度，0 = 开头，1 = 结尾 可一次传入多个。"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator.DeletePattern",
         "s": "DeletePattern(target, varname)",
         "d": "删除指定目标的整条属性通道。找不到时直接返回 false，不做任何改动。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "varname",
               "string",
               "属性名"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator.Destroy",
         "s": "Destroy()",
         "d": "把当前 Animator 从全局列表移除并销毁，等价于对自身调用 Animator_Destroy。",
         "p": []
      },
      {
         "c": "anim",
         "n": "Animator.GetPattern",
         "s": "GetPattern(target, var_name)",
         "d": "按目标对象 + 属性名查找属性通道，返回通道结构体；找不到返回 false。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator.IsKeyFrameExists",
         "s": "IsKeyFrameExists(pattern, progress)",
         "d": "用二分查找判断某个进度上是否已存在关键帧。关键帧表按进度有序，所以比线性遍历快。",
         "p": [
            [
               "pattern",
               "struct",
               "属性通道对象"
            ],
            [
               "progress",
               "0~1",
               "播放进度，0 = 开头，1 = 结尾"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator.Pause",
         "s": "Pause()",
         "d": "暂停播放，同时把当前速度存进内部变量，好让 Continue 原样恢复。返回 false 表示它本来就是停的。",
         "p": []
      },
      {
         "c": "anim",
         "n": "Animator.Play",
         "s": "Play(duration, delay, play_speed, play_direction, play_count, play_interval, auto_destroy)",
         "d": "开始播放关键帧动画。可指定总时长、起始延迟、播放速度、方向（正放 / 倒放）、循环次数与间隔。",
         "p": [
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "delay",
               "number（可选）",
               "延迟帧数"
            ],
            [
               "play_speed",
               "number",
               "播放速度倍数，1 = 原速"
            ],
            [
               "play_direction",
               "枚举",
               "播放方向：正放 / 倒放（ANIMATOR_PLAY_DIREATION）"
            ],
            [
               "play_count",
               "number",
               "播放次数，默认 1"
            ],
            [
               "play_interval",
               "number",
               "每轮之间的间隔帧数"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出面板后自动销毁"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator.SetKeyframe",
         "s": "SetKeyframe(target, var_name, keyframe...)",
         "d": "在指定进度插入关键帧。参数依次为通道、进度，之后可跟多个进度值。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ],
            [
               "keyframe",
               "0~1",
               "关键帧位置，取值 0 到 1。0 表示开头、1 表示结尾，中间值即进度比例；可一次传入多个。"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator.SetPlaySpeed",
         "s": "SetPlaySpeed(play_speed)",
         "d": "设置播放速度倍数。1 为原速，负数可倒放。",
         "p": [
            [
               "play_speed",
               "number",
               "播放速度倍数，1 = 原速"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator.SetProgress",
         "s": "SetProgress(progress)",
         "d": "直接把播放进度跳到指定值，立即生效，不做补间插值。",
         "p": [
            [
               "progress",
               "0~1",
               "播放进度，0 = 开头，1 = 结尾"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Animator.Step",
         "s": "Step()",
         "d": "推进该 Animator 的播放进度。通常不直接调用，由 Anim_Step 统一遍历驱动。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_AddBoardVertex",
         "s": "Battle_AddBoardVertex(board, vertex_x, vertex_y)",
         "d": "给 Battle_CreateBoardPoints 创建的框加顶点。⚠ 顺序必须顺时针。",
         "p": [
            [
               "board",
               "struct",
               "框结构体"
            ],
            [
               "vertex_x",
               "number",
               "顶点 X"
            ],
            [
               "vertex_y",
               "number",
               "顶点 Y"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_CallBulletEventSoulCollision",
         "s": "Battle_CallBulletEventSoulCollision()",
         "d": "让弹幕主动触发一次「撞到灵魂」的回调。通常由引擎在检测到碰撞时调用。",
         "p": []
      },
      {
         "c": "enemy",
         "n": "Battle_CallEnemyEvent",
         "s": "Battle_CallEnemyEvent(event, [enemy_slot])",
         "d": "主动触发敌人的事件回调。省略 enemy_slot 则对所有敌人广播。你自己的攻击代码里很少需要调它，但理解事件流必须知道它。",
         "p": [
            [
               "event",
               "BATTLE_ENEMY_EVENT",
               "要触发的事件枚举"
            ],
            [
               "enemy_slot",
               "0~2（可选）",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ],
         "hot": true
      },
      {
         "c": "bullet",
         "n": "Battle_CallSoulEventBulletCollision",
         "s": "Battle_CallSoulEventBulletCollision()",
         "d": "让灵魂主动触发一次「被弹幕撞到」的事件回调。一般只在调试或做特殊判定时手动调用。",
         "p": []
      },
      {
         "c": "soul",
         "n": "Battle_CallSoulEventHurt",
         "s": "Battle_CallSoulEventHurt()",
         "d": "让灵魂触发一次受伤回调，会走完整的扣血与无敌帧流程。",
         "p": []
      },
      {
         "c": "enemy",
         "n": "Battle_ConvertEnemySlotToMenuChoiceEnemy",
         "s": "Battle_ConvertEnemySlotToMenuChoiceEnemy(enemy_slot)",
         "d": "把敌人槽位号（0~2）换算成菜单里的目标序号。两套编号在 UI 与数据层之间转换时用。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ]
      },
      {
         "c": "enemy",
         "n": "Battle_ConvertMenuChoiceEnemyToEnemySlot",
         "s": "Battle_ConvertMenuChoiceEnemyToEnemySlot(menu_choice_enemy)",
         "d": "把菜单里的目标序号换算回敌人槽位号。与上一个函数互为反向。",
         "p": [
            [
               "menu_choice_enemy",
               "number",
               "菜单里的敌人序号（0~2），与槽位编号不同"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_CreateBoardCircle",
         "s": "Battle_CreateBoardCircle(x, y, radius, board_depth, cover)",
         "d": "创建一个圆形自绘战斗框。参数与矩形版类似，常用于圆形审判场或环形弹幕区域。返回 board 结构体，需要自己移除。",
         "p": [
            [
               "x",
               "number",
               "框中心 X"
            ],
            [
               "y",
               "number",
               "框中心 Y"
            ],
            [
               "radius",
               "number",
               "半径"
            ],
            [
               "board_depth",
               "number",
               "绘制深度"
            ],
            [
               "cover",
               "0/1",
               "1 = 减框：把这块区域从战斗框里挖掉，灵魂进不去（形状本身不可见，判定范围沿轮廓外扩一圈）；0 = 加框：把这块区域并入战斗框，灵魂可进入（正常绘制）"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_CreateBoardEllipse",
         "s": "Battle_CreateBoardEllipse(x, y, radius_x, radius_y, board_depth, angle, rotate, cover)",
         "d": "创建一个椭圆自绘战斗框。radius_x / radius_y 是横竖半径，后面依次是绘制深度、旋转角、是否旋转、cover：1 = 减框，否则加框。返回 board 结构体，用完需要自己移除。",
         "p": [
            [
               "x",
               "number",
               "框中心 X"
            ],
            [
               "y",
               "number",
               "框中心 Y"
            ],
            [
               "radius_x",
               "number",
               "横半径"
            ],
            [
               "radius_y",
               "number",
               "竖半径"
            ],
            [
               "board_depth",
               "number",
               "绘制深度"
            ],
            [
               "angle",
               "number",
               "旋转角"
            ],
            [
               "rotate",
               "number",
               "每帧自转角速度"
            ],
            [
               "cover",
               "0/1",
               "1 = 减框：把这块区域从战斗框里挖掉，灵魂进不去（形状本身不可见，判定范围沿轮廓外扩一圈）；0 = 加框：把这块区域并入战斗框，灵魂可进入（正常绘制）"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_CreateBoardPoints",
         "s": "Battle_CreateBoardPoints(x, y, board_depth, angle, rotate, cover)",
         "d": "创建一个空战斗框，之后用 Battle_AddBoardVertex 手动加顶点。⚠ 顶点必须按顺时针排列，否则画面出问题。",
         "p": [
            [
               "x",
               "number",
               "框中心 X"
            ],
            [
               "y",
               "number",
               "框中心 Y"
            ],
            [
               "board_depth",
               "number",
               "绘制深度"
            ],
            [
               "angle",
               "number",
               "旋转角"
            ],
            [
               "rotate",
               "number",
               "每帧自转角速度"
            ],
            [
               "cover",
               "0/1",
               "1 = 减框：把这块区域从战斗框里挖掉，灵魂进不去（形状本身不可见，判定范围沿轮廓外扩一圈）；0 = 加框：把这块区域并入战斗框，灵魂可进入（正常绘制）"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_CreateBoardRect",
         "s": "Battle_CreateBoardRect(x, y, up, down, left, right, board_depth, angle, rotate, cover)",
         "d": "创建一个矩形自绘战斗框。返回 board 结构体，需要自己移除。用于非矩形战斗框（如 Sans 的骨墙斜切框）。",
         "p": [
            [
               "x",
               "number",
               "框中心 X"
            ],
            [
               "y",
               "number",
               "框中心 Y"
            ],
            [
               "up",
               "number",
               "向上延伸距离（不是高度）"
            ],
            [
               "down",
               "number",
               "向下延伸距离"
            ],
            [
               "left",
               "number",
               "向左延伸距离"
            ],
            [
               "right",
               "number",
               "向右延伸距离"
            ],
            [
               "board_depth",
               "number",
               "绘制深度"
            ],
            [
               "angle",
               "number",
               "旋转角"
            ],
            [
               "rotate",
               "number",
               "每帧自转角速度"
            ],
            [
               "cover",
               "0/1",
               "1 = 减框：把这块区域从战斗框里挖掉，灵魂进不去（形状本身不可见，判定范围沿轮廓外扩一圈）；0 = 加框：把这块区域并入战斗框，灵魂可进入（正常绘制）"
            ]
         ],
         "hot": true
      },
      {
         "c": "battlecore",
         "n": "Battle_CreateBoardRoundrect",
         "s": "Battle_CreateBoardRoundrect(x, y, size, corner_radius, board_depth, angle, rotate, cover)",
         "d": "创建一个圆角矩形自绘战斗框。size 是边长，corner_radius 是圆角半径。适合做边缘柔化的战斗框。返回 board 结构体。",
         "p": [
            [
               "x",
               "number",
               "框中心 X"
            ],
            [
               "y",
               "number",
               "框中心 Y"
            ],
            [
               "size",
               "number",
               "边长"
            ],
            [
               "corner_radius",
               "number",
               "圆角半径"
            ],
            [
               "board_depth",
               "number",
               "绘制深度"
            ],
            [
               "angle",
               "number",
               "旋转角"
            ],
            [
               "rotate",
               "number",
               "每帧自转角速度"
            ],
            [
               "cover",
               "0/1",
               "1 = 减框：把这块区域从战斗框里挖掉，灵魂进不去（形状本身不可见，判定范围沿轮廓外扩一圈）；0 = 加框：把这块区域并入战斗框，灵魂可进入（正常绘制）"
            ]
         ]
      },
      {
         "c": "dialog",
         "n": "Battle_Dialog_Enemy_Add",
         "s": "Battle_Dialog_Enemy_Add(x, y, depth, text, template)",
         "d": "在敌人身上弹出一个气泡对话框。参数是显示坐标、深度与文本内容。",
         "p": [
            [
               "x",
               "number",
               "相对面板中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对面板中心的 Y 坐标"
            ],
            [
               "depth",
               "number",
               "绘制深度"
            ],
            [
               "text",
               "string",
               "文本内容（支持 {color} 等格式标签）"
            ],
            [
               "template",
               "string",
               "文本模板"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_End",
         "s": "Battle_End()",
         "d": "结束整场战斗，退出战斗状态并返回地图。胜利、逃跑、死亡三条路径最终都会走到它。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_EndDialog",
         "s": "Battle_EndDialog()",
         "d": "结束对话状态，状态机回到 MENU。配合 Battle_SetDialog 用，控制台词播完后往哪走。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_EndMenu",
         "s": "Battle_EndMenu()",
         "d": "结束菜单选择状态。玩家确认选项后由它收尾，把控制权交回状态机。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_EndMenuFightAim",
         "s": "Battle_EndMenuFightAim()",
         "d": "结束 FIGHT 的**瞄准**阶段，进入挥刀。一般由攻击条自己在玩家按确认时调用。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_EndMenuFightAnim",
         "s": "Battle_EndMenuFightAnim()",
         "d": "结束 FIGHT 的**挥刀动画**阶段，开始结算命中。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_EndMenuFightDamage",
         "s": "Battle_EndMenuFightDamage()",
         "d": "结束 FIGHT 的**伤害结算**阶段，整个 FIGHT 流程到此收尾。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_EndTurn",
         "s": "Battle_EndTurn()",
         "d": "结束当前回合，回到菜单。这是敌人回合结束的标准出口 —— 把回合时间设为有限，或用计时器调用它。",
         "p": [],
         "ex": "// 方式一：回合限时 300 帧\nBattle_SetTurnTime(300);\n\n// 方式二：自己计时结束\n// 在敌人 TURN_START 事件里\nalarm[0] = 60 * 5;   // 5 秒后\n// Alarm 0 里：\nBattle_EndTurn();",
         "hot": true
      },
      {
         "c": "battlecore",
         "n": "Battle_EndTurnPreparation",
         "s": "Battle_EndTurnPreparation()",
         "d": "提前结束回合准备阶段，立刻进入敌人回合。做「玩家一点就开打」的速攻型敌人时用。",
         "p": []
      },
      {
         "c": "ui",
         "n": "Battle_FadeFader",
         "s": "Battle_FadeFader(alpha, time)",
         "d": "战斗场景专用的黑幕。与通用的 Fader_Fade 区别在于深度层级，会盖在战斗 UI 之上。",
         "p": [
            [
               "alpha",
               "0~1",
               "目标透明度"
            ],
            [
               "time",
               "number",
               "时间（帧）。-1 或负数常表示「立即」"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_GetBoardSurface",
         "s": "Battle_GetBoardSurface()",
         "d": "取出框的绘制表面（surface）。需要直接往框上画东西时用它。",
         "p": []
      },
      {
         "c": "enemy",
         "n": "Battle_GetEnemy",
         "s": "Battle_GetEnemy(enemy_slot)",
         "d": "按槽位号取出敌人实例。配合 Battle_IsEnemyValid 使用更稳。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ]
      },
      {
         "c": "enemy",
         "n": "Battle_GetEnemyActionName",
         "s": "Battle_GetEnemyActionName(enemy_slot, action_slot)",
         "d": "读取敌人某个行动的名字。用 action_slot 指定第几个行动。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ],
            [
               "action_slot",
               "number",
               "第几个 ACT 选项（从 0 开始）"
            ]
         ],
         "ex": "Battle_SetEnemyActionName(0, 0, \"Check\");\nBattle_SetEnemyActionName(0, 1, \"Joke\");\nBattle_SetEnemyActionName(0, 2, \"Plead\");",
         "hot": true
      },
      {
         "c": "enemy",
         "n": "Battle_GetEnemyActionNumber",
         "s": "Battle_GetEnemyActionNumber(enemy_slot)",
         "d": "读取敌人当前执行到第几个行动。配合 Battle_CallEnemyEvent 可以知道敌人行动推进到哪一步了。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ],
         "ex": "Battle_SetEnemyActionNumber(0, 3);  // Sans 有3个可调查行动",
         "hot": true
      },
      {
         "c": "enemy",
         "n": "Battle_GetEnemyCenterPosX",
         "s": "Battle_GetEnemyCenterPosX(enemy_slot)",
         "d": "读取敌人立绘中心的 X 坐标。攻击指向敌人、计算命中范围时会用到。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ]
      },
      {
         "c": "enemy",
         "n": "Battle_GetEnemyCenterPosY",
         "s": "Battle_GetEnemyCenterPosY(enemy_slot)",
         "d": "读取敌人立绘中心的 Y 坐标。计算攻击落点、判断是否命中时会用到。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ]
      },
      {
         "c": "enemy",
         "n": "Battle_GetEnemyDEF",
         "s": "Battle_GetEnemyDEF(enemy_slot)",
         "d": "读取敌人的防御力，用于计算玩家攻击造成的伤害。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ]
      },
      {
         "c": "enemy",
         "n": "Battle_GetEnemyName",
         "s": "Battle_GetEnemyName(enemy_slot)",
         "d": "读取槽位上敌人的显示名。这个名字会出现在 ACT / FIGHT 等菜单与血条上。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ],
         "ex": "Battle_SetEnemyName(0, \"Sans\");\nBattle_SetEnemyName(1, \"Papyrus\");",
         "hot": true
      },
      {
         "c": "enemy",
         "n": "Battle_GetEnemyNumber",
         "s": "Battle_GetEnemyNumber()",
         "d": "读取当前场上还活着的敌人数量。用于判断战斗是否该结束、或按人数调整弹幕强度。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenu",
         "s": "Battle_GetMenu()",
         "d": "读取当前所处的菜单子状态，返回 BATTLE_MENU 枚举值（BUTTON / FIGHT_TARGET / ACT_TARGET / ITEM / MERCY 等）。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuChoiceAction",
         "s": "Battle_GetMenuChoiceAction()",
         "d": "读取战斗菜单当前选中的按钮或选项索引。菜单光标停在哪一项（例如 ACT 里选中的某个行动），返回的就是那一项在列表中的位置。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuChoiceButton",
         "s": "Battle_GetMenuChoiceButton()",
         "d": "当前光标在哪个主按钮上。返回 BATTLE_MENU_CHOICE_BUTTON（FIGHT / ACT / ITEM / MERCY）。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuChoiceEnemy",
         "s": "Battle_GetMenuChoiceEnemy()",
         "d": "读取当前选中的目标敌人（菜单侧编号，不是敌人槽位）。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuChoiceItem",
         "s": "Battle_GetMenuChoiceItem()",
         "d": "读取 ITEM 菜单当前选中的物品槽位。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuChoiceMercy",
         "s": "Battle_GetMenuChoiceMercy()",
         "d": "读取 MERCY 菜单当前选中的项（饶恕 / 逃跑等）。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuChoiceMercyOverrideName",
         "s": "Battle_GetMenuChoiceMercyOverrideName(choice_mercy_slot)",
         "d": "读取 MERCY 覆盖模式下某个槽位的自定义名字。",
         "p": [
            [
               "choice_mercy_slot",
               "number",
               "自定义 MERCY 选项的序号"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuChoiceMercyOverrideNumber",
         "s": "Battle_GetMenuChoiceMercyOverrideNumber()",
         "d": "读取 MERCY 覆盖模式下当前有多少个自定义选项。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuDialog",
         "s": "Battle_GetMenuDialog()",
         "d": "读取菜单下方当前的敌人台词（遭遇注册时设置的那句）。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuFightAnimTime",
         "s": "Battle_GetMenuFightAnimTime()",
         "d": "读取 FIGHT 挥刀动画的持续帧数。也就是按下确认后，刀子从出现到砍完一共占用多少帧。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuFightDamage",
         "s": "Battle_GetMenuFightDamage()",
         "d": "读取 FIGHT 这一刀结算出的伤害值。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuFightDamageTime",
         "s": "Battle_GetMenuFightDamageTime()",
         "d": "读取伤害数字在屏幕上停留的帧数。数值越大，敌人头顶那个红色数字挂得越久。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuFightPanel",
         "s": "Battle_GetMenuFightPanel()",
         "d": "读取 FIGHT 攻击条所使用的界面实例。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetMenuItemUsedLast",
         "s": "Battle_GetMenuItemUsedLast()",
         "d": "读取最后一次使用的物品编号。做「重复上次道具」这类便捷功能时用。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetNextState",
         "s": "Battle_GetNextState()",
         "d": "读取下一个将要切换到的战斗状态。配合 Battle_SetNextState 使用。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetPlayerTempAtk",
         "s": "Battle_GetPlayerTempAtk()",
         "d": "读取本回合临时攻击加成。只在本回合有效，回合结束自动失效。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetPlayerTempDef",
         "s": "Battle_GetPlayerTempDef()",
         "d": "读取本回合的临时防御加成，数值只在本回合有效，回合结束自动归零。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetPlayerTempInv",
         "s": "Battle_GetPlayerTempInv()",
         "d": "读取本回合的临时无敌帧加成，只在本回合有效。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetPlayerTempSpd",
         "s": "Battle_GetPlayerTempSpd()",
         "d": "读取本回合的临时速度加成，只在本回合有效。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetRewardExp",
         "s": "Battle_GetRewardExp()",
         "d": "读取本场战斗胜利后准备结算给玩家的经验值（EXP）。只读接口，不会改动奖励数值。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetRewardGold",
         "s": "Battle_GetRewardGold()",
         "d": "读取本场战斗胜利后准备结算给玩家的金币数（GOLD）。只读接口，不会改动奖励数值。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetState",
         "s": "Battle_GetState()",
         "d": "读取当前战斗主状态（MENU / DIALOG / TURN_PREPARATION / IN_TURN / BOARD_RESETTING / RESULT）。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetTurnInfo",
         "s": "Battle_GetTurnInfo(info, [default])",
         "d": "读取「回合信息」。回合信息是本回合的参数表，在回合准备阶段被消费。用 BATTLE_TURN 枚举作 key。",
         "p": [
            [
               "info",
               "FLAG_INFO_*",
               "信息键名，用 Info 系列宏"
            ],
            [
               "default",
               "任意（可选）",
               "键不存在时返回的默认值"
            ]
         ],
         "hot": true
      },
      {
         "c": "battlecore",
         "n": "Battle_GetTurnNumber",
         "s": "Battle_GetTurnNumber()",
         "d": "读取当前回合数。第几个回合从 1 开始计。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GetTurnTime",
         "s": "Battle_GetTurnTime()",
         "d": "读取当前回合已经进行了多少帧。常用来做「这一回合持续多久」的判断或计时器显示。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_GotoNextState",
         "s": "Battle_GotoNextState()",
         "d": "按正常流程切换到下一个战斗状态。这是引擎推进流程的标准方式，比 Battle_SetState 更安全。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_IsBoardTransforming",
         "s": "Battle_IsBoardTransforming()",
         "d": "查询框是否正在变形中。做「变形动画播完再放弹幕」这类串接时用。",
         "p": []
      },
      {
         "c": "bullet",
         "n": "Battle_IsBulletValid",
         "s": "Battle_IsBulletValid(bullet_obj/inst)",
         "d": "判断弹幕实例是否有效。弹幕撞到灵魂或超时后会销毁，操作前先检查可避免报错。",
         "p": [
            [
               "bullet_obj/inst",
               "object/instance",
               "弹幕物体名或实例"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_IsDialogAutoEnd",
         "s": "Battle_IsDialogAutoEnd()",
         "d": "查询对话是否开启自动结束。开启后台词播完自动收场，不需要玩家按键。",
         "p": []
      },
      {
         "c": "enemy",
         "n": "Battle_IsEnemySlotValid",
         "s": "Battle_IsEnemySlotValid(enemy_slot)",
         "d": "判断槽位号（0~2）是否有效。越界返回 false，查敌人属性前先过一道可避免报错。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ]
      },
      {
         "c": "enemy",
         "n": "Battle_IsEnemySpareable",
         "s": "Battle_IsEnemySpareable(enemy_slot)",
         "d": "查询敌人当前是否可以被饶恕（SPARE）。MERCY 菜单会读这个来决定是否放行。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ],
         "ex": "// 玩家已经饶恕过 → 名字变黄\nBattle_SetEnemySpareable(0, true);",
         "hot": true
      },
      {
         "c": "enemy",
         "n": "Battle_IsEnemyValid",
         "s": "Battle_IsEnemyValid(enemy_obj/inst)",
         "d": "判断传入的敌人物体名或实例是否有效。比 IsEnemySlotValid 更底层，接受对象而非槽位号。",
         "p": [
            [
               "enemy_obj/inst",
               "object/instance",
               "敌人物体名或已存在的实例"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_IsFleeable",
         "s": "Battle_IsFleeable()",
         "d": "查询本场战斗能否逃跑。MERCY 的逃跑项会读它。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_IsMenuChoiceMercyOverride",
         "s": "Battle_IsMenuChoiceMercyOverride()",
         "d": "查询 MERCY 菜单是否处于「覆盖模式」。覆盖模式下选项不用默认那套，而是显示你自定义的名字。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_IsMenuMercyFleeEnabled",
         "s": "Battle_IsMenuMercyFleeEnabled()",
         "d": "查询 MERCY 菜单里的「逃跑」这一项是否显示。与 IsFleeable 的区别：这个控制**菜单是否列出**，那个控制**能否真的跑掉**。",
         "p": []
      },
      {
         "c": "soul",
         "n": "Battle_IsSoulValid",
         "s": "Battle_IsSoulValid(soul_obj/inst)",
         "d": "判断灵魂实例是否有效。切换灵魂、灵魂被销毁或战斗结束时灵魂会失效，操作前先检查一下。",
         "p": [
            [
               "soul_obj/inst",
               "object/instance",
               "灵魂物体名或实例"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_IsTurnPreparationAutoEnd",
         "s": "Battle_IsTurnPreparationAutoEnd()",
         "d": "查询「回合准备阶段是否自动结束」。为 true 时引擎在准备完成后自动进入敌人回合。",
         "p": []
      },
      {
         "c": "battlecore",
         "n": "Battle_IsTurnValid",
         "s": "Battle_IsTurnValid(turn_obj/inst)",
         "d": "判断当前回合是否有效（战斗已开始且未结束）。操作回合数据前先检查一下。",
         "p": [
            [
               "turn_obj/inst",
               "object/instance",
               "回合控制器实例"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBone",
         "s": "Battle_MakeBone(x, y, length, hspeed, vspeed, type, out, angle, rotate, auto_destroy, duration, follow, follow_board, follow_target, follow_angle, point, point_at, follow_x, follow_y)",
         "d": "最底层的骨骼生成函数，其余 MakeBone* 都调用它。返回 bone 实例。",
         "p": [
            [
               "x",
               "number",
               "相对框中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对框中心的 Y 坐标"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "hspeed",
               "number",
               "横向速度"
            ],
            [
               "vspeed",
               "number",
               "纵向速度"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出框边界后仍保持活动"
            ],
            [
               "angle",
               "number",
               "朝向角度（度）"
            ],
            [
               "rotate",
               "number",
               "自转速度（度/帧）"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出框后自动销毁"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "follow",
               "object/instance",
               "要跟随的目标，noone = 不跟随"
            ],
            [
               "follow_board",
               "0/1",
               "1 = 跟随战斗框移动"
            ],
            [
               "follow_target",
               "bool",
               "是否跟随目标旋转"
            ],
            [
               "follow_angle",
               "number",
               "跟随角度偏移"
            ],
            [
               "point",
               "bool",
               "是否沿指定点运动"
            ],
            [
               "point_at",
               "number",
               "指向的目标角度"
            ],
            [
               "follow_x",
               "number",
               "跟随目标时使用的 X"
            ],
            [
               "follow_y",
               "number",
               "跟随目标时使用的 Y"
            ]
         ],
         "ex": "// 从屏幕下方升起一根骨头\nBattle_MakeBone(320, 520, 80, 0, -3, 0, 1, 90, 0, 1);\n\n// 一根缓慢旋转的长骨\nBattle_MakeBone(320, 240, 160, 0, 0, 0, 0, 0, 2, 1, 120);",
         "hot": true
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBone3D",
         "s": "Battle_MakeBone3D(x, y, angle_x, angle_y, angle_z, rotate_x, rotate_y, rotate_z, scale_x, scale_y, scale_z, vspeed, hspeed, shape, type, out, [duration], [gap])",
         "d": "生成 3D 骨头（伪 3D，用 shader 绘制）。做立体运镜的骨头，比如 Papyrus 的立体骨阵。",
         "p": [
            [
               "x",
               "number",
               "相对面板中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对面板中心的 Y 坐标"
            ],
            [
               "angle_x",
               "number",
               "X 轴旋转角"
            ],
            [
               "angle_y",
               "number",
               "Y 轴旋转角"
            ],
            [
               "angle_z",
               "number",
               "Z 轴旋转角"
            ],
            [
               "rotate_x",
               "number",
               "X 轴自转速度"
            ],
            [
               "rotate_y",
               "number",
               "Y 轴自转速度"
            ],
            [
               "rotate_z",
               "number",
               "Z 轴自转速度"
            ],
            [
               "scale_x",
               "number",
               "横向缩放"
            ],
            [
               "scale_y",
               "number",
               "纵向缩放"
            ],
            [
               "scale_z",
               "number",
               "纵深缩放"
            ],
            [
               "vspeed",
               "number",
               "纵向速度"
            ],
            [
               "hspeed",
               "number",
               "横向速度"
            ],
            [
               "shape",
               "number",
               "3D 骨的形状编号"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出面板边界后仍保持活动"
            ],
            [
               "duration",
               "number（可选）",
               "存活帧数，-1 = 永久"
            ],
            [
               "gap",
               "number（可选）",
               "两根骨头之间的间隙"
            ]
         ],
         "hot": true
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneArrow",
         "s": "Battle_MakeBoneArrow(x, y, length, hspeed, vspeed, type, out, angle, rotate, auto_destroy, [duration], [scale], [extra_angle], [follow], [follow_board], [follow_angle], [point], [point_at], [follow_x], [follow_y])",
         "d": "生成箭头骨。带 scale 缩放、extra_angle 张开角、range 射程三个专属参数。",
         "p": [
            [
               "x",
               "number",
               "相对框中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对框中心的 Y 坐标"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "hspeed",
               "number",
               "横向速度"
            ],
            [
               "vspeed",
               "number",
               "纵向速度"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出框边界后仍保持活动"
            ],
            [
               "angle",
               "number",
               "朝向角度（度）"
            ],
            [
               "rotate",
               "number",
               "自转速度（度/帧）"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出框后自动销毁"
            ],
            [
               "duration",
               "number（可选）",
               "存活帧数，-1 = 永久"
            ],
            [
               "scale",
               "number（可选）",
               "缩放倍数"
            ],
            [
               "extra_angle",
               "number（可选）",
               "额外角度偏移"
            ],
            [
               "follow",
               "object/instance（可选）",
               "要跟随的目标，noone = 不跟随"
            ],
            [
               "follow_board",
               "0/1（可选）",
               "1 = 跟随战斗框移动"
            ],
            [
               "follow_angle",
               "number（可选）",
               "跟随角度偏移"
            ],
            [
               "point",
               "bool（可选）",
               "是否沿指定点运动"
            ],
            [
               "point_at",
               "number（可选）",
               "指向的目标角度"
            ],
            [
               "follow_x",
               "number（可选）",
               "跟随目标时使用的 X"
            ],
            [
               "follow_y",
               "number（可选）",
               "跟随目标时使用的 Y"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneBottom",
         "s": "Battle_MakeBoneBottom(x, length, hspeed, type, out, rotate, auto_destroy, [duration], [follow], [follow_board], [follow_target], [follow_angle], [point], [point_at], [follow_x], [follow_y])",
         "d": "从框【下边缘】生成骨头，自动对齐框。参数是 MakeBone 的子集（去掉 y 和 vspeed）。",
         "p": [
            [
               "x",
               "number",
               "相对框中心的 X 坐标"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "hspeed",
               "number",
               "横向速度"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出框边界后仍保持活动"
            ],
            [
               "rotate",
               "number",
               "自转速度（度/帧）"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出框后自动销毁"
            ],
            [
               "duration",
               "number（可选）",
               "存活帧数，-1 = 永久"
            ],
            [
               "follow",
               "object/instance（可选）",
               "要跟随的目标，noone = 不跟随"
            ],
            [
               "follow_board",
               "0/1（可选）",
               "1 = 跟随战斗框移动"
            ],
            [
               "follow_target",
               "bool（可选）",
               "是否跟随目标旋转"
            ],
            [
               "follow_angle",
               "number（可选）",
               "跟随角度偏移"
            ],
            [
               "point",
               "bool（可选）",
               "是否沿指定点运动"
            ],
            [
               "point_at",
               "number（可选）",
               "指向的目标角度"
            ],
            [
               "follow_x",
               "number（可选）",
               "跟随目标时使用的 X"
            ],
            [
               "follow_y",
               "number（可选）",
               "跟随目标时使用的 Y"
            ]
         ],
         "ex": "// 从框底部冒出 3 根骨头\nrepeat (3) {\n    var xx = 120 + 160 * (3 - 1 - (irandom(2)));  // 随机位置\n    Battle_MakeBoneBottom(xx, 60, 0, 0, 1, 0, 1, 90);\n}",
         "hot": true
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneLeft",
         "s": "Battle_MakeBoneLeft(y, length, vspeed, type, out, rotate, auto_destroy, [duration], [follow], [follow_board], [follow_target], [follow_angle], [point], [point_at], [follow_x], [follow_y])",
         "d": "从框【左边缘】生成骨头，自动对齐框。参数是 MakeBone 的子集。",
         "p": [
            [
               "y",
               "number",
               "相对框中心的 Y 坐标"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "vspeed",
               "number",
               "纵向速度"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出框边界后仍保持活动"
            ],
            [
               "rotate",
               "number",
               "自转速度（度/帧）"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出框后自动销毁"
            ],
            [
               "duration",
               "number（可选）",
               "存活帧数，-1 = 永久"
            ],
            [
               "follow",
               "object/instance（可选）",
               "要跟随的目标，noone = 不跟随"
            ],
            [
               "follow_board",
               "0/1（可选）",
               "1 = 跟随战斗框移动"
            ],
            [
               "follow_target",
               "bool（可选）",
               "是否跟随目标旋转"
            ],
            [
               "follow_angle",
               "number（可选）",
               "跟随角度偏移"
            ],
            [
               "point",
               "bool（可选）",
               "是否沿指定点运动"
            ],
            [
               "point_at",
               "number（可选）",
               "指向的目标角度"
            ],
            [
               "follow_x",
               "number（可选）",
               "跟随目标时使用的 X"
            ],
            [
               "follow_y",
               "number（可选）",
               "跟随目标时使用的 Y"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneRight",
         "s": "Battle_MakeBoneRight(y, length, vspeed, type, out, rotate, auto_destroy, [duration], [follow], [follow_board], [follow_target], [follow_angle], [point], [point_at], [follow_x], [follow_y])",
         "d": "从框【右边缘】生成骨头，自动对齐框。参数是 MakeBone 的子集。",
         "p": [
            [
               "y",
               "number",
               "相对框中心的 Y 坐标"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "vspeed",
               "number",
               "纵向速度"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出框边界后仍保持活动"
            ],
            [
               "rotate",
               "number",
               "自转速度（度/帧）"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出框后自动销毁"
            ],
            [
               "duration",
               "number（可选）",
               "存活帧数，-1 = 永久"
            ],
            [
               "follow",
               "object/instance（可选）",
               "要跟随的目标，noone = 不跟随"
            ],
            [
               "follow_board",
               "0/1（可选）",
               "1 = 跟随战斗框移动"
            ],
            [
               "follow_target",
               "bool（可选）",
               "是否跟随目标旋转"
            ],
            [
               "follow_angle",
               "number（可选）",
               "跟随角度偏移"
            ],
            [
               "point",
               "bool（可选）",
               "是否沿指定点运动"
            ],
            [
               "point_at",
               "number（可选）",
               "指向的目标角度"
            ],
            [
               "follow_x",
               "number（可选）",
               "跟随目标时使用的 X"
            ],
            [
               "follow_y",
               "number（可选）",
               "跟随目标时使用的 Y"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneTop",
         "s": "Battle_MakeBoneTop(x, length, hspeed, type, out, rotate, auto_destroy, [duration], [follow], [follow_board], [follow_target], [follow_angle], [point], [point_at], [follow_x], [follow_y])",
         "d": "从框【上边缘】生成骨头，自动对齐框。参数是 MakeBone 的子集。",
         "p": [
            [
               "x",
               "number",
               "相对框中心的 X 坐标"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "hspeed",
               "number",
               "横向速度"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出框边界后仍保持活动"
            ],
            [
               "rotate",
               "number",
               "自转速度（度/帧）"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出框后自动销毁"
            ],
            [
               "duration",
               "number（可选）",
               "存活帧数，-1 = 永久"
            ],
            [
               "follow",
               "object/instance（可选）",
               "要跟随的目标，noone = 不跟随"
            ],
            [
               "follow_board",
               "0/1（可选）",
               "1 = 跟随战斗框移动"
            ],
            [
               "follow_target",
               "bool（可选）",
               "是否跟随目标旋转"
            ],
            [
               "follow_angle",
               "number（可选）",
               "跟随角度偏移"
            ],
            [
               "point",
               "bool（可选）",
               "是否沿指定点运动"
            ],
            [
               "point_at",
               "number（可选）",
               "指向的目标角度"
            ],
            [
               "follow_x",
               "number（可选）",
               "跟随目标时使用的 X"
            ],
            [
               "follow_y",
               "number（可选）",
               "跟随目标时使用的 Y"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneTwoH",
         "s": "Battle_MakeBoneTwoH(x, y, vspeed, type, out, rotate, gap, auto_destroy, [duration], [follow], [follow_board], [follow_target], [follow_angle], [point], [point_at], [follow_x], [follow_y])",
         "d": "在指定 x 处同时生成左右两根「水平骨墙」，中间留 gap 缺口让玩家钻过。返回数组 [boneLeft, boneRight]。",
         "p": [
            [
               "x",
               "number",
               "相对框中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对框中心的 Y 坐标"
            ],
            [
               "vspeed",
               "number",
               "纵向速度"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出框边界后仍保持活动"
            ],
            [
               "rotate",
               "number",
               "自转速度（度/帧）"
            ],
            [
               "gap",
               "number",
               "两根骨头之间的间隙"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出框后自动销毁"
            ],
            [
               "duration",
               "number（可选）",
               "存活帧数，-1 = 永久"
            ],
            [
               "follow",
               "object/instance（可选）",
               "要跟随的目标，noone = 不跟随"
            ],
            [
               "follow_board",
               "0/1（可选）",
               "1 = 跟随战斗框移动"
            ],
            [
               "follow_target",
               "bool（可选）",
               "是否跟随目标旋转"
            ],
            [
               "follow_angle",
               "number（可选）",
               "跟随角度偏移"
            ],
            [
               "point",
               "bool（可选）",
               "是否沿指定点运动"
            ],
            [
               "point_at",
               "number（可选）",
               "指向的目标角度"
            ],
            [
               "follow_x",
               "number（可选）",
               "跟随目标时使用的 X"
            ],
            [
               "follow_y",
               "number（可选）",
               "跟随目标时使用的 Y"
            ]
         ],
         "ex": "// 经典骨墙：中间留 80px 缺口\nBattle_MakeBoneTwoH(320, 240, -4, 0, 1, 0, 80, 0);",
         "hot": true
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneTwoV",
         "s": "Battle_MakeBoneTwoV(x, y, hspeed, type, out, rotate, gap, auto_destroy, [duration], [follow], [follow_board], [follow_target], [follow_angle], [point], [point_at], [follow_x], [follow_y])",
         "d": "在指定 y 处同时生成上下两根「垂直骨墙」，中间留 gap 缺口让玩家钻过。返回数组 [boneUp, boneDown]。",
         "p": [
            [
               "x",
               "number",
               "相对框中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对框中心的 Y 坐标"
            ],
            [
               "hspeed",
               "number",
               "横向速度"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出框边界后仍保持活动"
            ],
            [
               "rotate",
               "number",
               "自转速度（度/帧）"
            ],
            [
               "gap",
               "number",
               "两根骨头之间的间隙"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出框后自动销毁"
            ],
            [
               "duration",
               "number（可选）",
               "存活帧数，-1 = 永久"
            ],
            [
               "follow",
               "object/instance（可选）",
               "要跟随的目标，noone = 不跟随"
            ],
            [
               "follow_board",
               "0/1（可选）",
               "1 = 跟随战斗框移动"
            ],
            [
               "follow_target",
               "bool（可选）",
               "是否跟随目标旋转"
            ],
            [
               "follow_angle",
               "number（可选）",
               "跟随角度偏移"
            ],
            [
               "point",
               "bool（可选）",
               "是否沿指定点运动"
            ],
            [
               "point_at",
               "number（可选）",
               "指向的目标角度"
            ],
            [
               "follow_x",
               "number（可选）",
               "跟随目标时使用的 X"
            ],
            [
               "follow_y",
               "number（可选）",
               "跟随目标时使用的 Y"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneWallBottom",
         "s": "Battle_MakeBoneWallBottom(pause, length, duration, type, follow_board)",
         "d": "从框**下边**生成一整面横向骨墙。骨头整齐排列并长出来，是「封底」型攻击的常用做法。",
         "p": [
            [
               "pause",
               "number",
               "起始停顿帧数（物体先不出现，延迟这么久再动）"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "follow_board",
               "0/1",
               "1 = 跟随战斗框移动"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneWallLeft",
         "s": "Battle_MakeBoneWallLeft(pause, length, duration, type, follow_board)",
         "d": "从框**左边**生成一整面纵向骨墙，从侧面推进压缩空间。",
         "p": [
            [
               "pause",
               "number",
               "起始停顿帧数（物体先不出现，延迟这么久再动）"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "follow_board",
               "0/1",
               "1 = 跟随战斗框移动"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneWallRight",
         "s": "Battle_MakeBoneWallRight(pause, length, duration, type, follow_board)",
         "d": "从框**右边**生成一整面纵向骨墙。与左右侧墙配合可做夹击。",
         "p": [
            [
               "pause",
               "number",
               "起始停顿帧数（物体先不出现，延迟这么久再动）"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "follow_board",
               "0/1",
               "1 = 跟随战斗框移动"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneWallRound",
         "s": "Battle_MakeBoneWallRound(rotatespeed, radius, type, pause, duration)",
         "d": "生成一圈环绕推进的骨头墙，从四周同时向内收缩。",
         "p": [
            [
               "rotatespeed",
               "number",
               "旋转速度（度/帧）"
            ],
            [
               "radius",
               "number",
               "半径"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "pause",
               "number",
               "起始停顿帧数（物体先不出现，延迟这么久再动）"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ]
         ]
      },
      {
         "c": "bullet",
         "n": "Battle_MakeBoneWallTop",
         "s": "Battle_MakeBoneWallTop(pause, length, duration, type, follow_board)",
         "d": "从框**上边**生成一整面横向骨墙，自上而下截断玩家的活动空间。",
         "p": [
            [
               "pause",
               "number",
               "起始停顿帧数（物体先不出现，延迟这么久再动）"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "follow_board",
               "0/1",
               "1 = 跟随战斗框移动"
            ]
         ],
         "ex": "// 从顶部不断落下骨头墙\nBattle_MakeBoneWallTop(20, 40, 90, 0, 1);\n\n// 两侧夹击\nBattle_MakeBoneWallLeft(15, 50, 60);\nBattle_MakeBoneWallRight(15, 50, 60);",
         "hot": true
      },
      {
         "c": "bullet",
         "n": "Battle_MakeGB",
         "s": "Battle_MakeGB(x, y, x_target, y_target, angle_start, angle_target, scale_x, scale_y, type, pause, duration, time_move)",
         "d": "生成加斯特冲击波（Gaster Blaster）。返回 blaster 实例。",
         "p": [
            [
               "x",
               "number",
               "相对面板中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对面板中心的 Y 坐标"
            ],
            [
               "x_target",
               "number",
               "目标 X"
            ],
            [
               "y_target",
               "number",
               "目标 Y"
            ],
            [
               "angle_start",
               "number",
               "起始角度"
            ],
            [
               "angle_target",
               "number",
               "目标角度"
            ],
            [
               "scale_x",
               "number",
               "横向缩放"
            ],
            [
               "scale_y",
               "number",
               "纵向缩放"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "pause",
               "number",
               "起始停顿帧数（物体先不出现，延迟这么久再动）"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "time_move",
               "number",
               "转位移动的帧数"
            ]
         ],
         "ex": "// 从左上角射向玩家\nBattle_MakeGB(80, 60, battle_soul.x, battle_soul.y,\n              0, point_direction(80, 60, battle_soul.x, battle_soul.y),\n              1, 1, 0);",
         "hot": true
      },
      {
         "c": "bullet",
         "n": "Battle_MakePlatform",
         "s": "Battle_MakePlatform(x, y, width, angle, hspeed, vspeed, sticky, bounce, duration, auto_destroy)",
         "d": "生成一块平台（蓝魂跳跃关卡用）。返回平台实例。",
         "p": [
            [
               "x",
               "number",
               "相对面板中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对面板中心的 Y 坐标"
            ],
            [
               "width",
               "number",
               "宽度"
            ],
            [
               "angle",
               "number",
               "朝向角度（度）"
            ],
            [
               "hspeed",
               "number",
               "横向速度"
            ],
            [
               "vspeed",
               "number",
               "纵向速度"
            ],
            [
               "sticky",
               "bool",
               "true = 贴住表面不弹开"
            ],
            [
               "bounce",
               "number",
               "弹性系数"
            ],
            [
               "duration",
               "number",
               "存活帧数，-1 = 永久"
            ],
            [
               "auto_destroy",
               "0/1",
               "1 = 飞出面板后自动销毁"
            ]
         ],
         "ex": "// 一块会移动的粘性平台\nBattle_MakePlatform(240, 360, 64, 0, 1.5, 0, 1, 0, -1, 1);",
         "hot": true
      },
      {
         "c": "enemy",
         "n": "Battle_RemoveEnemy",
         "s": "Battle_RemoveEnemy(enemy_slot)",
         "d": "把敌人从指定槽位移除并销毁其实例。用于「敌人中途逃跑」或「召唤物消失」。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_RewardExp",
         "s": "Battle_RewardExp(reward_exp)",
         "d": "给本场战斗的胜利奖励追加经验值。注意是累加而非覆盖，反复调用会把 EXP 越加越多。",
         "p": [
            [
               "reward_exp",
               "number",
               "战斗胜利后给予的经验值"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_RewardGold",
         "s": "Battle_RewardGold(reward_gold)",
         "d": "给本场战斗的胜利奖励追加金币。注意是累加而非覆盖，反复调用会把结算金币越加越多。",
         "p": [
            [
               "reward_gold",
               "number",
               "战斗胜利后给予的金币数"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetBoardSize",
         "s": "Battle_SetBoardSize(up, down, left, right, [time])",
         "d": "直接改框四边尺寸。time 省略时默认 25 帧补间；time = 0 立即生效。做战斗中框突变（如骨墙收缩）时很方便。",
         "p": [
            [
               "up",
               "number",
               "框中心到上边的距离"
            ],
            [
               "down",
               "number",
               "框中心到下边的距离"
            ],
            [
               "left",
               "number",
               "框中心到左边的距离"
            ],
            [
               "right",
               "number",
               "框中心到右边的距离"
            ],
            [
               "time",
               "number（可选）",
               "时间（帧）。-1 或负数常表示「立即」"
            ]
         ],
         "ex": "Battle_SetBoardSize(90, 90, 180, 180, 30);  // 30帧内变成大框\nBattle_SetBoardSize(65, 65, 283, 283, 0);   // 瞬间还原"
      },
      {
         "c": "battlecore",
         "n": "Battle_SetDialog",
         "s": "Battle_SetDialog([text], [choice], [line2])",
         "d": "设置战斗中的打字机对话框。text 传空字符串则清除。choice = true 时文字变大居中（用于选项）。line2 = true 使用第二行文本框。",
         "p": [
            [
               "text",
               "string（可选）",
               "文本内容（支持 {color} 等格式标签）"
            ],
            [
               "choice",
               "bool（可选）",
               "true = 这行作为「选项列表」渲染（居中、高亮当前项）"
            ],
            [
               "line2",
               "bool（可选）",
               "true = 使用右侧第二栏（长选项列表用）"
            ]
         ],
         "ex": "Battle_SetDialog(\"* You're gonna have a bad time.\");\nBattle_SetDialog();  // 清除",
         "hot": true
      },
      {
         "c": "battlecore",
         "n": "Battle_SetDialogAutoEnd",
         "s": "Battle_SetDialogAutoEnd(enabled)",
         "d": "开关对话自动结束。适合做不可交互的旁白段。",
         "p": [
            [
               "enabled",
               "bool",
               "true 开启 / false 关闭"
            ]
         ]
      },
      {
         "c": "enemy",
         "n": "Battle_SetEnemy",
         "s": "Battle_SetEnemy(enemy_obj/inst, enemy_slot)",
         "d": "把一个敌人放进指定槽位（0~2）。传物体名会自动创建实例；传已存在的实例则直接接管。同时会触发敌人的 INIT 事件。",
         "p": [
            [
               "enemy_obj/inst",
               "object/instance",
               "敌人物体名或已存在的实例"
            ],
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ],
         "ex": "Battle_SetEnemy(obj_sans, 0);   // Sans 站中间\nBattle_SetEnemy(obj_papyrus, 1);",
         "hot": true
      },
      {
         "c": "enemy",
         "n": "Battle_SetEnemyActionName",
         "s": "Battle_SetEnemyActionName(enemy_slot, action_slot, text)",
         "d": "给敌人的某个行动命名。名字可用于界面显示，也方便自己写行动表时索引。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ],
            [
               "action_slot",
               "number",
               "第几个 ACT 选项（从 0 开始）"
            ],
            [
               "text",
               "string",
               "文本内容（支持 {color} 等格式标签）"
            ]
         ],
         "ex": "Battle_SetEnemyActionName(0, 0, \"Check\");\nBattle_SetEnemyActionName(0, 1, \"Joke\");\nBattle_SetEnemyActionName(0, 2, \"Plead\");",
         "hot": true
      },
      {
         "c": "enemy",
         "n": "Battle_SetEnemyActionNumber",
         "s": "Battle_SetEnemyActionNumber(enemy_slot, action_number)",
         "d": "设置敌人的行动序号。一般由引擎在行动切换时自行维护。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ],
            [
               "action_number",
               "number",
               "ACT 选项总数"
            ]
         ],
         "ex": "Battle_SetEnemyActionNumber(0, 3);  // Sans 有3个可调查行动",
         "hot": true
      },
      {
         "c": "enemy",
         "n": "Battle_SetEnemyCenterPos",
         "s": "Battle_SetEnemyCenterPos(enemy_slot, x, y)",
         "d": "设置敌人立绘的中心位置。默认会按槽位自动排布，只有特殊构图才需要手动改。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ],
            [
               "x",
               "number",
               "相对面板中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对面板中心的 Y 坐标"
            ]
         ]
      },
      {
         "c": "enemy",
         "n": "Battle_SetEnemyDEF",
         "s": "Battle_SetEnemyDEF(enemy_slot, def)",
         "d": "设置敌人的防御力。防御力越高，玩家这一刀造成的伤害越低。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ],
            [
               "def",
               "number",
               "敌人防御力，参与伤害计算"
            ]
         ]
      },
      {
         "c": "enemy",
         "n": "Battle_SetEnemyName",
         "s": "Battle_SetEnemyName(enemy_slot, name)",
         "d": "设置敌人的显示名。这个名字会出现在血条与菜单上。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ],
            [
               "name",
               "string",
               "要设置的名字（显示在 ACT / FIGHT 目标列表里）"
            ]
         ],
         "ex": "Battle_SetEnemyName(0, \"Sans\");\nBattle_SetEnemyName(1, \"Papyrus\");",
         "hot": true
      },
      {
         "c": "enemy",
         "n": "Battle_SetEnemySpareable",
         "s": "Battle_SetEnemySpareable(enemy_slot, spareable)",
         "d": "设置敌人是否可被饶恕。当玩家满足了饶恕条件（比如反复 ACT）时置 true。",
         "p": [
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ],
            [
               "spareable",
               "bool",
               "true = 该敌人可被饶恕（菜单里名字变黄）"
            ]
         ],
         "ex": "// 玩家已经饶恕过 → 名字变黄\nBattle_SetEnemySpareable(0, true);",
         "hot": true
      },
      {
         "c": "battlecore",
         "n": "Battle_SetFleeable",
         "s": "Battle_SetFleeable(fleeable)",
         "d": "设置本场战斗能否逃跑。剧情战一般置 false。",
         "p": [
            [
               "fleeable",
               "bool",
               "true = 本场战斗可以逃跑"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenu",
         "s": "Battle_SetMenu(menu, [call_event])",
         "d": "设置当前菜单子状态，传入 BATTLE_MENU 枚举值（BUTTON / ACT_TARGET / ITEM 等），用来跳转到指定菜单页。",
         "p": [
            [
               "menu",
               "BATTLE_MENU",
               "要切换到的主菜单页面"
            ],
            [
               "call_event",
               "bool（可选）",
               "是否同时触发敌人的 MENU_SWITCH 事件，默认 true"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuChoiceAction",
         "s": "Battle_SetMenuChoiceAction(action_choice, [call_event])",
         "d": "设置 ACT 菜单的选中项并可选触发选择事件。call_event 传 true 会立刻跑一次回调。",
         "p": [
            [
               "action_choice",
               "number",
               "选中的 ACT 选项序号"
            ],
            [
               "call_event",
               "bool（可选）",
               "是否同时触发敌人的 MENU_SWITCH 事件，默认 true"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuChoiceButton",
         "s": "Battle_SetMenuChoiceButton(button_choice, [call_event])",
         "d": "设置主菜单（FIGHT / ACT / ITEM / MERCY）当前选中的按钮，常用于从代码里强制移动光标。",
         "p": [
            [
               "button_choice",
               "number",
               "选中的按钮序号（0~3 = FIGHT/ACT/ITEM/MERCY）"
            ],
            [
               "call_event",
               "bool（可选）",
               "是否同时触发敌人的 MENU_SWITCH 事件，默认 true"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuChoiceEnemy",
         "s": "Battle_SetMenuChoiceEnemy(enemy_choice, [call_event])",
         "d": "设置当前选中的目标敌人，用于从代码里强制切换攻击目标。",
         "p": [
            [
               "enemy_choice",
               "number",
               "选中的敌人序号（对应敌人列表位置）"
            ],
            [
               "call_event",
               "bool（可选）",
               "是否同时触发敌人的 MENU_SWITCH 事件，默认 true"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuChoiceItem",
         "s": "Battle_SetMenuChoiceItem(slot, call)",
         "d": "设置 ITEM 菜单选中的物品槽位并可触发选择事件。",
         "p": [
            [
               "slot",
               "number",
               "槽位编号"
            ],
            [
               "call",
               "bool",
               "是否立刻触发一次回调"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuChoiceMercy",
         "s": "Battle_SetMenuChoiceMercy(mercy_choice, [call_event])",
         "d": "设置 MERCY 菜单的选中项并可触发选择事件。",
         "p": [
            [
               "mercy_choice",
               "number",
               "选中的 MERCY 选项序号"
            ],
            [
               "call_event",
               "bool（可选）",
               "是否同时触发敌人的 MENU_SWITCH 事件，默认 true"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuChoiceMercyOverride",
         "s": "Battle_SetMenuChoiceMercyOverride(override)",
         "d": "把 MERCY 菜单里的「Spare」（黄字）替换成自定义文字，例如 Sans 战的「Spare」。number 取值范围 1~3，slot 取值范围 0~2。",
         "p": [
            [
               "override",
               "bool",
               "true = 用自定义 MERCY 选项替换默认的 Spare/Flee"
            ]
         ],
         "ex": "Battle_SetMenuChoiceMercyOverride(true);\nBattle_SetMenuChoiceMercyOverrideNumber(1);            // 覆盖 1 项\nBattle_SetMenuChoiceMercyOverrideName(0, \"Spare\");     // 第0项显示为 Spare",
         "hot": true
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuChoiceMercyOverrideName",
         "s": "Battle_SetMenuChoiceMercyOverrideName(choice_mercy_slot, name)",
         "d": "设置 MERCY 覆盖模式下某个槽位的名字，用来做剧情专属的 MERCY 选项（如「SAVE」「饶恕 Flowey」）。",
         "p": [
            [
               "choice_mercy_slot",
               "number",
               "自定义 MERCY 选项的序号"
            ],
            [
               "name",
               "string",
               "要设置的名字（显示在 ACT / FIGHT 目标列表里）"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuChoiceMercyOverrideNumber",
         "s": "Battle_SetMenuChoiceMercyOverrideNumber(number)",
         "d": "设置 MERCY 覆盖模式下的选项数量。",
         "p": [
            [
               "number",
               "number",
               "数量，默认 10"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuDialog",
         "s": "Battle_SetMenuDialog(text)",
         "d": "改菜单下方的敌人台词（战斗中动态变台词，比如嘲讽递增）。",
         "p": [
            [
               "text",
               "string",
               "文本内容（支持 {color} 等格式标签）"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuFightAnimTime",
         "s": "Battle_SetMenuFightAnimTime(time)",
         "d": "设置 FIGHT 挥刀动画的帧数，用来加快或放慢攻击节奏。",
         "p": [
            [
               "time",
               "number",
               "时间（帧）。-1 或负数常表示「立即」"
            ]
         ],
         "ex": "// 用自制刀光动画替换默认攻击面板\nPlayer_SetBattleFightMenuObj(obj_my_knife_anim);"
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuFightDamage",
         "s": "Battle_SetMenuFightDamage(damage)",
         "d": "设置 FIGHT 攻击的伤害倍数。调高会让这一刀更疼。",
         "p": [
            [
               "damage",
               "number",
               "伤害数值"
            ]
         ],
         "ex": "// 用自制刀光动画替换默认攻击面板\nPlayer_SetBattleFightMenuObj(obj_my_knife_anim);"
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuFightDamageTime",
         "s": "Battle_SetMenuFightDamageTime(time)",
         "d": "设置伤害数字停留的帧数。只有在 FIGHT 的瞄准、挥刀、伤害三个阶段之一才会生效，其他状态直接返回 false。",
         "p": [
            [
               "time",
               "number",
               "时间（帧）。-1 或负数常表示「立即」"
            ]
         ],
         "ex": "// 用自制刀光动画替换默认攻击面板\nPlayer_SetBattleFightMenuObj(obj_my_knife_anim);"
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuFightPanel",
         "s": "Battle_SetMenuFightPanel(Object)",
         "d": "指定 FIGHT 攻击条要用的界面实例，换掉默认的攻击条外观。",
         "p": [
            [
               "obj",
               "object",
               "要使用的 FIGHT 面板物体（不填则用默认 knife）"
            ]
         ],
         "ex": "// 用自制刀光动画替换默认攻击面板\nPlayer_SetBattleFightMenuObj(obj_my_knife_anim);"
      },
      {
         "c": "battlecore",
         "n": "Battle_SetMenuMercyFleeEnabled",
         "s": "Battle_SetMenuMercyFleeEnabled(flee_enabled)",
         "d": "开关 MERCY 菜单中「逃跑」项的显示。",
         "p": [
            [
               "flee_enabled",
               "bool",
               "true = MERCY 里显示并允许「Flee」"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetNextState",
         "s": "Battle_SetNextState(next_state)",
         "d": "预设状态机的下一个状态。当前状态结束时引擎会跳到它，用来编排非线性的流程。",
         "p": [
            [
               "next_state",
               "BATTLE_STATE",
               "要写入的「下一状态」"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetPlayerTempAtk",
         "s": "Battle_SetPlayerTempAtk(atk)",
         "d": "设置本回合临时攻击加成。适合做「本回合攻击力提升」这类 BUFF。",
         "p": [
            [
               "atk",
               "number",
               "攻击力临时增减值"
            ]
         ],
         "ex": "// 本回合内玩家防御 +10\nBattle_SetPlayerTempDef(Battle_GetPlayerTempDef() + 10);",
         "hot": true
      },
      {
         "c": "battlecore",
         "n": "Battle_SetPlayerTempDef",
         "s": "Battle_SetPlayerTempDef(def)",
         "d": "设置本回合的临时防御加成，回合结束后自动失效。",
         "p": [
            [
               "def",
               "number",
               "敌人防御力，参与伤害计算"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetPlayerTempInv",
         "s": "Battle_SetPlayerTempInv(inv)",
         "d": "设置本回合的临时无敌帧加成，回合结束后自动失效。",
         "p": [
            [
               "inv",
               "number",
               "无敌帧数量（受伤后的免伤时间）"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetPlayerTempSpd",
         "s": "Battle_SetPlayerTempSpd(spd)",
         "d": "设置本回合的临时速度加成，回合结束后自动失效。",
         "p": [
            [
               "spd",
               "number",
               "速度临时增减值"
            ]
         ]
      },
      {
         "c": "soul",
         "n": "Battle_SetSoul",
         "s": "Battle_SetSoul(SOUL)",
         "d": "切换灵魂模式。会自动销毁旧灵魂、创建新灵魂，并承接位置与角度。",
         "p": [
            [
               "SOUL",
               "object",
               "要切换成的灵魂物件，如 battle_soul_red"
            ]
         ],
         "ex": "// 切蓝魂打跳跃关\nBattle_SetSoul(battle_soul_blue);\n\n// 打完切回红魂\nBattle_SetSoul(battle_soul_red);",
         "hot": true
      },
      {
         "c": "battlecore",
         "n": "Battle_SetState",
         "s": "Battle_SetState(state)",
         "d": "设置战斗主状态，传入 BATTLE_STATE 枚举值。会立即生效，跳过正常的流程过渡。",
         "p": [
            [
               "state",
               "BATTLE_STATE",
               "目标战斗状态"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetTurnInfo",
         "s": "Battle_SetTurnInfo(info, value)",
         "d": "写入回合信息。你控制框变形、回合时长、灵魂位置的核心手段 —— 在敌人 TURN_PREPARATION_START 事件里调用。",
         "p": [
            [
               "info",
               "FLAG_INFO_*",
               "信息键名，用 Info 系列宏"
            ],
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ],
         "ex": "// 敌人在回合准备阶段设置本回合参数\n// event_user(BATTLE_ENEMY_EVENT.TURN_PREPARATION_START) 内：\n\nBattle_SetTurnInfo(BATTLE_TURN.TIME, 60 * 8);        // 本回合 8 秒\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_X, 320);        // 框移到画面中央\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_Y, 240);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_UP, 100);       // 框变成大方块\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_DOWN, 100);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_LEFT, 200);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_RIGHT, 200);\nBattle_SetTurnInfo(BATTLE_TURN.SOUL_X, 0);           // 灵魂放中间\nBattle_SetTurnInfo(BATTLE_TURN.SOUL_Y, 0);",
         "hot": true
      },
      {
         "c": "battlecore",
         "n": "Battle_SetTurnNumber",
         "s": "Battle_SetTurnNumber(turn_number)",
         "d": "设置当前回合数。跳回合或做特殊编排时会用到。",
         "p": [
            [
               "turn_number",
               "number",
               "回合数（从 1 开始）"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetTurnPreparationAutoEnd",
         "s": "Battle_SetTurnPreparationAutoEnd(enabled)",
         "d": "设置回合准备阶段是否自动结束。true 时引擎在准备完成后自动开打，false 则需要手动结束。",
         "p": [
            [
               "enabled",
               "bool",
               "true 开启 / false 关闭"
            ]
         ]
      },
      {
         "c": "battlecore",
         "n": "Battle_SetTurnTime",
         "s": "Battle_SetTurnTime(time)",
         "d": "设置/重置本回合计时。把回合时长归零可以立刻开始新回合。",
         "p": [
            [
               "time",
               "number",
               "时间（帧）。-1 或负数常表示「立即」"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Bezier_AddPoint",
         "s": "Bezier_AddPoint(bezier, x, y)",
         "d": "往贝塞尔曲线上追加一个控制点。加的点越多曲线越复杂。",
         "p": [
            [
               "bezier",
               "struct",
               "Bezier_CreateStruct 创建的曲线结构体"
            ],
            [
               "x",
               "number",
               "相对面板中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对面板中心的 Y 坐标"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Bezier_CreateStruct",
         "s": "Bezier_CreateStruct(start_x, start_y, last_x, last_y)",
         "d": "创建一个贝塞尔曲线结构体。给起点与终点坐标，之后再逐点添加控制点。",
         "p": [
            [
               "start_x",
               "number",
               "起点 X"
            ],
            [
               "start_y",
               "number",
               "起点 Y"
            ],
            [
               "last_x",
               "number",
               "终点 X"
            ],
            [
               "last_y",
               "number",
               "终点 Y"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Bezier_GetValue",
         "s": "Bezier_GetValue(bezier, step)",
         "d": "取曲线上某个步进位置（0~1）的坐标。逐帧推进 step 就能让物体沿曲线运动。也可作为关键帧缓动传给 Animator.SetKeyframe（补间类型 ANIM_TWEEN.BEZIER，缓动参数传曲线结构体）。注意：当前引擎版本的 ANIM_TWEEN.BEZIER 分支未把求值结果写入返回值，用于关键帧缓动暂不生效，沿曲线运动请直接逐帧调用本函数。",
         "p": [
            [
               "bezier",
               "struct",
               "Bezier_CreateStruct 创建的曲线结构体"
            ],
            [
               "step",
               "0~1",
               "在曲线上的步进位置"
            ]
         ]
      },
      {
         "c": "anim",
         "n": "Bezier_PointNumber",
         "s": "Bezier_PointNumber(bezier)",
         "d": "返回这条贝塞尔曲线上已经加了多少个控制点。",
         "p": [
            [
               "bezier",
               "struct",
               "Bezier_CreateStruct 创建的曲线结构体"
            ]
         ]
      },
      {
         "c": "audio",
         "n": "BGM_Fade",
         "s": "BGM_Fade(bgm_slot, volume, TIME)",
         "d": "把指定槽位的 BGM 在给定帧数内渐变到目标音量，用来做战斗切入、场景转换的音乐过渡。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ],
            [
               "volume",
               "0~1",
               "音量"
            ],
            [
               "time",
               "number",
               "淡入淡出时长（帧）"
            ]
         ],
         "ex": "BGM_SetVolume(BGM_SLOT.MAIN, 0, 60);   // 60帧内淡出\nBGM_SetPitch(BGM_SLOT.MAIN, 0.8);        // 降调",
         "hot": true
      },
      {
         "c": "audio",
         "n": "BGM_GetAudio",
         "s": "BGM_GetAudio(bgm_slot)",
         "d": "取回槽位当前播放的音频资源 ID。拿到后可继续用底层 audio_* 函数做更细的操作（如改声道、加效果）。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ]
         ]
      },
      {
         "c": "audio",
         "n": "BGM_GetID",
         "s": "BGM_GetID(bgm_slot)",
         "d": "读取槽位上登记的 BGM ID，也就是 BGM_Play 时传进去的那个名字。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ]
         ]
      },
      {
         "c": "audio",
         "n": "BGM_Init",
         "s": "BGM_Init()",
         "d": "初始化 BGM 槽位系统，建好内部音频表。启动时调用一次。",
         "p": []
      },
      {
         "c": "audio",
         "n": "BGM_IsPaused",
         "s": "BGM_IsPaused(bgm_slot)",
         "d": "查询该槽位是否处于暂停状态。槽位无效时返回 false。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ]
         ]
      },
      {
         "c": "audio",
         "n": "BGM_IsPlaying",
         "s": "BGM_IsPlaying(bgm_slot)",
         "d": "查询该槽位是否正在播放。可用来判断换曲前是否需要先停。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ]
         ]
      },
      {
         "c": "audio",
         "n": "BGM_IsSlotValid",
         "s": "BGM_IsSlotValid(bgm_slot)",
         "d": "判断槽位号是否在合法范围内。越界查询前先过一道这个函数可以避免报错。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ]
         ]
      },
      {
         "c": "audio",
         "n": "BGM_Pause",
         "s": "BGM_Pause(bgm_slot)",
         "d": "暂停槽位播放，播放位置保留，之后用 BGM_Resume 可从原处继续。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ]
         ]
      },
      {
         "c": "audio",
         "n": "BGM_Play",
         "s": "BGM_Play(bgm_slot, audio, [loop], [loop_start], [loop_end])",
         "d": "在指定槽位播放BGM。槽位是抽象的通道号，可以多首同时播放再交叉淡入。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ],
            [
               "audio",
               "asset/audio",
               "音频资源"
            ],
            [
               "loop",
               "bool（可选）",
               "是否循环"
            ],
            [
               "loop_start",
               "number（可选）",
               "循环起点（秒）"
            ],
            [
               "loop_end",
               "number（可选）",
               "循环终点（秒）"
            ]
         ],
         "ex": "BGM_Play(BGM_SLOT.MAIN, mus_megalovania, true);",
         "hot": true
      },
      {
         "c": "audio",
         "n": "BGM_Resume",
         "s": "BGM_Resume(bgm_slot)",
         "d": "从暂停处继续播放，播放位置不会重置。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ]
         ]
      },
      {
         "c": "audio",
         "n": "BGM_SetPitch",
         "s": "BGM_SetPitch(bgm_slot, pitch)",
         "d": "调整音高，1.0 为原速。低于 1 会变低沉、并把整体拖慢。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ],
            [
               "pitch",
               "number",
               "音高倍率，1 = 原速"
            ]
         ],
         "ex": "BGM_SetVolume(BGM_SLOT.MAIN, 0, 60);   // 60帧内淡出\nBGM_SetPitch(BGM_SLOT.MAIN, 0.8);        // 降调",
         "hot": true
      },
      {
         "c": "audio",
         "n": "BGM_SetVolume",
         "s": "BGM_SetVolume(bgm_slot, volume, [time])",
         "d": "设置槽位音量。给了 time 就在这段时间内渐变，否则立即生效。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ],
            [
               "volume",
               "0~1",
               "音量"
            ],
            [
               "time",
               "number（可选）",
               "时间（帧）。-1 或负数常表示「立即」"
            ]
         ],
         "ex": "BGM_SetVolume(BGM_SLOT.MAIN, 0, 60);   // 60帧内淡出\nBGM_SetPitch(BGM_SLOT.MAIN, 0.8);        // 降调",
         "hot": true
      },
      {
         "c": "audio",
         "n": "BGM_Step",
         "s": "BGM_Step()",
         "d": "每帧更新 BGM 槽状态：推进音量渐变、处理播放结束等。放在 Step 事件里调用。",
         "p": []
      },
      {
         "c": "audio",
         "n": "BGM_Stop",
         "s": "BGM_Stop(bgm_slot)",
         "d": "停止播放并释放该槽位。之后再播同槽位需要重新调用 BGM_Play。",
         "p": [
            [
               "bgm_slot",
               "0~N",
               "BGM 槽位编号"
            ]
         ]
      },
      {
         "c": "ui",
         "n": "Blend_Color",
         "s": "Blend_Color(col1, col2)",
         "d": "按比例混合两个颜色并返回结果。做渐变、受击闪白时用。",
         "p": [
            [
               "col1",
               "color",
               "第一个颜色"
            ],
            [
               "col2",
               "color",
               "第二个颜色"
            ]
         ],
         "ex": "// 用白色底色乘以主题色\nvar c = Blend_Color(c_white, c_red);"
      },
      {
         "c": "soul",
         "n": "BlueSoulControl",
         "s": "BlueSoulControl(dir, impact_speed)",
         "d": "蓝魂的重力跳跃控制函数，处理起跳、落地与平台碰撞。蓝魂子物体在 Step 里调用它。",
         "p": [
            [
               "dir",
               "number",
               "方向，默认 270（向下）"
            ],
            [
               "impact_speed",
               "number",
               "撞击后的反弹速度"
            ]
         ]
      },
      {
         "c": "ui",
         "n": "Border_GetSprite",
         "s": "Border_GetSprite()",
         "d": "读取框边框当前使用的精灵，-1 表示用的是默认边框。",
         "p": [],
         "ex": "Border_SetEnabled(true, false);\nBorder_SetSprite(spr_sans_border, true, 20);",
         "hot": true
      },
      {
         "c": "ui",
         "n": "Border_IsEnabled",
         "s": "Border_IsEnabled()",
         "d": "查询战斗框四周那圈边框当前是否开启显示。返回 true 或 false，常用于判断边框相关演出是否在运行。",
         "p": []
      },
      {
         "c": "ui",
         "n": "Border_SetEnabled",
         "s": "Border_SetEnabled(enabled, blur)",
         "d": "开关战斗框的边框显示。边框就是战斗时围住弹幕区的那圈白线。",
         "p": [
            [
               "enabled",
               "bool",
               "true 开启 / false 关闭"
            ],
            [
               "blur",
               "bool",
               "是否附带模糊效果"
            ]
         ]
      },
      {
         "c": "ui",
         "n": "Border_SetSprite",
         "s": "Border_SetSprite(sprite, [fade], [time])",
         "d": "把框边框换成自定义精灵。可分别设置上下边与左右边用的图，做出非矩形边框。",
         "p": [
            [
               "sprite",
               "asset/sprite",
               "边框贴图"
            ],
            [
               "fade",
               "number（可选）",
               "淡入时长（帧）"
            ],
            [
               "time",
               "number（可选）",
               "时间（帧）。-1 或负数常表示「立即」"
            ]
         ],
         "ex": "Border_SetEnabled(true, false);\nBorder_SetSprite(spr_sans_border, true, 20);",
         "hot": true
      },
      {
         "c": "ui",
         "n": "Camera_Shake",
         "s": "Camera_Shake(shake_x, shake_y, shake_speed_x, shake_speed_y, shake_random_x, shake_random_y, shake_decrease_x, shake_decrease_y, blur)",
         "d": "让镜头按指定强度与时长震动。配合框变形与黑幕就是完整的演出三件套。",
         "p": [
            [
               "shake_x",
               "number",
               "横向抖动幅度"
            ],
            [
               "shake_y",
               "number",
               "纵向抖动幅度"
            ],
            [
               "shake_speed_x",
               "number",
               "横向抖动速度"
            ],
            [
               "shake_speed_y",
               "number",
               "纵向抖动速度"
            ],
            [
               "shake_random_x",
               "bool",
               "横向是否随机方向"
            ],
            [
               "shake_random_y",
               "bool",
               "纵向是否随机方向"
            ],
            [
               "shake_decrease_x",
               "number",
               "横向衰减系数"
            ],
            [
               "shake_decrease_y",
               "number",
               "纵向衰减系数"
            ],
            [
               "blur",
               "bool",
               "是否附带模糊效果"
            ]
         ],
         "ex": "Camera_Shake(2, 2, 4, 4);         // 轻微震动\nCamera_Shake(12, 12, 8, 8);       // 强烈震屏",
         "hot": true
      },
      {
         "c": "ui",
         "n": "CC_Add",
         "s": "CC_Add(text, [time])",
         "d": "往闭路字幕栏追加一行文字，会按顺序排布并自动淡出。",
         "p": [
            [
               "text",
               "string",
               "文本内容（支持 {color} 等格式标签）"
            ],
            [
               "time",
               "number（可选）",
               "时间（帧）。-1 或负数常表示「立即」"
            ]
         ]
      },
      {
         "c": "item",
         "n": "CustomItem_Bandage",
         "s": "CustomItem_Bandage()",
         "d": "示例物品：绷带。一个最简单的回复类道具，可当作写自己物品的起点。",
         "p": []
      },
      {
         "c": "item",
         "n": "CustomItem_Dice",
         "s": "CustomItem_Dice()",
         "d": "示例物品：骰子。每次使用随机掷出 1~6 并报给玩家，演示如何在 OnUse 里接战斗逻辑。",
         "p": []
      },
      {
         "c": "item",
         "n": "CustomItem_FadedRibbon",
         "s": "CustomItem_FadedRibbon()",
         "d": "示例物品：褪色缎带。纯装饰性装备物品，没有实际效果。",
         "p": []
      },
      {
         "c": "item",
         "n": "CustomItem_Phone_TML",
         "s": "CustomItem_Phone_TML()",
         "d": "示例物品：TML 版手机。演示带自定义名字与使用效果的特殊道具。",
         "p": []
      },
      {
         "c": "item",
         "n": "CustomItem_Stick",
         "s": "CustomItem_Stick()",
         "d": "示例物品：树枝。低伤害武器，用于演示装备类物品的写法。",
         "p": []
      },
      {
         "c": "item",
         "n": "CustomItem_ToyKnife",
         "s": "CustomItem_ToyKnife()",
         "d": "示例物品：玩具刀。可装备武器，静态数据在 Player_SetItemWeapon 处生效。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_AddInput",
         "s": "Demo_AddInput(input)",
         "d": "往录制数据里补记一个输入。只能在非录制状态下用（比如手动编辑一段录像）。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Demo_ClearInput",
         "s": "Demo_ClearInput()",
         "d": "清空全部录制数据，从零开始记一段新录像。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_GetInput",
         "s": "Demo_GetInput(pos)",
         "d": "按序号读取录制数据里的一个输入，越界返回 -1。",
         "p": [
            [
               "pos",
               "number",
               "回放位置（第几条）"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Demo_GetInputNumber",
         "s": "Demo_GetInputNumber()",
         "d": "返回录制数据里一共记录了多少个输入。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_Init",
         "s": "Demo_Init()",
         "d": "初始化录制回放系统，建好输入记录列表。启动时调用一次。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_IsPlaying",
         "s": "Demo_IsPlaying()",
         "d": "查询当前是否正在回放录像。判断依据是回放器实例是否存在，返回 true 或 false。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_IsPlayingPaused",
         "s": "Demo_IsPlayingPaused()",
         "d": "查询回放是否处于暂停状态。当前根本没有在回放时，一律返回 false。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_IsRecording",
         "s": "Demo_IsRecording()",
         "d": "查询当前是否正在录制操作录像。判断依据是录制器实例是否存在，返回 true 或 false。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_IsRecordingPaused",
         "s": "Demo_IsRecordingPaused()",
         "d": "查询录制是否处于暂停状态。当前根本没有在录制时，一律返回 false。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_PausePlaying",
         "s": "Demo_PausePlaying()",
         "d": "暂停回放。已播放的进度会保留，可用 Demo_ResumePlaying 继续。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_PauseRecording",
         "s": "Demo_PauseRecording()",
         "d": "暂停录制。已经录下的内容不会丢，可随时恢复。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_RemoveInput",
         "s": "Demo_RemoveInput(input)",
         "d": "从录制数据里删掉某个输入记录，用于手动修正一段录像。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Demo_ResumePlaying",
         "s": "Demo_ResumePlaying()",
         "d": "让暂停中的回放从中断处继续，已播进度不会重置。当前不在暂停状态时返回 false。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_ResumeRecording",
         "s": "Demo_ResumeRecording()",
         "d": "从暂停处继续录制，之前录下的内容不会丢。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_StartPlaying",
         "s": "Demo_StartPlaying()",
         "d": "开始回放。会创建回放器实例，按录制数据重演输入。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_StartRecording",
         "s": "Demo_StartRecording()",
         "d": "开始录制。会在场景里创建一个录制器实例记录输入。正在录或正在放时调用会失败并返回 false。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_StopPlaying",
         "s": "Demo_StopPlaying()",
         "d": "停止回放并销毁回放器实例，回到正常游戏流程。当前没有在回放时返回 false。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_StopRecording",
         "s": "Demo_StopRecording()",
         "d": "停止录制，销毁录制器实例。录制数据会保留下来供回放。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Demo_Uninit",
         "s": "Demo_Uninit()",
         "d": "卸载录制回放系统，销毁内部输入列表。",
         "p": []
      },
      {
         "c": "dialog",
         "n": "Dialog_Add",
         "s": "Dialog_Add(text)",
         "d": "往对话队列里追加一条文字。必须配合 Dialog_Start 才会显示。地图与战斗通用。",
         "p": [
            [
               "text",
               "string",
               "文本内容（支持 {color} 等格式标签）"
            ]
         ],
         "ex": "Dialog_Add(\"* 你感觉背后一阵寒意。\");\nDialog_Add(\"* 你不敢回头。\");\nDialog_Start();",
         "hot": true
      },
      {
         "c": "dialog",
         "n": "Dialog_Clear",
         "s": "Dialog_Clear()",
         "d": "清空对话队列里的所有待播内容。做「打断当前对话」时用。",
         "p": []
      },
      {
         "c": "dialog",
         "n": "Dialog_Get",
         "s": "Dialog_Get()",
         "d": "按序号取出对话队列里的一条内容，用于自定义对话渲染。",
         "p": []
      },
      {
         "c": "dialog",
         "n": "Dialog_Init",
         "s": "Dialog_Init()",
         "d": "初始化对话队列。引擎启动流程里调用一次，之后所有对话都排进这条队列按顺序播放。",
         "p": []
      },
      {
         "c": "dialog",
         "n": "Dialog_IsEmpty",
         "s": "Dialog_IsEmpty()",
         "d": "判断对话队列里还有没有待播放的内容。做「对话播完才允许操作」时用。",
         "p": []
      },
      {
         "c": "dialog",
         "n": "Dialog_Start",
         "s": "Dialog_Start(choose_enable, choice1, choice2)",
         "d": "开始播放队列里的对话。choose_enable = 1 时出现二选一选项（最多两个选项）。",
         "p": [
            [
               "choose_enable",
               "bool",
               "是否启用选项分支"
            ],
            [
               "choice1",
               "string",
               "第一个选项的文字"
            ],
            [
               "choice2",
               "string",
               "第二个选项的文字"
            ]
         ],
         "ex": "Dialog_Add(\"* 要接受这个挑战吗？\");\nDialog_Start(1, \"接受\", \"拒绝\");\n\n// 之后读玩家选择：\nvar c = Player_GetTextTyperChoice();",
         "hot": true
      },
      {
         "c": "dialog",
         "n": "Dialog_Uninit",
         "s": "Dialog_Uninit()",
         "d": "销毁对话队列，释放对话系统占用的资源。",
         "p": []
      },
      {
         "c": "encounter",
         "n": "Encounter_Custom",
         "s": "Encounter_Custom()",
         "d": "引擎留给你的注册入口。所有 Encounter_Set 调用写在这里。该函数在游戏初始化时由 Encounter_Init 自动执行。",
         "p": [],
         "hot": true
      },
      {
         "c": "encounter",
         "n": "Encounter_GetBGM",
         "s": "Encounter_GetBGM(encounter_id)",
         "d": "读取某个遭遇配置里指定的 BGM 资源。",
         "p": [
            [
               "encounter_id",
               "string/number",
               "Encounter_Set 注册时用的遭遇ID"
            ]
         ]
      },
      {
         "c": "encounter",
         "n": "Encounter_GetEnemy",
         "s": "Encounter_GetEnemy(encounter_id, enemy_slot)",
         "d": "读取某个遭遇配置里的敌人物体。属于内部与调试用途，写自己的遭遇逻辑时一般不需要。",
         "p": [
            [
               "encounter_id",
               "string/number",
               "Encounter_Set 注册时用的遭遇ID"
            ],
            [
               "enemy_slot",
               "0~2",
               "敌人槽位编号（0、1、2）。越界会返回 noone / false"
            ]
         ]
      },
      {
         "c": "encounter",
         "n": "Encounter_GetMenuDialog",
         "s": "Encounter_GetMenuDialog(encounter_id)",
         "d": "读取某个遭遇配置的菜单对话文本，就是战斗中框上方那句「* 你想干什么？」。",
         "p": [
            [
               "encounter_id",
               "string/number",
               "Encounter_Set 注册时用的遭遇ID"
            ]
         ]
      },
      {
         "c": "encounter",
         "n": "Encounter_GetSoulX",
         "s": "Encounter_GetSoulX(encounter_id)",
         "d": "读取遭遇里配置的灵魂初始 X 坐标（相对战斗框中心，不是屏幕坐标）。",
         "p": [
            [
               "encounter_id",
               "string/number",
               "Encounter_Set 注册时用的遭遇ID"
            ]
         ]
      },
      {
         "c": "encounter",
         "n": "Encounter_GetSoulY",
         "s": "Encounter_GetSoulY(encounter_id)",
         "d": "读取遭遇里配置的灵魂初始 Y 坐标（相对战斗框中心）。默认 454，也就是框底部附近。",
         "p": [
            [
               "encounter_id",
               "string/number",
               "Encounter_Set 注册时用的遭遇ID"
            ]
         ]
      },
      {
         "c": "encounter",
         "n": "Encounter_Init",
         "s": "Encounter_Init()",
         "d": "初始化遭遇配置表。启动时调用一次，之后 Encounter_Set 才有地方登记。",
         "p": []
      },
      {
         "c": "encounter",
         "n": "Encounter_IsExists",
         "s": "Encounter_IsExists(encounter_id)",
         "d": "查询某个遭遇 id 是否已注册（是否存在于 Encounter_Custom 的注册表里）。",
         "p": [
            [
               "encounter_id",
               "string/number",
               "Encounter_Set 注册时用的遭遇ID"
            ]
         ]
      },
      {
         "c": "encounter",
         "n": "Encounter_IsMenuMercyFleeEnabled",
         "s": "Encounter_IsMenuMercyFleeEnabled(encounter_id)",
         "d": "查询该遭遇的 MERCY 菜单里「逃跑」是否可用。有些剧情战会禁掉逃跑。",
         "p": [
            [
               "encounter_id",
               "string/number",
               "Encounter_Set 注册时用的遭遇ID"
            ]
         ]
      },
      {
         "c": "encounter",
         "n": "Encounter_IsPauseBGM",
         "s": "Encounter_IsPauseBGM(encounter_id)",
         "d": "查询进入该遭遇时是否暂停地图上的 BGM。默认 true，避免战斗曲和地图曲打架。",
         "p": [
            [
               "encounter_id",
               "string/number",
               "Encounter_Set 注册时用的遭遇ID"
            ]
         ]
      },
      {
         "c": "encounter",
         "n": "Encounter_IsQuick",
         "s": "Encounter_IsQuick(encounter_id)",
         "d": "查询该遭遇是否开启了 quick：开启后跳过「惊讶！→ 屏幕破碎」的遭遇动画，直接进战斗。",
         "p": [
            [
               "encounter_id",
               "string/number",
               "Encounter_Set 注册时用的遭遇ID"
            ]
         ]
      },
      {
         "c": "encounter",
         "n": "Encounter_Set",
         "s": "Encounter_Set(id, enemy_0, enemy_1, enemy_2, menu_dialog, [bgm], [menu_mercy_flee_enabled], [pause_bgm], [quick], [soul_x], [soul_y])",
         "d": "注册一场遭遇战。必须在使用前调用（一般放在 room_init 里）。",
         "p": [
            [
               "id",
               "string/number",
               "商店ID"
            ],
            [
               "enemy_0",
               "object",
               "0 号槽位的敌人物体"
            ],
            [
               "enemy_1",
               "object",
               "1 号槽位的敌人物体"
            ],
            [
               "enemy_2",
               "object",
               "2 号槽位的敌人物体"
            ],
            [
               "menu_dialog",
               "string",
               "主菜单下方的对话文本"
            ],
            [
               "bgm",
               "asset/audio（可选）",
               "战斗/场景 BGM，省略则不换曲"
            ],
            [
               "menu_mercy_flee_enabled",
               "bool（可选）",
               "MERCY 里「逃跑」是否可用，默认 true"
            ],
            [
               "pause_bgm",
               "bool（可选）",
               "进入商店时是否暂停地图 BGM"
            ],
            [
               "quick",
               "bool（可选）",
               "true = 跳过进入动画"
            ],
            [
               "soul_x",
               "number（可选）",
               "灵魂初始 X（相对面板中心），默认 48"
            ],
            [
               "soul_y",
               "number（可选）",
               "灵魂初始 Y（相对面板中心），默认 454"
            ]
         ],
         "ex": "#macro ENC_SANS \"sans_fight\"\n\nEncounter_Set(\n    ENC_SANS,           // 遭遇ID\n    obj_sans,           // 槽位0\n    noone, noone,       // 槽位1、2 空着\n    \"* Sans is judging you.\",  // 菜单对话\n    mus_megalovania,    // BGM\n    false,              // 不许逃跑\n    true,               // 暂停地图BGM\n    false,              // 播放遭遇动画\n    48, 454             // 灵魂初始位置\n);"
      },
      {
         "c": "encounter",
         "n": "Encounter_Start",
         "s": "Encounter_Start(encounter, anim, exclam)",
         "d": "触发战斗。这是从地图进入战斗的唯一入口，通常在 trigger 或对话后调用。",
         "p": [
            [
               "encounter",
               "string/number",
               "遭遇ID，必须是 Encounter_Set 注册过的"
            ],
            [
               "anim",
               "bool",
               "true = 播放遭遇动画；false = 直接切场景"
            ],
            [
               "exclam",
               "bool",
               "是否播放感叹号音效，默认 true"
            ]
         ],
         "ex": "// 触碰敌人触发带动画的战斗\nEncounter_Start(ENC_SANS);\n\n// 剧情直接进入战斗（无动画）\nEncounter_Start(ENC_SANS, false);"
      },
      {
         "c": "encounter",
         "n": "Encounter_Uninit",
         "s": "Encounter_Uninit()",
         "d": "释放遭遇配置表，清掉所有已注册的遭遇。",
         "p": []
      },
      {
         "c": "ui",
         "n": "Fader_Fade",
         "s": "Fader_Fade(start, target, time, [delay])",
         "d": "全屏黑幕淡入淡出。start 传 -1 表示从当前透明度开始（最常用）。",
         "p": [
            [
               "start",
               "number",
               "起始值"
            ],
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "time",
               "number",
               "时间（帧）。-1 或负数常表示「立即」"
            ],
            [
               "delay",
               "number（可选）",
               "延迟帧数"
            ]
         ],
         "ex": "Fader_Fade(-1, 1, 30);        // 30帧淡出到全黑\nFader_Fade(1, 0, 30, 20);      // 等20帧后淡入",
         "hot": true
      },
      {
         "c": "misc",
         "n": "File_ReadAllText",
         "s": "File_ReadAllText(path)",
         "d": "一次性读取整个文本文件并返回字符串。读取失败时返回空值，用前先判断。",
         "p": [
            [
               "path",
               "string",
               "文件路径"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "File_WriteAllText",
         "s": "File_WriteAllText(path, text)",
         "d": "把字符串整体写入文本文件，会覆盖原内容。",
         "p": [
            [
               "path",
               "string",
               "文件路径"
            ],
            [
               "text",
               "string",
               "文本内容（支持 {color} 等格式标签）"
            ]
         ]
      },
      {
         "c": "ui",
         "n": "Game_GetFrameSkip",
         "s": "Game_GetFrameSkip()",
         "d": "读取当前的跳帧设置。返回 1 表示不跳帧、每帧都渲染；大于 1 表示每隔若干帧才渲染一次以减轻负担。",
         "p": []
      },
      {
         "c": "ui",
         "n": "Game_SetFrameSkip",
         "s": "Game_SetFrameSkip(amount)",
         "d": "设置跳帧幅度。调高可以显著加快游戏节奏，用于快速测试或做「加速演出」效果。",
         "p": [
            [
               "amount",
               "number",
               "数量 / 幅度"
            ]
         ]
      },
      {
         "c": "ui",
         "n": "GetColorFromString",
         "s": "GetColorFromString(string)",
         "d": "把颜色字符串（如 \"white\" \"red\" \"#ff0000\"）转成 GameMaker 的颜色值。文本格式标签的颜色解析就靠它。",
         "p": [
            [
               "string",
               "string",
               "要解析的字符串"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "GetObjectBase",
         "s": "GetObjectBase(obj)",
         "d": "取某个物体的最顶层父物体。做继承判断时用。",
         "p": [
            [
               "obj",
               "object",
               "要使用的物体（不填则用默认值）"
            ]
         ]
      },
      {
         "c": "input",
         "n": "Input_Bind",
         "s": "Input_Bind(input, type, device, button)",
         "d": "给逻辑输入绑定实体按键。可绑多个键（多次调用即叠加）。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "device",
               "number",
               "设备编号，键盘填 0"
            ],
            [
               "button",
               "vk_*",
               "按键码，如 vk_left、ord(\"Z\")"
            ]
         ],
         "ex": "// 键盘\nInput_Bind(INPUT.CONFIRM, INPUT_TYPE.KEYBOARD, 0, ord(\"Z\"));\nInput_Bind(INPUT.CONFIRM, INPUT_TYPE.KEYBOARD, 0, vk_enter);\nInput_Bind(INPUT.CANCEL,  INPUT_TYPE.KEYBOARD, 0, ord(\"X\"));\nInput_Bind(INPUT.UP,      INPUT_TYPE.KEYBOARD, 0, vk_up);\n\n// 手柄\nInput_Bind(INPUT.CONFIRM, INPUT_TYPE.GAMEPAD, 0, gp_face1);",
         "hot": true
      },
      {
         "c": "input",
         "n": "Input_GetState",
         "s": "Input_GetState(input)",
         "d": "读取某个逻辑输入的当前状态（按下 / 保持 / 松开）。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ]
         ]
      },
      {
         "c": "input",
         "n": "Input_Init",
         "s": "Input_Init()",
         "d": "初始化输入系统（内置 GMU_Input v1.1.0）。会建好按键表与状态覆盖表，并注册 INPUT_TYPE / INPUT_STATE 枚举。",
         "p": []
      },
      {
         "c": "input",
         "n": "Input_IsHeld",
         "s": "Input_IsHeld(input)",
         "d": "是否按住（含刚按下那一帧）。做方向移动用这个。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ]
         ],
         "ex": "var hsp = 0, vsp = 0;\nif (Input_IsHeld(INPUT.LEFT))  hsp -= 2;\nif (Input_IsHeld(INPUT.RIGHT)) hsp += 2;\nif (Input_IsHeld(INPUT.UP))    vsp -= 2;\nif (Input_IsHeld(INPUT.DOWN))  vsp += 2;",
         "hot": true
      },
      {
         "c": "input",
         "n": "Input_IsPressed",
         "s": "Input_IsPressed(input)",
         "d": "这一帧刚按下。做「确认」「取消」的触发器。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ]
         ],
         "ex": "if (Input_IsPressed(INPUT.CONFIRM)) {\n    // 按下 Z / 回车\n}",
         "hot": true
      },
      {
         "c": "input",
         "n": "Input_IsReleased",
         "s": "Input_IsReleased(input)",
         "d": "这一帧刚从按下变为松开。适合做「松手才结算」的蓄力或确认操作。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ]
         ]
      },
      {
         "c": "input",
         "n": "Input_RemoveStateOverride",
         "s": "Input_RemoveStateOverride(input)",
         "d": "取消之前设的输入状态覆盖，让该按键恢复读取真实设备状态。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ]
         ],
         "ex": "// 演出期间锁死移动\nInput_SetStateOverride(INPUT.LEFT,  INPUT_STATE.NULL);\nInput_SetStateOverride(INPUT.RIGHT, INPUT_STATE.NULL);\n// 演出结束恢复\nInput_RemoveStateOverride(INPUT.LEFT);\nInput_RemoveStateOverride(INPUT.RIGHT);",
         "hot": true
      },
      {
         "c": "input",
         "n": "Input_SetStateOverride",
         "s": "Input_SetStateOverride(input, state)",
         "d": "强制指定输入的状态，屏蔽真实按键。用于剧情演出时锁定操作，或模拟一段输入。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ],
            [
               "state",
               "BATTLE_STATE",
               "目标战斗状态"
            ]
         ],
         "ex": "// 演出期间锁死移动\nInput_SetStateOverride(INPUT.LEFT,  INPUT_STATE.NULL);\nInput_SetStateOverride(INPUT.RIGHT, INPUT_STATE.NULL);\n// 演出结束恢复\nInput_RemoveStateOverride(INPUT.LEFT);\nInput_RemoveStateOverride(INPUT.RIGHT);",
         "hot": true
      },
      {
         "c": "input",
         "n": "Input_Unbind",
         "s": "Input_Unbind(input)",
         "d": "解除某个逻辑输入的键位绑定。做自定义键位设置时用。",
         "p": [
            [
               "input",
               "INPUT",
               "逻辑输入名（用 INPUT 枚举）"
            ]
         ]
      },
      {
         "c": "input",
         "n": "Input_Uninit",
         "s": "Input_Uninit()",
         "d": "卸载输入系统：逐个解绑所有按键，再销毁内部映射表。",
         "p": []
      },
      {
         "c": "item",
         "n": "Inventory",
         "s": "Inventory(itemTypeManager, capacity)",
         "d": "背包容器（构造函数）。用物品类型管理器校验物品合法性，容量决定能放几件。",
         "p": [
            [
               "itemTypeManager",
               "struct",
               "物品类型管理器（ItemTypeManager 实例）"
            ],
            [
               "capacity",
               "number",
               "容量上限"
            ]
         ],
         "hot": true
      },
      {
         "c": "item",
         "n": "Inventory.Add",
         "s": "Add(itemId)",
         "d": "把物品追加到背包末尾。等价于 Insert 到 count 位置。",
         "p": [
            [
               "itemId",
               "string",
               "物品类型 ID"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.Clear",
         "s": "Clear()",
         "d": "清空整个背包（容量不变，只把内容清掉）。",
         "p": []
      },
      {
         "c": "item",
         "n": "Inventory.Get",
         "s": "Get(index)",
         "d": "读取指定槽位的物品 ID。越界会报错，确定下标合法时才用。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.GetCapacity",
         "s": "GetCapacity()",
         "d": "返回背包的容量上限，也就是最多能放几件物品。",
         "p": []
      },
      {
         "c": "item",
         "n": "Inventory.GetCount",
         "s": "GetCount()",
         "d": "返回背包里当前有几件物品（不含空槽）。",
         "p": []
      },
      {
         "c": "item",
         "n": "Inventory.GetItem",
         "s": "GetItem(index)",
         "d": "读取指定槽位的物品**类型对象**，拿到后可以直接调它的 GetName / OnUse。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.GetItemName",
         "s": "GetItemName(index)",
         "d": "取指定槽位物品的名字，内部就是 GetItem + GetName。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.GetItemOrUndefined",
         "s": "GetItemOrUndefined(index)",
         "d": "读取指定槽位的物品类型对象，空槽返回 undefined 而不报错。遍历背包时用这个最稳。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.GetOrEmpty",
         "s": "GetOrEmpty(index)",
         "d": "读取指定槽位。空槽返回 ITEM_EMPTY；下标越界仍会报错。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.GetRawArray",
         "s": "GetRawArray()",
         "d": "直接取内部物品 ID 数组。用于存档序列化等底层场合。",
         "p": []
      },
      {
         "c": "item",
         "n": "Inventory.Insert",
         "s": "Insert(index, itemId)",
         "d": "把物品插入到指定槽位，后面的物品依次后移。槽位越界或物品类型非法时会报错并返回 false。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ],
            [
               "itemId",
               "string",
               "物品类型 ID"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.InvokeItemDrop",
         "s": "InvokeItemDrop(index)",
         "d": "触发指定槽位物品的 OnDrop，也就是「玩家丢弃了它」。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.InvokeItemInfo",
         "s": "InvokeItemInfo(index)",
         "d": "触发指定槽位物品的 OnInfo，也就是「玩家查看了它」。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.InvokeItemUse",
         "s": "InvokeItemUse(index)",
         "d": "触发指定槽位物品的 OnUse，也就是「玩家使用了它」。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.IsItemTypeEmptyOrValid",
         "s": "IsItemTypeEmptyOrValid(itemId)",
         "d": "判断物品 ID 是空槽还是合法物品。空槽也算通过。",
         "p": [
            [
               "itemId",
               "string",
               "物品类型 ID"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.IsItemTypeValid",
         "s": "IsItemTypeValid(itemId)",
         "d": "判断物品 ID 是否可用于本背包（要在它的类型管理器里注册过，且不是空槽）。",
         "p": [
            [
               "itemId",
               "string",
               "物品类型 ID"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.Normalize",
         "s": "Normalize()",
         "d": "整理背包：超容量的部分截掉，并可能压缩空槽，保证内部数组始终紧凑。",
         "p": []
      },
      {
         "c": "item",
         "n": "Inventory.Remove",
         "s": "Remove(index)",
         "d": "删除指定槽位的物品，后面的物品前移补位。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.Set",
         "s": "Set(index, itemId)",
         "d": "覆盖指定槽位。传入 ITEM_EMPTY 等于把该槽位移除。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ],
            [
               "itemId",
               "string",
               "物品类型 ID"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Inventory.SetRawArray",
         "s": "SetRawArray(arr)",
         "d": "直接写入内部物品 ID 数组，写完会自动 Normalize 一遍。读档时用。",
         "p": [
            [
               "arr",
               "array",
               "数组"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Item_Custom",
         "s": "Item_Custom()",
         "d": "注册引擎自带的示例物品与全部背包容器（items / phones / box1 / box2）。",
         "p": [],
         "ex": "function Item_Custom() {\n    var itemTypes = Item_GetTypeManager();\n\n    #macro ITEM_DICE \"dice\"\n    itemTypes.Register(ITEM_DICE, new CustomItem_Dice());\n\n    var inventories = Item_GetInventoryManager();\n    inventories.Register(\"items\", new Inventory(itemTypes, 8));\n}",
         "hot": true
      },
      {
         "c": "item",
         "n": "Item_GetInventoryBoxes",
         "s": "Item_GetInventoryBoxes(index)",
         "d": "按索引取回储物箱背包（0 = box1，1 = box2）。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Item_GetInventoryItems",
         "s": "Item_GetInventoryItems()",
         "d": "取回主物品背包（键名 \"items\"）。这是玩家在 ITEM 菜单里看到的那一栏。",
         "p": [],
         "hot": true
      },
      {
         "c": "item",
         "n": "Item_GetInventoryManager",
         "s": "Item_GetInventoryManager()",
         "d": "取回全局背包管理器。背包都注册在它下面，用 \"items\"、\"box1\" 这样的键取。",
         "p": []
      },
      {
         "c": "item",
         "n": "Item_GetInventoryPhones",
         "s": "Item_GetInventoryPhones()",
         "d": "取回手机背包（键名 \"phones\"）。",
         "p": []
      },
      {
         "c": "item",
         "n": "Item_GetNumber",
         "s": "Item_GetNumber()",
         "d": "读取主物品背包里当前一共装了多少件。堆叠物品会被逐件计数，返回一个整数。",
         "p": []
      },
      {
         "c": "item",
         "n": "Item_GetTextEat",
         "s": "Item_GetTextEat(item_name)",
         "d": "生成「吃掉」物品时的那句台词。会按物品名套进模板文本里。",
         "p": [
            [
               "item_name",
               "string",
               "物品名（对应物品注册表里的名字）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Item_GetTextEquip",
         "s": "Item_GetTextEquip(item_name)",
         "d": "生成装备某件物品时弹出的那句台词文本，会按传入的物品名替换其中的占位符，返回可直接交给对话系统显示的字符串。",
         "p": [
            [
               "item_name",
               "string",
               "物品名（对应物品注册表里的名字）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Item_GetTextHeal",
         "s": "Item_GetTextHeal(heal_hp, [new_line])",
         "d": "生成「回复 HP」的台词，自动填入回复数值。可选参数决定是否在句首换行。",
         "p": [
            [
               "heal_hp",
               "number",
               "要恢复的血量"
            ],
            [
               "new_line",
               "bool（可选）",
               "true = 在文本里强制换行"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Item_GetTypeManager",
         "s": "Item_GetTypeManager()",
         "d": "取回全局物品类型管理器。用它 Register 注册新物品类型。",
         "p": []
      },
      {
         "c": "item",
         "n": "Item_Init",
         "s": "Item_Init()",
         "d": "初始化物品系统：建好物品类型管理器与背包管理器，并注册引擎自带的示例物品。启动时调用一次。",
         "p": []
      },
      {
         "c": "item",
         "n": "Item_Uninit",
         "s": "Item_Uninit()",
         "d": "卸载物品系统，释放类型管理器与背包管理器。",
         "p": []
      },
      {
         "c": "item",
         "n": "ItemType",
         "s": "function MyItem() : ItemType() constructor { … }",
         "d": "物品类型基类（构造函数）。定义 GetName / OnUse / OnInfo / OnDrop 四个接口，新物品要么继承它、要么用 ItemTypeSimple。",
         "p": [],
         "ex": "function CustomItem_Dice() : ItemType() constructor {\n    _price_buy = 4;\n    _price_sell = 0;\n\n    function GetName() {\n        return choose(\"Dice\", \"Dice?\", \"Dice!\");\n    }\n\n    function OnUse(inventory, index) {\n        var number = irandom_range(1, 6);\n        Dialog_Add($\"* You rolled the dice.&* It's a {number}!\");\n\n        if (number == 1) {\n            inventory.Add(ITEM_DICE);   // 再来一个\n        } else if (number == 6) {\n            inventory.Remove(index);    // 自己消失\n        }\n        Dialog_Start();\n    }\n\n    function OnInfo(inventory, index) {\n        Dialog_Add(\"* 一个六面骰子。\");\n        Dialog_Start();\n    }\n}"
      },
      {
         "c": "item",
         "n": "ItemType.GetName",
         "s": "GetName()",
         "d": "返回物品的显示名。基类里直接返回创建时登记的 _name，子类可覆写做成会变的名字。",
         "p": []
      },
      {
         "c": "item",
         "n": "ItemType.GetNameOrFallback",
         "s": "GetNameOrFallback(id)",
         "d": "按 ID 取名字，取不到时返回兜底文案（空槽 / 未定义各有一套），不会崩。",
         "p": [
            [
               "id",
               "string/number",
               "商店ID"
            ]
         ]
      },
      {
         "c": "item",
         "n": "ItemType.IsEmptyOrValid",
         "s": "IsEmptyOrValid(itemId)",
         "d": "判断物品 ID 是「空槽」还是「已注册」。与 IsValid 的区别：空槽在这里返回 true。",
         "p": [
            [
               "itemId",
               "string",
               "物品类型 ID"
            ]
         ]
      },
      {
         "c": "item",
         "n": "ItemType.IsValid",
         "s": "IsValid(itemId)",
         "d": "判断物品 ID 是否已注册。ITEM_EMPTY（空槽）不算有效。",
         "p": [
            [
               "itemId",
               "string",
               "物品类型 ID"
            ]
         ]
      },
      {
         "c": "item",
         "n": "ItemType.OnDrop",
         "s": "OnDrop(inventory, index)",
         "d": "**丢弃**物品时触发。基类已实现：从 19 句随机台词里挑一句播出来，让丢弃也有反馈。",
         "p": [
            [
               "inventory",
               "struct",
               "背包对象（Inventory 实例）"
            ],
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "ItemType.OnInfo",
         "s": "OnInfo(inventory, index)",
         "d": "**查看**物品时触发。基类里是空函数，覆写它来显示物品说明。",
         "p": [
            [
               "inventory",
               "struct",
               "背包对象（Inventory 实例）"
            ],
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "ItemType.OnUse",
         "s": "OnUse(inventory, index)",
         "d": "**使用**物品时触发。基类里是空函数，必须覆写并在里面写好效果（回血、加属性、推进剧情）。",
         "p": [
            [
               "inventory",
               "struct",
               "背包对象（Inventory 实例）"
            ],
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "ItemTypeManager",
         "s": "ItemTypeManager()",
         "d": "物品类型管理器，继承自 RegisterManager。比基类多了 GetNameOrFallback，用于安全地取物品名。",
         "p": []
      },
      {
         "c": "item",
         "n": "ItemTypeSimple",
         "s": "ItemTypeSimple(name, info)",
         "d": "简化版物品类型，用两个参数就能建一个物品：名字与说明。内部自动生成 OnUse / OnInfo，适合快速做道具。",
         "p": [
            [
               "name",
               "string",
               "要设置的名字（显示在 ACT / FIGHT 目标列表里）"
            ],
            [
               "info",
               "FLAG_INFO_*",
               "信息键名，用 Info 系列宏"
            ]
         ]
      },
      {
         "c": "item",
         "n": "ItemTypeSimple.GetName",
         "s": "GetName()",
         "d": "返回这个简化物品在创建时登记的名字（通常是一个本地化 key）。物品界面和对话都用它来显示名称。",
         "p": []
      },
      {
         "c": "item",
         "n": "ItemTypeSimple.OnInfo",
         "s": "OnInfo(inventory, index)",
         "d": "查看该物品时触发，显示创建时登记的说明文字。",
         "p": [
            [
               "inventory",
               "struct",
               "背包对象（Inventory 实例）"
            ],
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "ItemTypeSimple.OnUse",
         "s": "OnUse(inventory, index)",
         "d": "使用该物品时触发。ItemTypeSimple 会给一个通用实现，各 CustomItem 示例一般会覆写它来做具体效果。",
         "p": [
            [
               "inventory",
               "struct",
               "背包对象（Inventory 实例）"
            ],
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "ui",
         "n": "Kawase",
         "s": "Kawase(_width, _height, _maxIterations)",
         "d": "Kawase 模糊后期特效，用来做画面失焦或受击反馈。",
         "p": [
            [
               "_width",
               "number",
               "模糊画布宽度"
            ],
            [
               "_height",
               "number",
               "模糊画布高度"
            ],
            [
               "_maxIterations",
               "number",
               "Kawase 模糊的迭代次数，越多越糊"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Macro_Battle",
         "s": "Macro_Battle()",
         "d": "战斗相关的宏容器函数。GML 的 #macro 必须写在函数体内才能全局生效，所以引擎用这些空函数来承载。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "Macro_Depth",
         "s": "Macro_Depth() → DEPTH_UI · DEPTH_BATTLE",
         "d": "绘制深度常量的容器（DEPTH_UI / DEPTH_BATTLE 等）。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "Macro_Direction",
         "s": "Macro_Direction()",
         "d": "方向相关的宏容器函数，承载上下左右等方向常量。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "Macro_Engine",
         "s": "Macro_Engine()",
         "d": "引擎级的宏容器函数，承载引擎全局配置类常量。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "Macro_Game",
         "s": "Macro_Game()",
         "d": "游戏级的宏容器函数，承载游戏通用常量。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "Macro_Input",
         "s": "Macro_Input()",
         "d": "输入相关的宏容器函数，承载按键与输入类型常量。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "Macro_Item",
         "s": "Macro_Item()",
         "d": "物品相关的宏容器函数，承载物品类型与空槽等常量。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "Macro_Phone",
         "s": "Macro_Phone()",
         "d": "手机相关的宏容器函数。GML 的 #macro 必须写在函数体内才能全局生效。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "Macro_Plot",
         "s": "Macro_Plot()",
         "d": "剧情标记相关的宏容器函数，承载剧情进度类常量。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "Macro_Shop",
         "s": "Macro_Shop()",
         "d": "商店相关的宏容器函数，承载商店状态常量。",
         "p": [],
         "hot": true
      },
      {
         "c": "bullet",
         "n": "Makebonecircle",
         "s": "Makebonecircle(number, angle, type, x, y, size_x, size_y, length, out, [roting], [rot], [extra_angle], [rotate], [duration], [rott])",
         "d": "生成一圈放射状排列的骨头（number 根，绕 angle 角度分布）。适合做环形弹幕。",
         "p": [
            [
               "number",
               "number",
               "数量，默认 10"
            ],
            [
               "angle",
               "number",
               "朝向角度（度）"
            ],
            [
               "type",
               "0~4",
               "伤害类型：0 普通 / 1 移动时受伤 / 2 静止时受伤 / 3 治疗 / 4 一次性"
            ],
            [
               "x",
               "number",
               "相对面板中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对面板中心的 Y 坐标"
            ],
            [
               "size_x",
               "number",
               "横向尺寸 / 半径"
            ],
            [
               "size_y",
               "number",
               "纵向尺寸 / 半径"
            ],
            [
               "length",
               "number",
               "骨头长度"
            ],
            [
               "out",
               "0/1",
               "1 = 允许飞出面板边界后仍保持活动"
            ],
            [
               "roting",
               "0/1（可选）",
               "1 = 启用旋转"
            ],
            [
               "rot",
               "number（可选）",
               "整体旋转角"
            ],
            [
               "extra_angle",
               "number（可选）",
               "额外角度偏移"
            ],
            [
               "rotate",
               "number（可选）",
               "自转速度（度/帧）"
            ],
            [
               "duration",
               "number（可选）",
               "存活帧数，-1 = 永久"
            ],
            [
               "rott",
               "number（可选）",
               "每根骨头的差异旋转角"
            ]
         ],
         "ex": "// 12 根骨头从中心放射而出\nMakebonecircle(12, 0, 0, 320, 240, 1, 1, 60, 1);",
         "hot": true
      },
      {
         "c": "item",
         "n": "Phone_GetNumber",
         "s": "Phone_GetNumber()",
         "d": "读取手机背包里当前装了多少件物品。手机与主背包分开计数，返回一个整数。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_CalculateDamage",
         "s": "Player_CalculateDamage(baseDamage, minDamage, maxDamage)",
         "d": "玩家打敌人的伤害公式：基础伤害 + (HP≥20 时 (HP-20)/10 向上取整) - DEF/5，再四舍五入并 clamp。改战斗平衡就改这个函数。",
         "p": [
            [
               "baseDamage",
               "number",
               "基础伤害值"
            ],
            [
               "minDamage",
               "number",
               "最小伤害下限"
            ],
            [
               "maxDamage",
               "number",
               "最大伤害上限"
            ]
         ],
         "ex": "var dmg = Player_CalculateDamage(Battle_GetMenuFightDamage());",
         "hot": true
      },
      {
         "c": "player",
         "n": "Player_CustomInitialData",
         "s": "Player_CustomInitialData()",
         "d": "引擎留给你初始化玩家数据的地方。新开档时的初始 HP、装备与道具都写在这里。",
         "p": [],
         "hot": true
      },
      {
         "c": "player",
         "n": "Player_GetAtk",
         "s": "Player_GetAtk()",
         "d": "读取玩家基础攻击力（不含装备加成）。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetAtkItem",
         "s": "Player_GetAtkItem()",
         "d": "读取武器提供的攻击加成值，不含玩家自身的基础攻击。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetAtkTotal",
         "s": "Player_GetAtkTotal()",
         "d": "读取玩家**最终**攻击力，也就是基础值加上武器加成后的结果。伤害计算用这个。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetBattleFightMenuObj",
         "s": "Player_GetBattleFightMenuObj()",
         "d": "读取战斗中 FIGHT 攻击条所使用的界面实例。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetDef",
         "s": "Player_GetDef()",
         "d": "读取玩家基础防御力（不含装备加成）。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetDefItem",
         "s": "Player_GetDefItem()",
         "d": "读取护甲提供的防御加成值，不含玩家自身的基础防御。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetDefTotal",
         "s": "Player_GetDefTotal()",
         "d": "读取玩家**最终**防御力，基础值加护甲加成。减伤计算用这个。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetExp",
         "s": "Player_GetExp()",
         "d": "读取玩家当前经验值，升级判定会读它。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetGold",
         "s": "Player_GetGold()",
         "d": "读取玩家当前持有的金币（G）数量。金币存放在静态存储里，尚无记录时返回 0。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetHp",
         "s": "Player_GetHp()",
         "d": "读取玩家当前 HP。战斗中血条、受伤判定都读这个值。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetHpMax",
         "s": "Player_GetHpMax()",
         "d": "读取玩家 HP 上限。受 LV 与装备影响。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetInv",
         "s": "Player_GetInv()",
         "d": "读取玩家基础无敌帧（inv）长度。受伤后短暂无敵就靠它。",
         "p": []
      },
      {
         "c": "item",
         "n": "Player_GetInvItem",
         "s": "Player_GetInvItem()",
         "d": "读取玩家背包中指定槽位上的物品 ID，用于遍历背包内容。该槽为空时返回 0。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetInvTotal",
         "s": "Player_GetInvTotal()",
         "d": "读取玩家**最终**无敌帧长度，含装备加成。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetItemArmor",
         "s": "Player_GetItemArmor()",
         "d": "读取玩家当前装备的护甲物品 ID。没有装备任何护甲时返回空字符串。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetItemWeapon",
         "s": "Player_GetItemWeapon()",
         "d": "读取玩家当前装备的武器物品 ID。没有装备任何武器时返回空字符串。",
         "p": [],
         "ex": "Player_SetItemWeapon(ITEM_TOY_KNIFE);\nPlayer_SetAtkItem(5);   // 玩具刀 +5 ATK",
         "hot": true
      },
      {
         "c": "player",
         "n": "Player_GetKills",
         "s": "Player_GetKills()",
         "d": "读取玩家的击杀数。有些结局判定会看它。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetKr",
         "s": "Player_GetKr()",
         "d": "读取玩家当前的 KR（Karma，业报）值。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetLv",
         "s": "Player_GetLv()",
         "d": "读取玩家当前 LV（等级）。LV 会联动 HP 上限与攻防。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetLvAtk",
         "s": "Player_GetLvAtk(lv)",
         "d": "按指定等级查出该等级的基础攻击力，升级动画里的数值滚动会用到。",
         "p": [
            [
               "lv",
               "number",
               "等级"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_GetLvDef",
         "s": "Player_GetLvDef(lv)",
         "d": "按传入的等级换算出该等级对应的基础防御力。公式为 10 + ceil((LV-4)/4)，等级越高这一项越厚。",
         "p": [
            [
               "lv",
               "number",
               "等级"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_GetLvExp",
         "s": "Player_GetLvExp(lv)",
         "d": "按指定等级查出升到该等级所需的经验值。",
         "p": [
            [
               "lv",
               "number",
               "等级"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_GetLvHpMax",
         "s": "Player_GetLvHpMax(lv)",
         "d": "按指定等级查出该等级的 HP 上限。升级动画里常用来做数值滚动。",
         "p": [
            [
               "lv",
               "number",
               "等级"
            ]
         ],
         "hot": true
      },
      {
         "c": "player",
         "n": "Player_GetName",
         "s": "Player_GetName()",
         "d": "读取玩家名字。这个名字会出现在战斗中（比如「* 你充满了决心」里的称呼）。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetPlot",
         "s": "Player_GetPlot()",
         "d": "读取剧情标记（plot）。自定义剧情进度常挂在这个值上。",
         "p": [],
         "ex": "Player_SetPlot(3);          // 推进到第3章\nif (Player_GetPlot() >= 3) { … }",
         "hot": true
      },
      {
         "c": "player",
         "n": "Player_GetRoomName",
         "s": "Player_GetRoomName(room)",
         "d": "读取当前房间名。用于存档界面展示位置，或做「到达过哪些房间」的判定。",
         "p": [
            [
               "room",
               "room asset",
               "房间 asset"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_GetSpd",
         "s": "Player_GetSpd()",
         "d": "读取玩家的基础速度（不含装备加成）。基础速度参与战斗中的闪避与行动先后判定。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetSpdItem",
         "s": "Player_GetSpdItem()",
         "d": "读取当前装备一共提供了多少速度加成。它是叠加在基础速度之外的那一部分。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_GetSpdTotal",
         "s": "Player_GetSpdTotal()",
         "d": "读取玩家**最终**速度，基础值加装备加成。",
         "p": []
      },
      {
         "c": "dialog",
         "n": "Player_GetTextTyperChoice",
         "s": "Player_GetTextTyperChoice()",
         "d": "读取玩家在对话选项里选了第几项（0 或 1）。配合 Dialog_Start(n, \"选项A\", \"选项B\") 使用。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_Heal",
         "s": "Player_Heal(heal)",
         "d": "恢复玩家 HP，不会超过上限。传负数无效。",
         "p": [
            [
               "heal",
               "number",
               "回复的 HP 数量"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_Hurt",
         "s": "Player_Hurt(damage)",
         "d": "扣血。传负数会自动转为治疗。扣到 0 触发死亡流程。",
         "p": [
            [
               "damage",
               "number",
               "伤害数值"
            ]
         ],
         "ex": "Player_Hurt(5);    // 扣 5 点\nPlayer_Hurt(-5);   // 等于 Player_Heal(5)",
         "hot": true
      },
      {
         "c": "player",
         "n": "Player_HurtKr",
         "s": "Player_HurtKr()",
         "d": "弹幕专用伤害入口。会先检查 global.kr（业报模式），有 KR 时改为叠加 KR 伤害。骨头/GB 的 type 0/4 都用它。",
         "p": [],
         "ex": "// 自己的弹幕里造成伤害\nif (global.kr) {\n    Player_HurtKr();\n} else {\n    Player_Hurt(3);\n}",
         "hot": true
      },
      {
         "c": "player",
         "n": "Player_IsInBattle",
         "s": "Player_IsInBattle()",
         "d": "查询玩家当前是否处于战斗状态。做「地图上禁用什么操作」时用。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_LvUp",
         "s": "Player_LvUp(lv)",
         "d": "执行一次升级：按等级曲线提升 HP 上限与各项属性。",
         "p": [
            [
               "lv",
               "number",
               "等级"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetAtk",
         "s": "Player_SetAtk(atk)",
         "d": "设置玩家的基础攻击力，不含武器加成。写入的是静态存储里的 ATK 数值。",
         "p": [
            [
               "atk",
               "number",
               "攻击力临时增减值"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetAtkItem",
         "s": "Player_SetAtkItem(atk)",
         "d": "设置武器提供的攻击加成，改完 GetAtkTotal 会跟着变。",
         "p": [
            [
               "atk",
               "number",
               "攻击力临时增减值"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetBattleFightMenuObj",
         "s": "Player_SetBattleFightMenuObj(obj)",
         "d": "指定战斗中 FIGHT 攻击条要用的界面实例。自定义攻击条时替换它。",
         "p": [
            [
               "obj",
               "object",
               "要使用的物体（不填则用默认值）"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetDef",
         "s": "Player_SetDef(def)",
         "d": "设置玩家的基础防御力，不含护甲加成。写入的是静态存储里的 DEF 数值。",
         "p": [
            [
               "def",
               "number",
               "敌人防御力，参与伤害计算"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetDefItem",
         "s": "Player_SetDefItem(def)",
         "d": "设置护甲物品提供的防御加成。它是叠加在基础防御之外的那一部分。",
         "p": [
            [
               "def",
               "number",
               "敌人防御力，参与伤害计算"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetExp",
         "s": "Player_SetExp(experience)",
         "d": "设置玩家经验值，之后需要自己调 Player_UpdateLv 判定升级。",
         "p": [
            [
               "experience",
               "number",
               "经验值"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetGold",
         "s": "Player_SetGold(gold)",
         "d": "直接设置玩家持有的金币数量，属于覆盖写入而非累加。做交易扣款或发放奖励时使用。",
         "p": [
            [
               "gold",
               "number",
               "金币数量"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetHp",
         "s": "Player_SetHp(hp)",
         "d": "设置玩家当前 HP。会被自动钳制在 0 ~ HpMax 之间。",
         "p": [
            [
               "hp",
               "number",
               "当前 HP"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetHpMax",
         "s": "Player_SetHpMax(hpMax)",
         "d": "设置玩家 HP 上限，会连带影响 LV 派生出的数值。",
         "p": [
            [
               "hpMax",
               "number",
               "HP 上限"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetInv",
         "s": "Player_SetInv(inv)",
         "d": "设置玩家基础无敌帧长度，也就是受伤后的短暂免伤时间。",
         "p": [
            [
               "inv",
               "number",
               "无敌帧数量（受伤后的免伤时间）"
            ]
         ]
      },
      {
         "c": "item",
         "n": "Player_SetInvItem",
         "s": "Player_SetInvItem(inv)",
         "d": "写入玩家背包指定槽位的物品 ID。收下/丢掉道具时调用。",
         "p": [
            [
               "inv",
               "number",
               "无敌帧数量（受伤后的免伤时间）"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetItemArmor",
         "s": "Player_SetItemArmor(item)",
         "d": "更换当前装备的护甲，防御加成会立刻生效。",
         "p": [
            [
               "item",
               "string/object",
               "物品 ID 或物品类型对象"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetItemWeapon",
         "s": "Player_SetItemWeapon(item)",
         "d": "更换当前装备的武器，攻击加成会立刻生效。",
         "p": [
            [
               "item",
               "string/object",
               "物品 ID 或物品类型对象"
            ]
         ],
         "ex": "Player_SetItemWeapon(ITEM_TOY_KNIFE);\nPlayer_SetAtkItem(5);   // 玩具刀 +5 ATK",
         "hot": true
      },
      {
         "c": "player",
         "n": "Player_SetKills",
         "s": "Player_SetKills(kills)",
         "d": "设置玩家击杀数，部分结局判定会读它。",
         "p": [
            [
               "kills",
               "number",
               "击杀数"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetKr",
         "s": "Player_SetKr()",
         "d": "设置玩家的 KR（业报）值。仅在全局开启了 KR 系统时才会真正写入，否则本函数什么都不做。",
         "p": []
      },
      {
         "c": "player",
         "n": "Player_SetLv",
         "s": "Player_SetLv(lv)",
         "d": "设置玩家 LV。改完一般要跟着调 Player_UpdateLv() 刷新派生属性。",
         "p": [
            [
               "lv",
               "number",
               "等级"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetName",
         "s": "Player_SetName(name)",
         "d": "设置玩家名字。战斗中与存档界面的称呼都会随之变成这个名字。",
         "p": [
            [
               "name",
               "string",
               "要设置的名字（显示在 ACT / FIGHT 目标列表里）"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetPlot",
         "s": "Player_SetPlot(plot)",
         "d": "设置剧情标记，自定义剧情进度常挂在这个值上。",
         "p": [
            [
               "plot",
               "any",
               "剧情标记值"
            ]
         ],
         "ex": "Player_SetPlot(3);          // 推进到第3章\nif (Player_GetPlot() >= 3) { … }",
         "hot": true
      },
      {
         "c": "player",
         "n": "Player_SetSpd",
         "s": "Player_SetSpd(spd)",
         "d": "设置玩家的基础速度（不含装备加成）。会直接覆盖原有的基础速度数值。",
         "p": [
            [
               "spd",
               "number",
               "速度临时增减值"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_SetSpdItem",
         "s": "Player_SetSpdItem(spd)",
         "d": "设置装备提供的速度加成。它是叠加在基础速度之外的那一部分。",
         "p": [
            [
               "spd",
               "number",
               "速度临时增减值"
            ]
         ]
      },
      {
         "c": "player",
         "n": "Player_UpdateLv",
         "s": "Player_UpdateLv()",
         "d": "按当前 LV 重算所有派生属性（HP 上限、攻击、防御等）。调过 LV 或经验后应该调一次。",
         "p": []
      },
      {
         "c": "misc",
         "n": "RegisterManager",
         "s": "RegisterManager()",
         "d": "通用注册管理器（构造函数）。把「ID → 对象」登记在一张表里，供背包、物品类型、商店等处复用。",
         "p": [],
         "hot": true
      },
      {
         "c": "misc",
         "n": "RegisterManager.Contains",
         "s": "Contains(id)",
         "d": "判断某个 ID 是否已经在管理器里登记过。",
         "p": [
            [
               "id",
               "string/number",
               "商店ID"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "RegisterManager.Get",
         "s": "Get(id)",
         "d": "按 ID 从注册表里取出内容。ID 不存在时会直接抛错并返回 undefined，建议先用 Contains 判断存在性再取。",
         "p": [
            [
               "id",
               "string/number",
               "商店ID"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "RegisterManager.GetIds",
         "s": "GetIds()",
         "d": "取回所有已登记的 ID 列表。遍历管理器内容时用。",
         "p": []
      },
      {
         "c": "misc",
         "n": "RegisterManager.GetOrUndefined",
         "s": "GetOrUndefined(id)",
         "d": "按 ID 取对象，不存在返回 undefined 而不报错。",
         "p": [
            [
               "id",
               "string/number",
               "商店ID"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "RegisterManager.Register",
         "s": "Register(id, content)",
         "d": "登记一个 ID 对应的对象。重复登记同一个 ID 通常会覆盖。",
         "p": [
            [
               "id",
               "string/number",
               "商店ID"
            ],
            [
               "content",
               "string",
               "内容文本"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "RotateAround",
         "s": "RotateAround(x_center, y_center, x_around, y_around, x_present, y_present, angle)",
         "d": "让实例绕一个指定点旋转。做环绕运动、行星弹幕时用。",
         "p": [
            [
               "x_center",
               "number",
               "旋转中心 X"
            ],
            [
               "y_center",
               "number",
               "旋转中心 Y"
            ],
            [
               "x_around",
               "number",
               "绕行起点 X"
            ],
            [
               "y_around",
               "number",
               "绕行起点 Y"
            ],
            [
               "x_present",
               "number",
               "当前 X"
            ],
            [
               "y_present",
               "number",
               "当前 Y"
            ],
            [
               "angle",
               "number",
               "朝向角度（度）"
            ]
         ],
         "ex": "var pos = RotateAround(board.x, board.y, board.x, board.y, bone_x, bone_y, board.angle);\nbone.x = pos[0];\nbone.y = pos[1];",
         "hot": true
      },
      {
         "c": "anim",
         "n": "Shake_Create",
         "s": "Shake_Create(target, var_name, shake_distance, shake_speed, shake_random, shake_decrease, delay)",
         "d": "让任意变量抖动（不只是屏幕）。做「受伤抖动」「数字跳动」。",
         "p": [
            [
               "target",
               "实例 id / 物体 / global",
               "动画作用的目标：可以是某个实例 id、物体索引，或 global（配合 var_name 指定要驱动哪个全局变量）。"
            ],
            [
               "var_name",
               "string",
               "要驱动的变量名。目标是实例时直接写变量名；目标是 global 时必须写成字符串形式的名字。"
            ],
            [
               "shake_distance",
               "number",
               "抖动幅度"
            ],
            [
               "shake_speed",
               "number",
               "抖动速度"
            ],
            [
               "shake_random",
               "bool",
               "是否随机方向抖动"
            ],
            [
               "shake_decrease",
               "number",
               "每帧衰减系数"
            ],
            [
               "delay",
               "number（可选）",
               "延迟帧数"
            ]
         ],
         "ex": "// 让伤害数字左右抖 5 帧\nShake_Create(damage_inst, \"x\", 4, 6, false, 1, 0);",
         "hot": true
      },
      {
         "c": "shop",
         "n": "Shop_CallDialog",
         "s": "Shop_CallDialog(index)",
         "d": "触发商店的第 index 段对话。用于店主边介绍边推进的多段台词。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_CallEvent",
         "s": "Shop_CallEvent(event)",
         "d": "主动触发商店的事件回调，用于自定义商店的交互时机。",
         "p": [
            [
               "event",
               "BATTLE_ENEMY_EVENT",
               "要触发的事件枚举"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_ClearTyper",
         "s": "Shop_ClearTyper()",
         "d": "清空商店打字机正在显示的内容并收起对话框，用于立刻打断商店里的文字演出。",
         "p": []
      },
      {
         "c": "shop",
         "n": "Shop_CreateTyper",
         "s": "Shop_CreateTyper()",
         "d": "为商店对话框创建打字机实例，负责逐字显示效果。",
         "p": []
      },
      {
         "c": "shop",
         "n": "Shop_Custom",
         "s": "Shop_Custom()",
         "d": "商店注册总入口，游戏初始化时自动执行。所有 Shop_Set 调用写在这里。",
         "p": [],
         "hot": true
      },
      {
         "c": "shop",
         "n": "Shop_DialogStart",
         "s": "Shop_DialogStart(text)",
         "d": "开启一段商店对话。按索引取该商店的对话配置并显示出来。",
         "p": [
            [
               "text",
               "string",
               "文本内容（支持 {color} 等格式标签）"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_End",
         "s": "Shop_End()",
         "d": "退出商店流程，关闭商店界面并把控制权交回地图。",
         "p": []
      },
      {
         "c": "shop",
         "n": "Shop_GetBackground",
         "s": "Shop_GetBackground(shop_id)",
         "d": "读取某个商店使用的背景图。传入商店 ID，若该商店不存在则返回 -1。",
         "p": [
            [
               "shop_id",
               "string/number",
               "商店ID"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_GetBGM",
         "s": "Shop_GetBGM(shop_id)",
         "d": "读取某个商店播放的背景音乐。传入商店 ID，若该商店不存在则返回 -1。",
         "p": [
            [
               "shop_id",
               "string/number",
               "商店ID"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_GetDialogTitle",
         "s": "Shop_GetDialogTitle(index)",
         "d": "读取商店对话标题栏上显示的文字（含颜色标记）。只接受 0 到 3 的索引，越界时返回空。",
         "p": [
            [
               "index",
               "number",
               "索引（从 0 开始）"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_GetHost",
         "s": "Shop_GetHost(shop_id)",
         "d": "读取某个商店的店主配置（立绘、名称等）。",
         "p": [
            [
               "shop_id",
               "string/number",
               "商店ID"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_GoState",
         "s": "Shop_GoState(state)",
         "d": "手动切换商店的内部状态（浏览 / 买卖 / 对话等）。一般由商店流程自己驱动，自定义商店时才需要调。",
         "p": [
            [
               "state",
               "BATTLE_STATE",
               "目标战斗状态"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_Init",
         "s": "Shop_Init()",
         "d": "初始化商店系统，建好商店注册表与对话打字机。启动时调用一次。",
         "p": []
      },
      {
         "c": "shop",
         "n": "Shop_IsExists",
         "s": "Shop_IsExists(shop_id)",
         "d": "判断某个商店 id 是否已注册，也就是是否存在于 Shop_Custom 的注册表里。",
         "p": [
            [
               "shop_id",
               "string/number",
               "商店ID"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_RefreshTyper",
         "s": "Shop_RefreshTyper([left], [right], [state], [info])",
         "d": "刷新商店打字机内容：传入左右选项与当前状态、提示信息，让它重新排版显示。",
         "p": [
            [
               "left",
               "number（可选）",
               "面板中心到左边的距离"
            ],
            [
               "right",
               "number（可选）",
               "面板中心到右边的距离"
            ],
            [
               "state",
               "BATTLE_STATE（可选）",
               "目标战斗状态"
            ],
            [
               "info",
               "FLAG_INFO_*（可选）",
               "信息键名，用 Info 系列宏"
            ]
         ]
      },
      {
         "c": "shop",
         "n": "Shop_Set",
         "s": "Shop_Set(id, host, background, [bgm], [pause_bgm], [quick])",
         "d": "注册一个商店。传入商店 id、店主物体、背景与 BGM 等配置，之后用 Shop_Start 进入。",
         "p": [
            [
               "id",
               "string/number",
               "商店ID"
            ],
            [
               "host",
               "object",
               "店主立绘物体"
            ],
            [
               "background",
               "asset/background",
               "商店背景"
            ],
            [
               "bgm",
               "asset/audio（可选）",
               "战斗/场景 BGM，省略则不换曲"
            ],
            [
               "pause_bgm",
               "bool（可选）",
               "进入商店时是否暂停地图 BGM"
            ],
            [
               "quick",
               "bool（可选）",
               "true = 跳过进入动画"
            ]
         ],
         "ex": "#macro SHOP_SANS \"sans_shop\"\n\nShop_Set(SHOP_SANS,\n         obj_sans_shopkeeper,      // 店主物体\n         spr_shop_bg,              // 背景\n         mus_shop,                 // BGM\n         true, false);",
         "hot": true
      },
      {
         "c": "shop",
         "n": "Shop_SetDialog",
         "s": "Shop_SetDialog(title, title_blend, text, next_dialog)",
         "d": "设置商店对话框内容。title 是店主头顶的标题。",
         "p": [
            [
               "title",
               "string",
               "标题文字"
            ],
            [
               "title_blend",
               "color",
               "标题染色"
            ],
            [
               "text",
               "string",
               "文本内容（支持 {color} 等格式标签）"
            ],
            [
               "next_dialog",
               "number",
               "下一段对话的索引"
            ]
         ],
         "hot": true
      },
      {
         "c": "shop",
         "n": "Shop_Start",
         "s": "Shop_Start(shop_id)",
         "d": "按商店 id 进入商店流程，会创建商店实例并接管玩家操作。",
         "p": [
            [
               "shop_id",
               "string/number",
               "商店ID"
            ]
         ],
         "hot": true
      },
      {
         "c": "shop",
         "n": "Shop_Uninit",
         "s": "Shop_Uninit()",
         "d": "卸载商店系统，释放注册表与打字机资源。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage",
         "s": "Storage(funcGetFilePath)",
         "d": "存储单元的构造函数。每个存储单元对应一个 JSON 文件，内部用 StorageZone 分区分门别类地放数据。",
         "p": [
            [
               "funcGetFilePath",
               "function",
               "返回存档文件路径的函数"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_Custom",
         "s": "Storage_Custom()",
         "d": "引擎留给你注册存储区的地方。它内部依次调用上面那五个 Storage_Custom_* 函数。",
         "p": [],
         "hot": true
      },
      {
         "c": "storage",
         "n": "Storage_Custom_Dynamic",
         "s": "Storage_Custom_Dynamic(storages)",
         "d": "注册 dynamic 区（存进 dynamic.json）。放**跟随存档槽**的可变数据，比如当前房间、背包内容。",
         "p": [
            [
               "storages",
               "struct",
               "存储管理器，用于注册存储区"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_Custom_Info",
         "s": "Storage_Custom_Info(storages)",
         "d": "注册 info 区（存进 info.json）。专门放**存档选择界面**要显示的信息，如 LV、游玩时长、所在地点。",
         "p": [
            [
               "storages",
               "struct",
               "存储管理器，用于注册存储区"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_Custom_Settings",
         "s": "Storage_Custom_Settings(storages)",
         "d": "注册 settings 区（存进 settings.json）。放玩家偏好设置，与存档槽无关。",
         "p": [
            [
               "storages",
               "struct",
               "存储管理器，用于注册存储区"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_Custom_Static",
         "s": "Storage_Custom_Static(storages)",
         "d": "注册 static 区（存进 static.json）。放**跨存档永久生效**的数据，比如见过的结局、解锁项。",
         "p": [
            [
               "storages",
               "struct",
               "存储管理器，用于注册存储区"
            ]
         ],
         "ex": "// 引擎自带的注册内容（在 Storage_Custom_* 里）：\nfunction Storage_Custom_Static(storages){\n    var s = new Storage(Storage_MakeGetFilePathFunc(true, \"static.json\"));\n    storages.Register(\"static\", s);\n    s.Register(\"general\", new StorageZoneStruct());\n}\n\n// 你要加自己的：\nfunction Storage_Custom_Static(storages){\n    // …原有内容…\n    s.Register(\"my_quests\", new MyQuestZone());\n}",
         "hot": true
      },
      {
         "c": "storage",
         "n": "Storage_Custom_Temp",
         "s": "Storage_Custom_Temp(storages)",
         "d": "注册 temp 区。**只存在内存、不落盘**，适合放战斗内的临时状态，关掉游戏即消失。",
         "p": [
            [
               "storages",
               "struct",
               "存储管理器，用于注册存储区"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_GetDynamic",
         "s": "Storage_GetDynamic()",
         "d": "取回名为 dynamic 的存储单元对象，用于读写游戏运行时（随存档一起保存）的数据。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_GetInfo",
         "s": "Storage_GetInfo()",
         "d": "取回 info 存储单元对象，里面放的是存档界面显示用的信息。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_GetInfoFlag",
         "s": "Storage_GetInfoFlag(flag, defaultValue)",
         "d": "读取 info 区 general 分区里的一个标记值。",
         "p": [
            [
               "flag",
               "string",
               "标记名（一般用 FLAG_* 宏）"
            ],
            [
               "defaultValue",
               "any",
               "标记不存在时返回的默认值"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_GetInfoGeneral",
         "s": "Storage_GetInfoGeneral()",
         "d": "取回 info 区的 general 分区（带缓存）。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_GetManager",
         "s": "Storage_GetManager()",
         "d": "取回全局存储管理器。四级存储区都注册在它下面，用 Get(\"static\") 这样的键取出来。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_GetSaveSlot",
         "s": "Storage_GetSaveSlot()",
         "d": "读取当前使用的存档槽编号，决定数据具体读写到哪一个存档文件。",
         "p": [],
         "hot": true
      },
      {
         "c": "storage",
         "n": "Storage_GetSettings",
         "s": "Storage_GetSettings()",
         "d": "取回名为 settings 的存储单元对象，用于读写音量、按键等设置类数据，与存档彼此独立。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_GetStatic",
         "s": "Storage_GetStatic()",
         "d": "取回 static 存储单元对象，里面放的是跨存档永久生效的数据。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_GetStaticFlag",
         "s": "Storage_GetStaticFlag(flag, defaultValue)",
         "d": "读取 static 区 general 分区里的一个标记值。没存过就返回 defaultValue。",
         "p": [
            [
               "flag",
               "string",
               "标记名（一般用 FLAG_* 宏）"
            ],
            [
               "defaultValue",
               "any",
               "标记不存在时返回的默认值"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_GetStaticGeneral",
         "s": "Storage_GetStaticGeneral()",
         "d": "取回 static 区的 general 分区。引擎为常用区做了缓存，所以它比 Get(\"general\") 更快。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_GetTemp",
         "s": "Storage_GetTemp()",
         "d": "取回 temp 存储单元对象，里面是只存内存、不落盘的临时数据。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_GetTempFlag",
         "s": "Storage_GetTempFlag(flag, defaultValue)",
         "d": "读取 temp 区 general 分区里的一个标记值。",
         "p": [
            [
               "flag",
               "string",
               "标记名（一般用 FLAG_* 宏）"
            ],
            [
               "defaultValue",
               "any",
               "标记不存在时返回的默认值"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_GetTempGeneral",
         "s": "Storage_GetTempGeneral()",
         "d": "取回 temp 区的 general 分区（带缓存）。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_Init",
         "s": "Storage_Init()",
         "d": "初始化存档系统：建好存储管理器并注册四级存储区。启动时调用一次。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_LoadGame",
         "s": "Storage_LoadGame()",
         "d": "读档：从文件里恢复 static 与 dynamic 两个区。",
         "p": [],
         "hot": true
      },
      {
         "c": "storage",
         "n": "Storage_MakeGetFilePathFunc",
         "s": "Storage_MakeGetFilePathFunc(useSlots, fileName)",
         "d": "生成一个「取存档文件路径」的函数，供自定义存储区复用。",
         "p": [
            [
               "useSlots",
               "bool",
               "true = 按存档槽分文件存放"
            ],
            [
               "fileName",
               "string",
               "数据文件名，如 \"info.json\""
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_SaveDynamic",
         "s": "Storage_SaveDynamic()",
         "d": "单独把 dynamic 区落盘。适合在换房间等场合做轻量保存，不必走完整的存档流程。",
         "p": []
      },
      {
         "c": "storage",
         "n": "Storage_SaveGame",
         "s": "Storage_SaveGame()",
         "d": "存档：把 static 与 info 区落盘，并顺手写入当前房间与 LV 等供存档界面显示的信息。",
         "p": [],
         "hot": true
      },
      {
         "c": "storage",
         "n": "Storage_SetInfoFlag",
         "s": "Storage_SetInfoFlag(flag, value)",
         "d": "写入 info 区 general 分区的一个标记值。",
         "p": [
            [
               "flag",
               "string",
               "标记名（一般用 FLAG_* 宏）"
            ],
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_SetSaveSlot",
         "s": "Storage_SetSaveSlot(slot)",
         "d": "设置当前使用的存档槽编号。存档文件路径会跟着槽位走。",
         "p": [
            [
               "slot",
               "number",
               "槽位编号"
            ]
         ],
         "hot": true
      },
      {
         "c": "storage",
         "n": "Storage_SetStaticFlag",
         "s": "Storage_SetStaticFlag(flag, value)",
         "d": "写入 static 区 general 分区的一个标记值，返回该分区以便链式调用。",
         "p": [
            [
               "flag",
               "string",
               "标记名（一般用 FLAG_* 宏）"
            ],
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_SetTempFlag",
         "s": "Storage_SetTempFlag(flag, value)",
         "d": "写入 temp 区 general 分区的一个标记值。",
         "p": [
            [
               "flag",
               "string",
               "标记名（一般用 FLAG_* 宏）"
            ],
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "Storage_Uninit",
         "s": "Storage_Uninit()",
         "d": "卸载存档系统，释放存储管理器占用的资源。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone",
         "s": "StorageZone()",
         "d": "存储区基类（构造函数）。定义 OnWrite / OnRead / OnClear 三个钩子，子类可覆写来做加密或格式转换。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.ClearData",
         "s": "ClearData()",
         "d": "清空该存储区里所有存储单元保存的键值对，相当于把这一整块数据重置回初始状态。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.DeserializeFromJson",
         "s": "DeserializeFromJson(json)",
         "d": "从 JSON 字符串还原出存储区的内部数据，读档时会用到。",
         "p": [
            [
               "json",
               "string",
               "JSON 字符串"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "StorageZone.Get",
         "s": "Get(key, defaultValue)",
         "d": "按键取值。键不存在时会报错，确定键一定存在时用。",
         "p": [
            [
               "key",
               "string",
               "键名"
            ],
            [
               "defaultValue",
               "any",
               "标记不存在时返回的默认值"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "StorageZone.GetData",
         "s": "GetData()",
         "d": "取回内部用来保存整个数据的那张表（结构体），可以直接读取其中所有键的当前值。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.GetFilePath",
         "s": "GetFilePath()",
         "d": "取回该存储区对应的文件路径。temp 区没有路径（不落盘）。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.GetOrDefault",
         "s": "GetOrDefault(key, defaultValue)",
         "d": "按键取值，键不存在就返回给定的默认值。比 Get 安全，推荐日常使用。",
         "p": [
            [
               "key",
               "string",
               "键名"
            ],
            [
               "defaultValue",
               "any",
               "标记不存在时返回的默认值"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "StorageZone.IsFileExists",
         "s": "IsFileExists()",
         "d": "判断存档文件是否已存在。第一次游玩时可以用它决定要不要走新手引导。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.LoadFromFile",
         "s": "LoadFromFile()",
         "d": "从文件读回数据，并覆盖当前内存里的内容。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.OnClear",
         "s": "OnClear()",
         "d": "清空钩子。默认什么都不做，覆写它可以在清档时附带做额外清理。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.OnRead",
         "s": "OnRead(from)",
         "d": "读取钩子。默认什么都不做，覆写它可以在读到数据后做还原处理。",
         "p": [
            [
               "from",
               "any",
               "数据来源"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "StorageZone.OnWrite",
         "s": "OnWrite()",
         "d": "写入钩子。默认什么都不做，覆写它可以在数据落盘前做加工（加密、压缩）。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.SaveToFile",
         "s": "SaveToFile()",
         "d": "把内存里的数据序列化后写进磁盘文件。若未配置取路径的函数则不会执行任何写入。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.SerializeToJson",
         "s": "SerializeToJson()",
         "d": "把内部数据整体序列化成 JSON 字符串返回，便于查看、调试或另存到别处。",
         "p": []
      },
      {
         "c": "storage",
         "n": "StorageZone.Set",
         "s": "Set(key, value)",
         "d": "写入一个键值对。键已存在时会覆盖旧值。",
         "p": [
            [
               "key",
               "string",
               "键名"
            ],
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "StorageZoneInventories",
         "s": "StorageZoneInventories(inventoryManager)",
         "d": "专门用于存放各背包容器的存储区，把背包内容纳入存档体系。",
         "p": [
            [
               "inventoryManager",
               "struct",
               "背包管理器（RegisterManager 实例）"
            ]
         ]
      },
      {
         "c": "storage",
         "n": "StorageZoneStruct",
         "s": "StorageZoneStruct()",
         "d": "带数据结构的存储区，继承自 StorageZone。绝大多数存放键值对的地方都用它。",
         "p": []
      },
      {
         "c": "dialog",
         "n": "TextTyper_Add",
         "s": "TextTyper_Add(x, y, depth, text)",
         "d": "在世界中直接生成一个打字机文本（不走队列，不进对话框）。返回实例。",
         "p": [
            [
               "x",
               "number",
               "相对面板中心的 X 坐标"
            ],
            [
               "y",
               "number",
               "相对面板中心的 Y 坐标"
            ],
            [
               "depth",
               "number",
               "绘制深度"
            ],
            [
               "text",
               "string",
               "文本内容（支持 {color} 等格式标签）"
            ]
         ],
         "ex": "TextTyper_Add(320, 240, -1000, \"* 这是一段漂浮文字\");",
         "hot": true
      },
      {
         "c": "misc",
         "n": "Time_Init",
         "s": "Time_Init()",
         "d": "初始化游戏计时系统，开始累计游玩时长。",
         "p": [],
         "ex": "// 自己写弹幕运动时也要乘上它\ninst.hspeed = 3 * global.delta_time_factor;\n\n// 全局变速（做子弹时间）：直接改这个值\nglobal.delta_time_factor = 0.5;",
         "hot": true
      },
      {
         "c": "misc",
         "n": "Time_Step",
         "s": "Time_Step()",
         "d": "每帧推进计时。放在 Step 事件里调用，用于统计游玩时间（存档界面会显示）。",
         "p": [],
         "ex": "// 自己写弹幕运动时也要乘上它\ninst.hspeed = 3 * global.delta_time_factor;\n\n// 全局变速（做子弹时间）：直接改这个值\nglobal.delta_time_factor = 0.5;",
         "hot": true
      },
      {
         "c": "misc",
         "n": "Vector3",
         "s": "Vector3(_x, _y, _z)",
         "d": "三维向量（构造函数）。带一套常用的向量运算方法，用于 3D 骨骼与空间计算。",
         "p": [
            [
               "_x",
               "number",
               "X 分量"
            ],
            [
               "_y",
               "number",
               "Y 分量"
            ],
            [
               "_z",
               "number",
               "Z 分量，默认 0"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Vector3.Add",
         "s": "Add(value)",
         "d": "两个向量相加，返回一个新的 Vector3，不修改自身。",
         "p": [
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Vector3.Angle",
         "s": "Angle(value)",
         "d": "返回与另一个向量的夹角，单位是弧度。",
         "p": [
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Vector3.Cross",
         "s": "Cross(value)",
         "d": "与另一个向量做叉积，返回一个新的 Vector3，方向垂直于两者构成的平面。",
         "p": [
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Vector3.Distance",
         "s": "Distance(value)",
         "d": "返回与另一个向量之间的欧几里得距离。",
         "p": [
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Vector3.DivideScalar",
         "s": "DivideScalar(value)",
         "d": "逐分量相除，返回新 Vector3。除数分量为 0 时结果会是无穷，调用前自己判一下。",
         "p": [
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Vector3.Dot",
         "s": "Dot(value)",
         "d": "与另一个向量做点积，返回标量。可以拿来判断两个方向是否同向。",
         "p": [
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Vector3.Magnitude",
         "s": "Magnitude()",
         "d": "返回向量的长度（模），也就是三个分量平方和再开根号。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Vector3.MulScalar",
         "s": "MulScalar(value)",
         "d": "逐分量相乘，返回新 Vector3。注意源码实现是 x·x、y·y、z·z，不是乘同一个标量。",
         "p": [
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      },
      {
         "c": "misc",
         "n": "Vector3.Normalize",
         "s": "Normalize()",
         "d": "就地归一化：把自身缩放到单位长度。注意它**不返回新对象**，直接改自己的 x/y/z。",
         "p": []
      },
      {
         "c": "misc",
         "n": "Vector3.Sub",
         "s": "Sub(value)",
         "d": "两个向量相减，返回一个新的 Vector3，不修改自身。",
         "p": [
            [
               "value",
               "任意",
               "要写入的值"
            ]
         ]
      }
   ],
   "objects": [
      {
         "g": "core",
         "n": "world",
         "t": "核心系统",
         "d": "引擎的全局总控物件 —— persistent 为 true（跨房间常驻）、visible 为 false、无父物体无精灵，全局只此一个。整个引擎由它串起来，要改全局行为先来这里：① Game Start 事件里初始化全部 9 个子系统（Anim / Shop / Input / Item / Storage / Encounter / BGM / Dialog / Demo）、写入默认键位（确认 = Enter 与 Z、取消 = Shift 与 X、菜单 = Ctrl 与 C、方向键），再创建 camera / fader / border / closed_captions 四个常驻单例，最后 room_goto_next() 进入游戏；② Step 事件里每帧驱动 Time_Step / Anim_Step / BGM_Step 三大系统，顺带累加存档里的游玩秒数、处理跳帧，并监听 F2 重开游戏、F4 切换全屏；③ Game End 事件里反向反初始化各子系统，CleanUp 里释放 global.surface_gui。它还持有 blur_strength / classic_ui / Panel / kr 等一批全局开关。",
         "v": [
            [
               "_time",
               "秒计时累加器（内部）。Step 里每帧加上 global.delta_time_factor，累计满 1 秒（GAME_FPS 帧）就清零，并给存档里的游玩时间 FLAG_STATIC_TIME 加 1。"
            ],
            [
               "_frame_skip",
               "跳帧计数器（内部）。记录自上次真正渲染以来累积了多少帧，达到 Game_GetFrameSkip() 的阈值就渲染一帧并清零。"
            ],
            [
               "_frame_skipped",
               "已跳过的帧总数（内部保留字段，当前主循环未使用）。"
            ],
            [
               "global.blur_strength",
               "全局模糊强度，数组 [横向, 纵向]。两个分量分别控制横、竖方向的模糊量，默认 [0,0] 即不模糊。"
            ],
            [
               "global.blur_amount",
               "全局模糊程度，与 blur_strength 配合使用，默认 0。"
            ],
            [
               "global.classic_ui",
               "是否启用经典 UI 布局，默认 0（新版）。改成 1 可切回老式界面。"
            ],
            [
               "global.Panel",
               "FIGHT 攻击条使用的外观物件（见 Battle_SetMenuFightPanel），默认 battle_menu_fight_knife。换成别的物件即可改攻击条造型。"
            ],
            [
               "global.kr",
               "是否启用 KR（业报）机制，默认 1。为假时 Player_SetKr() 不会写入任何值。"
            ],
            [
               "global.surface_gui",
               "GUI 层渲染用的 surface，创建时尺寸 640×480，物件 CleanUp 时被 surface_free() 释放。"
            ]
         ],
         "hot": true
      },
      {
         "g": "core",
         "n": "battle",
         "t": "核心系统",
         "d": "战斗系统的总控物件 —— 整场战斗的状态机、菜单、回合与结算全都由它持有。它按 BATTLE_STATE 推进流程：MENU（选 FIGHT / ACT / ITEM / MERCY）→ DIALOG（菜单提示或对话）→ TURN_PREPARATION（敌人生成与准备）→ IN_TURN（弹幕回合）→ BOARD_RESETTING（框复位）→ RESULT（结算）。敌人通过 User Event 往 _turn_info 里写行动参数，它再读出来执行；玩家的 ATK / DEF / SPD 在本回合的临时增减存在 _player_temp_* 里，回合结束即失效。所有 Battle_Set* / Battle_Get* 系列函数读写的就是它的这些内部变量。",
         "v": [
            [
               "_encounter",
               "当前遭遇战编号，创建时从临时存储 FLAG_TEMP_ENCOUNTER 读入。"
            ],
            [
               "_enemy_object",
               "当前敌人的物件索引（取遭遇表第 0 个槽位）。"
            ],
            [
               "_heal",
               "本回合敌人打算给自己回复的血量。"
            ],
            [
               "_hp",
               "当前敌人的生命值。"
            ],
            [
               "_kr",
               "当前敌人的 KR（业报）值。"
            ],
            [
               "damage",
               "伤害数值。；伤害累计与KR计时"
            ],
            [
               "_enemy",
               "当前敌人实例，noone 表示尚未生成。"
            ],
            [
               "_enemy_name",
               "敌人的显示名，战斗文本里用它称呼敌人。"
            ],
            [
               "_enemy_spareable",
               "敌人当前是否已经满足饶恕条件（血量为零或剧情允许）。"
            ],
            [
               "_enemy_action_number",
               "敌人本回合选中的行动编号。"
            ],
            [
               "_enemy_action_name",
               "敌人本回合行动的显示名，ACT 菜单里会显示它。"
            ],
            [
               "_enemy_center_pos_x",
               "敌人立绘中心的横坐标，用于把弹幕与特效对准敌人。"
            ],
            [
               "_enemy_center_pos_y",
               "敌人立绘中心的纵坐标，用于把弹幕与特效对准敌人。"
            ],
            [
               "_enemy_def",
               "敌人防御力。越高，玩家这一刀造成的伤害越低。"
            ],
            [
               "_state",
               "战斗状态机当前状态，取自 BATTLE_STATE 枚举（MENU / DIALOG / TURN_PREPARATION / IN_TURN / BOARD_RESETTING / RESULT）。"
            ],
            [
               "_state_next",
               "下一步要切换到的战斗状态，用于延迟一帧再切换。"
            ],
            [
               "_menu",
               "当前菜单页，取自 BATTLE_MENU 枚举（顶层的 FIGHT / ACT / ITEM / MERCY，以及 FIGHT 下的瞄准、挥刀、伤害等子状态）。"
            ],
            [
               "_menu_choice_button",
               "主菜单里选中的按钮（FIGHT / ACT / ITEM / MERCY）。"
            ],
            [
               "_menu_choice_enemy",
               "选中了第几个敌人作为目标。"
            ],
            [
               "_menu_choice_action",
               "ACT 菜单里选中的行动。"
            ],
            [
               "_menu_choice_item",
               "ITEM 菜单里选中的物品。"
            ],
            [
               "_menu_choice_item_first",
               "ITEM 菜单里首次选中的物品，用于关闭后再打开时恢复位置。"
            ],
            [
               "_menu_choice_mercy",
               "MERCY 菜单里选中的选项。"
            ],
            [
               "_menu_choice_mercy_override",
               "是否强制指定 MERCY 菜单的显示内容（覆盖默认的饶恕 / 逃跑）。"
            ],
            [
               "_menu_choice_mercy_override_number",
               "强制指定的 MERCY 选项数量。"
            ],
            [
               "_menu_choice_mercy_override_name",
               "强制指定的 MERCY 选项名称。"
            ],
            [
               "_menu_fleeable",
               "当前战斗是否允许逃跑。"
            ],
            [
               "_menu_mercy_flee_enabled",
               "遭遇表里是否开启了 MERCY 逃脱选项。"
            ],
            [
               "_menu_dialog",
               "菜单状态下要显示的提示文本（来自遭遇表）。"
            ],
            [
               "_menu_fight_damage",
               "FIGHT 里本次攻击造成的伤害值。"
            ],
            [
               "_menu_fight_anim_time",
               "挥刀动画的持续帧数。"
            ],
            [
               "_menu_fight_damage_time",
               "伤害数字在屏幕上停留的帧数。"
            ],
            [
               "_menu_item_used_last",
               "上一回合最后使用的物品索引，-1 表示没有。"
            ],
            [
               "_turn_number",
               "当前是第几回合。"
            ],
            [
               "_turn_info",
               "本回合的敌人行动信息表（ds_map），敌人的 User Event 往里写参数，引擎再读出来执行。"
            ],
            [
               "_dialog",
               "对话框相关实例或开关。"
            ],
            [
               "_dialog_auto_end",
               "对话结束后是否自动推进流程。"
            ],
            [
               "_dialog_enemy_auto_end",
               "敌人对话结束后是否自动推进流程。"
            ],
            [
               "_reward_gold",
               "战斗胜利后给玩家的金币，可累加。"
            ],
            [
               "_reward_exp",
               "战斗胜利后给玩家的经验值，可累加。"
            ],
            [
               "_player_temp_atk",
               "本回合临时附加给玩家的攻击力（增益或减益）。"
            ],
            [
               "_player_temp_def",
               "本回合临时附加给玩家的防御力。"
            ],
            [
               "_player_temp_spd",
               "本回合临时附加给玩家的速度。"
            ],
            [
               "_player_temp_inv",
               "本回合临时附加给玩家的无敌帧数。"
            ],
            [
               "kr_timer",
               "KR 伤害的累计计时器，控制业报伤害何时结算。；伤害累计与KR计时"
            ],
            [
               "hurt_timer",
               "玩家受伤后的无敌计时器，归零前不会再次受伤。；伤害累计与KR计时"
            ],
            [
               "_enemy[3]",
               "三个敌人实例"
            ],
            [
               "_enemy_name[3]",
               "敌人名字"
            ],
            [
               "_enemy_def[3]",
               "敌人防御"
            ],
            [
               "_enemy_spareable[3]",
               "是否可饶恕"
            ],
            [
               "_enemy_action_number[3] / _enemy_action_name[3,6]",
               "ACT 行动"
            ],
            [
               "_enemy_center_pos_x/y[3]",
               "敌人瞄准中心"
            ],
            [
               "_menu / _menu_choice_*",
               "菜单状态与光标"
            ],
            [
               "_dialog[2] / _dialog_auto_end",
               "对话框实例与自动结束开关"
            ],
            [
               "_player_temp_atk/def/spd/inv",
               "玩家临时属性"
            ]
         ],
         "rel": [
            [
               "相关函数",
               [
                  [
                     "Battle_GetState / Battle_SetState",
                     "读写战斗状态"
                  ],
                  [
                     "Battle_SetEnemy / Battle_RemoveEnemy",
                     "增删敌人槽位"
                  ],
                  [
                     "Battle_SetMenu / Battle_SetDialog",
                     "控制菜单与对话"
                  ]
               ]
            ]
         ]
      },
      {
         "g": "core",
         "n": "battle_bg",
         "t": "核心系统",
         "d": "战斗背景。战斗中铺在框后面的底图，创建时会用一个 120 帧的补间把它从屏幕外滑到预定位置，做出「场景切入」的观感。",
         "v": [
            [
               "a",
               "透明度，默认 0"
            ],
            [
               "image_xscale",
               "横向拉伸倍数，创建时设为 1000 用来横向铺满"
            ],
            [
               "（补间）",
               "创建时对 y 做 Anim_Create，从当前位置滑到 480 - y，历时 120 帧"
            ]
         ]
      },
      {
         "g": "core",
         "n": "battle_board",
         "t": "核心系统",
         "d": "战斗框 —— 弹幕回合里圈住灵魂的那个白框，战斗的一切都发生在它里面。x/y 是中心，up/down/left/right 是四边延伸距离（不是宽高），angle 是旋转角。绘制用了多层 surface 做旋转与遮罩，底色与边框都可调。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "_surface",
               "战斗框主渲染 surface，背景与内容都画在它上面。；用于旋转与遮罩的多个 surface，改绘制时要小心"
            ],
            [
               "_surface_bg",
               "战斗框背景的离屏 surface。"
            ],
            [
               "_surface_board_extra",
               "战斗框附加装饰层的 surface。"
            ],
            [
               "_surface_board_cover",
               "战斗框最上层遮盖层的 surface。"
            ],
            [
               "_surface_mask",
               "战斗框遮罩用的 surface，用来裁掉超出战斗框的部分。；用于旋转与遮罩的多个 surface，改绘制时要小心"
            ],
            [
               "x",
               "物件在房间里的横坐标。；战斗框中心坐标，默认 BATTLE_BOARD.X / .Y"
            ],
            [
               "y",
               "物件在房间里的纵坐标。；战斗框中心坐标，默认 BATTLE_BOARD.X / .Y"
            ],
            [
               "up",
               "向上延伸的距离（注意不是高度）。战斗框用它与中心点算出上边界，对话框的上边界同理。"
            ],
            [
               "down",
               "向下延伸的距离（不是高度）。"
            ],
            [
               "left",
               "向左延伸的距离（不是宽度）。"
            ],
            [
               "right",
               "向右延伸的距离（不是宽度）。"
            ],
            [
               "angle",
               "战斗框当前的旋转角度。"
            ],
            [
               "color_bg",
               "战斗框底色。；战斗框内底色与透明度（打雷、闪白用）"
            ],
            [
               "alpha_bg",
               "战斗框底色的透明度。；战斗框内底色与透明度（打雷、闪白用）"
            ],
            [
               "color_frame",
               "战斗框边框颜色。"
            ],
            [
               "mainboard",
               "主战斗框实例，多框叠加时用"
            ],
            [
               "edge",
               "是否显示边缘描边（受 classic_ui 影响）"
            ],
            [
               "alpha_frame",
               "战斗框边框的透明度。"
            ],
            [
               "_angle",
               "战斗框旋转的内部角度值，用于插值。"
            ],
            [
               "global.boards_array",
               "当前场景里所有战斗框的数组。"
            ],
            [
               "global.boards_controller_array",
               "各战斗框对应控制物件的数组，与 boards_array 一一对应。"
            ],
            [
               "global.board_uid",
               "战斗框编号的自增计数器，每新建一个框 +1，用来保证编号唯一。"
            ]
         ],
         "hot": true
      },
      {
         "g": "bullet",
         "n": "battle_bullet",
         "t": "弹幕",
         "d": "所有弹幕的父物体。自带与灵魂的碰撞检测，碰撞后调 event_user(10) = SOUL_COLLISION、event_user(11) = TURN_END。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "angle",
               "角度，单位为度。"
            ],
            [
               "follow",
               "是否启用跟随某个目标。"
            ],
            [
               "_y",
               "弹幕生成时记录的初始纵坐标，用于计算相对位移与跟随。"
            ],
            [
               "_x",
               "弹幕生成时记录的初始横坐标，用于计算相对位移与跟随。"
            ],
            [
               "duration",
               "存活帧数，-1永久"
            ],
            [
               "auto_destroy",
               "回合结束销毁"
            ],
            [
               "out",
               "可否超出框"
            ],
            [
               "_vspeed",
               "生成时记录的初始纵向速度，用于跟随重算。"
            ],
            [
               "_hspeed",
               "生成时记录的初始横向速度，用于跟随重算。"
            ],
            [
               "_speed",
               "弹幕自身的移动速度。"
            ],
            [
               "_direction",
               "弹幕的移动方向角度。"
            ],
            [
               "type",
               "伤害类型 0~4"
            ],
            [
               "disposable",
               "撞一次就销毁"
            ],
            [
               "follow_board",
               "是否跟随战斗框的位移与旋转，使物件在框晃动时保持相对位置。"
            ],
            [
               "follow_angle",
               "跟随时的角度偏移。"
            ],
            [
               "follow_x",
               "跟随目标的横坐标偏移量。"
            ],
            [
               "follow_y",
               "跟随目标的纵坐标偏移量。"
            ],
            [
               "follow_target",
               "要跟随的目标物件，noone 表示无目标。"
            ],
            [
               "center_x",
               "中心的横坐标，旋转与绘制以它为基准。"
            ],
            [
               "center_y",
               "中心的纵坐标，旋转与绘制以它为基准。"
            ],
            [
               "rotate",
               "旋转速度"
            ],
            [
               "_angle",
               "弹幕当前角度。"
            ],
            [
               "point_at",
               "是否让精灵朝向某个目标。"
            ],
            [
               "angle_offset",
               "自动朝向时的角度偏移，默认 180。"
            ],
            [
               "processed",
               "本帧是否已经做过伤害判定，避免同帧重复扣血。"
            ],
            [
               "path_function",
               "自定义运动函数"
            ],
            [
               "hspeed / vspeed",
               "速度"
            ],
            [
               "point / point_at",
               "尖端贴图与朝向"
            ]
         ],
         "hot": true
      },
      {
         "g": "bullet",
         "n": "battle_bullet_arrow",
         "t": "弹幕",
         "d": "箭头骨。多出 scale（缩放）、extra_angle（张开角，默认30）、range（射程）。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "_distance",
               "设定的作用距离，单位像素。；射程与初始距离，默认 500"
            ],
            [
               "_dir",
               "箭头弹幕的飞行方向。"
            ],
            [
               "_direction",
               "箭头弹幕的朝向角度。"
            ],
            [
               "_speed",
               "箭头弹幕的飞行速度。"
            ],
            [
               "type",
               "伤害类型"
            ],
            [
               "range",
               "触发或作用范围，单位像素。；射程与初始距离，默认 500"
            ],
            [
               "scale",
               "缩放倍数，默认 0.5"
            ],
            [
               "extra_angle",
               "张开角，默认 30"
            ]
         ]
      },
      {
         "g": "bullet",
         "n": "battle_bullet_bone",
         "t": "弹幕",
         "d": "骨头。继承 battle_bullet，用 spr_bone / spr_bone_1 拉伸绘制（image_xscale = (length+10)/14）。",
         "v": [
            [
               "length",
               "骨头长度"
            ],
            [
               "type",
               "骨头类型，取自 BONE_TYPE 枚举（普通 / 绿骨等），决定它能否被穿过或必须躲开。"
            ],
            [
               "out",
               "出屏判定标志。物件跑出战斗框后由引擎置位，表示它已经离开可玩区域。"
            ],
            [
               "rotate",
               "是否随移动方向自动旋转精灵。"
            ],
            [
               "point",
               "1 = 用带尖端贴图"
            ]
         ]
      },
      {
         "g": "bullet",
         "n": "battle_bullet_bone_3d",
         "t": "弹幕",
         "d": "3D 骨头。用 anglex/y/z、angxs/ys/zs、scalex/y/z 控制三维姿态，shape 控制形状，gap 控制间距。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "enable",
               "是否参与绘制"
            ],
            [
               "vert_list",
               "顶点列表，每个元素是一个 [x, y, z] 三元组。；顶点与棱的缓存表，改形状时由内部函数维护"
            ],
            [
               "vert_list_draw",
               "变换后用于绘制的顶点列表。"
            ],
            [
               "edge_list",
               "边列表，记录哪些顶点之间需要连线。；顶点与棱的缓存表，改形状时由内部函数维护"
            ],
            [
               "anglex",
               "绕 X 轴的旋转角度。"
            ],
            [
               "angley",
               "绕 Y 轴的旋转角度。"
            ],
            [
               "anglez",
               "绕 Z 轴的旋转角度。"
            ],
            [
               "angxs",
               "绕 X 轴的旋转速度（每帧增量）。"
            ],
            [
               "angys",
               "绕 Y 轴的旋转速度。"
            ],
            [
               "angzs",
               "绕 Z 轴的旋转速度。"
            ],
            [
               "scalex",
               "三维模型在 X 轴方向的缩放倍数。"
            ],
            [
               "scaley",
               "三维模型在 Y 轴方向的缩放倍数。"
            ],
            [
               "scalez",
               "三维模型在 Z 轴方向的缩放倍数。"
            ],
            [
               "shape",
               "形状：0 立方体 / 1 正四面体 / 2 正八面体 / 3 正十二面体 / 4 正二十面体"
            ],
            [
               "out",
               "3D 骨是否已经跑出可视范围。"
            ],
            [
               "type",
               "3D 骨的类型编号。"
            ],
            [
               "gap",
               "中间留空宽度，默认 40"
            ]
         ]
      },
      {
         "g": "bullet",
         "n": "battle_bullet_gb",
         "t": "弹幕",
         "d": "加斯特冲击波（俗称龙骨炮，Gaster Blaster）。内部有 blaster 结构体（龙骨炮本体）、state 状态机，以及 time_move / time_delay / time_blast 三个时间参数控制蓄力到发射的节奏。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "image_xscale",
               "横向缩放（GameMaker 内置）。1 = 原始大小，负数会水平翻转。"
            ],
            [
               "image_yscale",
               "纵向缩放（GameMaker 内置）。1 = 原始大小，负数会垂直翻转。"
            ],
            [
               "_blaster_yscale",
               "冲击波炮身的纵向缩放，发射时会被拉长。"
            ],
            [
               "target_x",
               "目标点的横坐标。"
            ],
            [
               "target_y",
               "目标点的纵坐标。"
            ],
            [
               "target_angle",
               "朝向目标的角度。"
            ],
            [
               "state",
               "内部状态机：待机 → 转向 → 蓄力 → 发射 → 退出"
            ],
            [
               "timer_move",
               "移动阶段已经进行的帧数。"
            ],
            [
               "timer_blast",
               "发射阶段已经进行的帧数。"
            ],
            [
               "timer_exit",
               "退场阶段已经进行的帧数。"
            ],
            [
               "time_move",
               "转位移动的帧数，默认 30"
            ],
            [
               "time_delay",
               "蓄力停顿的帧数，默认 16"
            ],
            [
               "time_blast",
               "激光持续帧数，默认 10"
            ],
            [
               "time_stay",
               "发射后停留帧数"
            ],
            [
               "charge_sound",
               "蓄力时是否播放音效。"
            ],
            [
               "blast_sound",
               "发射时是否播放音效。"
            ],
            [
               "destroy",
               "标记为待销毁"
            ],
            [
               "blaster",
               "龙骨炮（Gaster Blaster）结构体（方向、速度、贴图、坐标、缩放、颜色、透明度）"
            ]
         ],
         "hot": true
      },
      {
         "g": "bullet",
         "n": "battle_bullet_test",
         "t": "弹幕",
         "d": "弹幕测试物件，继承自 battle_bullet。引擎自带的调试样例，用来验证弹幕能否正常生成、移动与销毁，写自己的弹幕时可以先照着它改。",
         "v": [
            [
               "（继承）",
               "本身不定义变量，全部行为沿用 battle_bullet，只挂了一个 spr_default 精灵用于观察位置"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_button",
         "t": "界面",
         "d": "主菜单四个按钮的基类。负责绘制、光标高亮与按下反馈；本身不参与菜单逻辑，实际用的是下面四个子物体。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "_button_slot",
               "按钮位置编号（0~3 = FIGHT / ACT / ITEM / MERCY）"
            ],
            [
               "alpha",
               "透明度，当前选中的按钮会拉到 1，其余压暗"
            ]
         ],
         "rel": [
            [
               "子物体",
               [
                  [
                     "battle_button_fight",
                     "FIGHT 按钮"
                  ],
                  [
                     "battle_button_act",
                     "ACT 按钮"
                  ],
                  [
                     "battle_button_item",
                     "ITEM 按钮"
                  ],
                  [
                     "battle_button_mercy",
                     "MERCY 按钮"
                  ]
               ]
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_button_act",
         "t": "界面",
         "d": "ACT 按钮。贴图 spr_battle_button_act，以 battle_button 为父物体。",
         "v": [
            [
               "_button_slot",
               "本按钮在战斗菜单里的槽位序号，ACT 固定为 1。父物体 battle_button 依据这个序号决定按钮摆在哪、以及何时算作被选中。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_button_fight",
         "t": "界面",
         "d": "FIGHT 按钮。贴图 spr_battle_button_fight，以 battle_button 为父物体继承光标与反馈逻辑。",
         "v": [
            [
               "_button_slot",
               "本按钮在战斗菜单里的槽位序号，FIGHT 固定为 0，也就是最左边那一个。父物体据此摆位并处理高亮。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_button_item",
         "t": "界面",
         "d": "ITEM 按钮。贴图 spr_battle_button_item，以 battle_button 为父物体。",
         "v": [
            [
               "_button_slot",
               "本按钮在战斗菜单里的槽位序号，ITEM 固定为 2。父物体据此摆位，Step 事件里再用它判断当前是否被选中。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_button_mercy",
         "t": "界面",
         "d": "MERCY 按钮。贴图 spr_battle_button_mercy，以 battle_button 为父物体。",
         "v": [
            [
               "_button_slot",
               "本按钮在战斗菜单里的槽位序号，MERCY 固定为 3，也就是最右边那一个。父物体据此摆位并处理高亮。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_damage",
         "t": "界面",
         "d": "伤害数字与血条 —— 打在敌人身上时弹出的那个红色数字，以及敌人血量的动态条都由它绘制。数字会做弹跳动画（yscale / gra / vsp 控制下落的物理），血条则从 bar_hp_original 平滑动画到 bar_hp_target，时长由 bar_duration 决定，中途实际显示的中间值存在 _bar_hp。停留时间由 display_time 控制；不想要血条，把 bar_visible 关掉即可。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "visible",
               "是否绘制（GameMaker 内置）。为 false 时物件仍存在、仍会跑事件，只是不画出来。"
            ],
            [
               "yscale",
               "纵向缩放，伤害数字的弹跳动画会改它。"
            ],
            [
               "alpha",
               "透明度，0 = 完全透明，1 = 完全不透明。"
            ],
            [
               "damage",
               "要显示的数字"
            ],
            [
               "color",
               "数字颜色，默认 c_red"
            ],
            [
               "display_time",
               "停留帧数，默认 GAME_FPS（约 1 秒）"
            ],
            [
               "bar_visible",
               "是否同时显示血条动画"
            ],
            [
               "bar_width",
               "血条的像素宽度。；血条宽度与滚动时长，默认 100 / 45"
            ],
            [
               "bar_hp_max",
               "血条对应的最大生命值。"
            ],
            [
               "bar_hp_original",
               "血条动画开始时的生命值。"
            ],
            [
               "bar_hp_target",
               "血条要动到的目标生命值。"
            ],
            [
               "bar_duration",
               "血条动画的持续帧数。；血条宽度与滚动时长，默认 100 / 45"
            ],
            [
               "_bar_hp",
               "血条当前实际显示的中间值，介于原始值与目标值之间。"
            ],
            [
               "gra",
               "伤害数字下落的重力加速度。"
            ],
            [
               "vsp",
               "伤害数字的纵向速度。"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ],
            [
               "alarm[0]",
               "存活倒计时，触发后自动销毁"
            ]
         ]
      },
      {
         "g": "fx",
         "n": "battle_death_particle",
         "t": "特效",
         "d": "敌人被击败时炸开的碎片粒子。接受精灵与缩放参数，配合速度做抛物散落，是「怪物碎成渣」效果的单片。",
         "v": [
            [
               "sprite",
               "使用的碎片精灵，-1 表示用默认"
            ],
            [
               "scale_x",
               "横向缩放，默认 1"
            ],
            [
               "_ps",
               "粒子系统实例。"
            ],
            [
               "_p",
               "单个粒子的实例。"
            ],
            [
               "_surface",
               "粒子绘制用的离屏 surface。"
            ],
            [
               "_inst",
               "死亡粒子系统的控制实例。"
            ],
            [
               "_line",
               "当前所在行号。"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ]
         ]
      },
      {
         "g": "fx",
         "n": "battle_death_particle_collision",
         "t": "特效",
         "d": "死亡碎片的碰撞体。本身不绘制，只负责给碎片提供落点判定，让碎片能砸在地面或平台上而不是穿过去。",
         "v": [
            [
               "（继承）",
               "无自有变量与事件，纯碰撞占位物件"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_dialog_enemy",
         "t": "界面",
         "d": "敌人对话框 —— 战斗中敌人说话时弹在敌人旁边的那个带尖角的框。它把文本交给内部的打字机实例逐字打印（_inst），并按 dir 决定框子朝哪边伸尖角（show_spike），wide_spike 可切换加宽版。四边界（up / down / left / right）与文字偏移（text_offset_x / text_offset_y）都可调，用来适配不同体型的敌人。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "visible",
               "是否绘制（GameMaker 内置）。为 false 时物件仍存在、仍会跑事件，只是不画出来。"
            ],
            [
               "text",
               "气泡里要显示的文字"
            ],
            [
               "dir",
               "气泡尖角朝向：DIR.LEFT / RIGHT / UP / DOWN"
            ],
            [
               "show_spike",
               "是否显示对话框两侧的尖角。"
            ],
            [
               "wide_spike",
               "尖角是否使用加宽版。"
            ],
            [
               "up",
               "向上延伸的距离（注意不是高度）。战斗框用它与中心点算出上边界，对话框的上边界同理。；气泡四边相对锚点的延伸距离"
            ],
            [
               "down",
               "向下延伸的距离（不是高度）。；气泡四边相对锚点的延伸距离"
            ],
            [
               "left",
               "向左延伸的距离（不是宽度）。；气泡四边相对锚点的延伸距离"
            ],
            [
               "right",
               "向右延伸的距离（不是宽度）。；气泡四边相对锚点的延伸距离"
            ],
            [
               "template",
               "气泡样式模板编号"
            ],
            [
               "text_offset_x",
               "文字相对物件位置的横向偏移。；文字相对气泡的偏移"
            ],
            [
               "text_offset_y",
               "文字相对物件位置的纵向偏移。；文字相对气泡的偏移"
            ],
            [
               "fast",
               "true = 文字瞬显（不逐字打）"
            ],
            [
               "_inst",
               "内部创建的 text_typer 实例"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ]
         ]
      },
      {
         "g": "core",
         "n": "battle_enemy",
         "t": "核心系统",
         "d": "所有敌人的父物体。事件通过 User Event 0~13 回调，与 BATTLE_ENEMY_EVENT 枚举一一对应：IDE 里的 User Event 编号 = 枚举值（INIT=0 … BOARD_RESETTING_END=13），对应 .yy 事件文件 Other_10~Other_23。",
         "v": [
            [
               "depth",
               "绘制深度。创建时设为 DEPTH_BATTLE.ENEMY，保证敌人画在战斗框之上、UI 之下。"
            ],
            [
               "_enemy_slot",
               "本敌人占用的敌人槽位编号，默认 -1 表示尚未分配。回合结算、血条显示、攻击归属都靠它来对应到具体的敌人。"
            ]
         ],
         "rel": [
            [
               "事件映射（必须记住）",
               [
                  [
                     "event_user(10)",
                     "INIT — 敌人出场，设置名字/DEF/行动"
                  ],
                  [
                     "event_user(11)",
                     "BATTLE_START — 战斗开始"
                  ],
                  [
                     "event_user(12)",
                     "MENU_START — 进入菜单"
                  ],
                  [
                     "event_user(13)",
                     "MENU_SWITCH — 切换菜单"
                  ],
                  [
                     "event_user(14)",
                     "MENU_CHOICE_SWITCH — 菜单光标移动"
                  ],
                  [
                     "event_user(15)",
                     "MENU_END — 菜单结束"
                  ],
                  [
                     "event_user(16)",
                     "DIALOG_START — 对话开始"
                  ],
                  [
                     "event_user(17)",
                     "DIALOG_END — 对话结束"
                  ],
                  [
                     "event_user(18)",
                     "TURN_PREPARATION_START — 回合准备开始（设回合参数！）"
                  ],
                  [
                     "event_user(19)",
                     "TURN_PREPARATION_END — 回合准备结束"
                  ],
                  [
                     "event_user(20)",
                     "TURN_START — 回合开始（放弹幕！）"
                  ],
                  [
                     "event_user(21)",
                     "TURN_END — 回合结束"
                  ],
                  [
                     "event_user(22)",
                     "BOARD_RESETTING_START — 框复位开始"
                  ],
                  [
                     "event_user(23)",
                     "BOARD_RESETTING_END — 框复位结束"
                  ]
               ]
            ],
            [
               "变量",
               [
                  [
                     "_enemy_slot",
                     "自己在哪个槽位（0~2）"
                  ],
                  [
                     "depth",
                     "默认 DEPTH_BATTLE.ENEMY"
                  ]
               ]
            ]
         ],
         "hot": true
      },
      {
         "g": "core",
         "n": "battle_enemy_test",
         "t": "核心系统",
         "d": "引擎自带的演示敌人，继承自 battle_enemy，无精灵、无自有变量。它在 User Event 8（TURN_PREPARATION_START）里每回合生成 turn_test 演示物体：矩形战斗框 + 蓝色灵魂，回合里按空格 / 左 Alt / 小键盘 0 分别体验骨头长度动画、紫色灵魂轨道、龙骨炮齐射。引擎默认遭遇 0 的 enemy_0 就是它，Encounter_Start(0) 即可直接跑通遭遇战。",
         "v": [
            [
               "（继承）",
               "无自有变量；仅有的逻辑是 User Event 8（TURN_PREPARATION_START）里生成 turn_test 演示物体"
            ]
         ]
      },
      {
         "g": "fx",
         "n": "battle_fader",
         "t": "特效",
         "d": "战斗专用黑幕，层级由 DEPTH_BATTLE.FADER 决定，保证盖在框与 UI 之上。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "color",
               "黑幕颜色，默认 c_black"
            ],
            [
               "alpha",
               "当前透明度"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_menu_fight",
         "t": "界面",
         "d": "FIGHT 攻击条的主控。创建时会自动对齐到 battle_board 中心，负责瞄准、挥刀与伤害结算三个阶段。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "x",
               "物件在房间里的横坐标。；自动对齐到 battle_board 的中心点"
            ],
            [
               "y",
               "物件在房间里的纵坐标。；自动对齐到 battle_board 的中心点"
            ]
         ],
         "rel": [
            [
               "FIGHT 三个阶段（User Event）",
               [
                  [
                     "event_user(10)",
                     "ANIM —— 播放挥刀动画"
                  ],
                  [
                     "event_user(11)",
                     "AIM —— 瞄准条左右移动阶段"
                  ],
                  [
                     "event_user(12)",
                     "DAMAGE —— 判定命中并显示伤害"
                  ]
               ]
            ]
         ],
         "hot": true
      },
      {
         "g": "ui",
         "n": "battle_menu_fight_anim_knife",
         "t": "界面",
         "d": "挥刀动画的专用物件。只负责「刀挥下去」这一段演出，播放完毕即自行销毁，不参与瞄准与判定。",
         "v": [
            [
               "depth",
               "绘制深度。创建时被设为 DEPTH_BATTLE.UI，保证挥刀动画盖在战斗框之上。"
            ],
            [
               "image_speed",
               "帧动画播放速度，创建时设为 1，表示每帧推进一帧动画。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_menu_fight_hp_bar",
         "t": "界面",
         "d": "FIGHT 界面右下角的玩家 HP 条。命中后会播放血条从旧值滚到新值的动画，让扣血看得见。",
         "v": [
            [
               "depth",
               "绘制深度，创建时设为 DEPTH_BATTLE.UI_HIGH，压在普通 UI 之上。"
            ],
            [
               "enemy_slot",
               "本血条对应第几个敌人，默认 -1 表示尚未指定，需要外部赋值为敌人槽位。"
            ],
            [
               "width",
               "血条的像素宽度，默认 101。"
            ],
            [
               "hp_max",
               "该敌人的最大生命值，默认 0，用于换算血条填充比例。"
            ],
            [
               "hp",
               "该敌人当前生命值，默认 0。它除以 hp_max 决定血条画多长。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "battle_menu_fight_knife",
         "t": "界面",
         "d": "FIGHT 的刀本体。以 battle_menu_fight 为父物体，负责瞄准条的移动、按键判定与命中时机。",
         "v": [
            [
               "_dir",
               "挥刀方向，创建时从 DIR.LEFT 与 DIR.RIGHT 中随机取一个，决定刀从哪一侧扫入。"
            ],
            [
               "_input_acceptable",
               "当前是否还接受玩家的瞄准输入，默认 true，砍出去之后会置为 false。"
            ],
            [
               "_aim_x",
               "瞄准线当前所在的横坐标，会随 Aim 动画来回移动。"
            ],
            [
               "_aim_image",
               "瞄准线使用的动画编号，用于在瞄准动画之间切换。"
            ]
         ]
      },
      {
         "g": "core",
         "n": "battle_menu_item_dot",
         "t": "核心系统",
         "d": "ITEM 菜单滚动条两端的装饰圆点。纯视觉元素，让滚动条看起来有头有尾，不参与任何交互逻辑。",
         "v": [
            [
               "（继承）",
               "无自有变量，位置由滚动条驱动"
            ]
         ]
      },
      {
         "g": "core",
         "n": "battle_menu_item_scrollbar",
         "t": "核心系统",
         "d": "物品栏滚动条 —— ITEM 菜单右侧那条用来表示「还有很多物品」的竖条。它按背包物品总数（NUMBER）决定要画几段，yd 是它的纵向基准位置，yy 数组保存每一段的纵坐标，上下两端由 yy1 / yy2 界定；经典 UI 模式下会改为居中排布。透明度和能否被操作分别由 alpha 与 moveable 控制。",
         "v": [
            [
               "depth",
               "绘制深度，设为 DEPTH_BATTLE.UI_HIGH"
            ],
            [
               "x",
               "物件在房间里的横坐标。；滚动条位置，默认贴在框右边缘内侧"
            ],
            [
               "y",
               "物件在房间里的纵坐标。；滚动条位置，默认贴在框右边缘内侧"
            ],
            [
               "moveable",
               "是否可移动，默认 0"
            ],
            [
               "_arrow",
               "箭头偏移量，滚动提示动画用。"
            ],
            [
               "NUMBER",
               "物品总数，创建时取 Item_GetNumber()"
            ],
            [
               "alpha",
               "透明度，默认 0，出现时补间到 1"
            ],
            [
               "yy1",
               "滚动条上端的纵坐标。"
            ],
            [
               "yy2",
               "滚动条下端的纵坐标。"
            ],
            [
               "yy",
               "当前高亮段的端点数组"
            ],
            [
               "yd",
               "目标锚点，classic_ui 模式下会重新按物品数居中"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ]
         ]
      },
      {
         "g": "bullet",
         "n": "battle_platform",
         "t": "弹幕",
         "d": "蓝魂跳跃平台。width / angle / sticky / bounce / duration / auto_destroy。",
         "v": [
            [
               "width",
               "平台宽度，默认 48"
            ],
            [
               "sticky",
               "1 = 站上去后随平台一起移动"
            ],
            [
               "bounce",
               "true = 踩上去会弹跳"
            ],
            [
               "angle",
               "平台倾斜角度"
            ],
            [
               "duration",
               "存活帧数，-1 = 永久"
            ]
         ]
      },
      {
         "g": "core",
         "n": "battle_result_flee",
         "t": "核心系统",
         "d": "逃跑成功的过场动画，用 spr_battle_menu_flee 播放。灵魂从框飞出画面，随后战斗结束返回地图。",
         "v": [
            [
               "depth",
               "绘制深度，设为 DEPTH_BATTLE.SOUL（与灵魂同层）"
            ],
            [
               "image_speed",
               "动画速度，已乘 delta_time_factor 做帧率补偿"
            ],
            [
               "x",
               "物件在房间里的横坐标。；创建时对齐到当前灵魂位置"
            ],
            [
               "y",
               "物件在房间里的纵坐标。；创建时对齐到当前灵魂位置"
            ],
            [
               "_ended",
               "该流程是否已经结束，避免重复收尾。"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul",
         "t": "灵魂",
         "d": "灵魂的父物体。子物体包括 red / blue / green / yellow / orange / aqua / purple 七种模式。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "image_speed",
               "帧动画播放速度（GameMaker 内置）。1 = 每帧推进一帧动画，0 = 停在当前帧。"
            ],
            [
               "image_blend",
               "精灵混色（GameMaker 内置）。灵魂就是靠它换色的，例如 c_red / c_blue / c_yellow 直接染出对应颜色。"
            ],
            [
               "init_alpha",
               "灵魂的初始透明度（新版 UI 下为 0.7，否则为 0）。"
            ],
            [
               "moveable",
               "是否可移动"
            ],
            [
               "light_size",
               "灵魂周围光晕的大小。"
            ],
            [
               "index",
               "灵魂序号"
            ],
            [
               "follow_board",
               "是否跟随框"
            ],
            [
               "_inv",
               "无敌帧"
            ],
            [
               "global.moving",
               "全局：玩家本帧是否在动（type 1/2 骨头判定用）"
            ],
            [
               "dir / move / impact",
               "蓝魂：方向/速度/冲击"
            ],
            [
               "jump_state / gravity_jump / gravity_fall / jump_speed / max_speed",
               "蓝魂：跳跃物理参数"
            ],
            [
               "on_block / on_platform / on_board / inst_plat",
               "蓝魂：落地状态"
            ]
         ],
         "hot": true
      },
      {
         "g": "soul",
         "n": "battle_soul_aqua",
         "t": "灵魂",
         "d": "青心模式——可以斜向移动。在红心四个方向的基础上放开斜角，移动自由度最高，常用于需要精细走位的弹幕。",
         "v": [
            [
               "type",
               "模式编号，固定为 1"
            ],
            [
               "moveable",
               "是否允许玩家移动，默认 true"
            ],
            [
               "image_blend",
               "染成青色 c_aqua"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul_blue",
         "t": "灵魂",
         "d": "蓝心模式——重力 + 跳跃，横版平台玩法。灵魂会往下掉，只有踩到平台或地面才能再跳，需要配合 battle_platform 使用。",
         "v": [
            [
               "moveable",
               "是否允许玩家移动，默认 1"
            ],
            [
               "dir",
               "当前朝向，默认 270（向下）"
            ],
            [
               "move",
               "水平输入值 -1 / 0 / 1"
            ],
            [
               "impact",
               "当前下落速度（向下为正）"
            ],
            [
               "on_block",
               "是否正踩在方块上。"
            ],
            [
               "on_platform",
               "是否正踩在平台上。"
            ],
            [
               "on_board",
               "是否正踩在战斗框的边界上。"
            ],
            [
               "jump_state",
               "跳跃状态机，默认 1"
            ],
            [
               "inst_plat",
               "正在踩着的平台实例"
            ],
            [
               "image_blend",
               "染成蓝色 c_blue"
            ],
            [
               "gravity_jump",
               "上升阶段的重力加速度。；起跳与下落的重力加速度，默认 0.15"
            ],
            [
               "gravity_fall",
               "下落阶段的重力加速度。；起跳与下落的重力加速度，默认 0.15"
            ],
            [
               "jump_speed",
               "起跳初速度，默认 4.8"
            ],
            [
               "max_speed",
               "下落速度上限，默认 20"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul_green",
         "t": "灵魂",
         "d": "绿心模式——举盾格挡。灵魂固定在框中央不动，改为用一个 soul_block 当盾牌挡开弹幕，是「防守回合」的玩法。",
         "v": [
            [
               "type",
               "模式编号，固定为 1"
            ],
            [
               "a",
               "创建出的盾牌实例（soul_block）"
            ],
            [
               "image_blend",
               "染成绿色 rgb(0,255,0)"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul_moving_effect",
         "t": "灵魂",
         "d": "灵魂移动时的拖尾残影。灵魂快速移动时留下一串渐隐的影子，让动作看起来更有速度感。",
         "v": [
            [
               "image_blend",
               "染色，默认 c_orange"
            ],
            [
               "depth",
               "绘制深度，设为灵魂层加 1（盖在灵魂之上）"
            ],
            [
               "image_speed",
               "动画速度，默认 0（停在第一帧）"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul_orange",
         "t": "灵魂",
         "d": "橙心模式——受重力下落。与蓝心不同，这里只有持续的重力，没有跳跃，灵魂会被压到底部平面上滑动。",
         "v": [
            [
               "moveable",
               "是否允许玩家移动，默认 true"
            ],
            [
               "dir",
               "朝向，默认 0"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ],
            [
               "image_blend",
               "染成橙色 rgb(248,148,29)"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul_purple",
         "t": "灵魂",
         "d": "紫魂模式 —— 灵魂被限制在几条虚线轨道上移动，只能沿轨道滑动、不能自由飞行。它用 x_on / y_on 记录当前吸附在哪条横 / 竖轨道上，用 x_index / y_index 保存轨道索引；遇到十字路口时用 cross_start / cross_target / cross_step 描述从哪跳到哪、已经走了几步。moving_direction 表示在轨道上的移动方向。",
         "v": [
            [
               "image_blend",
               "染成紫色 rgb(128,0,128)"
            ],
            [
               "x_on",
               "竖向轨道上当前所在的轨道点，noone 表示未激活。"
            ],
            [
               "y_on",
               "横向轨道上当前所在的轨道点。"
            ],
            [
               "cross_step",
               "跳跃跨步的进度"
            ],
            [
               "cross_start",
               "十字轨道的起点。"
            ],
            [
               "cross_target",
               "十字轨道的目标点。"
            ],
            [
               "point",
               "当前所在路径点集"
            ],
            [
               "moving_direction",
               "移动方向"
            ],
            [
               "x_index",
               "竖向轨道的当前索引。"
            ],
            [
               "y_index",
               "横向轨道的当前索引。"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul_red",
         "t": "灵魂",
         "d": "红心模式——最基础的自由移动。上下左右随便走，UNDERTALE 默认玩法。所有其他模式都是在它基础上改移动规则。",
         "v": [
            [
               "image_blend",
               "染成红色 c_red"
            ],
            [
               "moveable",
               "是否允许玩家移动，默认 true"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul_yellow",
         "t": "灵魂",
         "d": "黄心模式——可以朝四个方向射击。灵魂本身移动，额外用确认键发射子弹，适合做需要还击的回合。",
         "v": [
            [
               "moveable",
               "是否允许玩家移动，默认 true"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul_yellow_bullet",
         "t": "灵魂",
         "d": "黄心模式发射的子弹。按下确认键时生成，朝灵魂当前朝向飞出，命中敌人后结算伤害。",
         "v": [
            [
               "（继承）",
               "无自有变量，创建时播放 snd_shoot 音效并设定飞行方向"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "battle_soul_yellow_target",
         "t": "灵魂",
         "d": "黄心模式的瞄准光标。在灵魂前方指示当前射击方向，随玩家操作旋转，让「朝哪打」一目了然。",
         "v": [
            [
               "（继承）",
               "无自有变量，位置与朝向由灵魂实时驱动"
            ]
         ]
      },
      {
         "g": "core",
         "n": "battle_turn",
         "t": "核心系统",
         "d": "回合内计时与状态推进。event_user(10~13) 对应 TURN_PREPARATION_START / _END / TURN_START / TURN_END。",
         "v": [
            [
               "start",
               "本回合起始时刻（帧计数）"
            ],
            [
               "time",
               "本回合已经过的帧数"
            ]
         ]
      },
      {
         "g": "core",
         "n": "battle_ui",
         "t": "核心系统",
         "d": "战斗界面底板。承载战斗区的整体布局，所有战斗 UI 元素都相对它的坐标摆放，改它的位置等于整体挪动战斗界面。",
         "v": [
            [
               "depth",
               "绘制深度，设为 DEPTH_BATTLE.UI"
            ],
            [
               "x",
               "物件在房间里的横坐标。；底板锚点，默认 30 / 401"
            ],
            [
               "y",
               "物件在房间里的纵坐标。；底板锚点，默认 30 / 401"
            ]
         ]
      },
      {
         "g": "core",
         "n": "block",
         "t": "核心系统",
         "d": "顶层阻挡基类，所有「会被墙挡住、会贴边」的实体都继承它。char（角色）与 block_corner 都从这里派生，是地图实体体系的根。",
         "v": [
            [
               "block_enabled",
               "是否启用阻挡判定，默认 true"
            ],
            [
               "pus_hspeedoulEnabled",
               "是否启用被推挤行为（源码里变量名有拼写笔误，沿用原样）"
            ],
            [
               "pus_hspeedoulDirection",
               "被推挤时的方向，默认 DIR.DOWN"
            ]
         ]
      },
      {
         "g": "core",
         "n": "block_corner",
         "t": "核心系统",
         "d": "角落阻挡物，继承自 block。贴在房间四角补上碰撞，防止角色卡进死角或从角落缝隙溜出地图。",
         "v": [
            [
               "（继承）",
               "无自有变量，只需摆好位置，靠父物体的阻挡逻辑生效"
            ]
         ]
      },
      {
         "g": "bullet",
         "n": "bone_arrow",
         "t": "弹幕",
         "d": "箭头形骨头，直接继承 battle_bullet。用 direction 控制飞行方向，适合做直线射出的箭矢，与只能横竖摆放的普通骨头不同，它可以斜着飞。",
         "v": [
            [
               "（继承）",
               "无自有变量，方向靠父物体的 direction / speed 驱动，外观由 Draw 事件自绘"
            ]
         ]
      },
      {
         "g": "bullet",
         "n": "bone_box",
         "t": "弹幕",
         "d": "盒形骨墙 —— 用四面骨墙围出一块可活动区域的经典弹幕。它先登记四条边的端点坐标（x1 / x2 / y1 / y2），再按框当前角度重算出实际绘制用的折线端点（xx1 到 xx4、yy1 到 yy4），所以框旋转时骨墙也能跟着贴合。circle 可切换成圆形布局，follow_board 决定是否跟随框位移，duration 是存活帧数。",
         "v": [
            [
               "duration",
               "存活帧数，默认 10"
            ],
            [
               "color",
               "绘制颜色，默认 255（白）"
            ],
            [
               "x1",
               "盒体上边的起始横坐标。；左边与上边的坐标（相对框中心）"
            ],
            [
               "x2",
               "盒体上边的结束横坐标。"
            ],
            [
               "y1",
               "盒体左边的起始纵坐标。；左边与上边的坐标（相对框中心）"
            ],
            [
               "y2",
               "盒体左边的结束纵坐标。"
            ],
            [
               "xx1",
               "上边墙体重算后的起始横坐标（配合框旋转做偏移修正）。"
            ],
            [
               "xx2",
               "上边墙体重算后的结束横坐标。"
            ],
            [
               "yy1",
               "滚动条上端的纵坐标。"
            ],
            [
               "yy2",
               "滚动条下端的纵坐标。"
            ],
            [
               "xx3",
               "下边墙体重算后的起始横坐标。"
            ],
            [
               "xx4",
               "下边墙体重算后的结束横坐标。"
            ],
            [
               "yy3",
               "右边墙体重算后的起始纵坐标。"
            ],
            [
               "yy4",
               "右边墙体重算后的结束纵坐标。"
            ],
            [
               "angle",
               "角度，单位为度。"
            ],
            [
               "follow_board",
               "盒子是否跟随战斗框位移。"
            ],
            [
               "circle",
               "是否把盒体当作圆形 / 圆角来处理碰撞。"
            ],
            [
               "center_x",
               "中心的横坐标，旋转与绘制以它为基准。"
            ],
            [
               "center_y",
               "中心的纵坐标，旋转与绘制以它为基准。"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ],
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "xx1~xx4 / yy1~yy4",
               "四条边的实际端点，按边分别存了两组坐标"
            ]
         ]
      },
      {
         "g": "bullet",
         "n": "bone_box_round",
         "t": "弹幕",
         "d": "圆角方框骨头，在 bone_box 的基础上把四个角磨圆。视觉上更柔和，适合做科技感或装饰性的包围框。",
         "v": [
            [
               "（继承）",
               "沿用 bone_box 的端点体系，四角由自绘逻辑改成圆弧"
            ]
         ]
      },
      {
         "g": "bullet",
         "n": "bone_circle",
         "t": "弹幕",
         "d": "环形骨弹幕 —— 把骨头沿一个椭圆均匀排成一圈。size_x / size_y 是椭圆的横向与纵向半径，number 是骨头根数，extra_angle 给每根骨头加额外的角度偏移。整圈还能整体旋转：rot 是起始角度，rott 是每帧的旋转速度，roting 控制是否持续旋转。",
         "v": [
            [
               "number",
               "绕成一圈用多少根骨头，默认 10"
            ],
            [
               "size_x",
               "环形椭圆的横向半径。；环的横向与纵向半径，默认 100"
            ],
            [
               "size_y",
               "环形椭圆的纵向半径。；环的横向与纵向半径，默认 100"
            ],
            [
               "length",
               "每根骨头的长度，默认 100"
            ],
            [
               "rot",
               "环形的起始旋转角度。"
            ],
            [
               "rott",
               "环形的旋转速度（每帧增量）。"
            ],
            [
               "roting",
               "是否启用旋转"
            ],
            [
               "type",
               "伤害类型 0~4"
            ],
            [
               "extra_angle",
               "额外角度偏移"
            ],
            [
               "out",
               "1 = 允许飞出框仍在活动"
            ],
            [
               "enable",
               "是否启用该环形"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "border",
         "t": "界面",
         "d": "战斗框边框——围住弹幕区的那圈白线。支持自定义精灵与 Kawase 模糊着色器，可以做「画面失焦、只留边框」的演出。",
         "v": [
            [
               "depth",
               "绘制深度，-9999（画在最前）"
            ],
            [
               "_kawase",
               "Kawase 模糊着色器实例（640×480）"
            ],
            [
               "_enabled",
               "是否启用边框，默认 false"
            ],
            [
               "_sprite",
               "使用的精灵资源，-1 表示暂无。；当前与上一帧使用的边框精灵，-1 表示用默认"
            ],
            [
               "_sprite_previous",
               "上一帧使用的精灵，用于检测精灵是否发生变化。；当前与上一帧使用的边框精灵，-1 表示用默认"
            ],
            [
               "_alpha",
               "边框透明度，默认 1"
            ],
            [
               "blur",
               "模糊强度，默认 0"
            ]
         ]
      },
      {
         "g": "fx",
         "n": "camera",
         "t": "特效",
         "d": "摄像机控制物。负责视角跟随与偏移，让画面能在大地图上移动。地图大于一屏时必须靠它决定看到哪一块。",
         "v": [
            [
               "_camera",
               "创建的镜头视图句柄。"
            ],
            [
               "（继承）",
               "无自有变量，靠 Create 与 Step 里的 follow / 偏移逻辑驱动"
            ]
         ]
      },
      {
         "g": "map",
         "n": "char",
         "t": "地图与商店",
         "d": "地图角色的基类，负责移动、朝向、动画与碰撞。char_player / char_sans / char_save 都以它或它的子类为父物体。",
         "v": [
            [
               "char_id",
               "角色编号，-1 = 未注册"
            ],
            [
               "dir",
               "当前朝向，取值 DIR.UP / DOWN / LEFT / RIGHT"
            ],
            [
               "dir_locked",
               "true = 锁定朝向（演出用）"
            ],
            [
               "talking",
               "角色当前是否在说话，用于驱动表情与动画切换。"
            ],
            [
               "interacting",
               "当前正在交互的对象索引，0 表示没有。"
            ],
            [
               "move_speed",
               "移动速度，单位像素 / 帧。"
            ],
            [
               "move",
               "本帧的移动输入值。"
            ],
            [
               "collision",
               "是否开启碰撞判定。"
            ],
            [
               "_collision_list",
               "本帧检测到的碰撞对象列表。"
            ],
            [
               "res_override",
               "是否由外部代码接管精灵切换，为 true 时引擎不再自动换图。"
            ],
            [
               "_talking_previous",
               "上一帧是否在说话，用于检测说话状态的切换瞬间。"
            ],
            [
               "_dir_previous",
               "上一帧的朝向，用于检测转身。"
            ],
            [
               "_move_previous",
               "上一帧的移动量，用于检测起步与停步。"
            ],
            [
               "move[方向] / move_speed[方向]",
               "四方向移动输入与速度，默认 2"
            ],
            [
               "res_idle_* / res_move_* / res_talk_*",
               "待机 / 行走 / 对话三套动画资源"
            ]
         ],
         "hot": true
      },
      {
         "g": "map",
         "n": "char_box",
         "t": "地图与商店",
         "d": "箱子角色，继承自 char_sign。有打开与关闭两种状态，交互一次就打开，是地图上常见的容器类交互物。",
         "v": [
            [
               "interact",
               "是否已交互过"
            ],
            [
               "open",
               "箱子当前是否打开（0 = 关，1 = 开）"
            ]
         ]
      },
      {
         "g": "map",
         "n": "char_player",
         "t": "地图与商店",
         "d": "玩家的角色物件 —— 继承自 char，是你在世界里操控的那个人。它登记好四个方向的待机与行走精灵（res_idle_sprite / res_move_sprite），并额外持有一组 _moveable_* 开关：分别控制「对话中 / 菜单打开时 / 存档界面 / 传送中 / 商店里 / 遭遇动画中 / 物品框打开时」这七种场景下玩家能否移动。想让玩家在看剧情时乖乖站住，改这些开关即可，不必禁用整个物件。",
         "v": [
            [
               "char_id",
               "玩家角色编号"
            ],
            [
               "res_idle_sprite",
               "待机状态使用的精灵表，按方向分别指定。"
            ],
            [
               "res_move_sprite",
               "行走状态使用的精灵表，按方向分别指定。"
            ],
            [
               "moveable",
               "总开关，false = 完全锁死操作"
            ],
            [
               "_moveable_dialog",
               "对话过程中是否允许移动。"
            ],
            [
               "_moveable_menu",
               "菜单打开时是否允许移动。"
            ],
            [
               "_moveable_save",
               "存档界面中是否允许移动。"
            ],
            [
               "_moveable_warp",
               "传送过程中是否允许移动。"
            ],
            [
               "_moveable_shop",
               "商店中是否允许移动。"
            ],
            [
               "_moveable_encounter",
               "遭遇动画中是否允许移动。"
            ],
            [
               "_moveable_box",
               "被推箱时能否移动"
            ]
         ]
      },
      {
         "g": "map",
         "n": "char_sans",
         "t": "地图与商店",
         "d": "可互动 NPC 示例。父物体是 char_sign，用来演示「一个会说话的地图角色」怎么写。",
         "v": [
            [
               "char_id",
               "角色编号，Sans 固定为 1，供需要区分角色的场合使用。"
            ],
            [
               "dir_locked",
               "是否锁死朝向，默认 false。置为 true 后角色不会因为玩家输入转向。"
            ],
            [
               "res_idle_sprite",
               "待机精灵表，按 DIR.UP / DOWN / LEFT / RIGHT 四个方向分别指定。左右两侧共用同一张向右的图。"
            ],
            [
               "res_move_sprite",
               "行走精灵表，同样按四个方向分别指定，用于角色移动时播放。"
            ],
            [
               "text",
               "该角色首次交互时显示的对话文本，支持换表情、换字体、换颜色、语音等控制标记。"
            ]
         ]
      },
      {
         "g": "map",
         "n": "char_save",
         "t": "地图与商店",
         "d": "存档点。玩家碰到后可存档、读档或返回标题，父物体为 char_sign。",
         "v": [
            [
               "res_idle_speed",
               "待机动画的播放速度。"
            ],
            [
               "res_move_speed",
               "行走动画的播放速度。"
            ],
            [
               "res_talk_speed",
               "说话时表情动画的播放速度。"
            ],
            [
               "res_idle_speed[角度]",
               "四方向待机动画速度"
            ],
            [
               "res_move_speed[角度]",
               "四方向行走动画速度"
            ],
            [
               "res_talk_speed[角度]",
               "四方向对话动画速度"
            ]
         ],
         "hot": true
      },
      {
         "g": "map",
         "n": "char_sign",
         "t": "地图与商店",
         "d": "告示牌基类。char_sans / char_save / char_box 都继承它。定义「一个会在地图上说话、可交互的物件」的基本骨架。",
         "v": [
            [
               "dir_locked",
               "是否锁定朝向，默认 true（牌子不会转身）"
            ],
            [
               "text",
               "交互时显示的文字，默认 \"* It's a sign.\""
            ]
         ]
      },
      {
         "g": "ui",
         "n": "closed_captions",
         "t": "界面",
         "d": "全屏字幕系统 —— 把当前播放的音效与语音以文字形式显示在屏幕下方，方便听障玩家。它用两个队列（_queue_text / _queue_duration）接收待显示的字幕，用四个列表跟踪已经创建的字幕实例与各自的剩余时间，并在字幕更新时做淡入淡出。字幕区域的四边界与基准透明度（_up / _down / _left / _right / _color / _alpha_base）都可以调。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "_x",
               "字幕区域的基准横坐标。；字幕区中心坐标，默认 320 / 400"
            ],
            [
               "_y",
               "字幕区域的基准纵坐标。；字幕区中心坐标，默认 320 / 400"
            ],
            [
               "_up",
               "字幕遮罩上边界的延伸距离。"
            ],
            [
               "_down",
               "字幕遮罩下边界的延伸距离。"
            ],
            [
               "_left",
               "字幕遮罩左边界的延伸距离。"
            ],
            [
               "_right",
               "字幕遮罩右边界的延伸距离。"
            ],
            [
               "_color",
               "颜色值。；底色、当前透明度与基础透明度（默认 0.6）"
            ],
            [
               "_alpha",
               "字幕背景当前透明度，用来做淡入淡出。；底色、当前透明度与基础透明度（默认 0.6）"
            ],
            [
               "_alpha_base",
               "背景的基准透明度，淡入淡出都以它为基准计算。；底色、当前透明度与基础透明度（默认 0.6）"
            ],
            [
               "_queue_text",
               "待显示字幕文本的队列。"
            ],
            [
               "_queue_duration",
               "每条字幕应显示时长的队列，与 _queue_text 一一对应。"
            ],
            [
               "_list_inst",
               "已经创建的字幕实例列表。"
            ],
            [
               "_list_time",
               "每条字幕剩余显示时间的列表。"
            ],
            [
               "_list_destroy_inst",
               "待销毁的字幕实例列表。；待销毁列表，避免边遍历边删"
            ],
            [
               "_list_destroy_time",
               "待销毁字幕的倒计时列表。；待销毁列表，避免边遍历边删"
            ],
            [
               "_showed",
               "是否已经显示过，避免重复触发。；显示状态与上一帧的 _up（用于平滑过渡）"
            ],
            [
               "_up_previous",
               "上一帧的上边界值，用于检测边界变化。；显示状态与上一帧的 _up（用于平滑过渡）"
            ]
         ]
      },
      {
         "g": "core",
         "n": "demo_player",
         "t": "核心系统",
         "d": "录像回放器 —— 把一份录制好的操作录像逐帧重放出来，用于做开场演示或调试复现。它按录制时的随机种子（_seed）还原随机数，从 _input_list 里逐帧取出玩家输入喂给输入系统，同时维护当前帧号（_frame_current）与总帧数（_frame_number）。播放期间会在角落显示一个指示图标（_icon_show_tick 计时）。配合 demo_recorder 使用。",
         "v": [
            [
               "_buffer",
               "待回放的数据缓冲区"
            ],
            [
               "_seed",
               "要还原的随机种子"
            ],
            [
               "_input_number",
               "输入种类数量"
            ],
            [
               "_input_list",
               "要回放的输入列表"
            ],
            [
               "_frame_number",
               "录像的总帧数。"
            ],
            [
               "_frame_current",
               "当前回放到第几帧。"
            ],
            [
               "_paused",
               "是否暂停回放"
            ],
            [
               "_fps",
               "回放帧率"
            ],
            [
               "_icon_show_tick",
               "录制 / 回放指示图标已经显示了多少帧。"
            ],
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ]
         ]
      },
      {
         "g": "core",
         "n": "demo_recorder",
         "t": "核心系统",
         "d": "操作录像机 —— 把玩家的输入与随机种子记录下来存进缓冲区（_buffer），供 demo_player 之后回放。它统计已录制的帧数（_frame_number），并维护一个显示中的录制指示图标（_icon_show_tick）。录制内容不含画面、只含输入与种子，所以体积很小、且回放结果完全可复现。",
         "v": [
            [
               "_buffer",
               "记录输入的缓冲区"
            ],
            [
               "_frame_number",
               "当前记录到第几帧"
            ],
            [
               "_paused",
               "是否暂停录制"
            ],
            [
               "_seed",
               "随机数种子，回放时必须还原"
            ],
            [
               "_icon_show_tick",
               "录制图标显示计时"
            ],
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ]
         ]
      },
      {
         "g": "core",
         "n": "encounter_anim",
         "t": "核心系统",
         "d": "遭遇战开场动画 —— 进入战斗前那段「屏幕变黑 + 灵魂飞入 + 玩家淡出」的转场演出。它按 _encounter 读取遭遇数据，用一组 _draw_* 开关分阶段控制绘制内容（灵魂、玩家、黑幕），_soul_x / _soul_y 是灵魂的起始位置，_exclam 决定是否先弹感叹号，_quick 可切到快速版演出。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "_encounter",
               "要进入的遭遇ID"
            ],
            [
               "_exclam",
               "是否播放「惊讶！」感叹号"
            ],
            [
               "_quick",
               "true = 跳过动画直接进战斗"
            ],
            [
               "_soul_x",
               "灵魂动画的横坐标起点。；灵魂的初始位置（默认 48 / 454）"
            ],
            [
               "_soul_y",
               "灵魂动画的纵坐标起点。；灵魂的初始位置（默认 48 / 454）"
            ],
            [
               "_draw_soul",
               "是否绘制灵魂。"
            ],
            [
               "_draw_soul_x",
               "灵魂当前绘制位置的横坐标。"
            ],
            [
               "_draw_soul_y",
               "灵魂当前绘制位置的纵坐标。"
            ],
            [
               "_draw_player",
               "是否绘制玩家角色。"
            ],
            [
               "_draw_black",
               "是否绘制全屏黑幕。"
            ],
            [
               "_flash",
               "闪白强度"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "exclamation",
         "t": "界面",
         "d": "感叹号提示 —— 触发遭遇战时敌人头顶弹出来的那个「！」。它会在 time 帧内播放出现动画后停留，_time 记录已经显示了多久。默认不自动推进动画（image_speed 为 0），由事件逐帧控制，方便和其他演出对齐。",
         "v": [
            [
               "depth",
               "绘制深度，-1600"
            ],
            [
               "image_speed",
               "动画速度，默认 0（由代码手动切帧）"
            ],
            [
               "time",
               "存活帧数，默认 60"
            ],
            [
               "_time",
               "感叹号已经显示了多久，用来控制它何时消失。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "face",
         "t": "界面",
         "d": "表情立绘系统。按 face_id（角色）与 emotion（情绪）两段索引去取对应表情，既可画在场景里也可画到 GUI 或 surface 上。",
         "v": [
            [
               "face_id",
               "角色编号，-1 表示未设置"
            ],
            [
               "emotion",
               "情绪编号，默认 0（普通）"
            ],
            [
               "gui",
               "true = 画到 GUI 层（不受镜头影响）"
            ],
            [
               "talking",
               "是否处于说话状态（切换到说话帧）"
            ],
            [
               "surface_target",
               "要渲染到的 surface，noone 表示直接画到屏幕"
            ],
            [
               "_emotion_previous",
               "上一帧的表情编号，用于检测表情是否切换。"
            ],
            [
               "_talking_previous",
               "上一帧是否在说话，用于检测说话状态的切换瞬间。"
            ],
            [
               "image_xscale",
               "横向缩放（GameMaker 内置）。1 = 原始大小，负数会水平翻转。；缩放倍数，默认 2"
            ],
            [
               "image_yscale",
               "纵向缩放（GameMaker 内置）。1 = 原始大小，负数会垂直翻转。；缩放倍数，默认 2"
            ],
            [
               "idle_sprite",
               "待机表情使用的精灵。"
            ],
            [
               "idle_image",
               "待机表情当前处在第几帧。"
            ],
            [
               "idle_speed",
               "待机表情的播放速度。"
            ],
            [
               "talk_sprite",
               "说话表情使用的精灵。"
            ],
            [
               "talk_image",
               "说话表情当前处在第几帧。"
            ],
            [
               "talk_speed",
               "说话表情的播放速度。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "face_sans",
         "t": "界面",
         "d": "Sans 专用表情立绘，继承自 face。预设好 Sans 的 face_id 与口型 / 眨眼时序，直接用就能让他说话。",
         "v": [
            [
               "（继承）",
               "无自有变量，face_id 在 Create 里写死为 Sans"
            ]
         ]
      },
      {
         "g": "fx",
         "n": "fader",
         "t": "特效",
         "d": "全屏淡入淡出遮罩 —— 一个铺满屏幕的纯色矩形，用来做转场黑屏或白闪。color 决定颜色，alpha 决定不透明度（0 = 完全透明，1 = 完全不遮）。引擎提供 Fader_Fade() 等函数驱动它做淡入淡出，一般不需要手动改这两个变量。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "color",
               "黑幕颜色，默认 c_black"
            ],
            [
               "alpha",
               "当前透明度，0 = 全透明，1 = 全黑"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "gameover",
         "t": "界面",
         "d": "GAME OVER 画面。显示碎掉的灵魂与「Stay determined」提示，灵魂颜色与位置会从 temp 存储里读回来，保证与死亡瞬间一致。",
         "v": [
            [
               "x",
               "物件在房间里的横坐标。；灵魂位置，读自 Storage_GetTempFlag(FLAG_TEMP_GAMEOVER_SOUL_X/Y)"
            ],
            [
               "y",
               "物件在房间里的纵坐标。；灵魂位置，读自 Storage_GetTempFlag(FLAG_TEMP_GAMEOVER_SOUL_X/Y)"
            ],
            [
               "image_blend",
               "灵魂颜色，读自 FLAG_TEMP_GAMEOVER_SOUL_COLOR"
            ],
            [
               "time",
               "已经滞留的帧数，默认 0"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "gameover_shard",
         "t": "界面",
         "d": "GAME OVER 时灵魂碎裂的碎片。带重力地四散飞出，是「心碎」那一秒的视觉表现。",
         "v": [
            [
               "image_speed",
               "自转速度，已乘 delta_time_factor"
            ],
            [
               "gravity",
               "重力加速度，0.1 × delta_time_factor"
            ],
            [
               "gravity_direction",
               "重力方向，默认 DIR.DOWN"
            ],
            [
               "speed",
               "初速度，3.5 × delta_time_factor"
            ],
            [
               "direction",
               "初速度方向，随机 0~360 度"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "hint_bgm",
         "t": "界面",
         "d": "地图上的 BGM 提示物。踩上去就切换背景音乐，让房间之间的音乐过渡不必写进触发器里，摆一个就生效。",
         "v": [
            [
               "bgm_slot",
               "要操作的 BGM 槽位，默认 0"
            ],
            [
               "bgm",
               "要播放的曲目 ID，-1 表示停止"
            ],
            [
               "pitch",
               "音高，默认 1"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "hint_border",
         "t": "界面",
         "d": "地图上的边框提示物。踩上去就替换屏幕边框样式，用来标记「进入某个区域」的视觉切换。",
         "v": [
            [
               "sprite",
               "要换上的边框精灵，-1 表示用默认"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "hint_half_size",
         "t": "界面",
         "d": "半尺寸提示物。踩上去把场景缩到一半，用来做「进入小房间」或「缩小视野」的演出。",
         "v": [
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ],
            [
               "（继承）",
               "无自有变量，靠 Create 里的闹钟一次性触发缩放"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "hint_landmark",
         "t": "界面",
         "d": "地标提示物。给地图上的关键位置打标记，供存档界面显示所在地点名称，也可以作为传送目标。",
         "v": [
            [
               "landmark_id",
               "地标编号，-1 表示未设置"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "logo",
         "t": "界面",
         "d": "标题 Logo 显示物件。创建时播放 Logo 音效，并用两个闹钟控制出现与停留时间，是开场演出的主角。",
         "v": [
            [
               "_hint",
               "是否显示「按任意键继续」提示，默认 false"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ],
            [
               "alarm[0]",
               "登场时机，默认 200 / delta_time_factor"
            ],
            [
               "alarm[1]",
               "停留结束时机，默认 1200 / delta_time_factor"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "menu",
         "t": "界面",
         "d": "主菜单 —— 游戏开始与暂停时出现的菜单，涵盖开始游戏、继续、设置、重置，以及新档的命名与确认流程。它用一个 _mode 区分大模式（标题 / 命名 / 确认），并为菜单里每一行文字各持有一个文本实例（_inst_begin / _inst_continue / _inst_settings / _inst_lv / _inst_time / _inst_room / _inst_reset 等）。命名界面额外维护选中的字母与命令（_choice_naming_*），确认界面则用一组 _confirm_* 控制名字预览的位置、缩放与旋转。",
         "v": [
            [
               "_menu",
               "当前所在的菜单层级"
            ],
            [
               "_mode",
               "菜单模式"
            ],
            [
               "_prefix",
               "文字格式前缀（即字体与字距标签），套在每条菜单文字前面"
            ],
            [
               "_inst_instruction",
               "「操作说明」文本实例。"
            ],
            [
               "_inst_begin",
               "「开始游戏」文本实例。"
            ],
            [
               "_inst_settings",
               "「设置」文本实例。"
            ],
            [
               "_inst_name",
               "显示名字文本的子物件实例。"
            ],
            [
               "_inst_lv",
               "「LV」数值文本实例。"
            ],
            [
               "_inst_time",
               "「游玩时间」文本实例。"
            ],
            [
               "_inst_room",
               "「当前房间」文本实例。"
            ],
            [
               "_inst_continue",
               "「继续」文本实例。"
            ],
            [
               "_inst_reset",
               "「重置」文本实例。"
            ],
            [
               "_inst_naming_title",
               "命名界面标题的文本实例。"
            ],
            [
               "_inst_naming_letters",
               "命名界面字母表的文本实例。"
            ],
            [
               "_inst_naming_quit",
               "命名界面「退出」的文本实例。"
            ],
            [
               "_inst_naming_backspace",
               "命名界面「退格」的文本实例。"
            ],
            [
               "_inst_naming_done",
               "命名界面「完成」的文本实例。"
            ],
            [
               "_inst_confirm_title",
               "确认界面标题的文本实例。"
            ],
            [
               "_inst_confirm_yes",
               "确认界面「是」的文本实例。"
            ],
            [
               "_inst_confirm_no",
               "确认界面「否」的文本实例。"
            ],
            [
               "_choice",
               "当前菜单页里选中的选项索引。"
            ],
            [
               "_choice_naming",
               "命名界面当前选中的区域（标题 / 字母表 / 命令）。"
            ],
            [
               "_choice_naming_letter",
               "命名界面当前选中的字母。"
            ],
            [
               "_choice_naming_command",
               "命名界面当前选中的命令（退格 / 完成 / 退出）。"
            ],
            [
               "_choice_confirm",
               "确认界面当前选中的选项。"
            ],
            [
               "_confirm_title",
               "确认界面显示的标题文字。"
            ],
            [
               "_confirm_valid",
               "玩家当前输入的名字是否合法（非空且不重复等）。"
            ],
            [
               "_confirm_name_x",
               "确认界面名字预览的横坐标。"
            ],
            [
               "_confirm_name_y",
               "确认界面名字预览的纵坐标。"
            ],
            [
               "_confirm_name_scale",
               "确认界面名字预览的缩放倍数。"
            ],
            [
               "_confirm_name_offset_x",
               "名字预览相对基准点的横向偏移。"
            ],
            [
               "_confirm_name_offset_y",
               "名字预览相对基准点的纵向偏移。"
            ],
            [
               "_confirm_name_angle",
               "名字预览的旋转角度。"
            ],
            [
               "_confirm_name_update",
               "名字预览是否需要重新计算排版。"
            ],
            [
               "_naming_name",
               "玩家正在输入的名字。"
            ],
            [
               "_change_inst",
               "正在做颜色变化动画的文本实例。"
            ],
            [
               "_change_color",
               "颜色变化动画使用的目标颜色。"
            ],
            [
               "_change_id",
               "颜色变化动画对应的编号。"
            ],
            [
               "_inst_*",
               "各子界面实例：说明、开始、设置、名字、LV、时间、房间、继续、重置、命名页等"
            ]
         ]
      },
      {
         "g": "fx",
         "n": "shaker",
         "t": "特效",
         "d": "通用震屏驱动器。挂到任意实例上，按参数抖动它的某个变量，可做震屏、抖字、抖战斗框。骨头从战斗框里「长出来」的抖动就是它在驱动，是打击感演出的核心件。",
         "v": [
            [
               "target",
               "要抖动的目标实例，默认 noone"
            ],
            [
               "var_name",
               "抖动目标上的哪个变量（如 \"_x\" 或 \"y\"）"
            ],
            [
               "shake_distance",
               "抖动幅度，默认 0"
            ],
            [
               "shake_speed",
               "抖动速度，默认 0"
            ],
            [
               "shake_random",
               "是否随机方向抖动，默认 false"
            ],
            [
               "shake_decrease",
               "每帧衰减系数，默认 1（不衰减）"
            ],
            [
               "_shake_base",
               "震动前记录的原始数值，震动结束后要恢复回去。"
            ],
            [
               "_shake_pos",
               "当前震动偏移量。"
            ],
            [
               "_shake_time",
               "震动已持续的帧数。"
            ],
            [
               "_shake_positive",
               "震动方向是否为正，用于让震动来回摆动。"
            ],
            [
               "delay",
               "延迟多少帧后才开始抖"
            ]
         ]
      },
      {
         "g": "map",
         "n": "shop",
         "t": "地图与商店",
         "d": "商店系统的总控界面 —— 从进店打招呼、浏览商品、选择买卖到结算退店，整个流程都在这里。它用一套状态机（_state，取自 SHOP_STATE）推进，维护商品列表索引（_index / _index_buy / _index_sell）与上一帧索引以便检测选中变化（_pre_index*），并用五个打字机实例分别渲染左侧列表、右侧详情、信息栏与两行状态栏（_typer_left / _typer_right / _typer_info / _typer_state_0 / _typer_state_1）。界面的边框与文字坐标都由一组几何变量决定（border_x1 到 border_y2、menu_divide_x、state_info_y、buy_info_*），改它们就能调整商店版面。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "border_x1",
               "商店边框的左边界坐标。"
            ],
            [
               "border_y1",
               "商店边框的上边界坐标。"
            ],
            [
               "border_x2",
               "商店边框的右边界坐标。"
            ],
            [
               "border_y2",
               "商店边框的下边界坐标。"
            ],
            [
               "border_width",
               "商店边框的线宽。"
            ],
            [
               "width_text",
               "文本列的宽度。"
            ],
            [
               "width_heart",
               "光标（心）横向移动的范围宽度。"
            ],
            [
               "height_text",
               "文本的行高。"
            ],
            [
               "menu_divide_x",
               "菜单区与信息区之间的横向分界线。"
            ],
            [
               "state_info_y",
               "状态信息行的纵坐标。"
            ],
            [
               "buy_info_x",
               "购买信息框的横坐标。"
            ],
            [
               "buy_info_y",
               "购买信息框的纵坐标。"
            ],
            [
               "buy_info_inst_y",
               "购买信息提示实例的纵坐标。"
            ],
            [
               "buy_info__vspeedpeed",
               "购买信息滚动的纵向速度（源码里变量名有拼写重复，沿用原样）。"
            ],
            [
               "_index",
               "主列表光标位置"
            ],
            [
               "_indexy",
               "商品列表的纵向排列索引。"
            ],
            [
               "_index_buy",
               "购买栏当前选中的索引。"
            ],
            [
               "_index_sell",
               "卖出栏当前选中的索引。"
            ],
            [
               "_choice_state",
               "当前处于哪一步（选物品 / 确认 / 结算）"
            ],
            [
               "_pre_index",
               "上一帧的选中索引，用于检测选项是否发生变化。；上一步光标位置，返回时还原"
            ],
            [
               "_pre_index_buy",
               "上一帧购买栏的选中索引。；上一步光标位置，返回时还原"
            ],
            [
               "_pre_index_sell",
               "上一帧卖出栏的选中索引。；上一步光标位置，返回时还原"
            ],
            [
               "_exit_index",
               "「离开」选项的位置"
            ],
            [
               "_host",
               "当前店主实例（shop_host），商店的文本、立绘与商品都从它取。"
            ],
            [
               "_background",
               "使用的背景图像。"
            ],
            [
               "_typer_left",
               "左侧文本的打字机实例。"
            ],
            [
               "_typer_right",
               "右侧文本的打字机实例。"
            ],
            [
               "_typer_info",
               "信息栏的打字机实例。"
            ],
            [
               "_typer_state_0",
               "状态栏第 0 行的打字机实例。"
            ],
            [
               "_typer_state_1",
               "状态栏第 1 行的打字机实例。"
            ],
            [
               "_typer_left_refresh",
               "左侧打字机是否需要刷新内容。"
            ],
            [
               "_typer_right_refresh",
               "右侧打字机是否需要刷新内容。"
            ],
            [
               "_typer_info_refresh",
               "信息栏打字机是否需要刷新内容。"
            ],
            [
               "_typer_state_refresh",
               "状态栏打字机是否需要刷新内容。"
            ],
            [
               "_state",
               "商店状态机当前状态，取自 SHOP_STATE 枚举（从进店打招呼一直到结算）。"
            ],
            [
               "_dialog",
               "对话框相关实例或开关。"
            ],
            [
               "_pre",
               "商店主文本的控制标记前缀。"
            ],
            [
               "_pre_inst",
               "商品列表文本的控制标记前缀。"
            ],
            [
               "_pre_inst_2",
               "第二套商品列表文本的控制标记前缀。"
            ],
            [
               "_pre_inst_3",
               "第三套商品列表文本的控制标记前缀。"
            ],
            [
               "_snd_buy_item",
               "购买物品时播放的音效。"
            ],
            [
               "border_x1/y1/x2/y2 / border_width",
               "商店边框范围与粗细"
            ]
         ],
         "hot": true
      },
      {
         "g": "map",
         "n": "shop_dialog",
         "t": "地图与商店",
         "d": "商店里的一段对话数据 —— 它本身不画东西，只是一个纯数据结构，被商店系统读来渲染。title 是标题栏内容索引、text 是正文内容索引（-1 表示该项不显示），title_blend 控制标题的混色颜色，next_dialog 指向下一段（noone 表示这是最后一段）。店主通过 Shop_SetDialog() 生成这些数据。",
         "v": [
            [
               "title",
               "标题栏内容索引，默认 -1 表示不显示标题。"
            ],
            [
               "title_blend",
               "标题栏的混色颜色，默认 c_white。"
            ],
            [
               "text",
               "正文内容索引，默认 -1 表示不显示正文。"
            ],
            [
               "next_dialog",
               "下一段对话跳转到的对象，默认 noone 表示它是最后一段。"
            ]
         ]
      },
      {
         "g": "map",
         "n": "shop_dialog_typer",
         "t": "地图与商店",
         "d": "商店对话框专用的打字机，复用了主引擎的逐字显示逻辑，用于把店主的话逐字打出来。",
         "v": [
            [
               "depth",
               "绘制深度，创建时设为 DEPTH_BATTLE.UI_HIGH，保证字幕压在商店画面之上。"
            ],
            [
               "visible",
               "是否可见，创建时先置 false，等打字机就绪后再显示。"
            ],
            [
               "text_offset_x",
               "文字相对本物体位置的横向偏移，默认 0。"
            ],
            [
               "text_offset_y",
               "文字相对本物体位置的纵向偏移，默认 0。"
            ],
            [
               "fast",
               "是否快速打字模式，默认 false。置 true 时文字会一次性全部显示。"
            ],
            [
               "text",
               "当前要逐字打出的字幕内容，默认空字符串。"
            ],
            [
               "_inst",
               "内部持有的打字机实例，创建时用 instance_create_depth 生成并保存，后续由它负责逐字显示。"
            ],
            [
               "alarm",
               "GameMaker 内置闹钟（数组）。赋值即设定倒计时帧数，归零时触发对应的 Alarm 事件，引擎里常写作 duration / global.delta_time_factor。"
            ]
         ]
      },
      {
         "g": "map",
         "n": "shop_host",
         "t": "地图与商店",
         "d": "商店店主的数据容器 —— 一个纯数据物件，把某位店主要说的话和要卖的东西集中登记：打招呼（encounter_text）、菜单提示（menu_text）、购买前后（buy_before_text / buy_after_text）、买不起或背包已满（buy_false_text），以及是否支持卖东西（sold_available）和卖出各阶段的文本。host_sprite 是立绘，shop_item 是商品列表。商店系统读它来渲染整个界面。",
         "v": [
            [
               "encounter_text",
               "遭遇 / 进店时显示的招呼文本。"
            ],
            [
               "menu_text",
               "菜单状态下显示的文本。"
            ],
            [
               "host_sprite",
               "店主立绘贴图"
            ],
            [
               "shop_item",
               "该店主出售的物品列表或物品编号。"
            ],
            [
               "buy_before_text",
               "购买前的确认文本。"
            ],
            [
               "buy_after_text",
               "购买成功后的文本。"
            ],
            [
               "buy_false_text",
               "购买失败时显示的文本。"
            ],
            [
               "sold_available",
               "该商店是否支持卖出物品。"
            ],
            [
               "sold_before_text",
               "卖出前的确认文本。"
            ],
            [
               "sold_choice_text",
               "卖出确认时的提示文本。"
            ],
            [
               "sold_after_text",
               "卖出成功后的文本。"
            ],
            [
               "sold_false_text",
               "不能卖出时显示的提示文本。"
            ],
            [
               "dialog_init",
               "进店时的初始对话文本。"
            ],
            [
               "dialog",
               "该物件持有的对话框实例。"
            ],
            [
               "exit_text",
               "离开时的告别语"
            ],
            [
               "shop_item[0~3]",
               "货架上的四件商品"
            ],
            [
               "sold_available / sold_*_text",
               "是否启用「已售出」状态及其文本"
            ],
            [
               "dialog_init[0~3] / dialog[0~3]",
               "四段对话的初始与当前内容"
            ]
         ],
         "rel": [
            [
               "店主事件（User Event）",
               [
                  [
                     "event_user(10~15)",
                     "商店各阶段的回调：进入、选物品、购买、结算等，在这里改文案与判断"
                  ]
               ]
            ]
         ]
      },
      {
         "g": "map",
         "n": "shop_host_test",
         "t": "地图与商店",
         "d": "商店店主的测试用例 —— 演示如何用最少的代码配出一位能说会卖的店主：把招呼语、菜单提示、买卖前后的台词，以及各种「钱不够 / 背包已满」的失败文本逐条填好，再指明要卖的商品（shop_item）与是否收购（sold_available），最后用 Shop_SetDialog() 组装出一段带颜色的对话。想新建店主，照抄这个物件的填法即可。",
         "v": [
            [
               "encounter_text",
               "开场白，-1 表示用默认"
            ],
            [
               "menu_text",
               "货架界面的提示文字"
            ],
            [
               "shop_item",
               "该店主出售的物品列表或物品编号。"
            ],
            [
               "buy_before_text",
               "购买前的确认文本。"
            ],
            [
               "buy_after_text",
               "购买成功后的文本。"
            ],
            [
               "buy_false_text_0",
               "购买失败的提示文本 0（钱不够）。"
            ],
            [
               "buy_false_text_1",
               "购买失败的提示文本 1（物品栏已满）。"
            ],
            [
               "sold_available",
               "是否允许卖东西给店主"
            ],
            [
               "sold_false_text",
               "店主拒收时的台词"
            ],
            [
               "dialog_before_text",
               "对话阶段的台词"
            ],
            [
               "dialog",
               "该物件持有的对话框实例。"
            ],
            [
               "exit_text",
               "离开时的道别台词"
            ]
         ]
      },
      {
         "g": "map",
         "n": "shop_ui_deeperpart",
         "t": "地图与商店",
         "d": "商店界面的「深层」装饰部分。负责画出货架信息区的分割线与边框，是商店 UI 里负责层次感的那一层。",
         "v": [
            [
               "buy_info_x",
               "购买信息框的横坐标。；货架信息区的位置，默认按商店面板自动对齐"
            ],
            [
               "buy_info_y",
               "购买信息框的纵坐标。；货架信息区的位置，默认按商店面板自动对齐"
            ],
            [
               "buy_info_inst_y",
               "信息实例的纵向偏移"
            ],
            [
               "border_x1",
               "商店边框的左边界坐标。"
            ],
            [
               "border_x2",
               "商店边框的右边界坐标。"
            ],
            [
               "border_width",
               "分割线粗细"
            ],
            [
               "_background",
               "使用的背景图像。"
            ],
            [
               "_host",
               "当前商店店主实例，商店的文本与立绘都从它取。"
            ],
            [
               "depth",
               "绘制深度，默认 99"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "soul_auxiliary",
         "t": "灵魂",
         "d": "灵魂辅助物。承载灵魂的附加显示元素（装饰圈、拖影等），自身不参与碰撞与移动，只跟着灵魂画。",
         "v": [
            [
               "（继承）",
               "无自有变量，位置与显隐由灵魂驱动"
            ]
         ]
      },
      {
         "g": "soul",
         "n": "soul_block",
         "t": "灵魂",
         "d": "灵魂阻挡物。给灵魂加一块可移动的碰撞体，绿心模式的盾牌就是它的实例。也可用来做「灵魂被框住」的限制效果。",
         "v": [
            [
               "type",
               "碰撞行为类型，由创建它的灵魂模式决定"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "text_typer",
         "t": "界面",
         "d": "引擎的文本渲染与打字机核心 —— 对话框、商店文本、菜单、字幕全都复用这一个物件。它接收带控制标记的文本（如 {color `white`}、{speed 2}、{face 1}、{pause}、{define ...}），先解析成逐字数据（_char_data_list）与控制指令表（_list_cmd），再按 _char_per_frame 的节奏逐字打印。除普通的逐字显示外，它还支持水平 / 垂直两种排版方向（_type_dir）、打字音效与语音（_voice）、按键跳过（_skippable / _skipping）、瞬间全显（_instant）、文本内嵌选项（_choice 系列）、文本宏（_map_macro）、与表情物件联动（_face），以及彩虹字、阴影、描边等文字特效。想改对话的观感与节奏，基本都在这里。",
         "v": [
            [
               "text",
               "要显示的完整字符串（带 {color} {speed} 等标签）"
            ],
            [
               "_line",
               "当前所在行"
            ],
            [
               "_type_dir",
               "打字方向：0 = 水平逐字，1 = 垂直逐字。"
            ],
            [
               "_halign",
               "文字的水平对齐方式（0 左 / 1 居中 / 2 右）。"
            ],
            [
               "_valign",
               "文字的垂直对齐方式。"
            ],
            [
               "_speed",
               "打字速度（每帧推进多少个字），与 _char_per_frame 配合。"
            ],
            [
               "_char_per_frame",
               "每帧推进多少个字，默认 1。调大就是加速打字。"
            ],
            [
               "_position_follow",
               "文字是否跟随物件位置一起移动。"
            ],
            [
               "_audio_clear",
               "开始打字时是否先清掉正在播放的语音。"
            ],
            [
               "_voice",
               "当前使用的语音编号。"
            ],
            [
               "_voice_single",
               "指定整段文字只用一个语音编号，-1 表示不限制。"
            ],
            [
               "_sleep",
               "开始打印前的等待帧数。"
            ],
            [
               "_skippable",
               "这段文字能否被玩家按键跳过。"
            ],
            [
               "_skipping",
               "当前是否正在执行跳过（按键后的一次性快进）。"
            ],
            [
               "_paused",
               "是否处于暂停状态。暂停后进度保留，可用对应的继续函数恢复。"
            ],
            [
               "_instant",
               "是否强制瞬间显示全部文字，不等逐字打印。"
            ],
            [
               "_space_x",
               "字距，每个字之间额外增加的横向间隔。"
            ],
            [
               "_space_y",
               "行距，每行之间额外增加的纵向间隔。"
            ],
            [
               "_char_frame_remain",
               "当前这个字还剩几帧才推进到下一个字。"
            ],
            [
               "_char_x",
               "下一个字要绘制的横坐标。"
            ],
            [
               "_char_y",
               "下一个字要绘制的纵坐标。"
            ],
            [
               "_char",
               "当前正在打印的这一个字符。"
            ],
            [
               "_angle",
               "文字整体的旋转角度。"
            ],
            [
               "_char_sprite",
               "当前字符使用的字形精灵，-1 表示该字符没有字形。"
            ],
            [
               "_char_sprite_image",
               "当前字形的帧编号。"
            ],
            [
               "_char_proc",
               "当前字符的解析进度，用于处理需要多帧才能完成的控制标记。"
            ],
            [
               "_voice_played",
               "当前字符的语音是否已播放过，避免同一个字重复出声。"
            ],
            [
               "_char_data_list",
               "解析后的字符数据列表，逐个元素记录每个字的字形、颜色、位置等信息。"
            ],
            [
               "_list_cmd",
               "文本里出现的控制指令列表（换行、等待、清屏等）。"
            ],
            [
               "_map_macro",
               "文本宏定义表，把 {define ...} 声明的宏名映射到实际内容。"
            ],
            [
               "_face",
               "文字要联动的表情物件，noone 表示不联动。"
            ],
            [
               "_face_linked",
               "是否与表情物件联动（换行时同步切换表情）。"
            ],
            [
               "_char_linked",
               "是否与角色物件联动。"
            ],
            [
               "_skip_space",
               "跳过时是否连空白字符一起跳过。"
            ],
            [
               "_choice",
               "文本里内嵌选项的当前选中索引，-1 表示这段文本没有选项。"
            ],
            [
               "_choice_x",
               "文本内嵌选项的横坐标。"
            ],
            [
               "_choice_y",
               "文本内嵌选项的纵坐标。"
            ],
            [
               "_choice_macro",
               "内嵌选项使用的宏名。"
            ],
            [
               "_choice_switch_direction",
               "内嵌选项的切换方向：0 = 左右，1 = 上下。"
            ],
            [
               "_choice_switch_key",
               "切换选项用的按键，默认左右"
            ],
            [
               "_choice_switch_sound",
               "切换内嵌选项时是否播放音效。"
            ],
            [
               "_show_item",
               "是否显示内嵌的物品图标。"
            ],
            [
               "_font",
               "文字使用的字体编号。"
            ],
            [
               "_scale_x",
               "文字横向缩放倍数。"
            ],
            [
               "_scale_y",
               "文字纵向缩放倍数。"
            ],
            [
               "_shadow",
               "是否开启文字阴影。"
            ],
            [
               "_outline",
               "是否开启文字描边。"
            ],
            [
               "_color_text",
               "文字颜色（长度为 4 的数组时表示从左到右的渐变色）。"
            ],
            [
               "_color_shadow",
               "文字阴影颜色。"
            ],
            [
               "_color_outline",
               "文字描边颜色。"
            ],
            [
               "_alpha",
               "文字整体透明度。"
            ],
            [
               "_rainbow",
               "彩虹字效果开关与强度。"
            ],
            [
               "_alpha_text",
               "文字本体的透明度。"
            ],
            [
               "_alpha_shadow",
               "文字阴影的透明度。"
            ],
            [
               "_alpha_outline",
               "文字描边的透明度。"
            ],
            [
               "_shadow_x",
               "阴影相对文字的横向偏移。"
            ],
            [
               "_shadow_y",
               "阴影相对文字的纵向偏移。"
            ],
            [
               "_effect",
               "当前生效的文字特效编号，-1 表示无。"
            ],
            [
               "_gui",
               "是否绘制在 GUI 层（不随镜头移动）。"
            ],
            [
               "_angle_previous",
               "上一帧的角度，用于检测角度变化。"
            ],
            [
               "_angle_follow",
               "每个字符的角度是否跟随文字整体角度旋转。"
            ],
            [
               "_effect_shook",
               "文字特效造成的震动量。"
            ],
            [
               "_surface_target",
               "绘制结果要输出到的目标 surface，noone 表示直接画在屏幕上。"
            ],
            [
               "width",
               "这段文本排版后的总宽度，单位像素。"
            ],
            [
               "height",
               "这段文本排版后的总高度，单位像素。"
            ],
            [
               "override_alpha_enabled",
               "是否启用外部强制指定的透明度，覆盖文本自身的 alpha 设置。"
            ],
            [
               "override_alpha",
               "外部强制指定的透明度值，仅在 override_alpha_enabled 为 true 时生效。"
            ],
            [
               "override_color_text_enabled",
               "是否启用外部强制指定的文字颜色。"
            ],
            [
               "override_color_text",
               "外部强制指定的文字颜色，仅在 override_color_text_enabled 为 true 时生效。"
            ],
            [
               "_time",
               "打字机自己的帧计时器，用于控制打字节奏与等待。"
            ],
            [
               "torder",
               "文本渲染顺序表，决定多个文本元素谁先画谁后画。"
            ],
            [
               "_order",
               "当前文本的渲染次序编号，数值决定谁先画谁后画。"
            ],
            [
               "auto_destroy",
               "是否在播放 / 显示结束后自动销毁自己。"
            ],
            [
               "alarm",
               "打字机的推进闹钟，每帧触发一次来打印下一个字。"
            ],
            [
               "_shadow / _outline / _color_*",
               "描影、描边与各级颜色"
            ]
         ],
         "hot": true
      },
      {
         "g": "map",
         "n": "trigger",
         "t": "地图与商店",
         "d": "触发器的基类。放在地图上，玩家碰到即触发；trigger_warp / trigger_shop 都继承它。",
         "v": [
            [
               "user_char",
               "触发者对象索引，默认 -1 表示尚未绑定。只有匹配的角色走进来才会触发。"
            ],
            [
               "_triggered",
               "本次碰撞是否已经触发过，默认 false，用来避免玩家站在触发区里被反复触发。"
            ],
            [
               "_collided_previous",
               "上一帧是否处于碰撞状态，默认 false，用于检测「刚进入」的那一瞬间。"
            ]
         ]
      },
      {
         "g": "map",
         "n": "trigger_shop",
         "t": "地图与商店",
         "d": "进店触发器 —— 继承自 trigger，放在地图上某个位置。玩家走进去时依次执行：淡入黑幕（fade_in_time / fade_in_color）、按 target_shop_id 打开对应商店、离开时淡出（fade_out_time / fade_out_color），并可选择让 BGM 一起淡出（bgm_fade / bgm_fade_time）。相较基类，它还支持跳转到指定地标（target_landmark）与设定传送后玩家的朝向（player_dir）。",
         "v": [
            [
               "user_char",
               "触发者对象索引，覆盖父类默认值，默认 0 表示任意角色都可触发。"
            ],
            [
               "target_shop_id",
               "要打开的商店 ID，默认 0。"
            ],
            [
               "target_landmark",
               "目标地标索引，默认 -1 表示原地处理不传送。"
            ],
            [
               "fade_in_time",
               "进入商店时淡入的持续帧数，默认 20。"
            ],
            [
               "fade_in_color",
               "淡入时遮罩的颜色，默认 c_black。"
            ],
            [
               "fade_out_time",
               "离开商店时淡出的持续帧数，默认 20。"
            ],
            [
               "fade_out_color",
               "淡出时遮罩的颜色，默认 c_black。"
            ],
            [
               "bgm_fade",
               "商店切换时是否对背景音乐做淡入淡出，默认 false。"
            ],
            [
               "bgm_fade_time",
               "背景音乐淡入淡出的持续帧数，默认 20。"
            ],
            [
               "warp_wait",
               "传送前等待的帧数，默认 0。"
            ],
            [
               "player_dir",
               "传送后玩家面朝的方向，默认 -1 表示不改朝向。"
            ]
         ]
      },
      {
         "g": "map",
         "n": "trigger_warp",
         "t": "地图与商店",
         "d": "传送触发器 —— 继承自 trigger，放在地图上用于切换房间。玩家碰到时按 target_room 跳到目标房间，并可指定落点地标（target_landmark）与到达后的朝向（player_dir）；转场用淡入淡出完成（fade_in_time / fade_in_color / fade_out_time / fade_out_color），也能让 BGM 一起淡出（bgm_fade / bgm_fade_time）。warp_wait 是传送前额外等待的帧数。",
         "v": [
            [
               "user_char",
               "允许触发的角色编号，0 = 不限"
            ],
            [
               "target_room",
               "目标房间 asset，-1 = 不切房间"
            ],
            [
               "target_landmark",
               "目标房间内的落点标记编号"
            ],
            [
               "fade_in_time",
               "进入时的淡入持续帧数。；进入时黑幕时长与颜色（默认 20 帧 / 黑）"
            ],
            [
               "fade_in_color",
               "进入时遮罩的颜色。；进入时黑幕时长与颜色（默认 20 帧 / 黑）"
            ],
            [
               "fade_out_time",
               "离开时的淡出持续帧数。"
            ],
            [
               "fade_out_color",
               "离开时遮罩的颜色。"
            ],
            [
               "bgm_fade",
               "切换场景时是否让背景音乐淡入淡出。"
            ],
            [
               "bgm_fade_time",
               "背景音乐淡入淡出的持续帧数。"
            ],
            [
               "warp_wait",
               "触发前等待帧数"
            ],
            [
               "player_dir",
               "传送后朝向，-1 = 保持原样"
            ]
         ]
      },
      {
         "g": "core",
         "n": "turn_test",
         "t": "核心系统",
         "d": "回合测试物件，继承自 battle_turn。用于单独验证回合推进、计时与结束条件，不参与正式战斗流程。",
         "v": [
            [
               "（继承）",
               "无自有变量，创建时读按键操作来手动推进回合"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "ui_box",
         "t": "界面",
         "d": "通用物品框界面 —— 显示「获得 / 失去物品」或「查看某个容器」时弹出的那个方框。它有自己的一套状态机（_state）与模式选择（_choice_mode，浏览 / 操作），内部用四个子实例分别渲染物品栏与物品框的列表和条目（_inst_inventory / _inst_box / _inst_item_*），最后用 _inst_finish 显示「完成」提示，展开宽度由 _show_width 驱动。",
         "v": [
            [
               "depth",
               "绘制深度，设为 DEPTH_UI.PANEL"
            ],
            [
               "box_slot",
               "底板样式编号，默认 0"
            ],
            [
               "_state",
               "物品栏各子状态机的当前状态，-1 表示尚未进入。"
            ],
            [
               "_choice_mode",
               "物品栏当前所处的模式（浏览 / 操作）。"
            ],
            [
               "_choice_mode_soul",
               "模式选择光标所在的索引。"
            ],
            [
               "_choice_item",
               "物品栏当前选中的物品索引。"
            ],
            [
               "_choice_item_soul",
               "物品栏光标所在索引。"
            ],
            [
               "_surface",
               "渲染用的 surface（离屏画布），-1 表示尚未创建。"
            ],
            [
               "_surface_text",
               "专门用来绘制文字的 surface。"
            ],
            [
               "_prefix",
               "一段固定的文本控制标记前缀，用于统一该界面的字体、颜色、缩放等默认样式。"
            ],
            [
               "_show_width",
               "物品栏当前展开到的宽度，用于做面板展开动画。"
            ],
            [
               "_inst_inventory",
               "物品列表的文本实例。"
            ],
            [
               "_inst_box",
               "物品框的文本实例。"
            ],
            [
               "_inst_item_inventory",
               "物品栏中物品条目的文本实例。"
            ],
            [
               "_inst_item_box",
               "物品框中物品条目的文本实例。"
            ],
            [
               "_inst_finish",
               "「完成 / 返回」的文本实例。"
            ],
            [
               "char_player._moveable_box",
               "创建时置 false，锁住玩家移动防止边走边说话"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "ui_dialog",
         "t": "界面",
         "d": "地图上的对话框容器。_choose_enable / _choice 控制选项的开关与当前选择。",
         "v": [
            [
               "depth",
               "绘制深度（GameMaker 内置）。数值越小越靠前画，引擎里统一用 DEPTH_BATTLE / DEPTH_UI 下的枚举赋值，别直接写魔法数字。"
            ],
            [
               "_surface_text",
               "用于绘制文字的 surface（640×480）"
            ],
            [
               "_inst",
               "内部打字机实例"
            ],
            [
               "_top",
               "对话框是否显示在角色上方（角色靠下时为 true）"
            ],
            [
               "_choose_enable",
               "是否进入选项模式"
            ],
            [
               "_choose",
               "当前选中的选项序号"
            ],
            [
               "_choose_soul",
               "选项光标的灵魂样式编号"
            ],
            [
               "_choice",
               "选项文本数组"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "ui_menu",
         "t": "界面",
         "d": "暂停菜单界面 —— 按菜单键弹出的面板，包含角色状态、物品栏与手机三个页签。它登记了三页各自的选项索引（_choice / _choice_item / _choice_phone）与光标位置（_choice_*_soul），并为每页的子面板与文本条目各持有一个实例（_inst_menu / _inst_item / _inst_stat_0 / _inst_stat_1 / _inst_phone 等）。三个子面板的展开宽度与销毁倒计时分别存在 _show_width 与 _destroy_time 数组里。",
         "v": [
            [
               "depth",
               "绘制深度，-9000"
            ],
            [
               "_offset",
               "展开动画的位移量，默认 -100"
            ],
            [
               "_menu",
               "当前菜单编号，取自该系统的菜单枚举。"
            ],
            [
               "_choice_soul",
               "选项光标所在的索引，用来判断灵魂停在哪个选项上。"
            ],
            [
               "_choice",
               "主菜单当前选中的选项索引。"
            ],
            [
               "_choice_item",
               "物品栏当前选中的物品索引。"
            ],
            [
               "_choice_item_soul",
               "物品栏光标所在索引。"
            ],
            [
               "_choice_item_operate",
               "物品操作菜单当前选中的项（使用 / 查看 / 丢弃）。"
            ],
            [
               "_choice_item_operate_soul",
               "物品操作菜单光标的纵向位置，带小数以便平滑移动。"
            ],
            [
               "_choice_phone",
               "手机菜单下标"
            ],
            [
               "_choice_phone_soul",
               "手机栏光标所在索引。"
            ],
            [
               "_surface",
               "主菜单渲染用的 surface（640×480）。"
            ],
            [
               "_surface_text",
               "专门用来绘制文字的 surface。"
            ],
            [
               "_prefix",
               "一段固定的文本控制标记前缀，用于统一该界面的字体、颜色、缩放等默认样式。"
            ],
            [
               "_inst_name",
               "显示名字文本的子物件实例。"
            ],
            [
               "_inst_menu",
               "菜单主标题的文本实例。"
            ],
            [
               "_inst_item",
               "物品栏的文本实例。"
            ],
            [
               "_inst_item_use",
               "「使用」提示的文本实例。"
            ],
            [
               "_inst_item_info",
               "「查看」提示的文本实例。"
            ],
            [
               "_inst_item_drop",
               "「丢弃」提示的文本实例。"
            ],
            [
               "_inst_stat_0",
               "状态栏第 0 行的文本实例。"
            ],
            [
               "_inst_stat_1",
               "状态栏第 1 行的文本实例。"
            ],
            [
               "_inst_phone",
               "手机栏的文本实例。"
            ],
            [
               "_show_width",
               "三个子面板各自的展开宽度数组，用于逐个弹出。"
            ],
            [
               "_destroy_time",
               "三个子面板各自的销毁倒计时。"
            ],
            [
               "_menu / _mode",
               "当前菜单页与模式"
            ],
            [
               "_top",
               "是否贴着屏幕顶部展开（按玩家与镜头的相对高度自动判断）"
            ]
         ]
      },
      {
         "g": "ui",
         "n": "ui_save",
         "t": "界面",
         "d": "存档界面 —— 保存 / 读取存档时显示的那个面板，展示玩家名字、LV、游玩时间与当前房间。它有一套简单的状态机（_state）与选项索引（_choice / _choice_soul），用六个文本子实例分别显示各项信息（_inst_name / _inst_lv / _inst_time / _inst_room / _inst_save / _inst_return），展开宽度由 _show_width 驱动。",
         "v": [
            [
               "depth",
               "绘制深度，设为 DEPTH_UI.PANEL"
            ],
            [
               "_show_width",
               "存档界面当前展开到的宽度，用于做面板展开动画。"
            ],
            [
               "_state",
               "存档界面状态机的当前状态，-1 表示尚未开始。"
            ],
            [
               "_choice",
               "存档界面当前选中的选项索引。"
            ],
            [
               "_choice_soul",
               "选项光标所在的索引，用来判断灵魂停在哪个选项上。"
            ],
            [
               "_prefix",
               "一段固定的文本控制标记前缀，用于统一该界面的字体、颜色、缩放等默认样式。"
            ],
            [
               "_surface",
               "渲染用的 surface（离屏画布），-1 表示尚未创建。"
            ],
            [
               "_surface_text",
               "专门用来绘制文字的 surface。"
            ],
            [
               "_inst_name",
               "显示名字文本的子物件实例。"
            ],
            [
               "_inst_lv",
               "「LV」数值文本实例。"
            ],
            [
               "_inst_time",
               "「游玩时间」文本实例。"
            ],
            [
               "_inst_room",
               "「当前房间」文本实例。"
            ],
            [
               "_inst_save",
               "「保存」文本实例。"
            ],
            [
               "_inst_return",
               "「返回」文本实例。"
            ],
            [
               "char_player._moveable_save",
               "创建时置 false，锁住玩家移动"
            ]
         ]
      }
   ],
   "enemyEvents": [
      [
         "INIT",
         "0",
         "敌人出场：SetEnemyName / SetEnemyDEF / SetEnemyActionNumber / SetEnemyActionName"
      ],
      [
         "BATTLE_START",
         "1",
         "整场战斗开始，做一次性演出"
      ],
      [
         "MENU_START",
         "2",
         "进入菜单，通常开菜单对话"
      ],
      [
         "MENU_SWITCH",
         "3",
         "切换子菜单"
      ],
      [
         "MENU_CHOICE_SWITCH",
         "4",
         "菜单光标移动（做音效反馈）"
      ],
      [
         "MENU_END",
         "5",
         "菜单阶段结束"
      ],
      [
         "DIALOG_START",
         "6",
         "菜单对话开始"
      ],
      [
         "DIALOG_END",
         "7",
         "菜单对话结束"
      ],
      [
         "TURN_PREPARATION_START",
         "8",
         "设置本回合面板参数与时长，并生成预告弹幕"
      ],
      [
         "TURN_PREPARATION_END",
         "9",
         "回合准备结束"
      ],
      [
         "TURN_START",
         "10",
         "回合正式开始，在这里生成攻击弹幕"
      ],
      [
         "TURN_END",
         "11",
         "回合结束，清理自建实例"
      ],
      [
         "BOARD_RESETTING_START",
         "12",
         "面板复位开始"
      ],
      [
         "BOARD_RESETTING_END",
         "13",
         "面板复位结束"
      ]
   ],
   "boneTypes": [
      {
         "t": "0",
         "n": "普通伤害",
         "d": "撞到就 Player_HurtKr()，最常见"
      },
      {
         "t": "1",
         "n": "移动时伤害",
         "d": "仅在玩家移动（global.moving）时造成伤害，逼玩家停手"
      },
      {
         "t": "2",
         "n": "静止时伤害",
         "d": "仅在玩家静止时造成伤害，逼玩家持续移动"
      },
      {
         "t": "3",
         "n": "治疗",
         "d": "不造成伤害，改为 Player_Heal(1)。做「绿色弹幕」用"
      },
      {
         "t": "4",
         "n": "一次性伤害",
         "d": "撞到即销毁（disposable = 1），适合子弹"
      }
   ],
   "objectsGroups": [
      {
         "id": "core",
         "name": "核心系统",
         "desc": "战斗总控、框、回合、敌人基类与遭遇动画。改引擎最先碰的就是这一组。"
      },
      {
         "id": "bullet",
         "name": "弹幕",
         "desc": "所有攻击物件的父类与内置弹幕：骨头、3D 骨、箭头骨、加斯特冲击波、跳跃平台。"
      },
      {
         "id": "soul",
         "name": "灵魂",
         "desc": "灵魂父物体与各模式子物体（red / blue / green / yellow / orange / aqua / purple）。换灵魂就是换玩法。"
      },
      {
         "id": "ui",
         "name": "界面",
         "desc": "按钮、菜单、对话框、打字机、伤害数字、字幕等所有 UI 元素。"
      },
      {
         "id": "fx",
         "name": "特效",
         "desc": "全屏黑幕与淡入淡出。"
      },
      {
         "id": "map",
         "name": "地图与商店",
         "desc": "地图角色、存档点、触发器与商店流程。"
      }
   ],
   "snippets": {
      "enemyFull": "// ============ 一个完整敌人的写法 ============\n// 物体名 obj_sans，父物体必须设为 battle_enemy\n\n// ---------- User Event 0 · INIT ----------\nBattle_SetEnemyName(0, \"Sans\");\nBattle_SetEnemyDEF(0, 1);\nBattle_SetEnemyActionNumber(0, 3);\nBattle_SetEnemyActionName(0, 0, \"Check\");\nBattle_SetEnemyActionName(0, 1, \"Joke\");\nBattle_SetEnemyActionName(0, 2, \"Spare\");\n\n// ---------- User Event 8 · TURN_PREPARATION_START ----------\n// 把面板变成正方形的审判场\nBattle_SetTurnInfo(BATTLE_TURN.TIME, 60 * 10);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_X, 320);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_Y, 240);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_UP, 90);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_DOWN, 90);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_LEFT, 180);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_RIGHT, 180);\nBattle_SetTurnInfo(BATTLE_TURN.BOARD_MOVE_EASE, ANIM_EASE.IN_OUT);\nBattle_SetTurnInfo(BATTLE_TURN.SOUL_X, 0);\nBattle_SetTurnInfo(BATTLE_TURN.SOUL_Y, 60);\n\n// ---------- User Event 10 · TURN_START ----------\n// 简单骨墙推进\nif (Battle_GetTurnNumber() <= 3) {\n    Battle_MakeBoneTwoH(320, 320, -4, 0, 1, 0, 90, 0);\n} else {\n    // 后期加加斯特冲击波\n    Battle_MakeGB(320, 100, battle_soul.x, battle_soul.y, 90, 90, 1, 1, 0);\n}\n\n// ---------- User Event 11 · TURN_END ----------\n// 清理自己额外创建的实例\ninstance_destroy(obj_my_temp_effect);",
      "customBullet": "// ============ 自定义弹幕物体 ============\n// 物体 obj_sun_bullet，父物体设为 battle_bullet\n\n// ---------- Create ----------\nevent_inherited();\ndepth = DEPTH_BATTLE.BULLET;\ntype    = 0;        // 普通伤害\nout     = 1;        // 可以在面板外活动\nduration = 120;     // 活 2 秒\nauto_destroy = 1;   // 回合结束自动销毁\ndisposable = 1;     // 撞一次就消失\nhspeed = 2;\nvspeed = 3;\nimage_blend = c_yellow;\n\n// ---------- Step ----------\nimage_angle += 6;                 // 自转\n\n// ---------- User Event 0 · SOUL_COLLISION ----------\n// 撞到灵魂时的自定义反应\nwith (other) { Battle_CallSoulEventHurt(); }\ninstance_destroy();\n\n// ---------- User Event 1 · TURN_END ----------\ninstance_destroy();\n\n// 生成它：\n// var b = instance_create_depth(x, y, DEPTH_BATTLE.BULLET, obj_sun_bullet);",
      "overworldDialog": "// ============ 地图互动与对话 ============\n\n// ---------- 触发对话（char_sans 的 Create 或碰撞事件内） ----------\nif (Input_IsPressed(INPUT.CONFIRM) && place_meeting(x, y, char_player)) {\n    Dialog_Add(\"* 你好啊。\");\n    Dialog_Add(\"* 最近过得怎么样？\");\n    Dialog_Add(\"* [1] 还行  [2] 不太好\");   // 选项写在文本里\n    Dialog_Start(true, \"还行\", \"不太好\");\n}\n\n// 读取玩家选择\nvar choice = Player_GetTextTyperChoice();\n\n// ---------- 触发战斗 ----------\nif (Dialog_IsEmpty() && choice == 1) {\n    Encounter_Start(ENC_SANS);          // 带遭遇动画\n}\n\n// ---------- 存档点 ----------\n// char_save 的交互里\nStorage_SaveGame();\n\n// ---------- 房间切换 ----------\n// trigger_warp 里\nStorage_SetTempFlag(FLAG_TEMP_TRIGGER_WARP_LANDMARK, \"from_left\");\nroom_goto(room_area_1);",
      "customItem": "// ============ 自定义物品 ============\n// 新建 script：CustomItem_HealPotion\n\nfunction CustomItem_HealPotion() : ItemType() constructor {\n    _price_buy  = 20;\n    _price_sell = 10;\n\n    function GetName() {\n        return \"治疗药水\";\n    }\n\n    function OnUse(inventory, index) {\n        if (Player_GetHp() >= Player_GetHpMax()) {\n            Dialog_Add(\"* 你的 HP 已经满了。\");\n        } else {\n            var healed = 20;\n            Player_Heal(healed);\n            Dialog_Add(Item_GetTextHeal(healed));\n            inventory.Remove(index);   // 用掉\n        }\n        Dialog_Start();\n    }\n\n    function OnInfo(inventory, index) {\n        Dialog_Add(\"* 一瓶红色的药水。&* 回复 20 HP。\");\n        Dialog_Start();\n    }\n}\n\n// ---------- 然后在 Item_Custom() 里注册 ----------\n#macro ITEM_HEAL_POTION \"heal_potion\"\nitemTypes.Register(ITEM_HEAL_POTION, new CustomItem_HealPotion());\n\n// ---------- 在 Player_CustomInitialData() 里发放 ----------\nItem_GetInventoryItems().Add(ITEM_HEAL_POTION);",
      "newSaveFlag": "// ============ 添加自定义存档数据 ============\n\n// 1) 在 Macro_Flag 的 #region static 加键名\n#macro FLAG_STATIC_MY_PROGRESS \"my_progress\"\n\n// 2) 读写\nStorage_SetStaticFlag(FLAG_STATIC_MY_PROGRESS, 5);\nvar p = Storage_GetStaticFlag(FLAG_STATIC_MY_PROGRESS, 0);\n\n// 3) 如果要存复杂结构，用 StorageZoneStruct\n// 在 Storage_Custom_Static() 里注册：\nstorages.Register(\"my_data\", new MyDataZone());\n\nfunction MyDataZone() : StorageZoneStruct() constructor {\n    function GetOrDefault(key, def) {\n        return data[$ key] ?? def;\n    }\n}\n\n// 使用：\nvar zone = Storage_GetStatic().Get(\"my_data\");\nzone.Set(\"visited_ruins\", true);",
      "animShowcase": "// ============ 动画补间常用套路 ============\n\n// 1) 面板呼吸式缩放\nAnim_Create(battle_board, \"up\", ANIM_TWEEN.SINE, ANIM_EASE.IN_OUT,\n            65, 25, 40, 0, 0, 1, 0, ANIM_MODE.BOUNCE);\n\n// 2) 文字浮现\nAnim_Create(text_inst, \"image_alpha\", ANIM_TWEEN.QUAD, ANIM_EASE.OUT,\n            0, 1, 20);\n\n// 3) 敌人出场滑入 + 停一下\nvar a = new Animator(ANIM_TWEEN.BACK, ANIM_EASE.OUT);\na.SetKeyframe(obj_enemy, \"x\", [0, 0], [1, 320, ANIM_TWEEN.BACK, ANIM_EASE.OUT]);\na.Play(45);\n\n// 4) 打断正在跑的动画（重要！）\nAnim_Destroy(battle_board, \"up\");\nbattle_board.up = 65;   // 立刻归位",
      "inputShowcase": "// ============ 输入系统：在 Input_Init 里绑定键位 ============\n// ⚠ 这个文件对应 scripts/Input_Init/Input_Init.gml，直接在里面加\n\nInput_Bind(INPUT.UP,      INPUT_TYPE.KEYBOARD, 0, vk_up);\nInput_Bind(INPUT.UP,      INPUT_TYPE.KEYBOARD, 0, ord(\"W\"));\nInput_Bind(INPUT.DOWN,    INPUT_TYPE.KEYBOARD, 0, vk_down);\nInput_Bind(INPUT.DOWN,    INPUT_TYPE.KEYBOARD, 0, ord(\"S\"));\nInput_Bind(INPUT.LEFT,    INPUT_TYPE.KEYBOARD, 0, vk_left);\nInput_Bind(INPUT.LEFT,    INPUT_TYPE.KEYBOARD, 0, ord(\"A\"));\nInput_Bind(INPUT.RIGHT,   INPUT_TYPE.KEYBOARD, 0, vk_right);\nInput_Bind(INPUT.RIGHT,   INPUT_TYPE.KEYBOARD, 0, ord(\"D\"));\nInput_Bind(INPUT.CONFIRM, INPUT_TYPE.KEYBOARD, 0, ord(\"Z\"));\nInput_Bind(INPUT.CONFIRM, INPUT_TYPE.KEYBOARD, 0, vk_enter);\nInput_Bind(INPUT.CANCEL,  INPUT_TYPE.KEYBOARD, 0, ord(\"X\"));\nInput_Bind(INPUT.MENU,    INPUT_TYPE.KEYBOARD, 0, ord(\"C\"));\n\n// 手柄绑定\nInput_Bind(INPUT.CONFIRM, INPUT_TYPE.GAMEPAD, 0, gp_face1);\nInput_Bind(INPUT.CANCEL,  INPUT_TYPE.GAMEPAD, 0, gp_face2);\n\n// ---------- 使用 ----------\n// 地图移动\nvar hsp = (Input_IsHeld(INPUT.RIGHT) - Input_IsHeld(INPUT.LEFT)) * 2;\nvar vsp = (Input_IsHeld(INPUT.DOWN)  - Input_IsHeld(INPUT.UP))   * 2;\nif (hsp != 0 && vsp != 0) { hsp *= 0.7071; vsp *= 0.7071; }  // 斜向归一化\nx += hsp; y += vsp;\n\n// 确认\nif (Input_IsPressed(INPUT.CONFIRM)) { /* ... */ }",
      "storageShowcase": "// ============ 存档：什么时候用哪一级 ============\n\n// ── Static：玩家在存档点保存时才写 ──\n// 用于：HP、LV、装备、道具、剧情进度\nStorage_SetStaticFlag(FLAG_STATIC_HP, Player_GetHp());\nStorage_SetStaticFlag(FLAG_STATIC_PLOT, 3);\n\n// ── Info：只给存档界面看 ──\nStorage_SetInfoFlag(FLAG_INFO_NAME, Player_GetName());\nStorage_SetInfoFlag(FLAG_INFO_LV,   Player_GetLv());\nStorage_SetInfoFlag(FLAG_INFO_ROOM, room);\n// FLAG_INFO_TIME 需要自己维护（引擎不会自动累计时长）\n\n// ── Temp：跨房间传递，不落盘 ──\n// 例：进战斗前记住回来的房间\nStorage_SetTempFlag(FLAG_TEMP_BATTLE_ROOM_RETURN, room);\n// 战斗结束后读出来\nvar back = Storage_GetTempFlag(FLAG_TEMP_BATTLE_ROOM_RETURN);\n\n// ── 保存 / 读取 ──\nStorage_SetSaveSlot(0);\nStorage_SaveGame();\nStorage_LoadGame();"
   }
};
