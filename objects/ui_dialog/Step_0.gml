if (!instance_exists(_inst)) {
    if (!Dialog_IsEmpty()) {
        _inst = instance_create_depth(60 ,(_top ? 30 : 340), 0, text_typer);
        _inst.text = "{voice 0}{shadow true}{speed 2}{scale 2}{space_y 1}{color `white`}{depth " + string(depth) + "}{surface "+ string(real(_surface_text)) + "}";
        _inst.text += Dialog_Get();
        if (_choose_enable) _inst.text += "&&         " + _choice[0] + "         " + _choice[1];
		_inst.text += "{pause}{end}";

    } else {
        instance_destroy();
    }
} else {
	_inst._surface_target=_surface_text;
    if (_inst._paused && _choose_enable) {
        if (Input_IsPressed(INPUT.LEFT) && _choose) {
            _choose = 0;
            Anim_Create(id, "_choose_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choose_soul, (_choose - _choose_soul), 15 * !global.classic_ui);
            audio_play_sound(snd_menu_switch, 0, false);

        } else if (Input_IsPressed(INPUT.RIGHT) && !_choose) {
            _choose = 1;
            Anim_Create(id, "_choose_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choose_soul, (_choose - _choose_soul), 15 * !global.classic_ui);
            audio_play_sound(snd_menu_switch, 0, false);
        } else if (Input_IsPressed(INPUT.CONFIRM)) audio_play_sound(snd_menu_confirm, 0, 0)
    }
}