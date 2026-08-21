/// @description Newcreate
if (is_struct(mainboard) && !mainboard._destroyed) {
	mainboard.destroy();
}
mainboard = Battle_CreateBoardRect(x, y, 65, 65, 283, 283);