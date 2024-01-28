/// @description Insert description here
// You can write your code in this editor
Battle_CreateBoardExtraRoundrect(100,320,40,45)
Battle_CreateBoardCoverRoundrect(400,320,40,45)
b=instance_create_depth(200,150,0,battle_board_cover_rect)
Battle_CreateBoardExtraRect(320,400,50,50,50,50,,1)
c=Battle_CreateBoardCover(200,200,0)
Battle_AddBoardVertex(c,100, 20)
Battle_AddBoardVertex(c,100, 70)
Battle_AddBoardVertex(c,-100, 70)
Battle_AddBoardVertex(c,-150, 20)
Battle_CreateBoardCoverCircle(320,100,20)
a=Battle_CreateBoardExtra(500,200,0)
Battle_AddBoardVertex(a,100, 20)
Battle_AddBoardVertex(a,120, 70)
Battle_AddBoardVertex(a,-100, 80)
Battle_AddBoardVertex(a,-160, 10)
Battle_CreateBoardExtraCircle(500,500,40)
event_inherited();

