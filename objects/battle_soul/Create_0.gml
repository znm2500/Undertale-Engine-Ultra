depth = DEPTH_BATTLE.SOUL;
image_speed = 0;
image_blend = c_white;
init_alpha = 0.7 * !global.classic_ui;
moveable = 1;
if (!global.classic_ui) Anim_Create(id, "init_alpha", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, init_alpha, -init_alpha, 35);
light_size = 0;
index = 1;
follow_board = false;
_inv = 0;
global.moving = 0;
