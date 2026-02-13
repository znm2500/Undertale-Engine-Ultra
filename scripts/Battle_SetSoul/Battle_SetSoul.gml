function Battle_SetSoul(SOUL) {
    if (Battle_IsSoulValid(SOUL) && object_exists(SOUL)) {
        var X = 0;
        var Y = 0;
        var temp = 0;
        if (instance_exists(battle_soul)) {
            X = battle_soul.x;
            Y = battle_soul.y;
            temp = battle_soul.image_angle;
            instance_destroy(battle_soul);
        }
        a = instance_create_depth(X, Y, DEPTH_BATTLE.SOUL, SOUL);
        if (!global.classic_ui) {
            a.image_angle = temp;
            if (SOUL != battle_soul_blue)
                Anim_Create(a, "image_angle", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, a.image_angle, 0 - a.image_angle, 10);
        }
        return true;
    } else {
        return false;
    }


}