ds_list_clear(mainboard.listVertex);
ds_list_add(
mainboard.listVertex,
[-left,-up],[right,-up],[right,down],[-left,down]
);

mainboard.x = x
mainboard.y = y
mainboard.rot = angle
mainboard.color_frame = color_frame

global.borderCount = ds_list_size(global.borders_list)

lx=x-lengthdir_x(left,-angle)-lengthdir_x(up,-angle+90);
ly=y-lengthdir_x(up,-angle)-lengthdir_x(left,-angle-90);
rx=x+lengthdir_x(right,-angle)-lengthdir_x(up,-angle+90);
ry=y-lengthdir_x(up,-angle)+lengthdir_x(right,-angle-90);
ux=x-lengthdir_x(left,-angle)+lengthdir_x(down,-angle+90);
uy=y+lengthdir_x(down,-angle)-lengthdir_x(left,-angle-90);
dx=x+lengthdir_x(right,-angle)+lengthdir_x(down,-angle+90);
dy=y+lengthdir_x(down,-angle)+lengthdir_x(right,-angle-90);