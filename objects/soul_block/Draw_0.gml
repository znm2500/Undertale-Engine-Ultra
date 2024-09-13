/// @description Insert description here
// You can write your code in this editor

surface_set_target(Battle_GetBoardSurface());{
	draw_self();
	draw_set_color(image_blend);
	draw_circle(x,y,30,1);
}surface_reset_target();
