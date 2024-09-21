if (Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP) <= 0) {
    Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_X, x - camera.x);
    Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_Y, y - camera.y);
    room_goto(room_gameover);
}
var STATE = Battle_GetState();
if (STATE == BATTLE_STATE.TURN_PREPARATION || STATE == BATTLE_STATE.IN_TURN) {
    var isInside = array_create(3, array_create(4, false));
    var limit_index = array_create(4, 0);
    var soul_position = [x, y];
    var boardcount = array_length(global.boards_array);
	var isContains = array_create(4, false);
    for (var i = 0; i < boardcount; i++) { //遍历所有框,判断是否出框
        global.boards_array[i].isCollide = array_create(4, false);
        isContains[0] = global.boards_array[i].contains(x - sprite_width / 2, y);
        isContains[1] = global.boards_array[i].contains(x + sprite_width / 2, y);
        isContains[2] = global.boards_array[i].contains(x, y - sprite_height / 2);
        isContains[3] = global.boards_array[i].contains(x, y + sprite_height / 2);
        if (isContains[0]) {
            global.boards_array[i].isCollide[0] = true;
            isInside[global.boards_array[i].cover][0] = true;
            isInside[2 - global.boards_array[i].cover][0] = isInside[1][0] || isInside[2 - global.boards_array[i].cover][0];
            if (global.boards_array[i].cover) isInside[2][0] = false;
        }
        if (isContains[1]) {
            global.boards_array[i].isCollide[1] = true;
            isInside[global.boards_array[i].cover][1] = true;
            isInside[2 - global.boards_array[i].cover][1] = isInside[1][1] || isInside[2 - global.boards_array[i].cover][1];
            if (global.boards_array[i].cover) isInside[2][1] = false;
        }
        if (isContains[2]) {
            global.boards_array[i].isCollide[2] = true;
            isInside[global.boards_array[i].cover][2] = true;
            isInside[2 - global.boards_array[i].cover][2] = isInside[1][2] || isInside[2 - global.boards_array[i].cover][2];
            if (global.boards_array[i].cover) isInside[2][2] = false;
        }
        if (isContains[3]) {
            global.boards_array[i].isCollide[3] = true;
            isInside[global.boards_array[i].cover][3] = true;
            isInside[2 - global.boards_array[i].cover][3] = isInside[1][3] || isInside[2 - global.boards_array[i].cover][3];
            if (global.boards_array[i].cover) isInside[2][3] = false;
        }
        if (!global.boards_array[i].cover) for (var j = 0; j < 4; j++) {
            if (!isContains[j] && isInside[1][j] && !array_equals(global.boards_array[i].isCollide, [false, false, false, false])) {
                limit_index[j] = i;
            }
        }
    }
    if (! (isInside[2][0] || isInside[2][1] || isInside[2][2] || isInside[2][3])) {
        var distance = [ - 1, -1];
        if (isInside[1][0]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = 0; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if (global.boards_array[i].cover) {
                    var pos = global.boards_array[i].limit(x - sprite_width / 2, y);
                    var dis = point_distance(x - sprite_width / 2, y, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }
            soul_position[0] = nearestPos[0] + sprite_width / 2;
            distance[0] = nearestDis;
        }

        if (isInside[1][1]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = 0; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if (global.boards_array[i].cover) {
                    var pos = global.boards_array[i].limit(x + sprite_width / 2, y);
                    var dis = point_distance(x + sprite_width / 2, y, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }
            if (distance[0] < nearestDis) soul_position[0] = nearestPos[0] - sprite_width / 2;

        }

        if (isInside[1][2]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = 0; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if (global.boards_array[i].cover) {
                    var pos = global.boards_array[i].limit(x, y - sprite_height / 2);
                    var dis = point_distance(x, y - sprite_height / 2, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }

            soul_position[1] = nearestPos[1] + sprite_height / 2;
            distance[1] = nearestDis;
        }

        if (isInside[1][3]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = 0; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if (global.boards_array[i].cover) {
                    var pos = global.boards_array[i].limit(x, y + sprite_height / 2);
                    var dis = point_distance(x, y + sprite_height / 2, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }
            if (distance[1] < nearestDis) soul_position[1] = nearestPos[1] - sprite_height / 2;
        }
        x = soul_position[0];
        y = soul_position[1];
    }
    if ((isInside[2][0] || isInside[2][1] || isInside[2][2] || isInside[2][3]) && (isInside[1][0] && isInside[1][1] && isInside[1][2] && isInside[1][3])) {
        var distance = [ - 1, -1];
        if (!isInside[2][0]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = limit_index[0]; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if ((!global.boards_array[i].cover) || (global.boards_array[i].cover && !(array_equals(global.boards_array[i].isCollide, [false, false, false, false]) || array_equals(global.boards_array[i].isCollide, [true, true, true, true])))) {
                    var pos = global.boards_array[i].limit(x - sprite_width / 2, y);
                    var dis = point_distance(x - sprite_width / 2, y, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }

            soul_position[0] = nearestPos[0] + sprite_width / 2;
            distance[0] = nearestDis;
        }

        if (!isInside[2][1]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = limit_index[1]; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if ((!global.boards_array[i].cover) || (global.boards_array[i].cover && !(array_equals(global.boards_array[i].isCollide, [false, false, false, false]) || array_equals(global.boards_array[i].isCollide, [true, true, true, true])))) {
                    var pos = global.boards_array[i].limit(x + sprite_width / 2, y);
                    var dis = point_distance(x + sprite_width / 2, y, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }
            if (distance[0] < nearestDis) soul_position[0] = nearestPos[0] - sprite_width / 2;

        }

        if (!isInside[2][2]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = limit_index[2]; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if ((!global.boards_array[i].cover) || (global.boards_array[i].cover && !(array_equals(global.boards_array[i].isCollide, [false, false, false, false]) || array_equals(global.boards_array[i].isCollide, [true, true, true, true])))) {
                    var pos = global.boards_array[i].limit(x, y - sprite_height / 2);
                    var dis = point_distance(x, y - sprite_height / 2, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }
            soul_position[1] = nearestPos[1] + sprite_height / 2;
            distance[1] = nearestDis;
        }

        if (!isInside[2][3]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = limit_index[3]; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if ((!global.boards_array[i].cover) || (global.boards_array[i].cover && !(array_equals(global.boards_array[i].isCollide, [false, false, false, false]) || array_equals(global.boards_array[i].isCollide, [true, true, true, true])))) {
                    var pos = global.boards_array[i].limit(x, y + sprite_height / 2);
                    var dis = point_distance(x, y + sprite_height / 2, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }
            if (distance[1] < nearestDis) soul_position[1] = nearestPos[1] - sprite_height / 2;
        }
        x = soul_position[0];
        y = soul_position[1];
    }
    var distance = [ - 1, -1];
    if (!isInside[0][0]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = 0; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (!global.boards_array[i].cover) {
                var pos = global.boards_array[i].limit(x - sprite_width / 2, y);
                var dis = point_distance(x - sprite_width / 2, y, pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
        }
        soul_position[0] = nearestPos[0] + sprite_width / 2;
        distance[0] = nearestDis;
    }

    if (!isInside[0][1]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = 0; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (!global.boards_array[i].cover) {
                var pos = global.boards_array[i].limit(x + sprite_width / 2, y);
                var dis = point_distance(x + sprite_width / 2, y, pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
        }
        if (distance[0] < nearestDis) soul_position[0] = nearestPos[0] - sprite_width / 2;

    }

    if (!isInside[0][2]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = 0; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (!global.boards_array[i].cover) {
                var pos = global.boards_array[i].limit(x, y - sprite_height / 2);
                var dis = point_distance(x, y - sprite_height / 2, pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
        }

        soul_position[1] = nearestPos[1] + sprite_height / 2;
        distance[1] = nearestDis;
    }

    if (!isInside[0][3]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = 0; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (!global.boards_array[i].cover) {
                var pos = global.boards_array[i].limit(x, y + sprite_height / 2);
                var dis = point_distance(x, y + sprite_height / 2, pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
        }
        if (distance[1] < nearestDis) soul_position[1] = nearestPos[1] - sprite_height / 2;
    }
    x = soul_position[0];
    y = soul_position[1];
}

if (Battle_GetState() == BATTLE_STATE.IN_TURN && moveable) {
    if (xprevious = x && yprevious = y) {
        global.moving = 0;
    } else {
        global.moving = 1;
    }
} else {
    global.moving = 0;
}