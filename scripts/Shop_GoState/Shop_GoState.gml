///@arg state
function Shop_GoState(){
	shop._state = argument[0];
	shop._index=0;
	shop._index_buy = 0;
	shop._index_sell = 0;
	shop._choice_state=0;
	shop.buy_info_inst_y = shop.border_y1;
	if(instance_exists(shop_dialog_typer))
		instance_destroy(shop_dialog_typer);
	Shop_RefreshTyper();
	Shop_CallEvent(shop._state);
}