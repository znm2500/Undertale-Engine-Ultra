// 术语修正（用户指定，2026-09-21）：battle_board 统一译为「战斗框」；
// cover 参数语义：1 = 减框（从战斗框里挖掉一块），0 = 加框（区域并入战斗框）。
// 运行：node docs/tools/_term_board.js（内部用 __dirname 定位，与 cwd 无关）
// 注意：只改 manual-api.js 数据；字典源文件的同步修正见 _term_board_dicts.js。
const fs = require('fs');
const path = require('path');
const DOCS = path.join(__dirname, '..');

global.window = {};
require(path.join(DOCS, 'manual-api.js'));
const A = window.API;

// 面板→框 的条目白名单（均为 battle_board / 战斗框语境）
const FN = new Set(['__Battle_Iloop','__Battle_RegisterBoard','__Battle_RemoveBoard','__Battle_RemoveBoardController',
  'Battle_AddBoardVertex','Battle_CreateBoardCircle','Battle_CreateBoardEllipse','Battle_CreateBoardPoints',
  'Battle_CreateBoardRect','Battle_CreateBoardRoundrect','Battle_GetBoardSurface','Battle_IsBoardTransforming',
  'Battle_MakeBone','Battle_MakeBoneArrow','Battle_MakeBoneBottom','Battle_MakeBoneLeft','Battle_MakeBoneRight','Battle_MakeBoneTop',
  'Battle_MakeBoneTwoH','Battle_MakeBoneTwoV',
  'Battle_MakeBoneWallBottom','Battle_MakeBoneWallLeft','Battle_MakeBoneWallRight','Battle_MakeBoneWallTop',
  'Battle_SetBoardSize','Battle_SetTurnInfo',
  'Border_GetSprite','Border_IsEnabled','Border_SetEnabled','Border_SetSprite',
  'Camera_Shake','Encounter_GetMenuDialog','Encounter_GetSoulX','Encounter_GetSoulY']);
const OB = new Set(['battle','battle_bg','battle_board','battle_bullet','battle_bullet_bone','battle_dialog_enemy',
  'battle_enemy','battle_fader','battle_menu_fight_anim_knife','battle_menu_item_scrollbar','battle_result_flee',
  'battle_soul','battle_soul_blue','battle_soul_green','bone_box','bone_circle','border','shaker']);

// 打磨：blanket 面板→框 之后，个别短语恢复成更自然的说法。
// 全部用「负向后行断言」正则，保证幂等：重复运行不会把「战斗框」再叠成「战斗战斗框」。
const POLISH = [
  [/，框背景与内容都画在它上面/g, '，背景与内容都画在它上面'],
  [/(?<!战斗)框背景的离屏 surface/g, '战斗框背景的离屏 surface'],
  [/(?<!战斗)框附加装饰层的 surface/g, '战斗框附加装饰层的 surface'],
  [/(?<!战斗)框最上层遮盖层的 surface/g, '战斗框最上层遮盖层的 surface'],
  [/(?<!战斗)框遮罩用的 surface/g, '战斗框遮罩用的 surface'],
  [/裁掉超出框的部分/g, '裁掉超出战斗框的部分'],
  [/(?<!战斗)框底色的透明度/g, '战斗框底色的透明度'],
  [/(?<!战斗)框底色/g, '战斗框底色'],
  [/(?<!战斗)框边框颜色/g, '战斗框边框颜色'],
  [/(?<!战斗)框边框的透明度/g, '战斗框边框的透明度'],
  [/(?<!战斗)主框实例/g, '主战斗框实例'],
  [/(?<!战斗)框编号的自增计数器/g, '战斗框编号的自增计数器'],
  [/(?<!战斗)框中心坐标/g, '战斗框中心坐标'],
  [/(?<!战斗)框旋转角与内部角/g, '战斗框旋转角与内部角'],
  [/(?<!战斗)框旋转的内部角度值/g, '战斗框旋转的内部角度值'],
  [/(?<!战斗)框内底色与透明度/g, '战斗框内底色与透明度'],
  [/对话框用它与中心点算出上边界/g, '对话框的上边界同理'],
  [/(?<!战斗)自绘框/g, '自绘战斗框'],
  [/空框/g, '空战斗框'],
];

function fix(s){
  if(typeof s!=='string') return s;
  s = s.replace(/战斗面板/g,'战斗框').replace(/面板/g,'框');
  POLISH.forEach(([re,b])=>{ s = s.replace(re,b); });
  return s;
}
// 递归处理对象内所有字符串字段
function walk(o){
  if(typeof o==='string') return fix(o);
  if(Array.isArray(o)) return o.map(walk);
  if(o&&typeof o==='object'){ for(const k in o) o[k]=walk(o[k]); }
  return o;
}

let changed=0;
A.functions.forEach(f=>{ if(FN.has(f.n)){ const before=JSON.stringify(f); walk(f); if(JSON.stringify(f)!==before) changed++; } });
A.objects.forEach(o=>{ if(OB.has(o.n)){ const before=JSON.stringify(o); walk(o); if(JSON.stringify(o)!==before) changed++; } });
// 分组描述（core 组提到「面板」）
A.objectsGroups.forEach(g=>{ g.desc=fix(g.desc||''); });
// 分类描述与名称（board 分类名「战斗面板」→「战斗框」）
A.categories.forEach(c=>{ c.desc=fix(c.desc||''); c.name=fix(c.name||''); });

// cover 参数补三列说明 + 描述里点明减框/加框
const COVER_DESC='1 = 减框：把这块区域从战斗框里挖掉，灵魂进不去（形状本身不可见，判定范围沿轮廓外扩一圈）；0 = 加框：把这块区域并入战斗框，灵魂可进入（正常绘制）';
const BOARD_PARAMS={
  Battle_CreateBoardPoints:{x:'框中心 X',y:'框中心 Y',board_depth:'绘制深度',angle:'旋转角',rotate:'每帧自转角速度'},
  Battle_CreateBoardRect:{x:'框中心 X',y:'框中心 Y',up:'向上延伸距离（不是高度）',down:'向下延伸距离',left:'向左延伸距离',right:'向右延伸距离',board_depth:'绘制深度',angle:'旋转角',rotate:'每帧自转角速度'},
  Battle_CreateBoardCircle:{x:'框中心 X',y:'框中心 Y',radius:'半径',board_depth:'绘制深度'},
  Battle_CreateBoardEllipse:{x:'框中心 X',y:'框中心 Y',radius_x:'横半径',radius_y:'竖半径',board_depth:'绘制深度',angle:'旋转角',rotate:'每帧自转角速度'},
  Battle_CreateBoardRoundrect:{x:'框中心 X',y:'框中心 Y',size:'边长',corner_radius:'圆角半径',board_depth:'绘制深度',angle:'旋转角',rotate:'每帧自转角速度'},
};
A.functions.forEach(f=>{
  if(!BOARD_PARAMS[f.n]) return;
  const desc=BOARD_PARAMS[f.n];
  f.p=(f.p||[]).map(row=>{
    if(!Array.isArray(row)) return row;
    const [n,t]=row;
    if(n==='cover') return ['cover','0/1',COVER_DESC];
    return [n, t||'number', desc[n]||''];
  });
  // 描述里的「是否遮挡」等旧说法统一成减框/加框
  f.d=(f.d||'').replace(/是否遮挡/g,'cover：1 = 减框，否则加框');
});

// world.global.Panel 消除歧义：那是 FIGHT 攻击条，不是战斗框
const w=A.objects.find(o=>o.n==='world');
const pv=(w.v||[]).find(v=>v[0]==='global.Panel');
if(pv) pv[1]='FIGHT 攻击条使用的外观物件（见 Battle_SetMenuFightPanel），默认 battle_menu_fight_knife。换成别的物件即可改攻击条造型。';

// 写回前自检：还有哪些白名单外条目残留「战斗面板」
const leftover=[];
A.functions.forEach(f=>{ if(!FN.has(f.n) && JSON.stringify(f).includes('战斗面板')) leftover.push('fn:'+f.n); });
A.objects.forEach(o=>{ if(!OB.has(o.n) && o.n!=='world' && JSON.stringify(o).includes('战斗面板')) leftover.push('obj:'+o.n); });

fs.writeFileSync(path.join(DOCS,'manual-api.js'),
  '/* eslint-disable */\n// Undertale-Engine-Ultra 手册数据 · 自动生成 + 人工维护 · 结构见 _TODO.md\nwindow.API = '+JSON.stringify(A,null,1)+';\n', {encoding:'utf8'});
console.log('entries changed:',changed,'| cover params:',Object.keys(BOARD_PARAMS).length);
console.log('leftover 战斗面板:',leftover.length?leftover.join(', '):'无');
