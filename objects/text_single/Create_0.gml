text = "";
sprite = -1;
sprite_image = 0;
font = -1;
scale_x = 1;
scale_y = 1;
angle = 0;
rainbow = 0 shadow = false;
outline = false;
color = 0 surface_target = noone
if (rainbow) {
    color_text[0] = make_color_hsv((x + color) % 255, 255, 255);
    color_text[1] = make_color_hsv((x + color + string_width(text)) % 255, 255, 255);
    color_text[2] = make_color_hsv((y + color) % 255, 255, 255);
    color_text[3] = make_color_hsv((y + color + string_height(text)) % 255, 255, 255);
    color_shadow[0] = make_color_hsv((x + color) % 255, 128, 128);
    color_shadow[1] = make_color_hsv((x + color + string_width(text)) % 255, 128, 128);
    color_shadow[2] = make_color_hsv((y + color) % 255, 128, 128);
    color_shadow[3] = make_color_hsv((y + color + string_height(text)) % 255, 128, 128);
} else {
    color_text[0] = c_white;
    color_text[1] = c_white;
    color_text[2] = c_white;
    color_text[3] = c_white;
    color_shadow[0] = make_color_rgb(41, 41, 87);
    color_shadow[1] = make_color_rgb(41, 41, 87);
    color_shadow[2] = make_color_rgb(3, 3, 125);
    color_shadow[3] = make_color_rgb(3, 3, 125);
}
color_outline[0] = make_color_rgb(110, 110, 110);
color_outline[1] = make_color_rgb(110, 110, 110);
color_outline[2] = make_color_rgb(110, 110, 110);
color_outline[3] = make_color_rgb(110, 110, 110);
shadow_x = 1;
shadow_y = 1;
alpha = 1;

if (room == room_battle) {
    if (Battle_GetMenu() == BATTLE_MENU.ITEM && depth == DEPTH_BATTLE.BULLET) {
        if (round(y) > battle_board.y - battle_board.up - 5 + 20 + 64 + 16) {
            alpha = 0;
        } else {
            alpha = 1;
        }
    }
}

alpha_text = 1;
alpha_shadow = 1;
alpha_outline = 1;
effect = 0;
gui = true;

_offset_x = 0;
_offset_y = 0;
_offset_xx = 0;
_offset_yy = 0;
_offset_xxx = 0;
_offset_yyy = 0;
_effect_shook = false;