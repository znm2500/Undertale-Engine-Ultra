image_xscale=scale_x;
image_yscale=scale_y;
if (instance_exists(_inst)) {
    _inst.type = type;
    var LEN = 20 * scale_y;
    var X = x + lengthdir_x(LEN, image_angle);
    var Y = y + lengthdir_y(LEN, image_angle);
    _inst.x = X;
    _inst.y = Y;
    _inst.image_angle = image_angle;
	_inst.image_alpha = _beam_alpha;
	_inst.image_xscale = 999*image_xscale;
    _inst.image_yscale = scale_y * _beam_scale;
    _inst.hurtable = (_beam_scale > 1.2) && (_beam_alpha > 0.8);
}

event_inherited();
