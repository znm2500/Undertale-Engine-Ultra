if (follow) {
    xx += hs;
    yy += vs;
    
    if (follow_board) {
        angle = _angle + battle_board.angle;
        _angle += rotate;
        
        var pos = RotateAround(center_x, center_y, xx, yy, battle_board.angle);
        x = battle_board.x + pos[0];
        y = battle_board.y + pos[1];
    }
    else {
        angle = _angle + follow_angle;
        _angle += rotate;
        
        var pos = RotateAround(follow_x, follow_y, xx, yy, follow_angle);
        x = follow_x + pos[0];
        y = follow_y + pos[1];
    }
}
else {
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
