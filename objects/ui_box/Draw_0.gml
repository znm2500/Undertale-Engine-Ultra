if (_state == 0) {
    draw_sprite_ext(spr_pixel, 0, 8, 8, 305, 225, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 8 + 3, 8 + 3, 305 - 3 * 2, 225 - 3 * 2, 0, c_black, 1);

    draw_sprite_ext(spr_pixel, 0, 8 + 3 + 149.5, 8 + 3 + 36, 0.5, 150, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 8 + 3 + 150.5, 8 + 3 + 36, 0.5, 150, 0, c_white, 1);

    var proc = 0;
    repeat (8) {
        if (!Item_IsValid(Item_Get(proc))) {
            draw_sprite_ext(spr_pixel, 0, 8 + 3 + 29, 8 + 3 + 35.5 + 16 * proc, 90, 0.5, 0, c_red, 1);
        }
        proc += 1;
    }
    
    proc = 0;
    repeat (10) {
        if (!Item_IsValid(Box_Get(box_slot, proc))) {
            draw_sprite_ext(spr_pixel, 0, 8 + 3 + 29 + 151, 8 + 3 + 35.5 + 16 * proc, 90, 0.5, 0, c_red, 1);
        }
        proc += 1;
    }
    
    draw_sprite_ext(spr_battle_soul, 0, 8 + 3 + 13.5 + 151 * _choice_mode_soul, 8 + 3 + 34.5 + 16 * _choice_item_soul, 0.5, 0.5, 90, c_red, 1);
}
