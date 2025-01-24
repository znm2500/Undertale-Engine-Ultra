var SPR = spr_gb_beam;
var LEN = (25 * scale_x);
var X = (x + lengthdir_x(LEN, image_angle));
var Y = (y + lengthdir_y(LEN, image_angle));
var YSCALE = (scale_y * _beam_scale);
image_xscale = scale_x;
image_yscale = scale_y;
if (point_at == 1) {
    if (x != xprevious || y != yprevious) {
        angle = point_direction(xprevious, yprevious, x, y) + angle_offset;
    }
}
if (follow) {
    _angle += rotate;
    angle = _angle + follow_angle;
} else angle += rotate;
image_angle = angle;
switch (type) {
case 0:
    image_blend = c_white;
    break;
case 1:
    image_blend = make_color_rgb(20, 196, 255);
    break;
case 2:
    image_blend = make_color_rgb(248, 148, 29);
    break;
case 3:
    image_blend = make_color_rgb(0, 255, 0);
    break;
case 4:
    image_blend = c_yellow;
    break;
}

if (out = 0) {
    depth = DEPTH_BATTLE.BULLET;
    surface_set_target(Battle_GetBoardSurface());
    draw_self();
    draw_sprite_ext(SPR, 0, X, Y, 9999, YSCALE, image_angle, color, _beam_alpha);
    surface_reset_target();
} else {
    depth = DEPTH_BATTLE.BULLET_OUTSIDE_HIGH;
    draw_self();
    draw_sprite_ext(SPR, 0, X, Y, 9999, YSCALE, image_angle, image_blend, _beam_alpha);
}