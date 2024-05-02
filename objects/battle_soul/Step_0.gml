var STATE = Battle_GetState();

if (STATE == BATTLE_STATE.TURN_PREPARATION || STATE == BATTLE_STATE.IN_TURN) {
    image_angle = battle.soul_angle
    if (follow_board) {
        x += battle_board.x - battle_board.xprevious;
        y += battle_board.y - battle_board.yprevious;
    }

    while (position_meeting(x + sprite_width / 2, y, block)) {
        x -= 0.01;
    }
    while (position_meeting(x - sprite_width / 2, y, block)) {
        x += 0.01;
    }
    while (position_meeting(x, y + sprite_height / 2, block)) {
        y -= 0.01;
    }
    while (position_meeting(x, y - sprite_height / 2, block)) {
        y += 0.01;
    }
}
if (STATE = BATTLE_STATE.IN_TURN && !global.classic_ui) {
    if (Input_IsHeld(INPUT.CANCEL)) {
        Anim_Create(id, "s", 0, 0, s, 0.08 - s, 5);
        index = 1;
        Anim_Create(id, "ss", 0, 0, ss, 1 - ss, 5);
    } else {
        Anim_Create(id, "ss", 0, 0, ss, -ss, 5);
        index = 0;
        Anim_Create(id, "s", 0, 0, s, -s, 5);
    }
}

//无敌时间闪烁
if (_inv > 0) {
    _inv -= 1;
    if (image_speed == 0) {
        image_speed = 1 / 2;
        image_index = 1;
    }
} else {
    if (image_speed != 0) {
        image_speed = 0;
        image_index = 0;
    }
}