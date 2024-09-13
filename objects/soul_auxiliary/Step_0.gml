if (!battle_soul_aqua.type)
	battle_soul_aqua.moveable = collision_circle(x, y, 30, battle_bullet, 0, 1);
else {
	var SPD = Player_GetSpdTotal();
	var SPD = (Input_IsHeld(INPUT.CANCEL) ? SPD / 2 : SPD);
	var STATE = Battle_GetState();

	if (STATE == BATTLE_STATE.TURN_PREPARATION || STATE == BATTLE_STATE.IN_TURN) {
		if (battle_soul.follow_board) {
			x += battle_board.x - battle_board.xprevious;
			y += battle_board.y - battle_board.yprevious;
		}

		while (position_meeting(x + sprite_width / 2, y, block)) {
			x -= 0.01;
		}
		while (position_meeting(x - sprite_width / 2, y, block)) {
			x += 0.01;
		}
		while (position_meeting(x, y + sprite_height / 2, block)) {
			y -= 0.01;
		}
		while (position_meeting(x, y - sprite_height / 2, block)) {
			y += 0.01;
		}
	}
	if (Battle_GetState() == BATTLE_STATE.IN_TURN && battle_soul.moveable) {
		repeat(SPD * 10) {
			if (Input_IsHeld(INPUT.UP)) {
				if (!position_meeting(x, y - sprite_height / 2, block)) {
					y -= 0.1;
				}
			}
			if (Input_IsHeld(INPUT.DOWN)) {
				if (!position_meeting(x, y + sprite_height / 2, block)) {
					y += 0.1;
				}
			}
			if (Input_IsHeld(INPUT.LEFT)) {
				if (!position_meeting(x - sprite_width / 2, y, block)) {
					x -= 0.1;
				}
			}
			if (Input_IsHeld(INPUT.RIGHT)) {
				if (!position_meeting(x + sprite_width / 2, y, block)) {
					x += 0.1;
				}
			}
		}
		if (!Input_IsHeld(INPUT.UP) && !Input_IsHeld(INPUT.DOWN) && !Input_IsHeld(INPUT.LEFT) && !Input_IsHeld(INPUT.RIGHT)) {
			battle_soul.x = x;
			battle_soul.y = y;
		}
	}
}