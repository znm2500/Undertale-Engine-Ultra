surface_set_target(battle_board._surface);
draw_circle_color(x,y,radius+5,battle_board.color_frame,battle_board.color_frame,0);
surface_reset_target();
draw_primitive_begin(pr_trianglestrip);
surface_set_target(battle_board._surface1)
gpu_set_alphatestenable(0)
gpu_set_blendmode(bm_normal)
gpu_set_blendenable(false)
gpu_set_colorwriteenable(0, 0, 0, 1)
draw_set_alpha(1)
draw_circle(x,y,radius,0)
draw_set_alpha(1)
gpu_set_blendenable(true)
gpu_set_colorwriteenable(1, 1, 1, 1)
draw_primitive_end();
surface_reset_target()