event_inherited();
image_blend = make_color_rgb(128, 0, 128);
x_on = noone;
y_on = noone;
cross_step = 0;
cross_start = noone;
cross_target = noone;
point = [];
moving_direction = 0;


x_index = 0;
y_index = 0;

_crossable = function(xx, yy) {
    var able = 0;
	var boardcount = array_length(global.boards_array);
    for (var i = 0; i < boardcount; i++) {
        if (global.boards_array[i].cover) able &= !global.boards_array[i].contains(xx, yy);
        else able |= global.boards_array[i].contains(xx, yy);
    }
    return able;
}
function AddPoint(x, y, vertical, horizontal, hspeed = 0, vspeed = 0, duration = -1, auto_destroy = 0) {
    var p = {
        x: x,
        y: y,
        vertical: vertical,
        horizontal: horizontal,
        hspeed: hspeed,
        vspeed: vspeed,
        duration: duration,
        auto_destroy: auto_destroy,
		destroyed: 0
    }
        array_push(point, p);
    return p;
}