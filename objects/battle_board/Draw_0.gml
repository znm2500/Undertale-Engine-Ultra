for (var i = 0; i < array_length(global.boards_array); i++) {
    if (instance_exists(global.boards_array[i])) {
        global.boards_array[i].drawBorder();

    }
}

surface_set_target(_surface);
draw_set_alpha(1);
draw_surface(_surface_border_cover, 0, 0);
surface_reset_target();
surface_set_target(_surface_final);
draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1 - alpha_bg);
draw_surface(_surface, 0, 0);
gpu_set_colorwriteenable(false, false, false, true);
gpu_set_blendenable(false);
draw_set_alpha(0);
draw_rectangle(0, 0, surface_get_width(_surface_final), surface_get_height(_surface_final), 0);
gpu_set_colorwriteenable(true, true, true, true);
gpu_set_blendenable(true);
surface_reset_target() for (var i = 0; i < array_length(global.boards_array); i++) {
    if (instance_exists(global.boards_array[i])) {
        global.boards_array[i].replaceSurfaceAlpha();

    }
}
draw_set_alpha(1);
draw_surface(_surface_border_extra, 0, 0);
draw_surface(_surface_final, 0, 0);