function Battle_MakeGB(x, y, x_target, y_target, angle_start, angle_target, scale_x, scale_y, type, pause=25, duration=35, time_move=25) {
    var xx = x;
    var yy = y;
    var idealx = x_target;
    var idealy = y_target;
    var angle = angle_start;
    var idealrot = angle_target;
    var xscale = scale_x;
    var yscale = scale_y;
    var cc = type;

    var bb = instance_create_depth(xx, yy, DEPTH_BATTLE.BULLET_OUTSIDE_HIGH, battle_bullet_gb);
    
    bb.x_target = idealx;
    bb.y_target = idealy;
    bb.angle_start = angle;
    bb.angle_target = idealrot;
    bb.scale_x = xscale;
    bb.scale_y = yscale;
    bb.type = cc;
    bb.time_release_delay = pause;
    bb.time_beam_end_delay = duration;
    bb.time_move = time_move;

    return bb;
}
