// ItemTypeSimple base receives a name localization key.
// It automatically sets up GetName to show the localized name "item.key.name"
// and OnInfo to show the localized dialog "item.key.info"
function CustomItem_Stick() : ItemTypeSimple("Stick","* Stick - Weapon AT 0&* Its bark is worse than&  its bite.") constructor{
	_price_buy = 0;
	_price_sell = 115;
	function OnUse(inventory,index){
		Dialog_Add("* You threw the stick away.{sleep 20}&* Then picked it back up.");
		Dialog_Start();
	}
}