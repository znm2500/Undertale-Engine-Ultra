ds_list_clear(mainboard.listVertex);
ds_list_add(
mainboard.listVertex,
[-left,-up],[right,-up],[right,down],[-left,down]
);

mainboard.x = x
mainboard.y = y
mainboard.rot = angle
mainboard.color_frame = color_frame
lx=x+lengthdir_x(point_distance(x,y,x-left,y-up),angle+point_direction(x,y,x-left,y-up))
	ly= y+lengthdir_y(point_distance(x,y,x-left,y-up),angle+point_direction(x,y,x-left,y-up))
	rx=x+lengthdir_x(point_distance(x,y,x+right,y-up),angle+point_direction(x,y,x+right,y-up))
	ry= y+lengthdir_y(point_distance(x,y,x+right,y-up),angle+point_direction(x,y,x+right,y-up))
ux=x+lengthdir_x(point_distance(x,y,x-left,y+down),angle+point_direction(x,y,x-left,y+down))
uy=y+lengthdir_y(point_distance(x,y,x-left,y+down),angle+point_direction(x,y,x-left,y+down))
dx=x+lengthdir_x(point_distance(x,y,x+right,y+down),angle+point_direction(x,y,x+right,y+down))
dy=y+lengthdir_y(point_distance(x,y,x+right,y+down),angle+point_direction(x,y,x+right,y+down))
global.borderCount = ds_list_size(global.borders_list)