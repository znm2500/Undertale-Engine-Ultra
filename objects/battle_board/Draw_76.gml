if (!surface_exists(_surface)) {
    _surface = surface_create(640, 480);
}
if (!surface_exists(_surface_border_cover)) {
    _surface_border_cover = surface_create(640, 480);
}
if (!surface_exists(_surface_border_extra)) {
    _surface_border_extra = surface_create(640, 480);
}

if (!surface_exists(_surface_final)) {
    _surface_final = surface_create(640, 480);
}
surface_set_target(_surface);
draw_clear_alpha(color_bg, 0);
surface_reset_target();
surface_set_target(_surface_final);
draw_clear_alpha(color_bg, 0);
surface_reset_target();
surface_set_target(_surface_border_cover);
draw_clear_alpha(color_bg, 0);
surface_reset_target();
surface_set_target(_surface_border_extra);
draw_clear_alpha(color_bg, 0);
surface_reset_target();