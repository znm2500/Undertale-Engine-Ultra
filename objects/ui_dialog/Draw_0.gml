if (_top) {
	draw_sprite_ext(spr_pixel, 0, 32 / 2, 10 / 2, 578 / 2, 152 / 2, 0, c_white, 1);
	draw_sprite_ext(spr_pixel, 0, 38 / 2, 16 / 2, 566 / 2, 140 / 2, 0, c_black, 1);
} else {
	draw_sprite_ext(spr_pixel, 0, 32 / 2, 320 / 2, 578 / 2, 152 / 2, 0, c_white, 1);
	draw_sprite_ext(spr_pixel, 0, 38 / 2, 326 / 2, 566 / 2, 140 / 2, 0, c_black, 1);
}
if (instance_exists(_inst) && _inst._paused && _choose_enable) {
	draw_sprite_ext(spr_battle_soul, 0, x + 11.5 * (string_width(" ") * _inst._scale_x) + _choose_soul * (string_width("         "+_choice[0]) * _inst._scale_x), _inst.y + 2.5 * ((string_height(" ") + 1) * _inst._scale_y), 1 / 2, 1 / 2, 90, c_red, 1)
}