surface_set_target(battle_board._surface);
draw_primitive_begin(pr_trianglefan);
draw_vertex_color(x, y, battle_board.color_frame, battle_board.alpha_frame);
    for (var i = 0; i <= precision; i++) {
        var pos = RotateAround(x, y, x + lengthdir_x(radius_x + 5, i * 360 / precision), y + lengthdir_y(radius_y + 5, i * 360 / precision), x, y, angle);
		draw_vertex_color(pos[0], pos[1], battle_board.color_frame, battle_board.alpha_frame);
    }
    draw_primitive_end();
surface_reset_target();
draw_primitive_begin(pr_trianglestrip);
surface_set_target(battle_board._surface1)
gpu_set_alphatestenable(0)
gpu_set_blendmode(bm_normal)
gpu_set_blendenable(false)
gpu_set_colorwriteenable(0, 0, 0, 1)
draw_set_alpha(1)
draw_primitive_begin(pr_trianglefan);
    draw_vertex(x, y);
    for (var i = 0; i <= precision; i++) {
        var pos = RotateAround(x, y, x + lengthdir_x(radius_x, i * 360 / precision), y + lengthdir_y(radius_y, i * 360 / precision), x, y, angle);
        draw_vertex(pos[0], pos[1]);
    }
    draw_primitive_end();
draw_set_alpha(1)
gpu_set_blendenable(true)
gpu_set_colorwriteenable(1, 1, 1, 1)
draw_primitive_end();
surface_reset_target()