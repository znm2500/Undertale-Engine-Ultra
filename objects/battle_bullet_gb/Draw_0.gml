event_inherited();
var color = c_white;
if (type == 1) {
    color = make_color_rgb(20, 169, 255);
} else if (type == 2) {
    color = make_color_rgb(255, 160, 64);
}

var SPR = spr_gb_beam;
draw_sprite_ext(sprite_index, image_index, x, y, (scale_x * image_xscale), (scale_y * image_yscale), image_angle, color, image_alpha);
var LEN = (25 * scale_x);
var X = (x + lengthdir_x(LEN, image_angle));
var Y = (y + lengthdir_y(LEN, image_angle));
var YSCALE = (scale_y * _beam_scale);
draw_sprite_ext(SPR, 0, X, Y, 9999, YSCALE, image_angle, color, _beam_alpha);