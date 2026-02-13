draw_set_color(c_white);
draw_rectangle(border_x1, border_y1, border_x2, border_y2, false);

draw_set_color(c_black);
draw_rectangle(border_x1 + border_width, border_y1 + border_width, border_x2 - border_width, border_y2 - border_width, false);

if (_state == SHOP_STATE.MENU || _state == SHOP_STATE.BUY || (_state == SHOP_STATE.DIALOG && _dialog == false)) {
    draw_set_color(c_white);
    draw_rectangle(menu_divide_x, border_y1, menu_divide_x + border_width, border_y2, false);
}

switch (_state) {
case SHOP_STATE.MENU:
    draw_sprite_ext(spr_battle_soul, 0, menu_divide_x + 24, border_y1 + 18.5 + 20 * _index, 0.5, 0.5, 90 * !global.classic_ui, c_red, 1);
    break;
case SHOP_STATE.BUY:
    if (_choice_state == 1) draw_sprite_ext(spr_battle_soul, 0, menu_divide_x + 16, border_y1 + 52.5 + 17 * _index_buy, 0.5, 0.5, 90 * !global.classic_ui, c_red, 1);
    else draw_sprite_ext(spr_battle_soul, 0, border_x1 + 16, border_y1 + 18.5 + 20 * _index, 0.5, 0.5, 90 * !global.classic_ui, c_red, 1);
    break;
case SHOP_STATE.SELL:
    if (_host.sold_available) {
        var X, Y;
        if (_choice_state == 0) {
            X = border_x1 + 12 + 160 * _index;
            Y = border_y1 + 16 + 20 * _indexy - 2;
        } else {
            X = border_x1 + 52 + 72 * _index_sell + 40;
            Y = border_y1 + 67 - 2;

        }
        draw_sprite_ext(spr_battle_soul, 0, X + 4, Y + 4, 0.5, 0.5, 90 * !global.classic_ui, c_red, 1);
    }

    break;
case SHOP_STATE.DIALOG:
    if (_dialog == false) draw_sprite_ext(spr_battle_soul, 0, border_x1 + 18, border_y1 + 18.5 + 20 * _index, 0.5, 0.5, 90 * !global.classic_ui, c_red, 1);
    break;
default:
    break;
}