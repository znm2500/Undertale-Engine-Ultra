depth = DEPTH_BATTLE.UI_HIGH;
x = battle_board.x + battle_board.right - 16;
y = battle_board.y;
moveable = 0;
_arrow = 0;

NUMBER = Item_GetNumber();
alpha = 0;
yy1 = y - 10 * floor(1 / 2) - 10 - _arrow;
yy2 = y - 10 * floor(1 / 2) + 10 * 1 + _arrow;
yy = [0, 0, 0, 0, 0, 0, 0, 0];
yd = global.classic_ui ? y - 10 * floor(NUMBER / 2) : y;
if (!global.classic_ui) {
    Anim_Create(id, "alpha", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, 0, 1, 20);
    Anim_Create(id, "yy1", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, yy1, y - 10 * floor(NUMBER / 2) - 10 - _arrow - yy1, 20);
    Anim_Create(id, "yy2", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, yy2, y - 10 * floor(NUMBER / 2) + 10 * NUMBER + _arrow - yy2, 20);
    for (var i = 0; i < NUMBER; i++) {
        Anim_Create(yy, i, ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, y, -10 * floor(NUMBER / 2) + 10 * i, 20);
    }
} else {
    alpha = 1;
    yy1 = y - 10 * floor(NUMBER / 2) - 10 - _arrow;
    yy2 = y - 10 * floor(NUMBER / 2) + 10 * NUMBER + _arrow;
    for (var i = 0; i < NUMBER; i++) {
        yy[i] = y - 10 * floor(NUMBER / 2) + 10 * i;
    }
}
alarm[0] = 21;