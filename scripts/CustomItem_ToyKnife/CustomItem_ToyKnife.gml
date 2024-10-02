function CustomItem_ToyKnife() : ItemTypeSimple("Toy Knife","* Toy Knife - Weapon AT 3&* Made of plastic.&* A rarity nowadays.") constructor{
	price =1145;
	function OnUse(inventory,index){
		Dialog_Add(Item_GetTextEquip(GetName()));
		Dialog_Start();

		var curWeapon=Player_GetItemWeapon();
		inventory.Set(index,curWeapon);
		Player_SetItemWeapon(ITEM_TOY_KNIFE);

		Player_SetAtkItem(3);

		audio_play_sound(snd_item_equip,0,false);
	}
}