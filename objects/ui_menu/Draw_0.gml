draw_sprite_ext(spr_pixel, 0, _offset + 16, 26 + (_top ? 135 : 0), 71, 55, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, _offset + 16 + 3, 26 + 3 + (_top ? 135 : 0), 71 - 3 * 2, 55 - 3 * 2, 0, c_black, 1);

draw_sprite_ext(spr_pixel, 0, _offset + 16, 84, 71, 74, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, _offset + 16 + 3, 84 + 3, 71 - 3 * 2, 74 - 3 * 2, 0, c_black, 1);

draw_set_font(font_crypt_of_tomorrow);
if (!surface_exists(_surface)) {
    _surface = surface_create(room_width * 2, room_height * 2)
}
draw_text_ext_transformed_color(16 + 3 + 4 + _offset + 0.5, 26 + (_top ? 135 : 0) + 3 + 21 + 0.5, "LV  " + string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.LV)) + "\nHP  " + string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP)) + "/" + string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX)) + "\nG   " + string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.GOLD)), 9, -1, 1, 1, 0, make_color_rgb(128, 128, 128), make_color_rgb(128, 128, 128), make_color_rgb(128, 128, 128), make_color_rgb(128, 128, 128), 1);
draw_set_color(c_white);
draw_text_ext_transformed(_offset + 16 + 3 + 4, 26 + (_top ? 135 : 0) + 3 + 21, "LV  " + string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.LV)) + "\nHP  " + string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP)) + "/" + string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX)) + "\nG   " + string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.GOLD)), 9, -1, 1, 1, 0);

if (_menu == 0) {
    draw_sprite_ext(spr_battle_soul, 0, _offset + 16 + 3 + 14.5, 84 + 3 + 15.5 + 18 * _choice_soul, 0.5, 0.5, 90, c_red, 1);
}

// ITEM
if (_menu == 1 || _menu == 2 || (_show_width[0] != 0)) {
    draw_sprite_ext(spr_pixel, 0, 94, 26, _show_width[0], 181, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 94 + 3, 26 + 3, _show_width[0] - 6 >= 0 ? _show_width[0] - 6 : 0, 181 - 3 * 2, 0, c_black, 1);
}

if (_menu == 1) {
    surface_set_target(_surface) draw_sprite_ext(spr_battle_soul, 0, (94 + 3 + 11) * 2, (26 + 3 + 20 + 16 * _choice_item_soul) * 2, 1, 1, 90, c_red, 1);
    surface_reset_target()
}

if (_menu == 2) {
    surface_set_target(_surface) draw_sprite_ext(spr_battle_soul, 0, (94 + 3 + _choice_item_operate_soul) * 2, (26 + 3 + 159.5) * 2, 1, 1, 90, c_red, 1);
    surface_reset_target()

}
// STAT
if (_menu == 3 || _show_width[1] != 0) {
    draw_sprite_ext(spr_pixel, 0, 94, 26, _show_width[1], 209, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 94 + 3, 26 + 3, _show_width[1] - 6 > 0 ? _show_width[1] - 6 : 0, 209 - 3 * 2, 0, c_black, 1);
}

// PHONE
if (_menu == 4 || _show_width[2] != 0) {
    draw_sprite_ext(spr_pixel, 0, 94, 26, _show_width[2], 135, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 94 + 3, 26 + 3, _show_width[2] - 6 > 0 ? _show_width[2] - 6 : 0, 135 - 3 * 2, 0, c_black, 1);
    surface_set_target(_surface) if (_menu == 4) draw_sprite_ext(spr_battle_soul, 0, (94 + 3 + 11) * 2, (26 + 3 + 20 + 16 * _choice_phone_soul) * 2, 1, 1, 90, c_red, 1);
    surface_reset_target()
}
for (var i = 0; i < 2; i++) {
    if (_show_width[i] != 0) break
}
draw_surface_part_ext(_surface, 0, 0, (91 + _show_width[i]) * 2, 2 * room_height, 0, 0, 0.5, 0.5, c_white, 1); 
surface_set_target(_surface);
draw_clear_alpha(c_white, 0);
surface_reset_target();