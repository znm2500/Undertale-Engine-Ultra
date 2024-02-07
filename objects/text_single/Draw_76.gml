switch (effect) {
case - 1 : _offset_x = 0;
    _offset_y = 0;
    break;

case 0:
    if (_effect_shook) {
        _offset_x = random_range( - 1, 1);
        _offset_y = random_range( - 1, 1);
    }
    _effect_shook = !_effect_shook;
    break;
case 1:
    if (_effect_shook) {
        _offset_x = random_range( - 2, 2);
        _offset_y = random_range( - 2, 2);
        _offset_xx = random_range( - 2, 2);
        _offset_yy = random_range( - 2, 2);
        _offset_xxx = random_range( - 2, 2);
        _offset_yyy = random_range( - 2, 2);
    }
    _effect_shook = !_effect_shook;
    break;
}
if (rainbow) {
    color++color_text[0] = make_color_hsv((x + color) % 255, 255, 255);
    color_text[1] = make_color_hsv((x + color + string_width(text)) % 255, 255, 255);
    color_text[2] = make_color_hsv((y + color) % 255, 255, 255);
    color_text[3] = make_color_hsv((y + color + string_height(text)) % 255, 255, 255);
    color_shadow[0] = make_color_hsv((x + color) % 255, 128, 128);
    color_shadow[1] = make_color_hsv((x + color + string_width(text)) % 255, 128, 128);
    color_shadow[2] = make_color_hsv((y + color) % 255, 128, 128);
    color_shadow[3] = make_color_hsv((y + color + string_height(text)) % 255, 128, 128);
}