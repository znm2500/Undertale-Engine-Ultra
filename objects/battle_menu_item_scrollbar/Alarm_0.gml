if (!global.classic_ui) {
    Anim_Create(id, "_arrow", ANIM_TWEEN.SINE, ANIM_EASE.OUT, 0, 5, 25);
    Anim_Create(id, "_arrow", ANIM_TWEEN.SINE, ANIM_EASE.OUT, 5, -5, 25, 30);
} else Anim_Create(id, "_arrow", ANIM_TWEEN.SINE, ANIM_EASE.OUT, 0, 5, 25);
alarm[0] = 60;
moveable = 1