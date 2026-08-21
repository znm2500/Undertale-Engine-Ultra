if (!is_struct(mainboard) || mainboard._destroyed) mainboard = Battle_CreateBoardRect(x, y, 65, 65, 283, 283);
mainboard.x = x;
mainboard.y = y;
mainboard.angle = angle;
mainboard.left = left;
mainboard.right = right;
mainboard.up = up;
mainboard.down = down;

for (var i = array_length(global.boards_controller_array) - 1; i >= 0; i--) {
	var controller = global.boards_controller_array[i];
	if (!is_struct(controller) || controller._destroyed) {
		array_delete(global.boards_controller_array, i, 1);
		continue;
	}
	controller.update();
}

for (var i = array_length(global.boards_array) - 1; i >= 0; i--) {
	var board = global.boards_array[i];
	if (!is_struct(board) || board._destroyed) {
		array_delete(global.boards_array, i, 1);
		continue;
	}
	board.update();
}

array_sort(global.boards_array, func_boardsort);