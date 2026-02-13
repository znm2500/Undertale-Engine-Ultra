if (bounce) {
    var isInside = array_create(2, array_create(4, false));
    var limit_index = array_create(4, 0);
    var platform_position = [x, y];
    var offset_pos = [RotateAround(0, 0, width / 2, sprite_height / 2, 0, 0, angle), RotateAround(0, 0, width / 2, -sprite_height / 2, 0, 0, angle)];
    var distance = -1;
    var bounced = false;
    var boardcount = array_length(global.boards_array);
    for (var i = 0; i < boardcount; i++) { //遍历所有框,判断是否出框
        global.boards_array[i].isCollide[0] = global.boards_array[i].contains(x - offset_pos[0][0], y - offset_pos[0][1]);
        global.boards_array[i].isCollide[1] = global.boards_array[i].contains(x + offset_pos[0][0], y + offset_pos[0][1]);
        global.boards_array[i].isCollide[2] = global.boards_array[i].contains(x - offset_pos[1][0], y - offset_pos[1][1]);
        global.boards_array[i].isCollide[3] = global.boards_array[i].contains(x + offset_pos[1][0], y + offset_pos[1][1]);
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

    if (isInside[1][0]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = limit_index[0]; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (global.boards_array[i].cover && !global.boards_array[i].isCollide[0]) continue;
            var pos = global.boards_array[i].limit(x - offset_pos[0][0], y - offset_pos[0][1]);
            var dis = point_distance(x - offset_pos[0][0], y - offset_pos[0][1], pos[0], pos[1]);
            if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                nearestPos = pos;
                nearestDis = dis;
            }

        }
        platform_position[0] = nearestPos[0] + offset_pos[0][0];
        platform_position[1] = nearestPos[1] + offset_pos[0][1];
        distance = nearestDis;
        bounced = true;
    }

    if (isInside[1][1]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = limit_index[1]; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (global.boards_array[i].cover && !global.boards_array[i].isCollide[1]) continue;
            var pos = global.boards_array[i].limit(x + offset_pos[0][0], y + offset_pos[0][1]);
            var dis = point_distance(x + offset_pos[0][0], y + offset_pos[0][1], pos[0], pos[1]);

            if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                nearestPos = pos;
                nearestDis = dis;
            }
        }
        if (distance < nearestDis) {
            distance = nearestDis;
            platform_position[0] = nearestPos[0] - offset_pos[0][0];
            platform_position[1] = nearestPos[1] - offset_pos[0][1];
        }
        bounced = true;
    }

    if (isInside[1][2]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = limit_index[2]; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (global.boards_array[i].cover && !global.boards_array[i].isCollide[2]) continue;
            var pos = global.boards_array[i].limit(x - offset_pos[1][0], y - offset_pos[1][1]);
            var dis = point_distance(x - offset_pos[1][0], y - offset_pos[1][1], pos[0], pos[1]);

            if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                nearestPos = pos;
                nearestDis = dis;
            }
        }
        if (distance < nearestDis) {
            distance = nearestDis;
            platform_position[0] = nearestPos[0] + offset_pos[1][0];
            platform_position[1] = nearestPos[1] + offset_pos[1][1];
            distance = nearestDis;
        }
        bounced = true;
    }

    if (isInside[1][3]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = limit_index[3]; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (global.boards_array[i].cover && !global.boards_array[i].isCollide[3]) continue;
            var pos = global.boards_array[i].limit(x + offset_pos[1][0], y + offset_pos[1][1]);
            var dis = point_distance(x + offset_pos[1][0], y + offset_pos[1][1], pos[0], pos[1]);

            if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                nearestPos = pos;
                nearestDis = dis;
            }
        }
        if (distance < nearestDis) {
            distance = nearestDis;
            platform_position[0] = nearestPos[0] - offset_pos[1][0];
            platform_position[1] = nearestPos[1] - offset_pos[1][1];
        }
        bounced = true;
    }
    x = platform_position[0];
    y = platform_position[1];
    distance = -1;
    if (!isInside[0][0]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = 0; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (!global.boards_array[i].cover) {
                var pos = global.boards_array[i].limit(x - offset_pos[0][0], y - offset_pos[0][1]);
                var dis = point_distance(x - offset_pos[0][0], y - offset_pos[0][1], pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
        }
        platform_position[0] = nearestPos[0] + offset_pos[0][0];
        platform_position[1] = nearestPos[1] + offset_pos[0][1];
        distance = nearestDis;
        bounced = true;
    }

    if (!isInside[0][1]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = 0; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (!global.boards_array[i].cover) {
                var pos = global.boards_array[i].limit(x + offset_pos[0][0], y + offset_pos[0][1]);
                var dis = point_distance(x + offset_pos[0][0], y + offset_pos[0][1], pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
        }
        if (distance < nearestDis) {
            distance = nearestDis;
            platform_position[0] = nearestPos[0] - offset_pos[0][0];
            platform_position[1] = nearestPos[1] - offset_pos[0][1];
        }
        bounced = true;

    }

    if (!isInside[0][2]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = 0; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (!global.boards_array[i].cover) {
                var pos = global.boards_array[i].limit(x - offset_pos[1][0], y - offset_pos[1][1]);
                var dis = point_distance(x - offset_pos[1][0], y - offset_pos[1][1], pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
        }
        if (distance < nearestDis) {
            distance = nearestDis;
            platform_position[0] = nearestPos[0] + offset_pos[1][0];
            platform_position[1] = nearestPos[1] + offset_pos[1][1];
            distance = nearestDis;
        }
        bounced = true;
    }

    if (!isInside[0][3]) {
        var nearestPos, nearestDis = -1; // 最近位置和最近距离
        for (var i = 0; i < boardcount; i++) { // 遍历所有框
            // 得到限制位置和距离
            if (!global.boards_array[i].cover) {
                var pos = global.boards_array[i].limit(x + offset_pos[1][0], y + offset_pos[1][1]);
                var dis = point_distance(x + offset_pos[1][0], y + offset_pos[1][1], pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) { // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
        }
        if (distance < nearestDis) {
            distance = nearestDis;
            platform_position[0] = nearestPos[0] - offset_pos[1][0];
            platform_position[1] = nearestPos[1] - offset_pos[1][1];
        }
        bounced = true;
    }
    x = platform_position[0];
    y = platform_position[1];
    if (bounced) {
        vspeed = -vspeed;
        hspeed = -hspeed;
    }
}