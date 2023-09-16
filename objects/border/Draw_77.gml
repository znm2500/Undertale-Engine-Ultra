if (_enabled) {
    var SW = (window_get_fullscreen() ? display_get_width() : window_get_width());
    var SH = (window_get_fullscreen() ? display_get_height() : window_get_height());
    var SX = SW / 960;
    var SY = SH / 540;
    var SF = min(SX, SY);
    display_set_gui_maximize(SF, SF, (SW - 960 * SF) / 2 + 160 * SF, (SH - 540 * SF) / 2 + 30 * SF);

    if (sprite_exists(_sprite_previous)) {
        draw_sprite_ext(_sprite_previous, 0, (SW - 960 * SF) / 2, (SH - 540 * SF) / 2, 960 / sprite_get_width(_sprite_previous) * SF, 540 / sprite_get_height(_sprite_previous) * SF, 0, c_white, 1);
    } else {
        draw_sprite_ext(spr_pixel, 0, (SW - 960 * SF) / 2, (SH - 540 * SF) / 2, SW, SH, 0, c_black, 1);
    }

    if (sprite_exists(_sprite)) {
        draw_sprite_ext(_sprite, 0, (SW - 960 * SF) / 2, (SH - 540 * SF) / 2, 960 / sprite_get_width(_sprite) * SF, 540 / sprite_get_height(_sprite) * SF, 0, c_white, _alpha);
    } else {
        draw_sprite_ext(spr_pixel, 0, (SW - 960 * SF) / 2, (SH - 540 * SF) / 2, SW, SH, 0, c_black, _alpha);
    }
	 if(blur) {
        if (!surface_exists(surf)) {
            surf = surface_create(surface_width, surface_height);
        }

        surface_set_target(surf);
        shader_set(shd_gaussian_horizontal);
        shader_set_uniform_f(uni_resolution_hoz, var_resolution_x, var_resolution_y);
        shader_set_uniform_f(uni_blur_amount_hoz, var_blur_amount);
        draw_surface(application_surface, 0, 0);
        shader_reset();
        surface_reset_target();

        shader_set(shd_gaussian_vertical);
        shader_set_uniform_f(uni_resolution_vert, var_resolution_x, var_resolution_y);
        shader_set_uniform_f(uni_blur_amount_vert, var_blur_amount);
        draw_surface_ext(surf, (SW - 960 * SF) / 2 + SF * 32, (SH - 540 * SF) / 2 - SF * 48, SF * 1.4, SF * 1.4, 0, c_white, 0.5*_alpha);

        shader_reset();
        surface_free(surf);

        _sprite = spr_border_simple;
    }

    draw_surface_ext(application_surface, (SW - 960 * SF) / 2 + 160 * SF, (SH - 540 * SF) / 2 + 30 * SF, SF, SF, 0, c_white, 1);

   
} else {
    var SW = (window_get_fullscreen() ? display_get_width() : window_get_width());
    var SH = (window_get_fullscreen() ? display_get_height() : window_get_height());
    var SX = SW / 640;
    var SY = SH / 480;
    var SF = min(SX, SY);
    display_set_gui_maximize(SF, SF, (SW - 640 * SF) / 2, (SH - 480 * SF) / 2);
    draw_surface_ext(application_surface, (SW - 640 * SF) / 2, (SH - 480 * SF) / 2, SF, SF, 0, c_white, 1);
}