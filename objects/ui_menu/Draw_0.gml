if (!surface_exists(_surface)) {
    _surface = surface_create(640, 480);
}
if (!surface_exists(_surface_text)) {
    _surface_text = surface_create(640, 480);
}
surface_set_target(global.surface_gui);
draw_sprite_ext(spr_pixel, 0, 2 * _offset + 32, 52 + (_top ? 270 : 0), 142, 110, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, 2 * _offset + 32 + 6, 52 + 6 + (_top ? 270 : 0), 142 - 6 * 2, 110 - 6 * 2, 0, c_black, 1);

draw_sprite_ext(spr_pixel, 0, 2 * _offset + 32, 168, 142, 148, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, 2 * _offset + 32 + 6, 168 + 6, 142 - 6 * 2, 148 - 6 * 2, 0, c_black, 1);

draw_set_font(font_crypt_of_tomorrow);
draw_set_color(c_white);
draw_text_ext_transformed(2 * _offset + 32 + 6 + 8, 52 + (_top ? 270 : 0) + 6 + 42, "LV  " + string(Player_GetLv()) + "\nHP  " + string(Player_GetHp()) + "/" + string(Player_GetHpMax()) + "\nG   " + string(Player_GetGold()), 9, -1, 2, 2, 0);

if (_menu == 0||_menu == -1) {
    draw_sprite_ext(spr_battle_soul, 0, 2 * _offset + 32 + 6 + 27, 168 + 6 + 31 + 36 * _choice_soul, 1, 1, !global.classic_ui * 90, c_red, 1);
}

// ITEM
if (_menu == 1 || _menu == 2 || (_show_width[0] != 0)) {
    draw_sprite_ext(spr_pixel, 0, 188, 52, _show_width[0] * 2, 362, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 188 + 6, 52 + 6, (_show_width[0] - 6 >= 0 ? _show_width[0] - 6 : 0) * 2, 362 - 6 * 2, 0, c_black, 1);
}
// STAT
if (_menu == 3 || _show_width[1] != 0) {
    draw_sprite_ext(spr_pixel, 0, 188, 52, _show_width[1] * 2, 418, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 188 + 6, 52 + 6, (_show_width[1] - 6 > 0 ? _show_width[1] - 6 : 0) * 2, 418 - 6 * 2, 0, c_black, 1);

}
surface_reset_target();
if (_menu == 1) {
    surface_set_target(_surface);

    draw_sprite_ext(spr_battle_soul, 0, (94 + 3 + 11) * 2, (26 + 3 + 20 + 16 * _choice_item_soul) * 2, 1, 1, !global.classic_ui * 90, c_red, 1);
    surface_reset_target();
}

if (_menu == 2) {
    surface_set_target(_surface);
    draw_sprite_ext(spr_battle_soul, 0, (94 + 3 + _choice_item_operate_soul) * 2, (26 + 3 + 159.5) * 2, 1, 1, !global.classic_ui * 90, c_red, 1);
    surface_reset_target();

}

// PHONE
if (_menu == 4 || _show_width[2] != 0) {
    surface_set_target(global.surface_gui);
    draw_sprite_ext(spr_pixel, 0, 188, 52, _show_width[2] * 2, 270, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 188 + 6, 52 + 6, (_show_width[2] - 6 > 0 ? _show_width[2] - 6 : 0) * 2, 270 - 6 * 2, 0, c_black, 1);

    surface_reset_target();
    surface_set_target(_surface);
    if (_menu == 4) draw_sprite_ext(spr_battle_soul, 0, (94 + 3 + 11) * 2, (26 + 3 + 20 + 16 * _choice_phone_soul) * 2, 1, 1, !global.classic_ui * 90, c_red, 1);
    surface_reset_target();
}
for (var i = 0; i < 2; i++) {
    if (_show_width[i] != 0) break;
}
surface_set_target(global.surface_gui) draw_surface_part_ext(_surface, 0, 0, (91 + _show_width[i]) * 2, 480, _offset * 2, 0, 1, 1, c_white, 1);
draw_surface_part_ext(_surface_text, 0, 0, (91 + _show_width[i]) * 2, 480, _offset * 2, 0, 1, 1, c_white, 1);
surface_reset_target();
surface_set_target(_surface);
draw_clear_alpha(c_white, 0);
surface_reset_target();
surface_set_target(_surface_text);
draw_clear_alpha(c_white, 0);
surface_reset_target();