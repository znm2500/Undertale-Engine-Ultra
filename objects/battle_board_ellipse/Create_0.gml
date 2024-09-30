depth = DEPTH_BATTLE.BOARD;
radius_x = 60; //椭圆的x半径
radius_y = 60; //椭圆的y半径
precision = 360; //精确度
angle = 0;
rotate = 0;
cover = 0;
board_depth = 0;
board_number = array_length(global.boards_array);
isCollide = array_create(4, 0);
array_push(global.boards_array, self);
// 返回是否在椭圆内
function contains(_x, _y) {
    var pos = RotateAround(x, y, _x, _y, x, y, -angle);
    if (cover) return sqr(pos[0] - x) * sqr(radius_y + 5) + sqr(pos[1] - y) * sqr(radius_x + 5) <= sqr((radius_x + 5) * (radius_y + 5));
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
    if (!cover) {
        var k = (pos[0] == 0) ? 99999 : pos[1] / pos[0];
        var len = radius_x * radius_y * sqrt((1 + k * k) / (radius_y * radius_y + sqr(radius_x * k)));
        var mul = len / sqrt(sqr(_x) + sqr(_y));

    } else {
        var k = (pos[0] == 0) ? 99999 : pos[1] / pos[0];
        var len = (radius_x + 5) * (radius_y + 5) * sqrt((1 + k * k) / (sqr(radius_y + 5) + sqr((5 + radius_x) * k)));
        var mul = len / sqrt(sqr(_x) + sqr(_y));

    }
    return [_x * mul + x, _y * mul + y];
}

// 对_surf进行遮罩
function replaceSurfaceAlpha() {
    //设置挖空
    gpu_set_colorwriteenable(false, false, false, true);
    gpu_set_blendenable(false);
    surface_set_target(battle_board._surface_mask);
    //挖空
    draw_set_alpha(!cover);
    draw_primitive_begin(pr_trianglefan);
    draw_vertex(x, y);
    for (var i = 0; i <= precision; i++) {
        var pos = RotateAround(x, y, x + lengthdir_x(radius_x, i * 360 / precision), y + lengthdir_y(radius_y, i * 360 / precision), x, y, angle);
        draw_vertex(pos[0], pos[1]);
    }
    draw_primitive_end();
    surface_reset_target();
    gpu_set_blendenable(true);
    gpu_set_colorwriteenable(true, true, true, true);

}
function drawBorder() {
    surface_set_target(cover ? battle_board._surface_board_cover: battle_board._surface_board_extra);
    draw_primitive_begin(pr_trianglefan);
    draw_vertex_color(x, y, battle_board.color_frame, battle_board.alpha_frame);
    for (var i = 0; i <= precision; i++) {
        var pos = RotateAround(x, y, x + lengthdir_x(radius_x + 5, i * 360 / precision), y + lengthdir_y(radius_y + 5, i * 360 / precision), x, y, angle);
        draw_vertex_color(pos[0], pos[1], battle_board.color_frame, battle_board.alpha_frame);
    }
    draw_primitive_end();
    surface_reset_target();
    gpu_set_colorwriteenable(false, false, false, true);
    gpu_set_blendenable(false);
    surface_set_target(!cover ? battle_board._surface_board_cover: battle_board._surface_board_extra);
    draw_set_alpha(0);
    draw_primitive_begin(pr_trianglefan);
    draw_vertex(x, y);
    for (var i = 0; i <= precision; i++) {
        var pos = RotateAround(x, y, x + lengthdir_x(radius_x, i * 360 / precision), y + lengthdir_y(radius_y, i * 360 / precision), x, y, angle);
        draw_vertex(pos[0], pos[1]);
    }
    draw_primitive_end();
    surface_reset_target();
    gpu_set_blendenable(true);
    gpu_set_colorwriteenable(true, true, true, true);
}