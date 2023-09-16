if (follow) {
    xx += hs;
    yy += vs;
    
    if (follow_board) {
        angle = _angle + battle_board.angle;
      
        _angle += rotate;
        x = battle_board.x + lengthdir_x(xx - battle_board.x, -battle_board.angle) + lengthdir_x(yy - battle_board.y, -battle_board.angle + 90);
        y = battle_board.y + lengthdir_x(xx - battle_board.x, -battle_board.angle - 90) + lengthdir_x(yy - battle_board.y, -battle_board.angle);
    }
    else {
        angle = _angle + follow_angle;
       
        _angle += rotate;
        x = follow_x + lengthdir_x(xx - follow_x, -follow_angle) + lengthdir_x(yy - follow_y, -follow_angle + 90);
        y = follow_y + lengthdir_x(xx - follow_x, -follow_angle - 90) + lengthdir_x(yy - follow_y, -follow_angle);
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
    obj = instance_place(x, y, battle_soul_yellow_bullet);
    instance_destroy(obj);
    instance_destroy();
}