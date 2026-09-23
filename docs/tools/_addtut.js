// 在 TUT_SECTIONS 的「引擎速览」之后插入一节「引擎的启动流程」
// 用 JSON 解析 → 插入 → 序列化回写，避免手工改内联脚本出错
const fs = require('fs');
const P = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const FILE = P + 'UNDERTALE-Engine-Ultra-手册.html';

let html = fs.readFileSync(FILE, 'utf8');

// 备份
fs.copyFileSync(FILE, P + '_bak3-UNDERTALE-Engine-Ultra-手册.html');

const KEY = 'const TUT_SECTIONS = [';
const i = html.indexOf(KEY);
if (i < 0) throw new Error('找不到 TUT_SECTIONS');
const start = i + KEY.length - 1;            // 指向 '['
// 从 '[' 开始配平找到数组结尾
let depth = 0, end = -1, inStr = false, esc = false;
for (let k = start; k < html.length; k++) {
  const c = html[k];
  if (inStr) {
    if (esc) esc = false;
    else if (c === '\\') esc = true;
    else if (c === '"') inStr = false;
    continue;
  }
  if (c === '"') { inStr = true; continue; }
  if (c === '[' || c === '{') depth++;
  else if (c === ']' || c === '}') { depth--; if (depth === 0) { end = k; break; } }
}
if (end < 0) throw new Error('数组未闭合');

const arrRaw = html.slice(start, end + 1);
const arr = JSON.parse(arrRaw);              // 已验证是合法 JSON
console.log('原有章节数: ' + arr.length);

const NEW = {
  h: '引擎的启动流程',
  lead: '读完这节你就知道引擎是怎么跑起来的、全局状态挂在哪 —— 想改全局行为，先找 world。',
  body: [
    '',
    '      <h4>唯一常驻物件：world</h4>',
    '      <p>引擎里有一个物件跟其它 90 个都不一样：<code>world</code>。它的 <code>persistent</code> 为 <b>true</b>（跨房间常驻，切场景不销毁）、<code>visible</code> 为 <b>false</b>、<b>没有父物体也没有精灵</b>。全工程只此一个，它是引擎的<b>总控与全局状态容器</b>。</p>',
    '      <p>打开 objects/world/ 你会看到它只有 6 个事件，但每一个都卡在关键位置上。理解这 6 个事件，就等于理解了引擎的生命周期。</p>',
    '',
    '      <h4>启动顺序（Other_2 · Game Start）</h4>',
    '      <p>游戏启动时，<code>world</code> 的 Game Start 事件依次做四件事：</p>',
    '      <p><b>① 初始化 9 个子系统</b>（顺序不能乱，后面依赖前面）：</p>',
    '      <table>',
    '        <tr><td><code>Anim_Init()</code></td><td>动画 / 补间系统</td></tr>',
    '        <tr><td><code>Shop_Init()</code></td><td>商店数据结构</td></tr>',
    '        <tr><td><code>Input_Init()</code></td><td>输入系统</td></tr>',
    '        <tr><td><code>Item_Init()</code></td><td>物品系统</td></tr>',
    '        <tr><td><code>Storage_Init()</code></td><td>四级存储</td></tr>',
    '        <tr><td><code>Encounter_Init()</code></td><td>遭遇战</td></tr>',
    '        <tr><td><code>BGM_Init()</code></td><td>背景音乐</td></tr>',
    '        <tr><td><code>Dialog_Init()</code></td><td>对话框</td></tr>',
    '        <tr><td><code>Demo_Init()</code></td><td>录像录制 / 回放</td></tr>',
    '      </table>',
    '      <p><b>② 写入默认键位</b> —— 用 <code>Input_Bind()</code> 绑定：确认 = Enter 与 Z，取消 = Shift 与 X，菜单 = Ctrl 与 C，方向键 = ↑↓←→。想换键位改这里，或在自己的代码里再绑一次。</p>',
    '      <p><b>③ 创建四个常驻单例物件</b>：<code>camera</code>（镜头）、<code>fader</code>（全屏淡入淡出）、<code>border</code>（战斗框边框）、<code>closed_captions</code>（字幕）。</p>',
    '      <p><b>④ 收尾</b>：<code>application_surface_draw_enable(false)</code> 关掉默认的画面自动绘制（引擎自己用 surface 管理渲染），<code>randomize()</code> 重置随机种子，最后 <code>room_goto_next()</code> 进入下一个房间 —— <b>游戏正式开始</b>。</p>',
    '',
    '      <h4>每帧驱动（Step）</h4>',
    '      <p><code>world</code> 的 Step 事件每帧做四件事：</p>',
    '      <p>· 驱动三大系统：<code>Time_Step()</code> / <code>Anim_Step()</code> / <code>BGM_Step()</code></p>',
    '      <p>· 累加游玩时间：每累计满 1 秒就把静态存储里的 <code>FLAG_STATIC_TIME</code> 加 1 —— 存档界面显示的游玩时长就是这么来的</p>',
    '      <p>· 跳帧：<code>Game_GetFrameSkip()</code> 大于 0 时按设定跳过若干帧的绘制，用来在低配机器上稳住帧率</p>',
    '      <p>· 快捷键：<b>F2 重开游戏</b>（<code>game_restart()</code>）、<b>F4 切换全屏</b>（不按任何修饰键时）</p>',
    '',
    '      <h4>退出与清理</h4>',
    '      <p><b>Other_3（Game End）</b>：反向反初始化 7 个子系统（<code>Anim_Uninit</code> / <code>Dialog_Uninit</code> / <code>Item_Uninit</code> / <code>Storage_Uninit</code> / <code>Encounter_Uninit</code> / <code>Input_Uninit</code> / <code>Demo_Uninit</code>）。</p>',
    '      <p><b>CleanUp</b>：<code>surface_free(global.surface_gui)</code> 释放 GUI 用的 surface，避免显存泄漏。</p>',
    '',
    '      <h4>全局开关（Create）</h4>',
    '      <p><code>world</code> 的 Create 里写了一批 <code>global.*</code> 开关，改引擎的全局行为先来这里：</p>',
    '      <table>',
    '        <tr><td><code>global.blur_strength</code></td><td>横向 / 纵向模糊强度，默认 [0,0]</td></tr>',
    '        <tr><td><code>global.blur_amount</code></td><td>模糊程度，默认 0</td></tr>',
    '        <tr><td><code>global.classic_ui</code></td><td>是否用经典 UI 布局，默认 0（新版）</td></tr>',
    '        <tr><td><code>global.Panel</code></td><td>FIGHT 攻击条外观物件，默认 battle_menu_fight_knife</td></tr>',
    '        <tr><td><code>global.kr</code></td><td>是否启用 KR（业报）机制，默认 1</td></tr>',
    '        <tr><td><code>global.surface_gui</code></td><td>GUI 渲染用的 surface，默认 640×480</td></tr>',
    '      </table>',
    '      <div class="tip"><b>想加自己的全局设置？</b>直接加在 <code>world</code> 的 Create 事件里，用 <code>global.你的变量</code> 命名，全工程任何脚本都能访问；如果申请了 surface / ds_map 这类资源，记得在 CleanUp 里释放。<span class="go" onclick="pickEx(\'ex_start_project\')">示例：开工清单 · 把引擎改成你自己的游戏 →</span></div>'
  ].join('\n')
};

// 插到「引擎速览」（index 0）之后
arr.splice(1, 0, NEW);
console.log('新章节数: ' + arr.length);
console.log('前 3 节: ' + arr.slice(0, 3).map(s => s.h).join(' / '));

html = html.slice(0, start) + JSON.stringify(arr) + html.slice(end + 1);
fs.writeFileSync(FILE, html, 'utf8');
console.log('已写入，HTML 大小 ' + (fs.statSync(FILE).size / 1024).toFixed(1) + ' KB');
