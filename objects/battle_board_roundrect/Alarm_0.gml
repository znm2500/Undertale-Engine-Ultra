hrect = Battle_CreateBoardRect(x, y, size / 2, size / 2, (size - precision * 2) / 2, (size - precision * 2) / 2, angle, board_depth, , cover);
vrect = Battle_CreateBoardRect(x, y, (size - precision * 2) / 2, (size - precision * 2) / 2, size / 2, size / 2, angle, board_depth, , cover);
circle_0 = Battle_CreateBoardCircle(x + (size - precision * 2) / 2 - 1, y - (size - precision * 2) / 2 - 1, precision, board_depth, cover);
circle_1 = Battle_CreateBoardCircle(x - (size - precision * 2) / 2 - 1, y - (size - precision * 2) / 2 - 1, precision, board_depth, cover);
circle_2 = Battle_CreateBoardCircle(x - (size - precision * 2) / 2 - 1, y + (size - precision * 2) / 2 - 1, precision, board_depth, cover);
circle_3 = Battle_CreateBoardCircle(x + (size - precision * 2) / 2 - 1, y + (size - precision * 2) / 2 - 1, precision, board_depth, cover);