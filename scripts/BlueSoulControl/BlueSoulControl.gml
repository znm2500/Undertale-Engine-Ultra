function BlueSoulControl(dir, impact_speed = 10) {
    Battle_SetSoul(battle_soul_blue);
    battle_soul.impact = 1;
    battle_soul.dir = dir;
    battle_soul.move = impact_speed;
    battle_soul.jump_state = 2;
    battle_soul.on_block = 0;
    battle_soul.on_board = 0;
    battle_soul.on_platform = 0;
}