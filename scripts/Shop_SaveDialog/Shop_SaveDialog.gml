///@arg host
function Shop_SaveDialog(){
	var MAP = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.SHOP_HOST);
	var HOST = argument[0];
	var HOST_INDEX = HOST.object_index;
	if(!ds_exists(MAP, ds_type_map))
		MAP = ds_map_create();
	
	if(ds_map_exists(MAP,HOST_INDEX))
		ds_map_replace(MAP,HOST_INDEX,HOST.dialog);
	else
	{
		ds_map_add(MAP,HOST_INDEX,HOST.dialog);
	
	}

	Flag_Set(FLAG_TYPE.STATIC,FLAG_STATIC.SHOP_HOST,MAP);
}