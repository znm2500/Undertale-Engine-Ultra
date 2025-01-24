if (!processed) {
    alarm[0] = duration;

    if (!type) {
        image_index = 0;
    } else {
        image_index = 2;
        if (follow) {
            _angle += 180;
        } else {
            angle += 180;
        }
    }

    _dir = _direction;
    if (follow) {
        _angle = _direction;
        vsin = vspeed;
        _hspeed = hspeed;
        vspeed = 0;
        hspeed = 0;
        if (follow_board) {
            follow_target = battle_board;
        }
        if (instance_exists(follow_target)) {
            center_x = follow_target.x;
            center_y = follow_target.y;
            follow_x = follow_target.x;
            follow_y = follow_target.y;
            if (variable_instance_exists(follow_target, "angle")) follow_angle = follow_target.angle;
            else follow_angle = follow_target.image_angle;

        } else {
            center_x = follow_x;
            center_y = follow_y;
        }
        processed = 1;
    } else {
        angle = _direction;
    }
}
if (follow) {
    _x += _hspeed;
    _y += _vspeed;
    if (follow_board && follow_target != battle_board) {
        follow_target = battle_board;
    }
    if (instance_exists(follow_target)) {
        follow_x = follow_target.x;
        follow_y = follow_target.y;
        if (variable_instance_exists(follow_target, "angle")) follow_angle = follow_target.angle;
        else follow_angle = follow_target.image_angle;
    }

    var pos = RotateAround(center_x, center_y, _x, _y, follow_x, follow_y, follow_angle);
    x = pos[0];
    y = pos[1];

} else {
    _x = x;
    _y = y;
    angle += rotate;
}