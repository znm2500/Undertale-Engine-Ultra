depth = DEPTH_BATTLE.BOARD;
radius = 60;	//圆的半径


// 返回是否在圆内
function contains(_x, _y) {
	return sqr(_x - x) + sqr(_y - y) <= sqr(radius+5);
}

// 将点限制到圆内
// 返回限制结果
function limit(_x, _y) {
	_x -= x;
	_y -= y;
	var mul = (radius+5) / sqrt(sqr(_x) + sqr(_y));
	return [_x * mul + x, _y * mul + y];
}

