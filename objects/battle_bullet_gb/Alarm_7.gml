_exit_speed++;
if (!follow) {
    x -= lengthdir_x(_exit_speed, image_angle);
    y -= lengthdir_y(_exit_speed, image_angle);
} {
    _x -= lengthdir_x(_exit_speed, image_angle);
    _y -= lengthdir_y(_exit_speed, image_angle);
}
alarm[7] = 1;