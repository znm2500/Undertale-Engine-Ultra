function Player_Heal(heal, anim = !global.classic_ui) {
	if (instance_exists(battle)) {
		if (!anim) {
			Player_SetKR(0);
			Player_SetHp((Player_GetHp() + heal > Player_GetHpMax()) ? Player_GetHpMax() : Player_GetHp() + heal);
		} else {
			heal = (Player_GetHp() + heal > Player_GetHpMax()) ? Player_GetHpMax() - Player_GetHp() : heal;
			battle._kr = Player_GetKR();
			battle._heal = heal;
			battle._hp = Player_GetHp();

			Anim_Create(battle, "_kr", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, Player_GetKR(), -Player_GetKR(), 30);
			Anim_Create(battle, "_heal", 0, 0, heal, -heal, 30);
			Anim_Create(battle, "_hp", ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT, Player_GetHp(), heal, 30);
		}
	} else Player_SetHp((Player_GetHp() + heal > Player_GetHpMax()) ? Player_GetHpMax() : Player_GetHp() + heal);
	return true;
}