if (round(global.blur_amount)) {
    show_debug_message(1) var _surface = _kawase.GetSurface();
    surface_set_target(_surface);
    draw_clear_alpha(c_black, 0);
    draw_set_alpha(1);
    draw_surface(global.surface_gui, 0, 0);
    surface_reset_target();
    _kawase.Blur(round(global.blur_amount));
    draw_set_color(c_white);
    draw_surface(_surface, 0, 0);
} else draw_surface(global.surface_gui, 0, 0);
surface_set_target(global.surface_gui);
draw_clear_alpha(c_white, 0);
surface_reset_target();