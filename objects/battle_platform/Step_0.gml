if (bounce) {
    var isInside = [array_create(4, 0), array_create(4, 0), array_create(4, 0)];
    var limit_index = array_create(4, 0);
    var boardcount = array_length(global.boards_array);
    var pos = [RotateAround(0, 0, sprite_width / 2, sprite_height / 2, 0, 0, angle), RotateAround(0, 0, sprite_width / 2, -sprite_height / 2, 0, 0, angle)]
    for (var i = 0; i < boardcount; i++) { //遍历所有框,判断是否出框
        if (global.boards_array[i].contains(x - pos[0][0], y - pos[0][1])) {
            isInside[global.boards_array[i].cover][0] = true;
            isInside[2 - global.boards_array[i].cover][0] = isInside[1][0] || isInside[2 - global.boards_array[i].cover][0];
            if (global.boards_array[i].cover) isInside[2][0] = false;
        } else if (isInside[1][0] && !global.boards_array[i].cover) {

            isInside[2][0] = false;
            limit_index[0] = i;
        }

        if (global.boards_array[i].contains(x + pos[0][0], y + pos[0][1])) {
            isInside[global.boards_array[i].cover][1] = true;
            isInside[2 - global.boards_array[i].cover][1] = isInside[1][1] || isInside[2 - global.boards_array[i].cover][1];
            if (global.boards_array[i].cover) isInside[2][1] = false;
        } else if (isInside[1][1] && !global.boards_array[i].cover) {

            isInside[2][1] = false;
            limit_index[1] = i;
        }
        if (global.boards_array[i].contains(x - pos[1][0], y - pos[1][1])) {
            isInside[global.boards_array[i].cover][2] = true;
            isInside[2 - global.boards_array[i].cover][2] = isInside[1][2] || isInside[2 - global.boards_array[i].cover][2];
            if (global.boards_array[i].cover) isInside[2][2] = false;
        } else if (isInside[1][2] && !global.boards_array[i].cover) {

            isInside[2][2] = false;
            limit_index[2] = i;
        }
        if (global.boards_array[i].contains(x + pos[1][0], y + pos[1][1])) {
            isInside[global.boards_array[i].cover][3] = true;
            isInside[2 - global.boards_array[i].cover][3] = isInside[1][3] || isInside[2 - global.boards_array[i].cover][3];
            if (global.boards_array[i].cover) isInside[2][3] = false;

        } else if (isInside[1][3] && !global.boards_array[i].cover) {

            isInside[2][3] = false;
            limit_index[3] = i;
        }
    }
    if (! (isInside[2][0] || isInside[2][1] || isInside[2][2] || isInside[2][3])) {
        if ((isInside[1][0]) || (isInside[1][1]) || (isInside[1][2]) || (isInside[1][3])) {
            vspeed = -vspeed;
            hspeed = -hspeed;
        }
    }
    if ((isInside[2][0] || isInside[2][1] || isInside[2][2] || isInside[2][3]) && (isInside[1][0] && isInside[1][1] && isInside[1][2] && isInside[1][3])) {
        if ((!isInside[2][0]) || (!isInside[2][1]) || (!isInside[2][2]) || (!isInside[2][3])) {
            vspeed = -vspeed;
            hspeed = -hspeed;
        }
    }

    if ((!isInside[0][0]) || (!isInside[0][1]) || (!isInside[0][2]) || (!isInside[0][3])) {
        vspeed = -vspeed;
        hspeed = -hspeed;
    }
}