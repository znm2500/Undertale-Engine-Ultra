depth = DEPTH_BATTLE.BOARD;
listVertex = []; // 替换为数组
listDivideIndex = []; 
listVertex_Outline = [];
angle = 0; 
rotate = 0;
rect = 0;
cover = 0;
board_depth = 0;
board_number = array_length(global.boards_array);
isCollide = array_create(4, 0);
array_push(global.boards_array, self);

// [返回点是否在多边形内]
function contains(_x, _y, _listVertex = cover ? listVertex_Outline : listVertex) {
    return relativeContains(_x - x, _y - y, _listVertex);
}

// [返回点是否在多边形内 (相对坐标)]
function relativeContains(_x, _y, _listVertex = cover ? listVertex_Outline : listVertex) {
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
}

// [返回离边框最近处的位置]
function limit(_x, _y, _listVertex = cover ? listVertex_Outline : listVertex) {
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
}

// 更新多边形的三角剖分
function updateDivide() {
    listDivideIndex = []; // 清空数组
    var size = array_length(listVertex);
    if (size < 3) return;

    for (var i = 0; i < size; i++) {
        var a = listVertex[i];
        var b = listVertex[iloop(i + 1)];
        var c = listVertex[iloop(i - 1)];

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

    // 内部辅助函数
    var canDivide = function(_index, _tmp, _mkr) {
        var p1 = _tmp[iloop(_index - 1, _tmp)],
            p2 = _tmp[iloop(_index + 1, _tmp)];
        if (!relativeContains((p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2, _tmp)) return false;

        var t_size = array_length(_tmp);
        var istart = _index + 2 - t_size,
            iend = _index - 2;
        var a1 = _tmp[iloop(_index - 1, _tmp)];
        var a2 = _tmp[iloop(_index + 1, _tmp)];
        
        var cp_func = function(_a1, _a2, _b1, _b2) {
            return (_a2[0] - _a1[0]) * (_b2[1] - _b1[1]) - (_a2[1] - _a1[1]) * (_b2[0] - _b1[0]);
        };

        for (var i = istart; i < iend; i++) {
            var b1 = _tmp[iloop(i, _tmp)];
            var b2 = _tmp[iloop(i + 1, _tmp)];
            if (sign(cp_func(a1, a2, a1, b1)) != sign(cp_func(a1, a2, a1, b2)) && sign(cp_func(b1, b2, b1, a1)) != sign(cp_func(b1, b2, b1, a2))) return false;
        }
        return true;
    };

    var isConvexFunc = function(_tmp) {
        var bool1 = false, bool2 = false;
        var t_size = array_length(_tmp);
        for (var i = 0; i < t_size; i++) {
            var p1 = _tmp[i],
                p2 = _tmp[iloop(i + 1, _tmp)],
                p3 = _tmp[iloop(i + 2, _tmp)];
            var cp = (p2[0] - p1[0]) * (p3[1] - p2[1]) - (p3[0] - p2[0]) * (p2[1] - p1[1]);
            if (cp > 0) bool1 = true;
            else if (cp < 0) bool2 = true;
            if (bool1 && bool2) return false;
        }
        return true;
    };

    // 进行剖分
    while (!isConvexFunc(listVertexTmp)) {
        var divided = false;
        for (var i = 0; i < array_length(listVertexTmp); i++) {
            if (canDivide(i, listVertexTmp, marker)) {
                divided = true;
                var a = marker[iloop(i - 1, marker)];
                var b = marker[iloop(i + 1, marker)];
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
        array_push(listDivideIndex, [marker[i], marker[iloop(i + 1, marker)], last]);
    }
}

// 遮罩
function replaceSurfaceAlpha() {
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
}

// 绘制边框
function drawBorder() {
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
            var a = listVertex[i], b = listVertex[iloop(i + 1)];
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
}

// 辅助循环函数
function iloop(_index, _list = listVertex) {
    var _len = array_length(_list);
    if (_len == 0) return 0;
    _index = _index % _len;
    if (_index < 0) _index += _len;
    return _index;
}