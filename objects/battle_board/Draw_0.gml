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
//用遮罩alpha同时乘RGB和A来裁剪内容层和背景层（只裁A会导致板外颜色在预乘合成时漏出）
gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
surface_set_target(_surface);
draw_surface(_surface_mask, 0, 0);
surface_reset_target();
surface_set_target(_surface_bg);
draw_surface(_surface_mask, 0, 0);
surface_reset_target();
gpu_set_colorwriteenable(0, 0, 0, 1);
gpu_set_blendmode(bm_subtract);
surface_set_target(_surface_board_extra);
draw_surface(_surface_mask, 0, 0);
surface_reset_target();
gpu_set_blendmode(bm_normal);
gpu_set_colorwriteenable(1, 1, 1, 1);
//先画背景层（bg_alpha只作用于此），再按预乘alpha合成内容层，避免alpha被二次乘算导致弹幕比预期更透明
draw_surface(_surface_bg, 0, 0);
gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
draw_surface(_surface, 0, 0);
gpu_set_blendmode(bm_normal);
draw_surface(_surface_board_extra, 0, 0);