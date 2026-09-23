// _TODO.md：状态行 + 新增 2026-09-22 小节（示例重写第 1 篇 + User Event 口径修正）
const fs = require('fs');
const TODO = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/_TODO.md';
const LOGP = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/tools/_todo_update.txt';
const lines = [];
fs.copyFileSync(TODO, TODO + '.bak3');

let td = fs.readFileSync(TODO, 'utf8');
const tdLines = td.split('\n');
let n = 0;
for (let i = 0; i < tdLines.length; i++) {
  if (tdLines[i].startsWith('> 状态：') && tdLines[i].includes('第九轮')) {
    tdLines[i] = '> 状态：**已完成（2026-09-22：示例重写第 1 篇「用 battle_enemy_test 跑通遭遇战」；并全库修正 User Event 编号口径 —— 正确为 User Event 0~13 = BATTLE_ENEMY_EVENT 枚举值，此前误用 .yy 文件号 10~23）** · 最后更新：2026-09-22';
    n++;
  }
}
if (n !== 1) throw new Error('状态行匹配数异常: ' + n);
td = tdLines.join('\n');

const anchor = '## 第九轮（2026-09-21）：清空示例数据';
if (!td.includes(anchor)) throw new Error('第九轮锚点不匹配');
const NEW = [
  '## 2026-09-22：示例重写第 1 篇 + User Event 口径修正',
  '',
  '**写示例时发现并全库修正了一个错误口径**：手册一直写「敌人事件 = User Event 10~23（枚举值 + 10）」，但源码实证 `Battle_CallEnemyEvent` 用 `event_user(枚举值)` 直调，**正确映射是 User Event 0~13 = BATTLE_ENEMY_EVENT 枚举值**（`.yy` 事件文件名 Other_10~23 是 GMS2 的「User Event N 存为 Other_(N+10)」规则，此前把文件号当成了事件号）。修正范围：`API.enemyEvents` 14 条编号、battle_enemy 卡、battle_enemy_test 卡（顺带修正「打印与断言」的错误描述，实际是 UE8 生成 turn_test）、`snippets.enemyFull` 4 处 / `customBullet` 2 处、教程速览表格 1 处。脚本 `tools/_ue_fix.js`，备份 `_bak10-manual-api.js` / `_bak10-…html`。',
  '',
  '**示例重写第 1 篇**：`ex_encounter_battle_enemy_test`（入门）——用自带 battle_enemy_test 跑通遭遇战全流程：Encounter_Custom 默认注册（Encounter_Set 11 参数，后 6 可省）→ trigger 触发（User Event 0 里 `_triggered=true; Encounter_Start(0);`）→ 战斗内 turn_test 演示 → 换自己的敌人。脚本 `tools/_ex_write1.js`，备份 `_bak10-manual-examples.js` / `_verify.js.bak2`。`_verify.js` 示例断言从空态改回有数据。四道校验全绿。',
  '',
].join('\n') + anchor;
td = td.replace(anchor, NEW);
fs.writeFileSync(TODO, td, { encoding: 'utf8' });
lines.push('_TODO.md 状态行 + 2026-09-22 小节已写入');
lines.push('ALL OK');
fs.writeFileSync(LOGP, lines.join('\n'), { encoding: 'utf8' });
