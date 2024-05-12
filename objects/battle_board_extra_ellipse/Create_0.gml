depth = DEPTH_BATTLE.BOARD;
radius_x = 60; //椭圆的x半径
radius_y = 60; //椭圆的y半径
precision = 360; //精确度
angle = 0;
board_number = global.borderCount

// 返回是否在椭圆内
function contains(_x, _y) {
    var pos = RotateAround(x, y, _x, _y, x, y, -angle);
    return sqr(pos[0] - x) * sqr(radius_y) + sqr(pos[1] - y) * sqr(radius_x) <= sqr(radius_x * radius_y);

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
    var len = radius_x * radius_y * sqrt((1 + k * k) / (radius_y * radius_y + sqr(radius_x * k)));
    var mul = len / sqrt(sqr(_x) + sqr(_y));

    return [_x * mul + x, _y * mul + y];
}

// 对_surf进行遮罩
function replaceSurfaceAlpha(_surf, _xOffset = 0, _yOffset = 0, _fillAlpha = true) {
    //一些设定
    surface_set_target(_surf);
    gpu_set_colorwriteenable(false, false, false, true);
    gpu_set_blendenable(false);

    //填充透明
    if (_fillAlpha) {
        draw_set_alpha(0);
        draw_rectangle(0, 0, surface_get_width(_surf), surface_get_height(_surf), false);
    }

    //挖空
    draw_set_alpha(1);
    draw_primitive_begin(pr_trianglefan);
    draw_vertex(x, y);
    for (var i = 0; i <= precision; i++) {
        var pos = RotateAround(x, y, x + lengthdir_x(radius_x, i * 360 / precision), y + lengthdir_y(radius_y, i * 360 / precision), x, y, angle);
        draw_vertex(pos[0], pos[1]);
    }
    draw_primitive_end();
    //恢复默认
    gpu_set_blendenable(true);
    gpu_set_colorwriteenable(true, true, true, true);
    surface_reset_target();
}
function drawBorder() {
    draw_primitive_begin(pr_trianglefan);
    draw_vertex_color(x, y, battle_board.color_frame, battle_board.alpha_frame);
    for (var i = 0; i <= precision; i++) {
        var pos = RotateAround(x, y, x + lengthdir_x(radius_x + 5, i * 360 / precision), y + lengthdir_y(radius_y + 5, i * 360 / precision), x, y, angle);
		draw_vertex_color(pos[0], pos[1], battle_board.color_frame, battle_board.alpha_frame);
    }
    draw_primitive_end();
}