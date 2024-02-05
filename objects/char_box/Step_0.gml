event_inherited();
if (interact) {
	if (!instance_exists(ui_dialog)) {
		if (open) {
			instance_create_depth(0, 0, 0, ui_box);
			interact = 0
		} else {
			char_player.moveable = true
		}

	} else {
		open = !ui_dialog._choose
	}
}