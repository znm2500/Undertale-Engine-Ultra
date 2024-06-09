if (global.classic_ui) if (instance_exists(ui_dialog)) {
    if (_menu != -1) {
        _menu = -1;
        event_user(0);
    }
}

switch (_menu) {
case - 1 : if (!instance_exists(ui_dialog)) {
        _menu--;
        alarm[0] = 15 - 14 * global.classic_ui;

    }
    break;
case 0:
    if (Input_IsPressed(INPUT.UP)) {
        if (_choice > 0) {
            _choice -= 1;
            Anim_Create(id, "_choice_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_soul, _choice - _choice_soul, 15 * !global.classic_ui);
            audio_play_sound(snd_menu_switch, 0, false);
        }
    } else if (Input_IsPressed(INPUT.DOWN)) {
        if (_choice < (Phone_GetNumber() > 0 ? 2 : 1)) {
            _choice += 1;
            Anim_Create(id, "_choice_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_soul, _choice - _choice_soul, 15 * !global.classic_ui);
            audio_play_sound(snd_menu_switch, 0, false);
        }
    } else if (Input_IsPressed(INPUT.CONFIRM)) {
        var index;
        switch (_choice) {
        case 0:
            if (Item_GetNumber() > 0) {
                _menu = 1;
                index = 0;
                Anim_Create(_show_width, string(index), ANIM_TWEEN.CUBIC, ANIM_EASE.IN, _show_width[index], 176 - _show_width[index], 20 * !global.classic_ui);
                event_user(0);
                audio_play_sound(snd_menu_confirm, 0, false);
            }
            break;
        case 1:
            _menu = 3;
            index = 1;
            Anim_Create(_show_width, string(index), ANIM_TWEEN.CUBIC, ANIM_EASE.IN, _show_width[index], 176 - _show_width[index], 20 * !global.classic_ui);
            event_user(0);
            audio_play_sound(snd_menu_confirm, 0, false);
            break;
        case 2:
            _menu = 4;
            index = 2;
            Anim_Create(_show_width, string(index), ANIM_TWEEN.CUBIC, ANIM_EASE.IN, _show_width[index], 176 - _show_width[index], 20 * !global.classic_ui);
            event_user(0);
            audio_play_sound(snd_menu_confirm, 0, false);
            break;
        }

    } else if (Input_IsPressed(INPUT.MENU) || Input_IsPressed(INPUT.CANCEL) && floor(_offset) == 0) {
        alarm[0] = 15 - 14 * global.classic_ui;
        Anim_Create(id, "_offset", ANIM_TWEEN.CUBIC, ANIM_EASE.IN, _offset, -100 - _offset, 15 * !global.classic_ui);

    }
    break;
case 1:
    if (Input_IsPressed(INPUT.UP)) {
        if (_choice_item > 0) {
            _choice_item -= 1;
            Anim_Create(id, "_choice_item_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_soul, _choice_item - _choice_item_soul, 15 * !global.classic_ui);
            audio_play_sound(snd_menu_switch, 0, false);
        }
    } else if (Input_IsPressed(INPUT.DOWN)) {
        if (_choice_item < Item_GetNumber() - 1) {
            _choice_item += 1;
            Anim_Create(id, "_choice_item_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_soul, _choice_item - _choice_item_soul, 15 * !global.classic_ui);
            audio_play_sound(snd_menu_switch, 0, false);
        }
    } else if (Input_IsPressed(INPUT.CONFIRM)) {
        _menu = 2;
        event_user(0);
        audio_play_sound(snd_menu_confirm, 0, false);
    } else if (Input_IsPressed(INPUT.CANCEL)) {
        Anim_Create(_show_width, "0", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _show_width[0], 0 - _show_width[0], 20 * !global.classic_ui);
        _menu = 0;
        event_user(0);
    }
    break;
case 2:
    if (Input_IsPressed(INPUT.LEFT)) {
        if (_choice_item_operate > 0) {
            _choice_item_operate -= 1;
            audio_play_sound(snd_menu_switch, 0, false);
            switch (_choice_item_operate) {
            case 0:
                Anim_Create(id, "_choice_item_operate_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_operate_soul, 11.5 - _choice_item_operate_soul, 15 * !global.classic_ui);
                break;
            case 1:
                Anim_Create(id, "_choice_item_operate_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_operate_soul, 59.5 - _choice_item_operate_soul, 15 * !global.classic_ui);
                break;
            case 2:
                Anim_Create(id, "_choice_item_operate_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_operate_soul, 116.5 - _choice_item_operate_soul, 15 * !global.classic_ui);
                break;
            }
        }
    } else if (Input_IsPressed(INPUT.RIGHT)) {
        if (_choice_item_operate < 2) {
            _choice_item_operate += 1;
            audio_play_sound(snd_menu_switch, 0, false);
            switch (_choice_item_operate) {
            case 0:
                Anim_Create(id, "_choice_item_operate_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_operate_soul, 11.5 - _choice_item_operate_soul, 15 * !global.classic_ui);
                break;
            case 1:
                Anim_Create(id, "_choice_item_operate_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_operate_soul, 59.5 - _choice_item_operate_soul, 15 * !global.classic_ui);
                break;
            case 2:
                Anim_Create(id, "_choice_item_operate_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_operate_soul, 116.5 - _choice_item_operate_soul, 15 * !global.classic_ui);
                break;
            }
        }
    } else if (Input_IsPressed(INPUT.CONFIRM)) {
        // TODO
        _menu = -1;
        event_user(0);
        Anim_Create(_show_width, "0", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _show_width[0], 0 - _show_width[0], 20 * !global.classic_ui);
        Anim_Create(id, "_offset", ANIM_TWEEN.CUBIC, ANIM_EASE.IN, _offset, -100 - _offset, 15 * !global.classic_ui);

        switch (_choice_item_operate) {
        case 0:
            Item_CallEvent(Item_Get(_choice_item), ITEM_EVENT.USE, _choice_item);
            break;
        case 1:
            Item_CallEvent(Item_Get(_choice_item), ITEM_EVENT.INFO, _choice_item);
            break;
        case 2:
            Item_CallEvent(Item_Get(_choice_item), ITEM_EVENT.DROP, _choice_item);
            break;
        }
        audio_play_sound(snd_menu_confirm, 0, false);
    } else if (Input_IsPressed(INPUT.CANCEL)) {
        _menu = 1;
        event_user(0);
    }
    break;
case 3:
    if (Input_IsPressed(INPUT.CANCEL)) {
        Anim_Create(id._show_width, "1", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _show_width[1], 0 - _show_width[1], 20 * !global.classic_ui);
        _menu = 0;
        event_user(0);
    }
    break;
case 4:
    if (Input_IsPressed(INPUT.UP)) {
        if (_choice_phone > 0) {
            _choice_phone -= 1;
            Anim_Create(id, "_choice_phone_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_phone_soul, _choice_phone - _choice_phone_soul, 15) audio_play_sound(snd_menu_switch, 0, false);
        }
    } else if (Input_IsPressed(INPUT.DOWN)) {
        if (_choice_phone < Phone_GetNumber() - 1) {
            _choice_phone += 1;
            Anim_Create(id, "_choice_phone_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_phone_soul, _choice_phone - _choice_phone_soul, 15) audio_play_sound(snd_menu_switch, 0, false);
        }
    } else if (Input_IsPressed(INPUT.CONFIRM)) {
        Phone_CallEvent(Phone_Get(_choice_phone), PHONE_EVENT.CALL, _choice_phone);
        _menu = -1;
        Anim_Create(_show_width, "2", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _show_width[2], 0 - _show_width[2], 20 * !global.classic_ui);
        Anim_Create(id, "_offset", ANIM_TWEEN.CUBIC, ANIM_EASE.IN, _offset, -100 - _offset, 15 * !global.classic_ui);

        event_user(0);
        audio_play_sound(snd_menu_confirm, 0, false);
    } else if (Input_IsPressed(INPUT.CANCEL)) {
        Anim_Create(_show_width, "2", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _show_width[2], 0 - _show_width[2], 20 * !global.classic_ui);
        _menu = 0;
        event_user(0);
    }
    break;
}
if (!global.classic_ui) {
    if (instance_exists(_inst_name)) {
        _inst_name._surface_target = _surface;
    }
    if (instance_exists(_inst_menu)) {
        _inst_menu._surface_target = _surface;
    }
    if (instance_exists(_inst_item)) {
        _inst_item._surface_target = _surface;
    }
    if (instance_exists(_inst_item_use)) {
        _inst_item_use._surface_target = _surface;
    }
    if (instance_exists(_inst_item_info)) {
        _inst_item_info._surface_target = _surface;
    }
    if (instance_exists(_inst_item_drop)) {
        _inst_item_drop._surface_target = _surface;
    }
    if (instance_exists(_inst_stat_0)) {
        _inst_stat_0._surface_target = _surface;
    }
    if (instance_exists(_inst_stat_1)) {
        _inst_stat_1._surface_target = _surface;
    }
    if (instance_exists(_inst_phone)) {
        _inst_phone._surface_target = _surface;
    }
} else {
    if (instance_exists(_inst_name)) {
        _inst_name.x = 23 + camera.x;
        _inst_name.y = camera.y + (52 + 6 + (_top ? 270 : 0) + 2) / 2;
    }
    if (instance_exists(_inst_menu)) {
        _inst_menu.x = (32 + 6 + 46) / 2 + camera.x;
        _inst_menu.y = camera.y + (168 + 6 + 14) / 2;
    }
}