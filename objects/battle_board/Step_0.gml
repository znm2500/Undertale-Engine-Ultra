if (!instance_exists(mainboard)) mainboard = Battle_CreateBoardRect(x, y, 65, 65, 283, 283);
mainboard.x = x;
mainboard.y = y;
mainboard.angle = angle;
mainboard.left = left;
mainboard.right = right;
mainboard.up = up;
mainboard.down = down;
array_sort(global.boards_array, func_boardsort);