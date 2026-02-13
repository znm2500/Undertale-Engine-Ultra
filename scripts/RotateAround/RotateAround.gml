function RotateAround(x_center, y_center, x_around, y_around, x_present, y_present, angle) {
    //center是初始中心位置
    //around是围绕物体位置
    //present是目前中心位置
    //angle是围绕角度
    var dx = x_around - x_center;
    var dy = y_around - y_center;
    var xx = lengthdir_x(dx, angle) - lengthdir_y(dy, angle);
    var yy = lengthdir_x(dy, angle) + lengthdir_y(dx, angle);
    return [xx + x_present, yy + y_present];
}