if (global.classic_ui) {
    if (_menu == 1) {
        if (!instance_exists(_inst_item)) {
            _inst_item = instance_create_depth((188 + 6 + 38)  , + (52 + 6 + 22) , 0, text_typer);
            _inst_item.text = _prefix;

            var proc=0;
		var items=Item_GetInventoryItems();
		repeat(items.GetCount()){
			_inst_item.text+=items.GetItemName(proc)+"&";
			proc+=1;
		}
        }
        if (!instance_exists(_inst_item_use)) {
            _inst_item_use = instance_create_depth((188 + 6 + 38)  , + (52 + 6 + 302) , 0, text_typer);
            _inst_item_use.text = _prefix + "USE";
        }
        if (!instance_exists(_inst_item_info)) {
            _inst_item_info = instance_create_depth((188 + 6 + 134)  , + (52 + 6 + 302) , 0, text_typer);
            _inst_item_info.text = _prefix + "INFO";
        }
        if (!instance_exists(_inst_item_drop)) {
            _inst_item_drop = instance_create_depth((188 + 6 + 248)  , + (52 + 6 + 302) , 0, text_typer);
            _inst_item_drop.text = _prefix + "DROP";
        }
    } else {
        if (_menu != 2) {
            if (instance_exists(_inst_item)) {
                instance_destroy(_inst_item);
            }
            if (instance_exists(_inst_item_use)) {
                instance_destroy(_inst_item_use);
            }
            if (instance_exists(_inst_item_info)) {
                instance_destroy(_inst_item_info);
            }
            if (instance_exists(_inst_item_drop)) {
                instance_destroy(_inst_item_drop);
            }
        }
    }

    if (_menu == 3) {
        if (!instance_exists(_inst_stat_0)) {
            _inst_stat_0 = instance_create_depth((188 + 6 + 22)  , + (52 + 6 + 26) , 0, text_typer);
            var name=Player_GetName();
		var lv=Player_GetLv();
		var hp=Player_GetHp();
		var hp_max=Player_GetHpMax();
		var atk=Player_GetAtk();
		var atk_item=Player_GetAtkItem();
		var def=Player_GetDef();
		var def_item=Player_GetDefItem();
		var itemTypeManager=Item_GetTypeManager();
		var weapon=itemTypeManager.GetNameOrFallback(Player_GetItemWeapon());
		var armor=itemTypeManager.GetNameOrFallback(Player_GetItemArmor());
		var gold=Player_GetGold();
            _inst_stat_0.text = _prefix + "{define `NAME` `" + name + "`}{define `LV` " + string(lv) + "}{define `HP` " + string(hp) + "}{define `HP_MAX` " + string(hp_max) + "}{define `ATK` " + string(atk) + "}{define `ATK_ITEM` " + string(atk_item) + "}{define `DEF` " + string(def) + "}{define `DEF_ITEM` " + string(def_item) + "}{define `WEAPON` `" + weapon + "`}{define `ARMOR` `" + armor + "`}{define `GOLD` " + string(gold) + "}" + "\"{insert NAME}\"{space_y -1}&&{space_y 0}LV  {insert LV}&HP  {insert HP} / {insert HP_MAX}&&AT  {insert ATK} ({insert ATK_ITEM})&DF  {insert DEF} ({insert DEF_ITEM}){space_y -1}&&{space_y 0}WEAPON: {insert WEAPON}&ARMOR: {insert ARMOR}{space_y 4}&{space_y 0}GOLD: {insert GOLD}";
        }
        if (!instance_exists(_inst_stat_1)) {
            _inst_stat_1 = instance_create_depth((188 + 6 + 190)  , + (52 + 6 + 182) , 0, text_typer);
         var xp=Player_GetExp();
		var lv=Player_GetLv();
		var lv_xp=Player_GetLvExp(lv+1);
		var kills=Player_GetKills();
            _inst_stat_1.text = _prefix + "{define `EXP` " + string(xp) + "}{define `EXP_NEXT` " + (lv_xp != -1 ? string(lv_xp - xp) : "`N/A`") + "}" + "EXP: {insert EXP}&NEXT: {insert EXP_NEXT}" + (kills > 0 ? "{define `KILLS` " + string(kills) + "}" + "{space_y -1}&&{space_y 0}&{space_y 4}&{space_y 0}KILLS: {insert KILLS}": "");
        }
    } else {
        if (instance_exists(_inst_stat_0)) {
            instance_destroy(_inst_stat_0);
        }
        if (instance_exists(_inst_stat_1)) {
            instance_destroy(_inst_stat_1);
        }
    }

    if (_menu == 4) {
        if(!instance_exists(_inst_phone)){
		_inst_phone=instance_create_depth(188+6+38,52+6+22,0,text_typer);
		_inst_phone.text=_prefix;
		
		var proc=0;
		var phones=Item_GetInventoryPhones();
		repeat(phones.GetCount()){
			_inst_phone.text+=phones.GetItemName(proc)+"&";
			proc+=1;
		}
	}
    } else {
        if (instance_exists(_inst_phone)) {
            instance_destroy(_inst_phone);
        }
    }
} else {
    if (_menu == 1) {
        _destroy_time[0] = 0;
        if (!instance_exists(_inst_item)) {
            _inst_item = instance_create_depth((188 + 6 + 38), (52 + 6 + 22), 0, text_typer);
            _inst_item.text = _prefix + "{shadow true}{color `white`}";

            var proc=0;
		var items=Item_GetInventoryItems();
		repeat(items.GetCount()){
			_inst_item.text+=items.GetItemName(proc)+"&";
			proc+=1;
		}
        }
        if (!instance_exists(_inst_item_use)) {
            _inst_item_use = instance_create_depth((188 + 6 + 38), (52 + 6 + 302), 0, text_typer);
            _inst_item_use.text = _prefix + "USE";
        }
        if (!instance_exists(_inst_item_info)) {
            _inst_item_info = instance_create_depth((188 + 6 + 134), (52 + 6 + 302), 0, text_typer);
            _inst_item_info.text = _prefix + "INFO";
        }
        if (!instance_exists(_inst_item_drop)) {
            _inst_item_drop = instance_create_depth((188 + 6 + 248), (52 + 6 + 302), 0, text_typer);
            _inst_item_drop.text = _prefix + "DROP";
        }
    } else {
        if (_menu != 2) {
            Anim_Create(_destroy_time, "0", 0, 0, _destroy_time[0], 20 - _destroy_time[0], 20 - _destroy_time[0]);
            if (instance_exists(_inst_item) && _destroy_time[0] > 0) {
                instance_destroy(_inst_item);
            }
            if (instance_exists(_inst_item_use) && _destroy_time[0] > 0) {
                instance_destroy(_inst_item_use);
            }
            if (instance_exists(_inst_item_info) && _destroy_time[0] > 0) {
                instance_destroy(_inst_item_info);
            }
            if (instance_exists(_inst_item_drop) && _destroy_time[0] > 0) {
                instance_destroy(_inst_item_drop);
            }
        }
    }

    if (_menu == 3) {
        _destroy_time[1] = 0
        if (!instance_exists(_inst_stat_0)) {
            _inst_stat_0 = instance_create_depth((188 + 6 + 22), (52 + 6 + 26), 0, text_typer);
           var name=Player_GetName();
		var lv=Player_GetLv();
		var hp=Player_GetHp();
		var hp_max=Player_GetHpMax();
		var atk=Player_GetAtk();
		var atk_item=Player_GetAtkItem();
		var def=Player_GetDef();
		var def_item=Player_GetDefItem();
		var itemTypeManager=Item_GetTypeManager();
		var weapon=itemTypeManager.GetNameOrFallback(Player_GetItemWeapon());
		var armor=itemTypeManager.GetNameOrFallback(Player_GetItemArmor());
		var gold=Player_GetGold();
            _inst_stat_0.text = _prefix + "{define `NAME` `" + name + "`}{define `LV` " + string(lv) + "}{define `HP` " + string(hp) + "}{define `HP_MAX` " + string(hp_max) + "}{define `ATK` " + string(atk) + "}{define `ATK_ITEM` " + string(atk_item) + "}{define `DEF` " + string(def) + "}{define `DEF_ITEM` " + string(def_item) + "}{define `WEAPON` `" + weapon + "`}{define `ARMOR` `" + armor + "`}{define `GOLD` " + string(gold) + "}" + "\"{insert NAME}\"{space_y -1}&&{space_y 0}LV  {insert LV}&HP  {insert HP} / {insert HP_MAX}&&AT  {insert ATK} ({insert ATK_ITEM})&DF  {insert DEF} ({insert DEF_ITEM}){space_y -1}&&{space_y 0}WEAPON: {insert WEAPON}&ARMOR: {insert ARMOR}{space_y 4}&{space_y 0}GOLD: {insert GOLD}";
        }
        if (!instance_exists(_inst_stat_1)) {
            _inst_stat_1 = instance_create_depth((188 + 6 + 190), (52 + 6 + 182), 0, text_typer);
            var xp=Player_GetExp();
		var lv=Player_GetLv();
		var lv_xp=Player_GetLvExp(lv+1);
		var kills=Player_GetKills();
            _inst_stat_1.text = _prefix + "{define `EXP` " + string(xp) + "}{define `EXP_NEXT` " + (lv_xp != -1 ? string(lv_xp - xp) : "`N/A`") + "}" + "EXP: {insert EXP}&NEXT: {insert EXP_NEXT}" + (kills > 0 ? "{define `KILLS` " + string(kills) + "}" + "{space_y -1}&&{space_y 0}&{space_y 4}&{space_y 0}KILLS: {insert KILLS}": "");
        }
    } else {
        Anim_Create(_destroy_time, "1", 0, 0, _destroy_time[1], 20 - _destroy_time[1], 20 - _destroy_time[1]);
        if (instance_exists(_inst_stat_0) && _destroy_time[1] > 0) {
            instance_destroy(_inst_stat_0);
        }
        if (instance_exists(_inst_stat_1) && _destroy_time[1] > 0) {
            instance_destroy(_inst_stat_1);
        }
    }

    if (_menu == 4) {
        _destroy_time[2] = 0
        if(!instance_exists(_inst_phone)){
		_inst_phone=instance_create_depth(188+6+38,52+6+22,0,text_typer);
		_inst_phone.text=_prefix;
		
		var proc=0;
		var phones=Item_GetInventoryPhones();
		repeat(phones.GetCount()){
			_inst_phone.text+=phones.GetItemName(proc)+"&";
			proc+=1;
		}
	}
    } else {
        Anim_Create(_destroy_time, "2", 0, 0, _destroy_time[2], 20 - _destroy_time[2], 20 - _destroy_time[2]);
        if (instance_exists(_inst_phone) && _destroy_time[2] > 0) {
            instance_destroy(_inst_phone);
        }
    }
}