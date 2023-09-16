if (point_at == 1) {
    if (x != xprevious && y != yprevious) {
        image_angle = point_direction(xprevious, yprevious, x, y) + angle_offset;
    }
} else {
    image_angle = angle;
}