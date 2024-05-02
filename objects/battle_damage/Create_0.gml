depth = DEPTH_BATTLE.UI;
visible = false;
yscale = 1;
alpha = 1;
if (!global.classic_ui) {
    Anim_Create(id, "alpha", ANIM_TWEEN.CUBIC, ANIM_EASE.IN, 1, -1, 25, 30);
    Anim_Create(id, "yscale", ANIM_TWEEN.CUBIC, ANIM_EASE.IN, 1, -1, 25, 30);
}
damage = 0;
color = c_red;
display_time = 60;
bar_visible = true;
bar_width = 100;
bar_hp_max = 0;
bar_hp_original = 0;
bar_hp_target = 0;
bar_duration = 45;
_bar_hp = 0;

alarm[0] = 1;