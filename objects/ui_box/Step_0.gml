if (_state == -1) {
    if (!instance_exists(ui_dialog)) {
        _state = 0;
        event_user(0);
    }
} else if (_state == 0) {
    if (Input_IsPressed(INPUT.UP)) {
        if (_choice_item > 0) {
            _choice_item -= 1;
            Anim_Create(id, "_choice_item_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_soul, _choice_item - _choice_item_soul, 15 * !global.classic_ui);

        }
    } else if (Input_IsPressed(INPUT.DOWN)) {
        if ((_choice_mode == 0 && _choice_item < 7) || (_choice_mode == 1 && _choice_item < 9)) {
            _choice_item += 1;
            Anim_Create(id, "_choice_item_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_soul, _choice_item - _choice_item_soul, 15 * !global.classic_ui);
        }
    } else if (Input_IsPressed(INPUT.RIGHT)) {
        _choice_mode = 1;
        Anim_Create(id, "_choice_mode_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_mode_soul, _choice_mode - _choice_mode_soul, 15 * !global.classic_ui);
    } else if (Input_IsPressed(INPUT.LEFT)) {
        _choice_mode = 0;
        Anim_Create(id, "_choice_mode_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_mode_soul, _choice_mode - _choice_mode_soul, 15 * !global.classic_ui);
        if (_choice_item > 7) {
            _choice_item = 7;
            Anim_Create(id, "_choice_item_soul", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _choice_item_soul, _choice_item - _choice_item_soul, 15 * !global.classic_ui);
        }
    } else if (Input_IsPressed(INPUT.CONFIRM)) {
        var items = Item_GetInventoryItems();
        var box = Item_GetInventoryBoxes(box_slot);
        if (_choice_mode == 0) {
            var target = items.GetOrEmpty(_choice_item);
            if (items.IsItemTypeValid(target) && box.GetCount() < box.GetCapacity()) {
                items.Remove(_choice_item);
                box.Add(target);
                event_user(1);
            }
        } else {
            var target = box.GetOrEmpty(_choice_item);
            if (box.IsItemTypeValid(target) && items.GetCount() < items.GetCapacity()) {
                box.Remove(_choice_item);
                items.Add(target);
                event_user(1);
            }
        }
    } else if (Input_IsPressed(INPUT.CANCEL)) {
        alarm[0] = 30;
        Anim_Create(id, "_show_width", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _show_width, 0 - _show_width, 30 * !global.classic_ui);
        char_player.moveable = true
    }
}
if (instance_exists(_inst_inventory)) {
    _inst_inventory._surface_target = _surface_text;
}
if (instance_exists(_inst_box)) {
    _inst_box._surface_target = _surface_text;
}
if (instance_exists(_inst_item_inventory)) {
    _inst_item_inventory._surface_target = _surface_text;
}
if (instance_exists(_inst_item_box)) {
    _inst_item_box._surface_target = _surface_text;
}
if (instance_exists(_inst_finish)) {
    _inst_finish._surface_target = _surface_text;
}