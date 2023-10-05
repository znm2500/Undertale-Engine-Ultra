///@arg index
function Shop_CallDialog(){
	var INDEX = argument[0];

	if(INDEX < 4 && INDEX >= 0)
	{
		var blt = shop._host.dialog[INDEX];
		with(blt)
			event_user(0);
	}
}