event_inherited();

var items=Item_GetInventoryItems();
sprite_index=(items.GetCount()>0) ? spr_battle_button_item : spr_battle_button_item_empty;
