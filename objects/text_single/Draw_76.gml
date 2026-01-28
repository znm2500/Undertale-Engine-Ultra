switch (effect) {
case - 1 : _offset_x[0] = 0;
    _offset_y[0] = 0;
    break;

case 0:
    if (_effect_shook) {
        _offset_x[0] = random_range( - 1, 1);
        _offset_y[0] = random_range( - 1, 1);
    }
    _effect_shook = !_effect_shook;
    break;
case 1:
    if (_effect_shook) {
        var i = 0;
        repeat(3) {
            _offset_x[i] = random_range( - 2, 2);
            _offset_y[i++] = random_range( - 2, 2);
        }
    }
    _effect_shook = !_effect_shook;
    break;
case 2:
		_offset_x[0] = floor(lengthdir_x(1.5,typer.torder[order mod 10]));
		_offset_y[0] = floor(lengthdir_y(1.5,typer.torder[order mod 10]));
	break;	
}
if (rainbow) {
    color++;
    color_text[0] = make_color_hsv((x + color) % 255, 255, 255);
    color_text[1] = make_color_hsv((x + color + string_width(text)) % 255, 255, 255);
    color_text[2] = make_color_hsv((y + color) % 255, 255, 255);
    color_text[3] = make_color_hsv((y + color + string_height(text)) % 255, 255, 255);
    color_shadow[0] = make_color_hsv((x + color) % 255, 128, 128);
    color_shadow[1] = make_color_hsv((x + color + string_width(text)) % 255, 128, 128);
    color_shadow[2] = make_color_hsv((y + color) % 255, 128, 128);
    color_shadow[3] = make_color_hsv((y + color + string_height(text)) % 255, 128, 128);
}
if (show_item && !_processed) {
    alpha = (round(y) >= battle_board.y - battle_board.up - 5 + 20 - 16 && round(y) <= battle_board.y - battle_board.up - 5 + 20 + 64 + 16);
    _processed = 1;
}