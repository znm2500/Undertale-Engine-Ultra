if (round(global.blur_amount)) {
	var _surface = _kawase.GetSurface();
    surface_set_target(_surface);
    draw_clear_alpha(c_black, 0);
    draw_surface(application_surface, 0, 0);
    surface_reset_target();
    _kawase.Blur(round(global.blur_amount));
    draw_set_color(c_white);
    draw_surface(_surface, 0, 0);
}