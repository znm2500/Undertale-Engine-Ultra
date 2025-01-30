if (point_at == 1) {
    if (x != xprevious || y != yprevious) {
        angle = point_direction(xprevious, yprevious, x, y) + angle_offset;
    }
}
if(follow){
    _angle += rotate;
    angle = _angle + follow_angle;}
else
	angle += rotate;
image_angle = angle;
switch(type)
{
    case 0:
        image_blend = c_white;
        break;
    case 1:
        image_blend = make_color_rgb(20,196,255);
        break;
    case 2:
        image_blend = make_color_rgb(248,148,29);
        break;
    case 3:
        image_blend = make_color_rgb(0, 255, 0);
        break;
    case 4:
        image_blend = c_yellow;
        break;
}

if(out = 0){
	depth = DEPTH_BATTLE.BULLET;
	surface_set_target(Battle_GetBoardSurface());{
		draw_self();
	}surface_reset_target();
}
else{
	depth = DEPTH_BATTLE.BULLET_OUTSIDE_LOW;
	draw_self()
}


