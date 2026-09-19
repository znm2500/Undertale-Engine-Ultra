if (!surface_exists(_surface)) {
    _surface = surface_create(640, 480);
}
if (!surface_exists(_surface_bg)) {
    _surface_bg = surface_create(640, 480);
}
if (!surface_exists(_surface_board_cover)) {
    _surface_board_cover = surface_create(640, 480);
}
if (!surface_exists(_surface_board_extra)) {
    _surface_board_extra = surface_create(640, 480);
}

if (!surface_exists(_surface_mask)) {
    _surface_mask = surface_create(640, 480);
}
//背景与内容分层：_surface_bg只承载背景色，_surface保持全透明只承载弹幕等内容，
//这样bg_alpha只淡化背景，不会和内容的image_alpha叠加乘算
surface_set_target(_surface);
draw_clear_alpha(c_black, 0);
surface_reset_target();
surface_set_target(_surface_bg);
draw_clear_alpha(color_bg, alpha_bg);
surface_reset_target();
surface_set_target(_surface_mask);
draw_clear_alpha(color_bg, 0);
surface_reset_target();
surface_set_target(_surface_board_cover);
draw_clear_alpha(color_frame, 0);
surface_reset_target();
surface_set_target(_surface_board_extra);
draw_clear_alpha(color_frame, 0);
surface_reset_target();