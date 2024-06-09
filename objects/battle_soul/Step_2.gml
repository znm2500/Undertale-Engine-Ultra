if (Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP) <= 0) {
    Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_X, x - camera.x);
    Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_Y, y - camera.y);
    room_goto(room_gameover);
}
var STATE = Battle_GetState();
if (STATE == BATTLE_STATE.TURN_PREPARATION || STATE == BATTLE_STATE.IN_TURN) {
    if (instance_exists(battle_soul)) {
        var isInside = [array_create(4, 0), array_create(4, 0), array_create(4, 0)];
        var limit_index = array_create(4, 0);
        var boardcount = array_length(global.boards_array);
        for (var i = 0; i < boardcount; i++) { //遍历所有框,判断是否出框
            if (global.boards_array[i].contains(battle_soul.x - sprite_width / 2, battle_soul.y)) {
                isInside[global.boards_array[i].cover][0] = true;
                isInside[2 - global.boards_array[i].cover][0] = isInside[1][0] || isInside[2 - global.boards_array[i].cover][0];
                if (global.boards_array[i].cover) isInside[2][0] = false;
            } else if (isInside[1][0] && !global.boards_array[i].cover) {

                isInside[2][0] = false;
                limit_index[0] = i;
            }

            if (global.boards_array[i].contains(battle_soul.x + sprite_width / 2, battle_soul.y)) {
                isInside[global.boards_array[i].cover][1] = true;
                isInside[2 - global.boards_array[i].cover][1] = isInside[1][1] || isInside[2 - global.boards_array[i].cover][1];
                if (global.boards_array[i].cover) isInside[2][1] = false;
            } else if (isInside[1][1] && !global.boards_array[i].cover) {

                isInside[2][1] = false;
                limit_index[1] = i;
            }
            if (global.boards_array[i].contains(battle_soul.x, battle_soul.y - sprite_height / 2)) {
                isInside[global.boards_array[i].cover][2] = true;
                isInside[2 - global.boards_array[i].cover][2] = isInside[1][2] || isInside[2 - global.boards_array[i].cover][2];
                if (global.boards_array[i].cover) isInside[2][2] = false;
            } else if (isInside[1][2] && !global.boards_array[i].cover) {

                isInside[2][2] = false;
                limit_index[2] = i;
            }
            if (global.boards_array[i].contains(battle_soul.x, battle_soul.y + sprite_height / 2)) {
                isInside[global.boards_array[i].cover][3] = true;
                isInside[2 - global.boards_array[i].cover][3] = isInside[1][3] || isInside[2 - global.boards_array[i].cover][3];
                if (global.boards_array[i].cover) isInside[2][3] = false;

            } else if (isInside[1][3] && !global.boards_array[i].cover) {

                isInside[2][3] = false;
                limit_index[3] = i;
            }
        }

        if (! (isInside[2][0] || isInside[2][1] || isInside[2][2] || isInside[2][3])) {
            if (isInside[1][0]) {
                var nearestPos, nearestDis = -1; // 最近位置和最近距离
                for (var i = 0; i < boardcount; i++) { // 遍历所有框
                    // 得到限制位置和距离
                    if (global.boards_array[i].cover) {
                        var pos = global.boards_array[i].limit(battle_soul.x - sprite_width / 2, battle_soul.y);
                        var dis = point_distance(battle_soul.x - sprite_width / 2, battle_soul.y, pos[0], pos[1]);

                        if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                            nearestPos = pos;
                            nearestDis = dis;
                        }
                    }
                }
                battle_soul.x = nearestPos[0] + sprite_width / 2;

            }

            if (isInside[1][1]) {
                var nearestPos, nearestDis = -1; // 最近位置和最近距离
                for (var i = 0; i < boardcount; i++) { // 遍历所有框
                    // 得到限制位置和距离
                    if (global.boards_array[i].cover) {
                        var pos = global.boards_array[i].limit(battle_soul.x + sprite_width / 2, battle_soul.y);
                        var dis = point_distance(battle_soul.x + sprite_width / 2, battle_soul.y, pos[0], pos[1]);

                        if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                            nearestPos = pos;
                            nearestDis = dis;
                        }
                    }
                }
                battle_soul.x = nearestPos[0] - sprite_width / 2;

            }

            if (isInside[1][2]) {
                var nearestPos, nearestDis = -1; // 最近位置和最近距离
                for (var i = 0; i < boardcount; i++) { // 遍历所有框
                    // 得到限制位置和距离
                    if (global.boards_array[i].cover) {
                        var pos = global.boards_array[i].limit(battle_soul.x, battle_soul.y - sprite_height / 2);
                        var dis = point_distance(battle_soul.x, battle_soul.y - sprite_height / 2, pos[0], pos[1]);

                        if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                            nearestPos = pos;
                            nearestDis = dis;
                        }
                    }
                }

                battle_soul.y = nearestPos[1] + sprite_height / 2;
            }

            if (isInside[1][3]) {
                var nearestPos, nearestDis = -1; // 最近位置和最近距离
                for (var i = 0; i < boardcount; i++) { // 遍历所有框
                    // 得到限制位置和距离
                    if (global.boards_array[i].cover) {
                        var pos = global.boards_array[i].limit(battle_soul.x, battle_soul.y + sprite_height / 2);
                        var dis = point_distance(battle_soul.x, battle_soul.y + sprite_height / 2, pos[0], pos[1]);

                        if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                            nearestPos = pos;
                            nearestDis = dis;
                        }
                    }
                }

                battle_soul.y = nearestPos[1] - sprite_height / 2;
            }
        }
        if ((isInside[2][0] || isInside[2][1] || isInside[2][2] || isInside[2][3]) && (isInside[1][0] && isInside[1][1] && isInside[1][2] && isInside[1][3])) {
            if (!isInside[2][0]) {
                var nearestPos, nearestDis = -1; // 最近位置和最近距离
                for (var i = limit_index[0]; i < boardcount; i++) { // 遍历所有框
                    // 得到限制位置和距离
                    if (!global.boards_array[i].cover) {
                        var pos = global.boards_array[i].limit(battle_soul.x - sprite_width / 2, battle_soul.y);
                        var dis = point_distance(battle_soul.x - sprite_width / 2, battle_soul.y, pos[0], pos[1]);

                        if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                            nearestPos = pos;
                            nearestDis = dis;
                        }
                    }
                }
                battle_soul.x = nearestPos[0] + sprite_width / 2;

            }

            if (!isInside[2][1]) {
                var nearestPos, nearestDis = -1; // 最近位置和最近距离
                for (var i = limit_index[1]; i < boardcount; i++) { // 遍历所有框
                    // 得到限制位置和距离
                    if (!global.boards_array[i].cover) {
                        var pos = global.boards_array[i].limit(battle_soul.x + sprite_width / 2, battle_soul.y);
                        var dis = point_distance(battle_soul.x + sprite_width / 2, battle_soul.y, pos[0], pos[1]);

                        if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                            nearestPos = pos;
                            nearestDis = dis;
                        }
                    }
                }
                battle_soul.x = nearestPos[0] - sprite_width / 2;

            }

            if (!isInside[2][2]) {
                var nearestPos, nearestDis = -1; // 最近位置和最近距离
                for (var i = limit_index[2]; i < boardcount; i++) { // 遍历所有框
                    // 得到限制位置和距离
                    if (!global.boards_array[i].cover) {
                        var pos = global.boards_array[i].limit(battle_soul.x, battle_soul.y - sprite_height / 2);
                        var dis = point_distance(battle_soul.x, battle_soul.y - sprite_height / 2, pos[0], pos[1]);

                        if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                            nearestPos = pos;
                            nearestDis = dis;
                        }
                    }
                }

                battle_soul.y = nearestPos[1] + sprite_height / 2;
            }

            if (!isInside[2][3]) {
                var nearestPos, nearestDis = -1; // 最近位置和最近距离
                for (var i = limit_index[3]; i < boardcount; i++) { // 遍历所有框
                    // 得到限制位置和距离
                    if (!global.boards_array[i].cover) {
                        var pos = global.boards_array[i].limit(battle_soul.x, battle_soul.y + sprite_height / 2);
                        var dis = point_distance(battle_soul.x, battle_soul.y + sprite_height / 2, pos[0], pos[1]);

                        if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                            nearestPos = pos;
                            nearestDis = dis;
                        }
                    }
                }

                battle_soul.y = nearestPos[1] - sprite_height / 2;
            }
        }

        if (!isInside[0][0]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = 0; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if (!global.boards_array[i].cover) {
                    var pos = global.boards_array[i].limit(battle_soul.x - sprite_width / 2, battle_soul.y);
                    var dis = point_distance(battle_soul.x - sprite_width / 2, battle_soul.y, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }
            battle_soul.x = nearestPos[0] + sprite_width / 2;

        }

        if (!isInside[0][1]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = 0; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if (!global.boards_array[i].cover) {
                    var pos = global.boards_array[i].limit(battle_soul.x + sprite_width / 2, battle_soul.y);
                    var dis = point_distance(battle_soul.x + sprite_width / 2, battle_soul.y, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }
            battle_soul.x = nearestPos[0] - sprite_width / 2;

        }

        if (!isInside[0][2]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = 0; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if (!global.boards_array[i].cover) {
                    var pos = global.boards_array[i].limit(battle_soul.x, battle_soul.y - sprite_height / 2);
                    var dis = point_distance(battle_soul.x, battle_soul.y - sprite_height / 2, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }

            battle_soul.y = nearestPos[1] + sprite_height / 2;
        }

        if (!isInside[0][3]) {
            var nearestPos, nearestDis = -1; // 最近位置和最近距离
            for (var i = 0; i < boardcount; i++) { // 遍历所有框
                // 得到限制位置和距离
                if (!global.boards_array[i].cover) {
                    var pos = global.boards_array[i].limit(battle_soul.x, battle_soul.y + sprite_height / 2);
                    var dis = point_distance(battle_soul.x, battle_soul.y + sprite_height / 2, pos[0], pos[1]);

                    if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                        nearestPos = pos;
                        nearestDis = dis;
                    }
                }
            }

            battle_soul.y = nearestPos[1] - sprite_height / 2;
        }

    }
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