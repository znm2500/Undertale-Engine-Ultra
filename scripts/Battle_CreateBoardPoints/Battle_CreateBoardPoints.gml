// 直接创建一个框，创建后需要手动添加顶点
// Create an Board directly, you need to add vertexes by yourself
function Battle_CreateBoardPoints(x, y, board_depth = 0, angle = 0, rotate = 0, cover = 0) {

    var board = instance_create_depth(x, y, 0, battle_board_points);
    board.rotate = rotate;
    board.angle = angle;
    board.board_depth = board_depth;
    board.cover = cover;
    return board;
}

//创建一个矩形的框
//Create a Board that is rect
function Battle_CreateBoardRect(x, y, up, down, left, right, board_depth = 0, angle = 0, rotate = 0, cover = 0) {

    var rect = instance_create_depth(x, y, 0, battle_board_rect);
    rect.up = up;
    rect.down = down;
    rect.left = left;
    rect.right = right;
    rect.rotate = rotate;
    rect.angle = angle;
    rect.board_depth = board_depth;
    rect.cover = cover;
    return rect;
}

//创建一个圆形的框
//Create a Board that is circle
function Battle_CreateBoardCircle(x, y, radius, board_depth = 0, cover = 0) {

    var circle = instance_create_depth(x, y, 0, battle_board_ellipse);
    circle.radius_x = radius;
    circle.radius_y = radius;
    circle.board_depth = board_depth;
    circle.cover = cover;
    return circle;
}
//创建一个椭圆的框
//Create a Board that is ellipse
function Battle_CreateBoardEllipse(x, y, radius_x, radius_y, board_depth = 0, angle = 0, rotate = 0, cover = 0) {

    var ellipse = instance_create_depth(x, y, 0, battle_board_ellipse);
    ellipse.radius_x = radius_x;
    ellipse.radius_y = radius_y;
    ellipse.rotate = rotate;
    ellipse.angle = angle;
    ellipse.board_depth = board_depth;
    ellipse.cover = cover;

    return ellipse;
}
//创建一个圆角矩形的框
//Create a Board that is roundrect
function Battle_CreateBoardRoundrect(x, y, size, precision, board_depth = 0, angle = 0, rotate = 0, cover = 0) {

    var roundrect = instance_create_depth(x, y, 0, battle_board_roundrect);
    roundrect.size = size;
    roundrect.precision = precision;
    roundrect.rotate = rotate;
    roundrect.angle = angle;
    roundrect.board_depth = board_depth;
    roundrect.cover = cover;
    return roundrect;
}
//给指定框添加顶点,最少要三个顶点才能正常运行
//注意：顶点坐标顺序一定要按顺时针排列否则会出显示问题
//Add vertex to the Board,you need to add at least 3 vertexes to make it work properly
//WARNING:The arrangement of vertexes' positions must be clockwise or visual problem happens
function Battle_AddBoardVertex(board, vertex_x, vertex_y) {
    var BOARD = board;
    var X = vertex_x;
    var Y = vertex_y;
    var VERTEXLIST = BOARD.listVertex;

    ds_list_add(VERTEXLIST, [X, Y]);
    BOARD.updateDivide();
}

