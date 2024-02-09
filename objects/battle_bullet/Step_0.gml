if (follow) {
    xx += hs;
    yy += vs;
    if (follow_board) {
        follow_target = battle_board
    }
    if (instance_exists(follow_target)) {
        follow_x = follow_target.x follow_y = follow_target.y
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

if (place_meeting(x, y, battle_soul)) {
    Battle_CallSoulEventBulletCollision();
}

if (place_meeting(x, y, battle_soul_yellow_bullet) && type == 4) {
    var obj = instance_place(x, y, battle_soul_yellow_bullet);
    instance_destroy(obj);
    instance_destroy();
}