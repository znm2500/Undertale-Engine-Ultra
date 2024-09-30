if (_state == -1) {
    if (!instance_exists(ui_dialog)) {
        Anim_Create(id, "_show_width", ANIM_TWEEN.CUBIC, ANIM_EASE.IN, _show_width, 212 - _show_width, 20 * !global.classic_ui);
        _state = 0;
        event_user(0);
    }
} else if (_state == 0) {
    if (Input_IsPressed(INPUT.LEFT)) {
        if (_choice == 1) {
            _choice = 0;
            Anim_Create(id, "_choice_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_soul, _choice - _choice_soul, 15 * !global.classic_ui);
            audio_play_sound(snd_menu_switch, 0, false);
        }
    } else if (Input_IsPressed(INPUT.RIGHT)) {
        if (_choice == 0) {
            _choice = 1;
            Anim_Create(id, "_choice_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_soul, _choice - _choice_soul, 15 * !global.classic_ui);
            audio_play_sound(snd_menu_switch, 0, false);
        }
    } else if (Input_IsPressed(INPUT.CONFIRM)) {
        if (_choice == 0) {
            _state = 1;
            event_user(0);
        } else {
            alarm[0] = 20;
            Anim_Create(id, "_show_width", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _show_width, 0 - _show_width, 20 * !global.classic_ui);
        }
    } else if (Input_IsPressed(INPUT.CANCEL)) {
        alarm[0] = 20;
        Anim_Create(id, "_show_width", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _show_width, 0 - _show_width, 20 * !global.classic_ui);
    }
} else if (_state == 1) {
    if (Input_IsPressed(INPUT.CONFIRM) || Input_IsPressed(INPUT.CANCEL)) {
        alarm[0] = 20;
        Anim_Create(id, "_show_width", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _show_width, 0 - _show_width, 20 * !global.classic_ui);
    }
}
if (instance_exists(_inst_name)) {
    _inst_name._surface_target = _surface_text;
}
if (instance_exists(_inst_lv)) {
    _inst_lv._surface_target = _surface_text;
}
if (instance_exists(_inst_time)) {
    _inst_time._surface_target = _surface_text;
}
if (instance_exists(_inst_room)) {
    _inst_room._surface_target = _surface_text;
}
if (instance_exists(_inst_save)) {
    _inst_save._surface_target = _surface_text;
}
if (instance_exists(_inst_return)) {
    _inst_return._surface_target = _surface_text;
}