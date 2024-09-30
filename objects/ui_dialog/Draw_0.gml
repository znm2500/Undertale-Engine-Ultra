if (!surface_exists(_surface_text)) _surface_text = surface_create(640, 480);
surface_set_target(global.surface_gui);
if (_top) {
    draw_sprite_ext(spr_pixel, 0, 32, 10, 578, 152, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 38, 16, 566, 140, 0, c_black, 1);
} else {
    draw_sprite_ext(spr_pixel, 0, 32, 320, 578, 152, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 38, 326, 566, 140, 0, c_black, 1);
}
if (instance_exists(_inst) && _inst._paused && _choose_enable) {
    draw_sprite_ext(spr_battle_soul, 0, x + 11.5 * (string_width(" ") * _inst._scale_x) + _choose_soul * (string_width("         " + _choice[0]) * _inst._scale_x), _inst.y + 2.5 * ((string_height(" ") + 1) * _inst._scale_y), 1, 1, 90 * !global.classic_ui, c_red, 1);
}
draw_surface(_surface_text, 0, 0);
surface_reset_target();
surface_set_target(_surface_text);
draw_clear_alpha(c_white, 0);
surface_reset_target();