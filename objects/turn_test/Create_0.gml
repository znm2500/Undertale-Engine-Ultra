/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码 

Battle_CreateBoardRect(320,320+30,50,50,50,50,,90,1,1)
Battle_CreateBoardRect(320-50,320,50,50,30,30,,,-1,0)
Battle_CreateBoardRect(320-100,320,50,50,30,30,,90,1,1)
a=Battle_CreateBoardPoints(320+100,320,,,1,1)
Battle_AddBoardVertex(a,100,-100)
Battle_AddBoardVertex(a,120,20)
Battle_AddBoardVertex(a,-100,-100)
Battle_MakePlatform(320,320,30,20,1,1,1,1)
// Inherit the parent event
event_inherited();

