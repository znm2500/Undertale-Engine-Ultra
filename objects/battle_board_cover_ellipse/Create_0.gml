depth = DEPTH_BATTLE.BOARD;
radius_x = 60; //椭圆的x半径
radius_y = 60; //椭圆的y半径
precision = 360; //精确度
angle = 0;

// 返回是否在椭圆内
function contains(_x, _y) {
    var pos = RotateAround(x, y, _x, _y, x, y, -angle);
    return sqr(pos[0] - x) * sqr(radius_y + 5) + sqr(pos[1] - y) * sqr(radius_x + 5) <= sqr((radius_x + 5) * (radius_y + 5));

}

// 将点限制到椭圆内
// 返回限制结果
function limit(_x, _y) {
    var pos = RotateAround(x, y, _x, _y, x, y, -angle);
    pos[0] -= x;
    pos[1] -= y;
    _x -= x;
    _y -= y;
    var k = (pos[0] == 0) ? 99999 : pos[1] / pos[0];
    var len = (radius_x + 5) * (radius_y + 5) * sqrt((1 + k * k) / (sqr(radius_y + 5) + sqr((5 + radius_x) * k)));
    var mul = len / sqrt(sqr(_x) + sqr(_y));

    return [_x * mul + x, _y * mul + y];
}