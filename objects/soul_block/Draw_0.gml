surface_set_target(Battle_GetBoardSurface());{
	draw_self();
	draw_set_color(battle_soul.image_blend);
	draw_circle(x,y,30,1);
}surface_reset_target();
