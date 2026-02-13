/// @description Encounter
// You can write your code in this editor
if(is_string(encounter_text))
{
	Shop_DialogStart(encounter_text);
}
else
{
	Shop_GoState(SHOP_STATE.MENU);
}