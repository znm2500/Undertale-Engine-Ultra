// 重写教程页「引擎速览」，保留「引擎的启动流程」，删除其后所有章节
const fs = require('fs');
const p = 'docs/index.html';
let s = fs.readFileSync(p, 'utf8');

const lineRe = /^const TUT_SECTIONS = (.*)$/m;
const m = s.match(lineRe);
if (!m) throw new Error('TUT_SECTIONS not found');
const oldArr = JSON.parse(m[1].replace(/;\s*$/, ''));
const keep = oldArr.find(x => x.h === '引擎的启动流程');
if (!keep) throw new Error('启动流程 section not found');

const OVERVIEW = {
  h: '引擎速览',
  lead: '先花三分钟认识项目里有什么、代码怎么组织，后面的教程都会用到这些概念。',
  body: `
      <h4>这是什么</h4>
      <p>UNDERTALE Engine Ultra 是用 GameMaker Studio 2 制作的 Undertale 同人游戏引擎（当前 <code>ENGINE_VERSION v2.0.1</code>，60 帧），基于 TML 的 UndertaleEngine 改进扩展。打开工程根目录的 <code>UNDERTALE Engine Ultra.yyp</code> 按 F5 即可运行：Logo → 主菜单 → 示例地图 <code>room_area_0</code>，直接就能体验完整的地图、对话与战斗流程。</p>

      <h4>项目里有什么</h4>
      <table class="pt">
        <tr><th>目录</th><th>规模</th><th>内容</th></tr>
        <tr><td>scripts/</td><td>301 个模块</td><td>引擎全部函数，命名前缀即模块名</td></tr>
        <tr><td>objects/</td><td>91 个物体</td><td>战斗、角色、商店、UI 等实体</td></tr>
        <tr><td>rooms/</td><td>8 个房间</td><td>初始化、Logo、主菜单、示例地图、战斗、商店、设置、游戏结束</td></tr>
        <tr><td>sprites/ · sounds/</td><td>91 · 38</td><td>贴图与音频资源</td></tr>
      </table>

      <h4>脚本层：调函数就够了</h4>
      <p>引擎所有能力都以 <code>XXX_DoSomething()</code> 函数暴露，<b>前缀即模块</b>。你 90% 的代码只需要调函数，不用碰物体内部：</p>
      <table class="pt">
        <tr><th>前缀</th><th>规模</th><th>负责什么</th></tr>
        <tr><td>Battle_*</td><td>108</td><td>战斗核心：回合流程、战斗框、弹幕、菜单、敌人接口</td></tr>
        <tr><td>Player_*</td><td>58</td><td>玩家：HP/LV、装备、伤害公式、移动与初始数据</td></tr>
        <tr><td>Shop_* / Item_* / Inventory</td><td>27</td><td>商店、物品类型、背包</td></tr>
        <tr><td>Demo_*</td><td>19</td><td>输入录制与回放（调试、自动演示）</td></tr>
        <tr><td>Encounter_* / Storage_* / BGM_*</td><td>各 14</td><td>遭遇战配置 / 四级存档 / 音乐播放</td></tr>
        <tr><td>Dialog_* / TextTyper</td><td>8</td><td>对话框与打字机</td></tr>
        <tr><td>Macro_*</td><td>11</td><td>全部枚举与常量（战斗、输入、存储键名、绘制深度…）</td></tr>
        <tr><td>Anim / Input / Time / Camera / Fader 等</td><td>—</td><td>补间动画、输入映射、计时、镜头、淡入淡出等基础设施</td></tr>
      </table>

      <h4>物体层：继承 + User Event</h4>
      <p>91 个物体里，先记住这几条继承链：</p>
      <table class="pt">
        <tr><th>父物体</th><th>现成派生</th><th>怎么用</th></tr>
        <tr><td>battle_enemy</td><td>battle_enemy_test</td><td>你的敌人把它设为 Parent，在 User Event 10~23 里写回合逻辑</td></tr>
        <tr><td>battle_bullet</td><td>_bone / _bone_3d / _gb / _arrow</td><td>骨头、冲击波、箭矢都在这条链上，自定义弹幕同样继承它</td></tr>
        <tr><td>battle_soul</td><td>red / blue / green / yellow / orange / aqua / purple</td><td>七种灵魂玩法，<code>Battle_SetSoul()</code> 一行切换</td></tr>
        <tr><td>char_*</td><td>char_player / char_sans / char_save / char_sign</td><td>地图角色与交互物</td></tr>
        <tr><td>trigger_*</td><td>trigger_warp / trigger_shop</td><td>碰撞即触发换图 / 进商店</td></tr>
      </table>
      <p>唯一例外是 <code>world</code>：没有父物体和精灵、persistent 常驻，是引擎的总控（下节详述）。</p>

      <h4>数据层：四级存储</h4>
      <p>所有持久化数据走 <code>Storage_*</code> 函数 + <code>FLAG_*</code> 键名宏（定义在 <code>Macro_Flag</code>），分四级：<b>Static</b>（存档点落盘的进度）、<b>Dynamic</b>（与存档槽绑定的动态数据）、<b>Info</b>（存档界面展示）、<b>Temp</b>（跨房间临时传递，不落盘）。</p>

      <h4>改造入口：*_Custom</h4>
      <p>引擎把「应该由你改」的地方集中成 <code>*_Custom</code> 系列脚本：<code>Encounter_Custom</code> 注册遭遇战、<code>Item_Custom</code> 注册物品、<code>Shop_Custom</code> 注册商店、<code>Storage_Custom*</code> 注册存档字段、<code>Player_CustomInitialData</code> 设新档初始状态。游戏名、作者、版本、存档文件名在 <code>Macro_Game</code> 里改。</p>
      <div class="tip"><b>核心心法：</b>引擎把「敌人」当成一个<b>事件驱动的黑箱</b>。你不写主循环，只要在正确的时机（User Event）把参数（<code>Battle_SetTurnInfo</code>）和内容（<code>Battle_MakeBone</code>）塞进去，引擎负责其余的一切调度。各系统的具体写法见「示例」页。</div>`
};

const newArr = [OVERVIEW, keep];
s = s.replace(lineRe, 'const TUT_SECTIONS = ' + JSON.stringify(newArr) + ';');

const oldDesc = '本教程覆盖战斗系统、弹幕生成、灵魂模式、对话、物品、存档与输入系统的实战写法。';
const newDesc = '本教程讲清引擎的整体结构与启动流程；各系统的具体写法见「示例」页，函数与物体细节见「函数」「物体」页。';
if (!s.includes(oldDesc)) throw new Error('intro description not found');
s = s.replace(oldDesc, newDesc);

fs.writeFileSync(p, s);
console.log('OK: sections =', newArr.map(x => x.h).join(' / '));
