if (!enable) {
    var dangle = (360 / number);
    for (i = 0; i < (number + 1); i += 1) {
        var pos = RotateAround(x, y, (x + lengthdir_x(size_x, rott + (dangle * i))), (y + lengthdir_y(size_y, rott + (dangle * i))), x, y, angle);
        bone[i] = instance_create_depth(pos[0], pos[1], 0, battle_bullet_bone);
        bone[i].angle = point_direction(x,y,pos[0],pos[1]);
        bone[i].length = length;
        bone[i].type = type;
    }
    enable = 1;
}
event_inherited();