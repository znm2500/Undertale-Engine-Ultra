for (var i = 0; i < array_length(global.boards_array); i++) {
    var board = global.boards_array[i];
    if (is_struct(board) && !board._destroyed) {
        board.drawBorder();
        board.replaceSurfaceAlpha();
    }
}
draw_set_alpha(1);
surface_set_target(_surface);
draw_surface(_surface_board_cover, 0, 0);
surface_reset_target();
gpu_set_colorwriteenable(0, 0, 0, 1);
gpu_set_blendmode(bm_min);
surface_set_target(_surface);
draw_surface(_surface_mask, 0, 0);
surface_reset_target();
gpu_set_blendmode(bm_subtract);
surface_set_target(_surface_board_extra);
draw_surface(_surface_mask, 0, 0);
surface_reset_target();
gpu_set_blendmode(bm_normal);
gpu_set_colorwriteenable(1, 1, 1, 1);
draw_surface(_surface, 0, 0);
draw_surface(_surface_board_extra, 0, 0);