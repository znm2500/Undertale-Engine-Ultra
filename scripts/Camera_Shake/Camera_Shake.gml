function Camera_Shake(shake_x, shake_y, shake_speed_x = 0, shake_speed_y = 0, shake_random_x = 0, shake_random_y = 0, shake_decrease_x = 1, shake_decrease_y = 1, blur = !global.classic_ui) {

    var X = shake_x;
    var Y = shake_y;
    var SPEED_X = shake_speed_x;
    var SPEED_Y = shake_speed_y;
    var RANDOM_X = shake_random_x;
    var RANDOM_Y = shake_random_y;
    var DECREASE_X = shake_decrease_x;
    var DECREASE_Y = shake_decrease_y;
    camera.shake_x = X;
    camera.shake_y = Y;
    camera.shake_speed_x = SPEED_X;
    camera.shake_speed_y = SPEED_Y;
    camera.shake_random_x = RANDOM_X;
    camera.shake_random_y = RANDOM_Y;
    camera.shake_decrease_x = DECREASE_X;
    camera.shake_decrease_y = DECREASE_Y;
    camera._shake_pos_x = 0;
    camera._shake_pos_y = 0;
    camera._shake_time_x = 0;
    camera._shake_time_y = 0;
    camera._shake_positive_x = true;
    camera._shake_positive_y = true;
    if (blur) Anim_Create(global, "blur_amount", 0, 0, 2, -2, 20);
    return true;

}