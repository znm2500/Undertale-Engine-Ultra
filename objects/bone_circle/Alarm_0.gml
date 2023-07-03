angle = (360 / number)
for (i = 0; i < (number + 1); i += 1)
{
    bone[i] = instance_create_depth((x + lengthdir_x(size_x, (angle * i))), (x + lengthdir_y(size_y, (angle * i))), 0, battle_bullet_bone)
    bone[i].angle = ((angle * i) + 90)
    bone[i].length = length
    bone[i].type = type

}
enable = 1
