event_inherited();
if (Battle_GetState() == BATTLE_STATE.IN_TURN && moveable) {
    var px = [];
    var py = [];
    var ps = array_length(point);
    for (var i = 0; i < ps; i++) {
        if (point[i].horizontal) {
            array_push(py, point[i]);
        }
        if (point[i].vertical) {
            array_push(px, point[i]);
        }
    }
    array_sort(px,
    function(a, b) {
        return a.x > b.x;
    });
    array_sort(py,
    function(a, b) {
        return a.y > b.y;
    });

    if (cross_step) {
        if (is_struct(cross_start) && is_struct(cross_target) && !cross_start.destroyed && !cross_start.destroyed) {
            if (moving_direction) {
                y = lerp(cross_target.y, cross_start.y, --cross_step / 10);
            } else {
                x = lerp(cross_target.x, cross_start.x, --cross_step / 10);
            }
        } else {
            cross_start = noone;
            cross_target = noone;
            cross_step = 0;
        }
    } else {
        x_on = noone;
        y_on = noone;
        for (var i = 0; i < array_length(px); i++) {
            if (x >= px[i].x - 5 && x <= px[i].x + 5) {
                moving_direction = 1;
                x_on = px[i];
                x_index = i;
            }
        }

        for (var i = 0; i < array_length(py); i++) {
            if (y >= py[i].y - 5 && y <= py[i].y + 5) {
                moving_direction = 0;
                y_on = py[i];
                y_index = i;
            }
        }

        var SPD = Player_GetSpdTotal();
        SPD = (Input_IsHeld(INPUT.CANCEL) ? SPD / 2 : SPD);

        // 根据输入移动角色
        if (moveable) {
            if (is_struct(x_on)) {
                repeat(SPD * 10) {
                    if (Input_IsHeld(INPUT.UP)) {
                        if (!position_meeting(x, y - sprite_height / 2, block)) {
                            y -= 0.1;
                            x = x_on.x;
                            moving_direction = 1;
                        }
                    }

                    if (Input_IsHeld(INPUT.DOWN)) {
                        if (!position_meeting(x, y + sprite_height / 2, block)) {
                            y += 0.1;
                            x = x_on.x;
                            moving_direction = 1;
                        }
                    }
                }
            } else {
                if (Input_IsPressed(INPUT.UP)) {
                    if (y_index > 0) {
                        if (_crossable(x, py[y_index - 1].y - sprite_height / 2)) {
                            moving_direction = 1;
                            cross_step = 10;
                            cross_start = y_on;
                            cross_target = py[y_index - 1];

                        }
                    }
                } else if (Input_IsPressed(INPUT.DOWN)) {
                    if ((y_index + 1) < array_length(py)) if (_crossable(x, py[y_index + 1].y + sprite_height / 2)) {
                        moving_direction = 1;
                        cross_step = 10;
                        cross_start = y_on;
                        cross_target = py[y_index + 1];
                    }
                }
            }
            if (is_struct(y_on)) {
                repeat(SPD * 10) {
                    if (Input_IsHeld(INPUT.LEFT)) {
                        if (!position_meeting(x - sprite_width / 2, y, block)) {
                            x -= 0.1;
                            y = y_on.y;
                            if (!cross_step) moving_direction = 0;
                        }
                    }

                    if (Input_IsHeld(INPUT.RIGHT)) {
                        if (!position_meeting(x + sprite_width / 2, y, block)) {
                            x += 0.1;
                            y = y_on.y;
                            if (!cross_step) moving_direction = 0;
                        }
                    }
                }
            } else {
                if (Input_IsPressed(INPUT.LEFT)) {
                    if (x_index > 0) if (_crossable(px[x_index - 1].x - sprite_width / 2, y)) {
                        moving_direction = 0;
                        cross_step = 10;
                        cross_start = x_on;
                        cross_target = px[x_index - 1];
                    }
                } else if (Input_IsPressed(INPUT.RIGHT)) {
                    if ((x_index + 1) < array_length(px)) if (_crossable(px[x_index + 1].x + sprite_width / 2, y)) {
                        moving_direction = 0;
                        cross_step = 10;
                        cross_start = x_on;
                        cross_target = px[x_index + 1];
                    }
                }
            }
        }
    }
    for (var i = 0; i < ps; i++) {
        point[i].x += point[i].hspeed;
        point[i].y += point[i].vspeed;
        if (point[i].duration == 0) point[i].destroyed = 1;
        else if (point[i] > 0) point[i].duration--;
        if (point[i].auto_destroy && (point[i].y < 0 || point[i].y > room_height || point[i].x < 0 || point[i].x > room_width)) point[i].destroyed = 1;
        if (point[i].destroyed) {
            delete point[i];
            array_delete(point, i--, 1);
            continue;
        }
    }
}