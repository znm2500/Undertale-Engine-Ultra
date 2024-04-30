if (point_at == 1) {
    if (x != xprevious || y != yprevious) {
        angle = point_direction(xprevious, yprevious, x, y) + angle_offset;
    }
}
if(follow){
    _angle += rotate;
    angle = _angle + follow_angle;}

image_angle = angle;