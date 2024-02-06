draw_sprite_ext(spr_pixel, 0, _offset+16, 26+(_top ? 135 : 0), 71, 55, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, _offset+16+3, 26+3+(_top ? 135 : 0), 71-3*2, 55-3*2, 0, c_black, 1);

draw_sprite_ext(spr_pixel, 0, _offset+16, 84, 71, 74, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, _offset+16+3, 84+3, 71-3*2, 74-3*2, 0, c_black, 1);

draw_set_font(font_crypt_of_tomorrow);
draw_set_color(c_white);
draw_text_ext_transformed(_offset+16+3+4, 26+(_top ? 135 : 0)+3+21, "LV  "+string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.LV))+"\nHP  "+string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP))+"/"+string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP_MAX))+"\nG   "+string(Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.GOLD)), 9, -1, 1, 1, 0);

if (_menu==0) {
    draw_sprite_ext(spr_battle_soul, 0, _offset+16+3+14.5, 84+3+15.5+18*_choice_soul, 0.5, 0.5, 90, c_red, 1);
}

// ITEM
if (_menu==1||_menu==2) {
    draw_sprite_ext(spr_pixel, 0, 94, 26, 173, 181, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 94+3, 26+3, 173-3*2, 181-3*2, 0, c_black, 1);
}

if (_menu==1) {
    draw_sprite_ext(spr_battle_soul, 0, 94+3+11.5, 26+3+19.5+16*_choice_item_soul, 0.5, 0.5, 90, c_red, 1);
}

if (_menu==2) {
    draw_sprite_ext(spr_battle_soul, 0, 94+3+_choice_item_operate_soul, 26+3+159.5, 0.5, 0.5, 90, c_red, 1);
}

// STAT
if (_menu==3) {
    draw_sprite_ext(spr_pixel, 0, 94, 26, 173, 209, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 94+3, 26+3, 173-3*2, 209-3*2, 0, c_black, 1);
}

// PHONE
if (_menu==4) {
    draw_sprite_ext(spr_pixel, 0, 94, 26, 173, 135, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, 94+3, 26+3, 173-3*2, 135-3*2, 0, c_black, 1);
    draw_sprite_ext(spr_battle_soul, 0, 94+3+11.5, 26+3+19.5+16*_choice_phone, 0.5, 0.5, 90, c_red, 1);
}