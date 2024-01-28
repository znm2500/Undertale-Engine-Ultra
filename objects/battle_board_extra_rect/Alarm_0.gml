rect = instance_create_depth(x,y,0,battle_board_extra);
ds_list_add(
	rect.listVertex,
	[-left,-up],[right,-up],[right,down],[-left,down]
	);
rect.updateDivide();

ds_list_add(global.borders_list,rect);