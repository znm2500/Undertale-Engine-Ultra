/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码 
Battle_SetSoul(battle_soul_blue)
Battle_CreateBoardRect(320,320+30,50,50,50,50,,,0,1)
//Battle_CreateBoardRect(320-50,320,50,50,30,30,,,-0,0)
//Battle_CreateBoardRect(320-100,320,50,50,30,30,,90,0,1)
Battle_MakePlatform(320,320,30,20,1,1,1,1)
// Inherit the parent event
event_inherited();

