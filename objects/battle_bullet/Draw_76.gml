if (point_at == 1) {
    if (x != xprevious || y != yprevious) {
        angle = point_direction(xprevious, yprevious, x, y) + angle_offset;
    }
}
image_angle = angle;