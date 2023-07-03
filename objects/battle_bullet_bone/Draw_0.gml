/// @description Insert description here
// You can write your code in this editor

if(type=0){
	blend = c_white;
}
if(type=1){
	blend = make_color_rgb(20,196,255);
}
if(type=2){
	blend = make_color_rgb(248,148,29);
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

