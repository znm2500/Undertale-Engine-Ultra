if (!battle_soul_aqua.type) {
	surface_set_target(Battle_GetBoardSurface());
	draw_set_color(c_aqua);
	draw_circle(x, y, 30, 1);
	surface_reset_target();
}