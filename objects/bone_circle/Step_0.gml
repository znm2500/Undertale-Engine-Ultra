if (enable == 1) {
    rott += rot;
    for (i = 0; i < (number + 1); i += 1) {
        var pos = RotateAround(x, y, (x + lengthdir_x(size_x, rott + ((360 / number) * i))), (y + lengthdir_y(size_y, rott + ((360 / number) * i))), x, y, angle);
        if (roting == 1) {
            bone[i].angle = point_direction(x, y, pos[0], pos[1]) + extra_angle;
        } else {
            bone[i].angle = point_direction(0, 0, lengthdir_x(size_x, ((360 / number) * i)), lengthdir_y(size_y, ((360 / number) * i))) + extra_angle;
        }

        bone[i].x = pos[0];
        bone[i].y = pos[1];
        bone[i].out = out;
        bone[i].length = length;
        bone[i].type = type;
    }
}