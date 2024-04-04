if (follow) {
    if (!processed) {
        vs = vspeed;
        hs = hspeed;
        vspeed = 0;
        hspeed = 0;
        if (follow_board) {
            follow_target = battle_board;
        }
        if (instance_exists(follow_target)) {
            center_x = follow_target.x;
            center_y = follow_target.y;

        } else {
            center_x = follow_x;
            center_y = follow_y;
        }
        processed = 1;
    }
    xx += hs;
    yy += vs;
    if (follow_board && follow_target != battle_board) {
        follow_target = battle_board;
    }
    if (instance_exists(follow_target)) {
        follow_x = follow_target.x;
        follow_y = follow_target.y;
        if (variable_instance_exists(follow_target, "angle")) follow_angle = follow_target.angle;
        else follow_angle = follow_target.image_angle;
    }
    angle = _angle + follow_angle;
    _angle += rotate;
    var pos = RotateAround(center_x, center_y, xx, yy, follow_x, follow_y, follow_angle);
    x = pos[0];
    y = pos[1];

} else {
    xx = x;
    yy = y;
    angle += rotate;
}