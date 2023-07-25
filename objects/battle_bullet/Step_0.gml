if (follow)
{
    xx += hs;
    yy += vs;
    
    if (follow_board)
    {
        angle = _angle + battle_board.angle;
        dis = point_distance(xx, yy, 320, 320);
        _angle += rotate;
        x = battle_board.x - lengthdir_x(dis, point_direction(xx, yy, 320, 320) + battle_board.angle);
        y = battle_board.y - lengthdir_y(dis, point_direction(xx, yy, 320, 320) + battle_board.angle);
    }
    else
    {
        angle = _angle + follow_angle;
        dis = point_distance(xx, yy, follow_x, follow_y);
        _angle += rotate;
        x = battle_board.x - lengthdir_x(dis, point_direction(xx, yy, follow_x, follow_y) + follow_angle);
        y = battle_board.y - lengthdir_y(dis, point_direction(xx, yy, follow_x, follow_y) + follow_angle);
    }
}
else
{
    xx = x;
    yy = y;
    angle += rotate;
}

if (place_meeting(x, y, battle_soul))
{
    Battle_CallSoulEventBulletCollision();
}

if (place_meeting(x, y, battle_soul_yellow_bullet) && type == 4)
{   obj=instance_place(x,y,battle_soul_yellow_bullet)
	instance_destroy(obj)
    instance_destroy();
}