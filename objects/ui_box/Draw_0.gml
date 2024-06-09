if (!surface_exists(_surface)) {
    _surface = surface_create(640, 480)
}
if (_state == 0) {
    draw_sprite_ext(spr_pixel, 0, (320 - _show_width) / 2 + camera.x, camera.y + 8, _show_width, 225, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, (320 - (_show_width >= 6 ? _show_width - 6 : 0)) / 2 + camera.x, camera.y + 11, _show_width >= 6 ? _show_width - 6 : 0, 225 - 3 * 2, 0, c_black, 1);
    surface_set_target(_surface);
    draw_sprite_ext(spr_pixel, 0, (8 + 3 + 149.5) * 2, (8 + 3 + 36) * 2, 1, 300, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, (8 + 3 + 150.5) * 2, (8 + 3 + 36) * 2, 1, 300, 0, c_white, 1);

    var proc = 0;
    repeat(8) {
        if (!Item_IsValid(Item_Get(proc))) {
            draw_sprite_ext(spr_pixel, 0, (8 + 3 + 29) * 2, (8 + 3 + 35.5 + 16 * proc) * 2, 180, 1, 0, c_red, 1);
        }
        proc += 1;
    }

    proc = 0;
    repeat(10) {
        if (!Item_IsValid(Box_Get(box_slot, proc))) {
            draw_sprite_ext(spr_pixel, 0, (8 + 3 + 29 + 151) * 2, (8 + 3 + 35.5 + 16 * proc) * 2, 180, 1, 0, c_red, 1);
        }
        proc += 1;
    }

    draw_sprite_ext(spr_battle_soul, 0, (8 + 3 + 13.5 + 151 * _choice_mode_soul) * 2, (8 + 3 + 34.5 + 16 * _choice_item_soul) * 2, 1, 1, 90 * !global.classic_ui, c_red, 1);
    surface_reset_target()
}
draw_surface_part_ext(_surface, 320 - (_show_width >= 6 ? _show_width - 6 : 0), 0, (_show_width >= 6 ? _show_width - 6 : 0) * 2, 480, 160 - (_show_width >= 6 ? _show_width - 6 : 0) / 2 + camera.x, camera.y + 0, 0.5, 0.5, c_white, 1);
surface_set_target(_surface);
draw_clear_alpha(c_white, 0);
surface_reset_target();