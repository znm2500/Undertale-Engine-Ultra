///@arg item_id
function Item_GetSellGold(){
	var ITEM=argument[0];

	if(Item_IsValid(ITEM)){
		var INST=instance_create_depth(0,0,0,ITEM);
		var GOLD=INST._price_sell;
		instance_destroy(INST);
		return GOLD;
	}else{
		return "";
	}
}