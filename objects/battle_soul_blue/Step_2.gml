if (Player_GetHp() <= 0) {
    var z = Storage_SetTempFlag(FLAG_TEMP_GAMEOVER_SOUL_X, x - camera.x);
    z.Set(FLAG_TEMP_GAMEOVER_SOUL_Y, y - camera.y);
    z.Set(FLAG_TEMP_GAMEOVER_SOUL_COLOR, image_blend);
    room_goto(room_gameover);
}
var STATE = Battle_GetState();
if (STATE == BATTLE_STATE.TURN_PREPARATION || STATE == BATTLE_STATE.IN_TURN) {
    var isInside = array_create(2, array_create(4, false));
    var limit_index = array_create(4, 0);
    var distance = -1;
    var boardcount = array_length(global.boards_array);
    for (var i = 0; i < boardcount; i++) { //遍历所有框,判断是否出框
        global.boards_array[i].isCollide[0] = global.boards_array[i].contains(x - sprite_width / 2, y);
        global.boards_array[i].isCollide[1] = global.boards_array[i].contains(x + sprite_width / 2, y);
        global.boards_array[i].isCollide[2] = global.boards_array[i].contains(x, y - sprite_height / 2);
        global.boards_array[i].isCollide[3] = global.boards_array[i].contains(x, y + sprite_height / 2);
        if (global.boards_array[i].isCollide[0]) {
            if (!global.boards_array[i].cover) isInside[1][0] = false;
            else if (!isInside[1][0]) limit_index[0] = i;
            isInside[global.boards_array[i].cover][0] = true;
        }
        if (global.boards_array[i].isCollide[1]) {
            if (!global.boards_array[i].cover) isInside[1][1] = false;
            else if (!isInside[1][1]) limit_index[1] = i;
            isInside[global.boards_array[i].cover][1] = true;
        }
        if (global.boards_array[i].isCollide[2]) {
            if (!global.boards_array[i].cover) isInside[1][2] = false;
            else if (!isInside[1][2]) limit_index[2] = i;
            isInside[global.boards_array[i].cover][2] = true;
        }
        if (global.boards_array[i].isCollide[3]) {
            if (!global.boards_array[i].cover) isInside[1][3] = false;
            else if (!isInside[1][3]) limit_index[3] = i;
            isInside[global.boards_array[i].cover][3] = true;
        }
    }
    xx = 0;
    yy = 0;
    ii = 0;
    jump_input = 0;
    opposite_dir = 0;

    switch (dir) {
    case 0:
        xx = 1;
        ii = isInside[0][1] && !isInside[1][1];
        jump_input = INPUT.LEFT;
        opposite_dir = isInside[0][0] && !isInside[1][0];
        break;
    case 90:
        yy = -1;
        ii = isInside[0][2] && !isInside[1][2];
        jump_input = INPUT.DOWN;
        opposite_dir = isInside[0][3] && !isInside[1][3];
        break;
    case 180:
        xx = -1;
        ii = isInside[0][0] && !isInside[1][0];
        jump_input = INPUT.RIGHT;
        opposite_dir = isInside[0][1] && !isInside[1][1];
        break;
    case 270:
        yy = 1;
        ii = isInside[0][3] && !isInside[1][3];
        jump_input = INPUT.UP;
        opposite_dir = isInside[0][2] && !isInside[1][2];
        break;
    }

    if ! (instance_position(x + xx * (sprite_width / 2 + 1), y + yy * (sprite_height / 2 + 1), block)) {
        on_block = 0;
    }
    if ! (ii = 0) {
        on_board = 0;
    }
    if ! (place_meeting(x + xx, y + yy, battle_platform)) {
        on_platform = 0;
        inst_plat = noone;
    }
    //底部无支撑时
    if (on_block = 0 && on_board = 0 && on_platform = 0 && jump_state = 0) {
        jump_state = 2;
        move = 0;
    }
    //底部无支撑时自然下落
    if (jump_state != 0 && opposite_dir = 0) {
        jump_state = 2;
        if (impact = 0) move = 0;
    }
    if (jump_state != 0 && instance_position(x - xx * (sprite_width / 2 + 1), y - yy * (sprite_height / 2 + 1), block)) {
        jump_state = 2;
        if (impact = 0) move = 0;
    }
    //碰到顶时强制下落
    if (jump_state = 1) {
        if (Input_IsReleased(jump_input)) {
            jump_state = 2;
            move = -1;
        }
        if (move >= 0) {
            jump_state = 2;
        }
    }
    //松开跳跃键时改变状态
    if (jump_state = 2) {
        if (move <= max_speed) {
            move += gravity_fall;
        } else {
            move = max_speed;
        }
        //自然下落
        if (instance_position(x + xx * (sprite_width / 2 + 1), y + yy * (sprite_height / 2 + 1), block)) {
            on_block = 1;
            jump_state = 0;
            move = 0;
            if (impact = 1) {
                audio_play_sound(snd_dong, 0, 0);
                Camera_Shake(8, 8, 1, 1, 1, 1);
                impact = 0;
            }
        }
        if (ii = 0) {
            on_board = 1;
            jump_state = 0;
            move = 1;
            if (impact = 1) {
                audio_play_sound(snd_dong, 0, 0);
                Camera_Shake(8, 8, 1, 1, 1, 1);
                impact = 0;
            }
        }
        inst_plat = instance_place(x + xx, y + yy, battle_platform);
        if (instance_exists(inst_plat) && move > 0) {
            on_platform = 1;
            jump_state = 0;
            move = 0;
            if (impact = 1) {
                audio_play_sound(snd_dong, 0, 0);
                Camera_Shake(8, 8, 1, 1, 1, 1);
                impact = 0;
            }
        }
        //碰到支撑物时停止下落并改变状态
    }

    if (on_platform) {
        while (place_meeting(x + xx, y + xx, inst_plat)) {
            x -= xx;
            y -= yy;
        }
    }
    if (isInside[1][0]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = limit_index[0]; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (global.boards_array[i].cover && !global.boards_array[i].isCollide[0]) continue;
            var pos = global.boards_array[i].limit(x - sprite_width / 2, y);
            var dis = point_distance(x - sprite_width / 2, y, pos[0], pos[1]);
            if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                nearestPos = pos;
                nearestDis = dis;
            }

        }
        x = nearestPos[0] + sprite_width / 2;
        y = nearestPos[1];
        distance = nearestDis;
    }

    if (isInside[1][1]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = limit_index[1]; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (global.boards_array[i].cover && !global.boards_array[i].isCollide[1]) continue;
            var pos = global.boards_array[i].limit(x + sprite_width / 2, y);
            var dis = point_distance(x + sprite_width / 2, y, pos[0], pos[1]);

            if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                nearestPos = pos;
                nearestDis = dis;
            }
        }
        if (distance <= nearestDis) {
            x = nearestPos[0] - sprite_width / 2;
            y = nearestPos[1];
            distance = nearestDis;
        }
    }

    if (isInside[1][2]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = limit_index[2]; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (global.boards_array[i].cover && !global.boards_array[i].isCollide[2]) continue;
            var pos = global.boards_array[i].limit(x, y - sprite_height / 2);
            var dis = point_distance(x, y - sprite_height / 2, pos[0], pos[1]);
            if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                nearestPos = pos;
                nearestDis = dis;
            }
        }
        if (distance <= nearestDis) {
            x = nearestPos[0];
            y = nearestPos[1] + sprite_height / 2;
            distance = nearestDis;
        }
    }

    if (isInside[1][3]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = limit_index[3]; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (global.boards_array[i].cover && !global.boards_array[i].isCollide[3]) continue;
            var pos = global.boards_array[i].limit(x, y + sprite_height / 2);
            var dis = point_distance(x, y + sprite_height / 2, pos[0], pos[1]);

            if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                nearestPos = pos;
                nearestDis = dis;
            }
        }
        if (distance <= nearestDis) {
            x = nearestPos[0];
            y = nearestPos[1] - sprite_height / 2;
        }
    }

    distance = -1;
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
        x = nearestPos[0] + sprite_width / 2;
        y = nearestPos[1];
        distance = nearestDis;
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
        if (distance <= nearestDis) {
            x = nearestPos[0] - sprite_width / 2;
            y = nearestPos[1];
            distance = nearestDis;
        }

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
        if (distance <= nearestDis) {
            x = nearestPos[0];
            y = nearestPos[1] + sprite_height / 2;
            distance = nearestDis;
        }
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
        if (distance <= nearestDis) {
            x = nearestPos[0];
            y = nearestPos[1] - sprite_height / 2;
        }
    }
}

if (Battle_GetState() == BATTLE_STATE.IN_TURN && moveable) {
    if (jump_state == 0) {
        if (on_platform == 1) {
            if (instance_exists(inst_plat)) {
                if (inst_plat.sticky == 1) {
                    x += inst_plat.x - inst_plat.xprevious;
                    y += inst_plat.y - inst_plat.yprevious;
                }
            }
        }
    } // 随板子移动
    if (jump_state == 0) {
        if (xprevious != x || yprevious != y) {
            global.moving = 1;
        } else {
            global.moving = 0;
        }
    } else if (jump_state == 2) {
        if (xprevious != x && yprevious != y) {
            global.moving = 1;
        } else {
            global.moving = 0;
        }
    } else {
        global.moving = 1;
    }
}