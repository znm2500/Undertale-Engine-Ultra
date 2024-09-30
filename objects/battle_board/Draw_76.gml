if (!surface_exists(_surface)) {
    _surface = surface_create(640, 480);
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
surface_set_target(_surface);
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