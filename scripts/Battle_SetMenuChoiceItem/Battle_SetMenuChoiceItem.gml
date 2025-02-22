function Battle_SetMenuChoiceItem(slot, call = true) {
    var items = Item_GetInventoryItems();
    var count = items.GetCount();
    if (slot < count) {
        battle._menu_choice_item = slot;
        while (slot >= battle._menu_choice_item_first + 3) {
            battle._menu_choice_item_first += 1;
        }
        while (slot < battle._menu_choice_item_first) {
            battle._menu_choice_item_first -= 1;
        }

        //更新文字
        var text = global.classic_ui ? "": "{depth " + string(DEPTH_BATTLE.BULLET) + "}{show_item true}";;
        var proc = battle._menu_choice_item_first;
        repeat(min(global.classic_ui ? 3 : 8, count)) {
            text += "* " + items.GetItemName(proc) + "&";
            proc += 1;
        }
        Battle_SetDialog(text, true);
        if (call) {
            Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.MENU_CHOICE_SWITCH);
        }

        return true;
    } else {
        return false;
    }

}