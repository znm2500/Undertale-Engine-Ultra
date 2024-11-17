depth = DEPTH_BATTLE.BOARD;
listVertex = ds_list_create(); //多边形的顶点,请使用ds_list_add、ds_list_delete等进行操作
listDivideIndex = ds_list_create(); //多边形的三角剖分
listVertex_Outline = ds_list_create();
angle = 0; //旋转角度（逆时针）
rotate = 0; //旋转速度
rect = 0;
cover = 0;
board_depth = 0;
board_number = array_length(global.boards_array);
isCollide = array_create(4, 0);
array_push(global.boards_array, self);

// [返回点是否在多边形内]
// 传入参数:
//     _x: 点的横坐标
//     _y: 点的纵坐标
//     _listVertex: 别管这个
function contains(_x, _y, _listVertex = cover ? listVertex_Outline: listVertex) {
    return relativeContains(_x - x, _y - y, _listVertex);
}

// [返回点是否在多边形内]
// 传入参数:
//     _x: 相对于该多边形x的横坐标
//     _y: 相对于该多边形y的纵坐标
//     _listVertex: 别管这个
function relativeContains(_x, _y, _listVertex = cover ? listVertex_Outline: listVertex) {
    var size = ds_list_size(_listVertex);
    if (size < 2) //若顶点数量不足则返回false
    return false;

    var vsin = dsin(angle),
    vcos = dcos(angle);
    var xx = _x * vcos - _y * vsin,
    yy = _x * vsin + _y * vcos;

    //从末尾开始遍历得到第一个不为水平的线的 走向 和 交点情况
    var isAllHor = true,
    prevTrend = false,
    prevHasIntersection = false;
    var prev = _listVertex[| size - 1],
    cur;
    for (var i = size - 2; i >= 0; i--) {
        cur = _listVertex[| i];
        if (prev[1] != cur[1]) {
            isAllHor = false;
            prevTrend = cur[1] < prev[1]; //因为是反向遍历,所以是小于（和后面的大于相反）
            prevHasIntersection = (yy >= min(prev[1], cur[1]) && yy <= max(prev[1], cur[1]));
            break;
        }
        prev = cur;
    }
    if (isAllHor) //如果全部都为水平线,则返回false
    return false;

    //计算交点横坐标
    var intersections, count = 0;
    prev = _listVertex[| size - 1];
    for (var i = 0; i < size; i++) {
        cur = _listVertex[| i];
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
    if (count == 0) //如果没有交点,则返回false
    return false;

    array_sort(intersections, true); //从小到大对交点横坐标进行排序
    //根据交点对是否在内部进行判断
    var isInside = false;
    for (var i = 0; i < count; i++) {
        if (intersections[i] > xx) return isInside;
        isInside = !isInside;
    }
    return false;
}

// [返回离边框最近处的位置,长度为2的数组（下标0是x,下标1是y）]
function limit(_x, _y, _listVertex = cover ? listVertex_Outline: listVertex) {
   var size = ds_list_size(_listVertex);
    if (size == 0) return [_x, _y];
    if (size == 1) {
        var vertex = _listVertex[|0];
        return [vertex[0] + x, vertex[1] + y];
    }

    _x -= x;
    _y -= y;
    var vsin = dsin( - angle),
    vcos = dcos( - angle);
    var xx = _x * vcos + _y * vsin,
    yy = -_x * vsin + _y * vcos;

    var nearestPos, nearestDis = -1;
    var prev = _listVertex[|size - 1],
    cur;
    for (var i = 0; i < size; i++) {
        cur = _listVertex[|i];
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

// 用于更新多边形的三角剖分
// 如果你要实现框内遮罩的效果,请在添加或删除多边形的顶点后调用此函数
function updateDivide() {
    ds_list_clear(listDivideIndex); //清除原剖分结果
    var size = ds_list_size(listVertex);
    if (size < 3) return;
    for (var i = 0; i < size; i++) {

        var a = listVertex[| i];
        var b = listVertex[| iloop(i + 1)];
        var c = listVertex[| iloop(i - 1)];

        var ax = a[0];
        var ay = a[1];
        var bx = b[0];
        var by = b[1];
        var cx = c[0];
        var cy = c[1];
        var dangle = (point_direction(ax, ay, bx, by) - point_direction(ax, ay, cx, cy)) / 2 listVertex_Outline[| i] = [(ax + bx) / 2 + lengthdir_x(5, point_direction(ax, ay, bx, by) + 90) + lengthdir_x(point_distance(ax, ay, bx, by) / 2 + 5 / dtan(dangle), point_direction(bx, by, ax, ay)), (ay + by) / 2 + lengthdir_y(5, point_direction(ax, ay, bx, by) + 90) + lengthdir_y(point_distance(ax, ay, bx, by) / 2 + 5 / dtan(dangle), point_direction(bx, by, ax, ay))]
    }
    listVertexTmp = ds_list_create(); //创建临时顶点列表
    ds_list_copy(listVertexTmp, listVertex);

    var marker = ds_list_create(); //创建tmp与原列表对应关系
    for (var i = 0; i < size; i++) ds_list_add(marker, i);

    // 辅助函数,用于_index处的顶点是否可以剖分
    function canDivide(_index) {
        //判断是否为凸顶点,如果不是,则return false
        //实际上这里也有部分为凹顶点的情况无法被排除,但是后续的代码会同时排除掉这些
        var p1 = listVertexTmp[| iloop(_index - 1, listVertexTmp)],
        p2 = listVertexTmp[| iloop(_index + 1, listVertexTmp)];
        if (!relativeContains((p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2, listVertexTmp)) return false;

        //判断移除顶点后是否出现边相交
        var istart = _index + 2 - ds_list_size(listVertexTmp),
        iend = _index - 2;
        var a1 = listVertexTmp[| iloop(_index - 1, listVertexTmp)];
        var a2 = listVertexTmp[| iloop(_index + 1, listVertexTmp)];
        var b1, b2;
        function cp(_a1, _a2, _b1, _b2) {
            return (_a2[0] - _a1[0]) * (_b2[1] - _b1[1]) - (_a2[1] - _a1[1]) * (_b2[0] - _b1[0]);
        }
        for (var i = istart; i < iend; i++) {
            b1 = listVertexTmp[| iloop(i, listVertexTmp)];
            b2 = listVertexTmp[| iloop(i + 1, listVertexTmp)];
            if (sign(cp(a1, a2, a1, b1)) != sign(cp(a1, a2, a1, b2)) && sign(cp(b1, b2, b1, a1)) != sign(cp(b1, b2, b1, a2))) return false;
        }
        return true;
    }
    // 辅助函数,用于检查是否为凸多边形
    function isConvex() {
        var bool1 = false,
        bool2 = false; //分别记录边的两种走向是否存在
        for (var i = 0; i < ds_list_size(listVertexTmp); i++) {
            var p1 = listVertexTmp[| i];
            var p2 = listVertexTmp[| iloop(i + 1, listVertexTmp)];
            var p3 = listVertexTmp[| iloop(i + 2, listVertexTmp)];
            var x1 = p2[0] - p1[0],
            y1 = p2[1] - p1[1],
            x2 = p3[0] - p2[0],
            y2 = p3[1] - p2[1];
            var cp = x1 * y2 - x2 * y1;

            if (cp > 0) { //一种走向
                bool1 = true;
            } else if (cp < 0) { //另一种走向
                bool2 = true;
            }

            if (bool1 && bool2) //如果两种走向都存在,则不是凸多边形
            return false;
        }
        return true; //是凸多边形
    }

    //进行剖分
    while (!isConvex()) { //循环直到listVertexTmp变为凸多边形
        var divided = false;
        for (var i = 0; i < ds_list_size(listVertexTmp); i++) { //遍历所有顶点
            if (canDivide(i)) { //如果该顶点可以剖分
                divided = true;
                var a = marker[| iloop(i - 1, marker)];
                var b = marker[| iloop(i + 1, marker)];
                ds_list_add(listDivideIndex, [marker[| i], a, b]);
                ds_list_delete(listVertexTmp, i);
                ds_list_delete(marker, i);
                break;
            }
        }
        if (!divided) { //当出现死循环时（大多是因为多边形的边出现相交）直接结束
            ds_list_clear(listDivideIndex);
            ds_list_destroy(listVertexTmp); //销毁临时顶点列表
            ds_list_destroy(marker); //销毁
            return;
        }
    }
    var tmpLast = ds_list_size(listVertexTmp) - 1;
    var last = marker[| tmpLast];
    for (var i = 0; i < tmpLast - 1; i++) { //对剩下的凸多边形部分进行剖分
        ds_list_add(listDivideIndex, [marker[| i], marker[| iloop(i + 1, marker)], last]);
    }

    ds_list_destroy(listVertexTmp); //销毁临时顶点列表
    ds_list_destroy(marker); //销毁
}
// 用于更改surface的alpha以达到限制显示范围的目的（遮罩）
function replaceSurfaceAlpha() {

    //设置挖空
    gpu_set_colorwriteenable(false, false, false, true);
    gpu_set_blendenable(false);
    surface_set_target(battle_board._surface_mask);
    //挖空
    draw_set_alpha(!cover);
    var vsin = dsin( - angle),
    vcos = dcos( - angle);
    var size = ds_list_size(listDivideIndex);
    for (var i = 0; i < size; i++) { //遍历所有的三角
        var di = listDivideIndex[| i];
        draw_primitive_begin(pr_trianglelist);
        for (var j = 0; j < 3; j++) {
            var pos = listVertex[| di[j]];
            var resultx = pos[0] * vcos - pos[1] * vsin;
            var resulty = pos[0] * vsin + pos[1] * vcos;
            draw_vertex(x + resultx, y + resulty);
        }
        draw_primitive_end();
    }
    surface_reset_target();
    if (!cover) {
        surface_set_target(battle_board._surface_board_extra);
        //挖空
        draw_set_alpha(0);
        var vsin = dsin( - angle),
        vcos = dcos( - angle);
        var size = ds_list_size(listDivideIndex);
        for (var i = 0; i < size; i++) { //遍历所有的三角
            var di = listDivideIndex[| i];
            draw_primitive_begin(pr_trianglelist);
            for (var j = 0; j < 3; j++) {
                var pos = listVertex[| di[j]];
                var resultx = pos[0] * vcos - pos[1] * vsin;
                var resulty = pos[0] * vsin + pos[1] * vcos;
                draw_vertex(x + resultx, y + resulty);
            }
            draw_primitive_end();
        }
        surface_reset_target();
    }
    //恢复默认
    gpu_set_blendenable(true);
    gpu_set_colorwriteenable(true, true, true, true);

}
// 用于绘制边框
function drawBorder() {
    surface_set_target(cover ? battle_board._surface_board_cover: battle_board._surface_board_extra);
    var vsin = dsin( - angle);
    var vcos = dcos( - angle);
    if (rect && battle_board.edge) {
        var left = RotateAround(x, y, x + listVertex[| 0][0], y + listVertex[| 0][1], x, y, angle);
        var right = RotateAround(x, y, x + listVertex[| 1][0], y + listVertex[| 1][1], x, y, angle);
        var up = RotateAround(x, y, x + listVertex[| 3][0], y + listVertex[| 3][1], x, y, angle);
        var down = RotateAround(x, y, x + listVertex[| 2][0], y + listVertex[| 2][1], x, y, angle);
        draw_sprite_ext(spr_battle_board_edge, 0, left[0], left[1], 1, 1, angle, battle_board.color_frame, battle_board.alpha_frame);
        draw_sprite_ext(spr_battle_board_edge, 0, right[0], right[1], -1, 1, angle, battle_board.color_frame, battle_board.alpha_frame);
        draw_sprite_ext(spr_battle_board_edge, 0, up[0], up[1], 1, -1, angle, battle_board.color_frame, battle_board.alpha_frame);
        draw_sprite_ext(spr_battle_board_edge, 0, down[0], down[1], -1, -1, angle, battle_board.color_frame, battle_board.alpha_frame);

        for (var i = 0; i < ds_list_size(listVertex); i++) {
            var a = listVertex[| i];
            var b = listVertex[| iloop(i + 1)];

            var ax = a[0] * vcos - a[1] * vsin;
            var ay = a[0] * vsin + a[1] * vcos;
            var bx = b[0] * vcos - b[1] * vsin;
            var by = b[0] * vsin + b[1] * vcos;

            draw_sprite_ext(spr_pixel, 0, x + ax - (5 - 4 * battle_board.edge) * cos(degtorad(floor(point_direction(ax, ay, bx, by)))), y + ay + (5 - 4 * battle_board.edge) * sin(degtorad(floor(point_direction(ax, ay, bx, by)))), 5, point_distance(ax, ay, bx, by) + 5 + 5 * cos(degtorad((point_direction(ax, ay, bx, by) % 45))) - 2 * 4 * battle_board.edge, point_direction(ax, ay, bx, by) + 90, battle_board.color_frame, battle_board.alpha_frame);
        }
    } else {
        var size = ds_list_size(listDivideIndex);
        for (var i = 0; i < size; i++) { //遍历所有的三角
            var di = listDivideIndex[| i];
            draw_primitive_begin(pr_trianglestrip);
            for (var j = 0; j < 3; j++) {
                var pos = listVertex_Outline[| di[j]];
                var resultx = pos[0] * vcos - pos[1] * vsin;
                var resulty = pos[0] * vsin + pos[1] * vcos;
                draw_vertex_color(x + resultx, y + resulty, battle_board.color_frame, battle_board.alpha_frame);
            }
            draw_primitive_end();
        }
    }
    surface_reset_target();
    gpu_set_colorwriteenable(false, false, false, true);
    gpu_set_blendenable(false);
    surface_set_target(!cover ? battle_board._surface_board_cover: battle_board._surface_board_extra);
    draw_set_alpha(0);
    var vsin = dsin( - angle),
    vcos = dcos( - angle);
    var size = ds_list_size(listDivideIndex);
    for (var i = 0; i < size; i++) { //遍历所有的三角
        var di = listDivideIndex[| i];
        draw_primitive_begin(pr_trianglelist);
        for (var j = 0; j < 3; j++) {
            var pos = listVertex[| di[j]];
            var resultx = pos[0] * vcos - pos[1] * vsin;
            var resulty = pos[0] * vsin + pos[1] * vcos;
            draw_vertex(x + resultx, y + resulty);
        }
        draw_primitive_end();
    }
    surface_reset_target();
    gpu_set_blendenable(true);
    gpu_set_colorwriteenable(true, true, true, true);
}
// 辅助函数,用于当_index超出边界时循环
// 因为都是稍微超出,所以只考虑了稍微超出时的情况
function iloop(_index, _list = listVertex) {
    if (_index < 0) {
        return iloop(_index + ds_list_size(_list));
    }
    return _index % ds_list_size(_list);
}