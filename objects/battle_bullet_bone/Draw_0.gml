/// @description Insert description here
// You can write your code in this editor

if(type=0){
	image_blend = c_white;
}
if(type=1){
	image_blend = c_aqua;
}
if(type=2){
	image_blend = c_orange;
}

if(out = 0){
	depth = DEPTH_BATTLE.BULLET;
	surface_set_target(Battle_GetBoardSurface());{
		draw_self()
	}surface_reset_target();
}
else{
	depth = DEPTH_BATTLE.BULLET_OUTSIDE_LOW;
	draw_self()
}


