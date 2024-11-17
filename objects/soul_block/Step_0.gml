var SPD = 1;
var SPD = (Input_IsHeld(INPUT.CANCEL) ? SPD * 2 : SPD);
x = battle_soul.x;
y = battle_soul.y;
if (battle_soul.moveable) {
    if (!type) {
        if (image_angle == -270) {
            image_angle = 90;
        } else if (image_angle == 180) {
            image_angle = -180;
        }
        if (moving = 0) {
            if (Input_IsPressed(INPUT.UP)) {
                Anim_Create(id, "moving", 0, 0, 1, -1, abs((image_angle == -180) ? -90 : 90 - image_angle) / 20);
                Anim_Create(id, "image_angle", ANIM_TWEEN.SINE, ANIM_EASE.IN_OUT, image_angle, (image_angle == -180) ? -90 : 90 - image_angle, abs((image_angle == -180) ? -90 : 90 - image_angle) / 20 * SPD);
            } else if (Input_IsPressed(INPUT.LEFT)) {
                Anim_Create(id, "image_angle", ANIM_TWEEN.SINE, ANIM_EASE.IN_OUT, image_angle, (image_angle == 90) ? 90 : -180 - image_angle, abs((image_angle == 90) ? 90 : -180 - image_angle) / 20 * SPD);
                Anim_Create(id, "moving", 0, 0, 1, -1, abs((image_angle == 90) ? 90 : -180 - image_angle) / 20);
            } else if (Input_IsPressed(INPUT.DOWN)) {
                Anim_Create(id, "image_angle", ANIM_TWEEN.SINE, ANIM_EASE.IN_OUT, image_angle, -90 - image_angle, abs( - 90 - image_angle) / 20 * SPD);
                Anim_Create(id, "moving", 0, 0, 1, -1, abs( - 90 - image_angle) / 20);
            } else if (Input_IsPressed(INPUT.RIGHT)) {
                Anim_Create(id, "image_angle", ANIM_TWEEN.SINE, ANIM_EASE.IN_OUT, image_angle, 0 - image_angle, abs(0 - image_angle) / 20 * SPD);
                Anim_Create(id, "moving", 0, 0, 1, -1, abs(0 - image_angle) / 20);
            }
        }
    } else {
        while (image_angle < 0) image_angle += 360;
        if (Input_IsHeld(INPUT.LEFT)) {
            if (abs(image_angle % 360 - 180) < 4 / SPD) image_angle = 180;
            else image_angle += sign(180 - image_angle % 360) * 4 / SPD;
        } else if (Input_IsHeld(INPUT.UP)) {
            if (abs(image_angle % 360 - 90) < 4 / SPD) image_angle = 90;
            else image_angle += sign(90 - image_angle % 360) * 4 / SPD * (image_angle > 270 ? -1 : 1);
        } else if (Input_IsHeld(INPUT.RIGHT)) {
            if (abs(image_angle % 360) < 4 / SPD) image_angle = 0;
            else image_angle += sign(360 - (image_angle + 180) % 360) * 4 / SPD;
        } else if (Input_IsHeld(INPUT.DOWN)) {
            if (abs(image_angle % 360 - 270) < 4 / SPD) image_angle = 270;
            else image_angle += sign(270 - image_angle % 360) * 4 / SPD * (image_angle < 90 ? -1 : 1);
        }
    }
    var bulletInstance = noone;

    for (var i = 0; i < instance_count; i++) {
        bulletInstance = instance_find(battle_bullet_arrow, i);

        if (bulletInstance && bulletInstance.type == 0) {
            bulletInstance.image_index = 1;
            break;
        }
    }
}
var STATE = Battle_GetState();
if (STATE == BATTLE_STATE.TURN_PREPARATION || STATE == BATTLE_STATE.IN_TURN) {
    visible = 1;
} else {
    visible = 0;
    image_angle = 90;
}