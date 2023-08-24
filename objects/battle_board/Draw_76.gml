lx=x+lengthdir_x(point_distance(x,y,x-left,y-up),angle+point_direction(x,y,x-left,y-up))
ly= y+lengthdir_y(point_distance(x,y,x-left,y-up),angle+point_direction(x,y,x-left,y-up))
rx=x+lengthdir_x(point_distance(x,y,x+right,y-up),angle+point_direction(x,y,x+right,y-up))
ry= y+lengthdir_y(point_distance(x,y,x+right,y-up),angle+point_direction(x,y,x+right,y-up))
ux=x+lengthdir_x(point_distance(x,y,x-left,y+down),angle+point_direction(x,y,x-left,y+down))
uy=y+lengthdir_y(point_distance(x,y,x-left,y+down),angle+point_direction(x,y,x-left,y+down))
dx=x+lengthdir_x(point_distance(x,y,x+right,y+down),angle+point_direction(x,y,x+right,y+down))
dy=y+lengthdir_y(point_distance(x,y,x+right,y+down),angle+point_direction(x,y,x+right,y+down))
if(!surface_exists(_surface1)){
	_surface1=surface_create(640,480);
}
if(!surface_exists(_surface2)){
	_surface2=surface_create(640,480);
}
if(!surface_exists(_surface3)){
	_surface3=surface_create(640,480);
}
if(!surface_exists(_surface4)){
	_surface4=surface_create(640,480);
}

surface_set_target(_surface1);{
	draw_clear_alpha(color_bg,0);
	surface_reset_target();
	surface_set_target(_surface3);
	draw_clear_alpha(c_black,0);
}surface_reset_target();
if(!surface_exists(_surface)){
	_surface=surface_create(640,480);
}

surface_set_target(_surface);{
	draw_clear_alpha(color_bg,0);
}surface_reset_target();