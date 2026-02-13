if (Battle_GetMenu() != BATTLE_MENU.ITEM) {
    instance_destroy();
}
NUMBER = Item_GetNumber();
var P = Battle_GetMenuChoiceItem();
if (!global.classic_ui) Anim_Create(id, "yd", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, yd, y - 10 * floor(NUMBER / 2) + 10 * P - yd, 15);
else yd = y - 10 * floor(NUMBER / 2) + 10 * P;
if (moveable = 1) {
    yy1 = y - 10 * floor(NUMBER / 2) - 10 - _arrow;
    yy2 = y - 10 * floor(NUMBER / 2) + 10 * NUMBER + _arrow;
}