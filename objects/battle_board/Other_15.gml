/// @description Newcreate
mainboard = instance_create_depth(x, y, 0, battle_board_points);
ds_list_add(mainboard.listVertex, [ - 283, -65], [283, -65], [283, 65], [ - 283, 65]);
mainboard.rect = 1;
mainboard.updateDivide();
mainboard.color_frame = color_frame;
mainboard.color_bg = color_bg;
mainboard.angle = angle;
array_push(global.boards_array);