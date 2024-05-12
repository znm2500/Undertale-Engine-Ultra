// 直接创建一个加框，创建后需要手动添加顶点
// Create an Extra-Board directly, you need to add vertexes by yourself
function Battle_CreateBoardExtra(x, y, angle = 0, rot = 0) {
    var X = x;
    var Y = y;
    var ROT = rot;

    extra = instance_create_depth(X, Y, 0, battle_board_extra);
    extra.rot = ROT;
    extra.angle = angle;
    ds_list_add(global.borders_list, extra);

    return extra;
}

//创建一个矩形的加框
//Create a Extra-Board that is rect
function Battle_CreateBoardExtraRect(x, y, up, down, left, right, angle = 0, rot = 0) {
    var X = x;
    var Y = y;
    var UP = up;
    var DOWN = down;
    var LEFT = left;
    var RIGHT = right;
    var ANGLE = angle;
    var ROT = 0;

    if (argument_count >= 8) {
        ROT = rot;
    }

    rect = instance_create_depth(X, Y, 0, battle_board_extra_rect);
    rect.up = UP;
    rect.down = DOWN;
    rect.left = LEFT;
    rect.right = RIGHT;
    rect.angle = ANGLE;
    rect.rot = ROT;

    return rect;
}

//创建一个圆形的加框
//Create a Extra-Board that is circle
function Battle_CreateBoardExtraCircle(x, y, radius) {
    var X = x;
    var Y = y;
    var RADIUS = radius;

    circle = instance_create_depth(X, Y, 0, battle_board_extra_ellipse);
    circle.radius_x = RADIUS;
    circle.radius_y = RADIUS;
    ds_list_add(global.borders_list, circle);

    return circle;
}
//创建一个椭圆的加框
//Create a Extra-Board that is ellipse
function Battle_CreateBoardExtraEllipse(x, y, radius_x, radius_y, angle = 0) {
    var X = x;
    var Y = y;

    ellipse = instance_create_depth(X, Y, 0, battle_board_extra_ellipse);
    ellipse.radius_x = radius_x;
    ellipse.radius_y = radius_y;
    ellipse.angle = angle;
    ds_list_add(global.borders_list, ellipse);

    return ellipse;
}
//创建一个圆角矩形的加框
//Create a Extra-Board that is roundrect
function Battle_CreateBoardExtraRoundrect(x, y, size, precision) {
    var X = x;
    var Y = y;
    var SIZE = size;
    var PRECISION = precision;

    roundrect = instance_create_depth(X, Y, 0, battle_board_extra_roundrect);
    roundrect.size = SIZE;
    roundrect.precision = PRECISION;

    return roundrect;
}