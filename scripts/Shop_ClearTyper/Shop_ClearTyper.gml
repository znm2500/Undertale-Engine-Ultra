//var SHOP = shop;
//if(instance_exists(SHOP._typer_left))
//instance_destroy(SHOP._typer_left);
//if(instance_exists(SHOP._typer_right))
//instance_destroy(SHOP._typer_right);
//if(instance_exists(SHOP._typer_state))
//instance_destroy(SHOP._typer_state);
//if(instance_exists(SHOP._typer_info))
//instance_destroy(SHOP._typer_info);
//if(instance_exists(text_single))
//instance_destroy(text_single);
//if(instance_exists(text_typer))
//instance_destroy(text_typer);
function Shop_ClearTyper(){
	with(shop)event_user(2);
}