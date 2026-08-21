function __Battle_RegisterBoard(_board) {
    if (!variable_global_exists("boards_array")) global.boards_array = [];
    if (!variable_global_exists("board_uid")) global.board_uid = 0;
    _board.board_number = global.board_uid;
    global.board_uid++;
    array_push(global.boards_array, _board);
    return _board;
}

function __Battle_RemoveBoard(_board) {
    if (!variable_global_exists("boards_array")) return;
    var idx = array_find_index(global.boards_array, function(a, index) {
        return a == _board;
    });
    if (idx != -1) array_delete(global.boards_array, idx, 1);
}

function __Battle_RemoveBoardController(_controller){
	if (!variable_global_exists("boards_controlle_array")) return;
    var idx = array_find_index(global.boards_controller_array, function(a, index) {
        return a == _controller;
    });
    if (idx != -1) array_delete(global.boards_controller_array, idx, 1);
}
function __Battle_Iloop(_index, _list) {
    var _len = array_length(_list);
    if (_len <= 0) return 0;
    _index = _index mod _len;
    if (_index < 0) _index += _len;
    return _index;
}

// 直接创建一个框，创建后需要手动添加顶点
// Create an Board directly, you need to add vertexes by yourself
function Battle_CreateBoardPoints(x, y, board_depth = 0, angle = 0, rotate = 0, cover = 0) {
    var board = {
        _destroyed: false,
        x: x,
        y: y,
        angle: angle,
        rotate: rotate,
        rect: 0,
        cover: cover,
        board_depth: board_depth,
        board_number: -1,
        isCollide: array_create(4, 0),
        listVertex: [],
        listDivideIndex: [],
        listVertex_Outline: [],

        contains: function(_x, _y, _listVertex = cover ? listVertex_Outline : listVertex) {
            return relativeContains(_x - x, _y - y, _listVertex);
        },

        relativeContains: function(_x, _y, _listVertex = cover ? listVertex_Outline : listVertex) {
            var size = array_length(_listVertex);
            if (size < 2) return false;

            var vsin = dsin(angle),
                vcos = dcos(angle);
            var xx = _x * vcos - _y * vsin,
                yy = _x * vsin + _y * vcos;

            var isAllHor = true,
                prevTrend = false,
                prevHasIntersection = false;
            var prev = _listVertex[size - 1],
                cur;

            for (var i = size - 2; i >= 0; i--) {
                cur = _listVertex[i];
                if (prev[1] != cur[1]) {
                    isAllHor = false;
                    prevTrend = cur[1] < prev[1];
                    prevHasIntersection = (yy >= min(prev[1], cur[1]) && yy <= max(prev[1], cur[1]));
                    break;
                }
                prev = cur;
            }
            if (isAllHor) return false;

            var intersections = [], count = 0;
            prev = _listVertex[size - 1];
            for (var i = 0; i < size; i++) {
                cur = _listVertex[i];
                if (prev[1] != cur[1]) {
                    var hasIntersection = false;
                    var trend = cur[1] > prev[1];
                    if (trend != prevTrend || !prevHasIntersection) {
                        if (yy >= min(prev[1], cur[1]) && yy <= max(prev[1], cur[1])) {
                            hasIntersection = true;
                            intersections[count] = prev[0] + (cur[0] - prev[0]) * (yy - prev[1]) / (cur[1] - prev[1]);
                            count++;
                        }
                    }
                    if (trend != prevTrend) prevTrend = trend;
                    prevHasIntersection = hasIntersection;
                }
                prev = cur;
            }
            if (count == 0) return false;

            array_sort(intersections, true);
            var isInside = false;
            for (var i = 0; i < count; i++) {
                if (intersections[i] > xx) return isInside;
                isInside = !isInside;
            }
            return false;
        },

        limit: function(_x, _y, _listVertex = cover ? listVertex_Outline : listVertex) {
            var size = array_length(_listVertex);
            if (size == 0) return [_x, _y];
            if (size == 1) {
                var vertex = _listVertex[0];
                return [vertex[0] + x, vertex[1] + y];
            }

            _x -= x;
            _y -= y;
            var vsin = dsin(-angle),
                vcos = dcos(-angle);
            var xx = _x * vcos + _y * vsin,
                yy = -_x * vsin + _y * vcos;

            var nearestPos, nearestDis = -1;
            var prev = _listVertex[size - 1],
                cur;
            for (var i = 0; i < size; i++) {
                cur = _listVertex[i];
                if ((prev[0] - xx) * (prev[0] - cur[0]) + (prev[1] - yy) * (prev[1] - cur[1]) < 0) {
                    var dis = point_distance(xx, yy, prev[0], prev[1]);
                    if (dis < nearestDis || nearestDis == -1) {
                        nearestDis = dis;
                        nearestPos = prev;
                    }
                } else if ((cur[0] - xx) * (cur[0] - prev[0]) + (cur[1] - yy) * (cur[1] - prev[1]) < 0) {
                    var dis = point_distance(xx, yy, cur[0], cur[1]);
                    if (dis < nearestDis || nearestDis == -1) {
                        nearestDis = dis;
                        nearestPos = cur;
                    }
                } else {
                    var k = ((yy - prev[1]) * (cur[0] - prev[0]) - (xx - prev[0]) * (cur[1] - prev[1])) / (sqr(cur[1] - prev[1]) + sqr(cur[0] - prev[0]));
                    var dis = abs(k) * point_distance(prev[0], prev[1], cur[0], cur[1]);
                    if (dis < nearestDis || nearestDis == -1) {
                        nearestDis = dis;
                        nearestPos = [xx + k * (cur[1] - prev[1]), yy + k * (prev[0] - cur[0])];
                    }
                }
                prev = cur;
            }
            var resultx = nearestPos[0] * vcos - nearestPos[1] * vsin;
            var resulty = nearestPos[0] * vsin + nearestPos[1] * vcos;
            return [resultx + x, resulty + y];
        },

        updateDivide: function() {
            listDivideIndex = [];
            var size = array_length(listVertex);
            if (size < 3) return;

            for (var i = 0; i < size; i++) {
                var a = listVertex[i];
                var b = listVertex[__Battle_Iloop(i + 1, listVertex)];
                var c = listVertex[__Battle_Iloop(i - 1, listVertex)];

                var ax = a[0], ay = a[1];
                var bx = b[0], by = b[1];
                var cx = c[0], cy = c[1];
                var dangle = (point_direction(ax, ay, bx, by) - point_direction(ax, ay, cx, cy)) / 2;

                listVertex_Outline[i] = [
                    (ax + bx) / 2 + lengthdir_x(5, point_direction(ax, ay, bx, by) + 90) + lengthdir_x(point_distance(ax, ay, bx, by) / 2 + 5 / dtan(dangle), point_direction(bx, by, ax, ay)),
                    (ay + by) / 2 + lengthdir_y(5, point_direction(ax, ay, bx, by) + 90) + lengthdir_y(point_distance(ax, ay, bx, by) / 2 + 5 / dtan(dangle), point_direction(bx, by, ax, ay))
                ];
            }

            var listVertexTmp = [];
            array_copy(listVertexTmp, 0, listVertex, 0, size);

            var marker = [];
            for (var i = 0; i < size; i++) array_push(marker, i);

            var canDivide = function(_index, _tmp, _mkr) {
                var p1 = _tmp[__Battle_Iloop(_index - 1, _tmp)],
                    p2 = _tmp[__Battle_Iloop(_index + 1, _tmp)];
                if (!relativeContains((p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2, _tmp)) return false;

                var t_size = array_length(_tmp);
                var istart = _index + 2 - t_size,
                    iend = _index - 2;
                var a1 = _tmp[__Battle_Iloop(_index - 1, _tmp)];
                var a2 = _tmp[__Battle_Iloop(_index + 1, _tmp)];

                var cp_func = function(_a1, _a2, _b1, _b2) {
                    return (_a2[0] - _a1[0]) * (_b2[1] - _b1[1]) - (_a2[1] - _a1[1]) * (_b2[0] - _b1[0]);
                };

                for (var i = istart; i < iend; i++) {
                    var b1 = _tmp[__Battle_Iloop(i, _tmp)];
                    var b2 = _tmp[__Battle_Iloop(i + 1, _tmp)];
                    if (sign(cp_func(a1, a2, a1, b1)) != sign(cp_func(a1, a2, a1, b2)) && sign(cp_func(b1, b2, b1, a1)) != sign(cp_func(b1, b2, b1, a2))) return false;
                }
                return true;
            };

            var isConvexFunc = function(_tmp) {
                var bool1 = false, bool2 = false;
                var t_size = array_length(_tmp);
                for (var i = 0; i < t_size; i++) {
                    var p1 = _tmp[i],
                        p2 = _tmp[__Battle_Iloop(i + 1, _tmp)],
                        p3 = _tmp[__Battle_Iloop(i + 2, _tmp)];
                    var cp = (p2[0] - p1[0]) * (p3[1] - p2[1]) - (p3[0] - p2[0]) * (p2[1] - p1[1]);
                    if (cp > 0) bool1 = true;
                    else if (cp < 0) bool2 = true;
                    if (bool1 && bool2) return false;
                }
                return true;
            };

            while (!isConvexFunc(listVertexTmp)) {
                var divided = false;
                for (var i = 0; i < array_length(listVertexTmp); i++) {
                    if (canDivide(i, listVertexTmp, marker)) {
                        divided = true;
                        var a = marker[__Battle_Iloop(i - 1, marker)];
                        var b = marker[__Battle_Iloop(i + 1, marker)];
                        array_push(listDivideIndex, [marker[i], a, b]);
                        array_delete(listVertexTmp, i, 1);
                        array_delete(marker, i, 1);
                        break;
                    }
                }
                if (!divided) {
                    listDivideIndex = [];
                    return;
                }
            }

            var tmpLast = array_length(listVertexTmp) - 1;
            var last = marker[tmpLast];
            for (var i = 0; i < tmpLast - 1; i++) {
                array_push(listDivideIndex, [marker[i], marker[__Battle_Iloop(i + 1, marker)], last]);
            }
        },

        replaceSurfaceAlpha: function() {
            gpu_set_colorwriteenable(false, false, false, true);
            gpu_set_blendenable(false);
            surface_set_target(battle_board._surface_mask);

            draw_set_alpha(!cover);
            var vsin = dsin(-angle), vcos = dcos(-angle);
            var size = array_length(listDivideIndex);

            for (var i = 0; i < size; i++) {
                var di = listDivideIndex[i];
                draw_primitive_begin(pr_trianglelist);
                for (var j = 0; j < 3; j++) {
                    var pos = listVertex[di[j]];
                    var rx = pos[0] * vcos - pos[1] * vsin;
                    var ry = pos[0] * vsin + pos[1] * vcos;
                    draw_vertex(x + rx, y + ry);
                }
                draw_primitive_end();
            }
            surface_reset_target();

            if (!cover) {
                surface_set_target(battle_board._surface_board_extra);
                draw_set_alpha(0);
                for (var i = 0; i < size; i++) {
                    var di = listDivideIndex[i];
                    draw_primitive_begin(pr_trianglelist);
                    for (var j = 0; j < 3; j++) {
                        var pos = listVertex[di[j]];
                        var rx = pos[0] * vcos - pos[1] * vsin;
                        var ry = pos[0] * vsin + pos[1] * vcos;
                        draw_vertex(x + rx, y + ry);
                    }
                    draw_primitive_end();
                }
                surface_reset_target();
            }
            gpu_set_blendenable(true);
            gpu_set_colorwriteenable(true, true, true, true);
        },

        drawBorder: function() {
            surface_set_target(cover ? battle_board._surface_board_cover : battle_board._surface_board_extra);
            var vsin = dsin(-angle), vcos = dcos(-angle);

            if (rect && battle_board.edge) {
                var left = RotateAround(x, y, x + listVertex[0][0], y + listVertex[0][1], x, y, angle);
                var right = RotateAround(x, y, x + listVertex[1][0], y + listVertex[1][1], x, y, angle);
                var up = RotateAround(x, y, x + listVertex[3][0], y + listVertex[3][1], x, y, angle);
                var down = RotateAround(x, y, x + listVertex[2][0], y + listVertex[2][1], x, y, angle);

                draw_sprite_ext(spr_battle_board_edge, 0, left[0], left[1], 1, 1, angle, battle_board.color_frame, battle_board.alpha_frame);
                draw_sprite_ext(spr_battle_board_edge, 0, right[0], right[1], -1, 1, angle, battle_board.color_frame, battle_board.alpha_frame);
                draw_sprite_ext(spr_battle_board_edge, 0, up[0], up[1], 1, -1, angle, battle_board.color_frame, battle_board.alpha_frame);
                draw_sprite_ext(spr_battle_board_edge, 0, down[0], down[1], -1, -1, angle, battle_board.color_frame, battle_board.alpha_frame);

                for (var i = 0; i < array_length(listVertex); i++) {
                    var a = listVertex[i], b = listVertex[__Battle_Iloop(i + 1, listVertex)];
                    var ax = a[0] * vcos - a[1] * vsin, ay = a[0] * vsin + a[1] * vcos;
                    var bx = b[0] * vcos - b[1] * vsin, by = b[0] * vsin + b[1] * vcos;
                    var p_dir = point_direction(ax, ay, bx, by);
                    draw_sprite_ext(spr_pixel, 0, x + ax - (5 - 4 * battle_board.edge) * cos(degtorad(floor(p_dir))), y + ay + (5 - 4 * battle_board.edge) * sin(degtorad(floor(p_dir))), 5, point_distance(ax, ay, bx, by) + 5 + 5 * cos(degtorad((p_dir % 45))) - 8 * battle_board.edge, p_dir + 90, battle_board.color_frame, battle_board.alpha_frame);
                }
            } else {
                var size = array_length(listDivideIndex);
                for (var i = 0; i < size; i++) {
                    var di = listDivideIndex[i];
                    draw_primitive_begin(pr_trianglestrip);
                    for (var j = 0; j < 3; j++) {
                        var pos = listVertex_Outline[di[j]];
                        var rx = pos[0] * vcos - pos[1] * vsin;
                        var ry = pos[0] * vsin + pos[1] * vcos;
                        draw_vertex_color(x + rx, y + ry, battle_board.color_frame, battle_board.alpha_frame);
                    }
                    draw_primitive_end();
                }
            }
            surface_reset_target();

            gpu_set_colorwriteenable(false, false, false, true);
            gpu_set_blendenable(false);
            surface_set_target(!cover ? battle_board._surface_board_cover : battle_board._surface_board_extra);
            draw_set_alpha(0);
            var size = array_length(listDivideIndex);
            for (var i = 0; i < size; i++) {
                var di = listDivideIndex[i];
                draw_primitive_begin(pr_trianglelist);
                for (var j = 0; j < 3; j++) {
                    var pos = listVertex[di[j]];
                    var rx = pos[0] * vcos - pos[1] * vsin;
                    var ry = pos[0] * vsin + pos[1] * vcos;
                    draw_vertex(x + rx, y + ry);
                }
                draw_primitive_end();
            }
            surface_reset_target();
            gpu_set_blendenable(true);
            gpu_set_colorwriteenable(true, true, true, true);
        },

        update: function() {
            angle += rotate;
        },

        destroy: function() {
            if (_destroyed) return;
            _destroyed = true;
            __Battle_RemoveBoard(self);
        }
    };

    return __Battle_RegisterBoard(board);
}

//创建一个矩形的框
//Create a Board that is rect
function Battle_CreateBoardRect(x, y, up, down, left, right, board_depth = 0, angle = 0, rotate = 0, cover = 0) {
    var rect = Battle_CreateBoardPoints(x, y, board_depth, angle, rotate, cover);
    rect.up = up;
    rect.down = down;
    rect.left = left;
    rect.right = right;
    rect.rect = 1;
    rect.update = method(rect, function() {
        self.angle += self.rotate;
        self.listVertex = [
            [-self.left, -self.up],
            [self.right, -self.up],
            [self.right, self.down],
            [-self.left, self.down]
        ];
        self.updateDivide();
    });
    rect.update();
    return rect;
}

//创建一个圆形的框
//Create a Board that is circle
function Battle_CreateBoardCircle(x, y, radius, board_depth = 0, cover = 0) {
    return Battle_CreateBoardEllipse(x, y, radius, radius, board_depth, 0, 0, cover);
}

//创建一个椭圆的框
//Create a Board that is ellipse
function Battle_CreateBoardEllipse(x, y, radius_x, radius_y, board_depth = 0, angle = 0, rotate = 0, cover = 0) {
    var ellipse = {
        _destroyed: false,
        x: x,
        y: y,
        radius_x: radius_x,
        radius_y: radius_y,
        precision: 360,
        angle: angle,
        rotate: rotate,
        cover: cover,
        board_depth: board_depth,
        board_number: -1,
        isCollide: array_create(4, 0),

        contains: function(_x, _y) {
            var pos = RotateAround(x, y, _x, _y, x, y, -angle);
            if (cover) return sqr(pos[0] - x) * sqr(radius_y + 5) + sqr(pos[1] - y) * sqr(radius_x + 5) <= sqr((radius_x + 5) * (radius_y + 5));
            return sqr(pos[0] - x) * sqr(radius_y) + sqr(pos[1] - y) * sqr(radius_x) <= sqr(radius_x * radius_y);
        },

        limit: function(_x, _y) {
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
        },

        replaceSurfaceAlpha: function() {
            gpu_set_colorwriteenable(false, false, false, true);
            gpu_set_blendenable(false);
            surface_set_target(battle_board._surface_mask);
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
        },

        drawBorder: function() {
            surface_set_target(cover ? battle_board._surface_board_cover : battle_board._surface_board_extra);
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
            surface_set_target(!cover ? battle_board._surface_board_cover : battle_board._surface_board_extra);
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
        },

        update: function() {
            angle += rotate;
        },

        destroy: function() {
            if (_destroyed) return;
            _destroyed = true;
            __Battle_RemoveBoard(self);
        }
    };

    return __Battle_RegisterBoard(ellipse);
}

//创建一个圆角矩形的框
//Create a Board that is roundrect
function Battle_CreateBoardRoundrect(x, y, size, precision, board_depth = 0, angle = 0, rotate = 0, cover = 0) {
    if (!variable_global_exists("boards_controller_array")) global.boards_controller_array = [];
    var roundrect = {
        _destroyed: false,
        x: x,
        y: y,
        size: size,
        precision: precision,
        board_depth: board_depth,
        angle: angle,
        rotate: rotate,
        cover: cover,
        hrect: Battle_CreateBoardRect(x, y, size / 2, size / 2, (size - precision * 2) / 2, (size - precision * 2) / 2, board_depth, angle, 0, cover),
        vrect: Battle_CreateBoardRect(x, y, (size - precision * 2) / 2, (size - precision * 2) / 2, size / 2, size / 2, board_depth, angle, 0, cover),
        circle_0: Battle_CreateBoardCircle(x + (size - precision * 2) / 2 - 1, y - (size - precision * 2) / 2 - 1, precision, board_depth, cover),
        circle_1: Battle_CreateBoardCircle(x - (size - precision * 2) / 2 - 1, y - (size - precision * 2) / 2 - 1, precision, board_depth, cover),
        circle_2: Battle_CreateBoardCircle(x - (size - precision * 2) / 2 - 1, y + (size - precision * 2) / 2 - 1, precision, board_depth, cover),
        circle_3: Battle_CreateBoardCircle(x + (size - precision * 2) / 2 - 1, y + (size - precision * 2) / 2 - 1, precision, board_depth, cover),

        update: function() {
            angle += rotate;

            hrect.angle = angle;
            hrect.up = size / 2;
            hrect.down = size / 2;
            hrect.left = (size - precision * 2) / 2;
            hrect.right = (size - precision * 2) / 2;
            hrect.x = x;
            hrect.y = y;
            hrect.cover = cover;
            hrect.board_depth = board_depth;

            vrect.angle = angle;
            vrect.up = (size - precision * 2) / 2;
            vrect.down = (size - precision * 2) / 2;
            vrect.left = size / 2;
            vrect.right = size / 2;
            vrect.x = x;
            vrect.y = y;
            vrect.cover = cover;
            vrect.board_depth = board_depth;

            circle_0.radius_x = precision;
            circle_0.radius_y = precision;
            circle_0.x = x + lengthdir_x(((size - precision * 2) / 2) * 1.414, angle + 45) - 1;
            circle_0.y = y + lengthdir_y(((size - precision * 2) / 2) * 1.414, angle + 45) - 1;
            circle_0.cover = cover;
            circle_0.board_depth = board_depth;

            circle_1.radius_x = precision;
            circle_1.radius_y = precision;
            circle_1.x = x + lengthdir_x(((size - precision * 2) / 2) * 1.414, angle + 45 + 90 * 1) - 1;
            circle_1.y = y + lengthdir_y(((size - precision * 2) / 2) * 1.414, angle + 45 + 90 * 1) - 1;
            circle_1.cover = cover;
            circle_1.board_depth = board_depth;

            circle_2.radius_x = precision;
            circle_2.radius_y = precision;
            circle_2.x = x + lengthdir_x(((size - precision * 2) / 2) * 1.414, angle + 45 + 90 * 2) - 1;
            circle_2.y = y + lengthdir_y(((size - precision * 2) / 2) * 1.414, angle + 45 + 90 * 2) - 1;
            circle_2.cover = cover;
            circle_2.board_depth = board_depth;

            circle_3.radius_x = precision;
            circle_3.radius_y = precision;
            circle_3.x = x + lengthdir_x(((size - precision * 2) / 2) * 1.414, angle + 45 + 90 * 3) - 1;
            circle_3.y = y + lengthdir_y(((size - precision * 2) / 2) * 1.414, angle + 45 + 90 * 3) - 1;
            circle_3.cover = cover;
            circle_3.board_depth = board_depth;
        },

        destroy: function() {
            if (_destroyed) return;
			__Battle_RemoveBoardController(self);
            _destroyed = true;
            hrect.destroy();
            vrect.destroy();
            circle_0.destroy();
            circle_1.destroy();
            circle_2.destroy();
            circle_3.destroy();
        }
    };

    array_push(global.boards_controller_array, roundrect);
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

    array_push(VERTEXLIST, [X, Y]);
    BOARD.updateDivide();
}

