var STATE = Battle_GetState();
var MENU = Battle_GetMenu();
if (STATE == BATTLE_STATE.IN_TURN || STATE == BATTLE_STATE.TURN_PREPARATION || (STATE == BATTLE_STATE.MENU && MENU != BATTLE_MENU.FIGHT_AIM && MENU != BATTLE_MENU.FIGHT_ANIM && MENU != BATTLE_MENU.FIGHT_DAMAGE)) {
    draw_self();
}
if (STATE == BATTLE_STATE.IN_TURN) {
    draw_sprite_ext(sprite_index, 0, x, y, 1.6, 1.6, image_angle, image_blend, init_alpha);
	draw_sprite_ext(spr_soul_light, image_index, x, y, light_size * 0.08, light_size * 0.08, image_angle, image_blend, !global.classic_ui);
	draw_sprite_ext(spr_soul_guangbiao, index, x, y, light_size, light_size, 0, c_white, !global.classic_ui)
}
