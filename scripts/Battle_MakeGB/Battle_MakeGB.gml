function Battle_MakeGB(x, y, x_target, y_target, angle_start, angle_target, scale_x, scale_y, type, pause=25, duration=35, time_move=25) {
    var bb = instance_create_depth(0, 0, DEPTH_BATTLE.BULLET_OUTSIDE_HIGH, battle_bullet_gb);    
	bb.blaster.x=x;
	bb.blaster.y=y;
	bb.blaster.image_angle=angle_start;
	bb.blaster.image_xscale=scale_x;
	bb.blaster.image_yscale=scale_y;
    bb.target_x = x_target;
    bb.target_y = y_target;
    bb.angle_start = angle_start;
    bb.target_angle = angle_target;
    bb.scale_x = scale_x;
    bb.scale_y = scale_y;
    bb.type = type;
    bb.time_delay = pause;
    bb.time_blast = duration;
    bb.time_move = time_move;
	show_debug_message(x_target)
    return bb;
}
