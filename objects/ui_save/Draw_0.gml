if (!surface_exists(_surface)) {
    _surface = surface_create(room_width * 2, room_height * 2)
}
if (_state == 0 || _state == 1) {
    draw_sprite_ext(spr_pixel, 0, (320 - _show_width) / 2, 118 / 2, _show_width, 174 / 2, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, (320 - (_show_width >= 6 ? _show_width - 6 : 0)) / 2, (118 + 6) / 2, _show_width >= 6 ? _show_width - 6 : 0, (174 - 6 * 2) / 2, 0, c_black, 1);
}

if (_state == 0) {
    surface_set_target(_surface) draw_sprite_ext(spr_battle_soul, 0, (108 + 6 + 37 + _choice_soul * 180), (118 + 6 + 131), 1, 1, 90, c_red, 1);
    surface_reset_target()
}
draw_surface_part_ext(_surface, room_width - (_show_width >= 6 ? _show_width - 6 : 0), 0, (_show_width >= 6 ? _show_width - 6 : 0) * 2, room_height * 2, 160 - (_show_width >= 6 ? _show_width - 6 : 0) / 2, 0, 0.5, 0.5, c_white, 1);
surface_set_target(_surface);
draw_clear_alpha(c_white, 0);
surface_reset_target();