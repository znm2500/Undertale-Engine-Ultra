event_inherited();  // 保留父事件

// ---- 角色朝向动画（未改动） ----
if (!global.classic_ui) {
    switch (dir) {
        case 0:
            Anim_Create(id, "image_angle", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, image_angle, 90 - image_angle, 10);
            break;
        case 90:
            Anim_Create(id, "image_angle", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, image_angle, 180 - image_angle, 10);
            break;
        case 180:
            Anim_Create(id, "image_angle", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, image_angle, -90 - image_angle, 10);
            break;
        case 270:
            Anim_Create(id, "image_angle", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, image_angle, 0 - image_angle, 10);
            break;
    }
} else {
    switch (dir) {
        case 0:   image_angle = 90;  break;
        case 90:  image_angle = 180; break;
        case 180: image_angle = -90; break;
        case 270: image_angle = 0;   break;
    }
}

// ---- 移动与跳跃逻辑（核心修正） ----
if (Battle_GetState() == BATTLE_STATE.IN_TURN && moveable) {
    var SPD = Player_GetSpdTotal();
    SPD = (Input_IsHeld(INPUT.CANCEL) ? SPD / 2 : SPD);

    // ★ 重力累积：每帧强制执行，与按键无关（修复手感奇怪的关键）
    if (move < 0) {
        move += gravity_jump * global.delta_time_factor;
    }

    // ---- 方向按键处理（跳跃初速度不再乘 delta） ----
    if (Input_IsHeld(INPUT.LEFT)) {
        switch (dir) {
            case 0:
                if (jump_state == 0) {
                    move = -jump_speed;          // 正确！初速度为速度值，不乘 delta
                    jump_state = 1;
                }
                break;
            case 90:
            case 270:
                repeat(5 * SPD) {
                    if (!position_meeting(x - sprite_width / 2, y, block)) {
                        x -= Player_GetSpdTotal() / 10 * global.delta_time_factor;
                    } else {
                        x = xprevious;
                    }
                }
                break;
        }
    }

    if (Input_IsHeld(INPUT.RIGHT)) {
        switch (dir) {
            case 180:
                if (jump_state == 0) {
                    move = -jump_speed;
                    jump_state = 1;
                }
                break;
            case 90:
            case 270:
                repeat(5 * SPD) {
                    if (!position_meeting(x + sprite_width / 2, y, block)) {
                        x += Player_GetSpdTotal() / 10 * global.delta_time_factor;
                    } else {
                        x = xprevious;
                    }
                }
                break;
        }
    }

    if (Input_IsHeld(INPUT.UP)) {
        switch (dir) {
            case 270:
                if (jump_state == 0) {
                    move = -jump_speed;
                    jump_state = 1;
                }
                break;
            case 0:
            case 180:
                repeat(5 * SPD) {
                    if (!position_meeting(x, y - sprite_height / 2, block)) {
                        y -= Player_GetSpdTotal() / 10 * global.delta_time_factor;
                    } else {
                        y = yprevious;
                    }
                }
                break;
        }
    }

    if (Input_IsHeld(INPUT.DOWN)) {
        switch (dir) {
            case 90:
                if (jump_state == 0) {
                    move = -jump_speed;
                    jump_state = 1;
                }
                break;
            case 0:
            case 180:
                repeat(5 * SPD) {
                    if (!position_meeting(x, y + sprite_height / 2, block)) {
                        y += Player_GetSpdTotal() / 10 * global.delta_time_factor;
                    } else {
                        y = yprevious;
                    }
                }
                break;
        }
    }

    // ---- 根据朝向应用位移（move 已包含速度，乘以 delta 得像素位移） ----
    switch (dir) {
        case 0:   x += move * global.delta_time_factor; break;
        case 90:  y -= move * global.delta_time_factor; break;
        case 180: x -= move * global.delta_time_factor; break;
        case 270: y += move * global.delta_time_factor; break;
    }
}