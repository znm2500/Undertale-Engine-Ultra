function CustomItem_Bandage() : ItemTypeSimple("Bandage","* Bandage - Heals 10 HP&* It has already been used&  several times.") constructor{
	_price_buy = -1;
	_price_sell = 1;
	_shop_description = "Bandage";
	function OnUse(inventory,index){
		Dialog_Add("* You re-applied the bandage."+Item_GetTextHeal(10));
		Dialog_Start();

		Player_Heal(10);
		audio_play_sound(snd_item_heal,0,false);

		inventory.Remove(index);
	}
}