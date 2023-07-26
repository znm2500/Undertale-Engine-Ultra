/// @description Insert description here
// You can write your code in this editor

surface_set_target(Battle_GetBoardSurface());{
	draw_self();
	draw_sprite_ext(spr_soul_aren,0,x,y,1,1,0,make_color_rgb(0,255,0),1)
}surface_reset_target();
