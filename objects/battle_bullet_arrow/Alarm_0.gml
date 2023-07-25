event_inherited();

if (!follow) {
    angle = _direction;
} else {
    _angle = _direction;
}

if (!type) {
    image_index = 0;
} else {
    image_index = 2;
    if (follow) {
        _angle += 180;
    } else {
        angle += 180;
    }
}

_dir = _direction;