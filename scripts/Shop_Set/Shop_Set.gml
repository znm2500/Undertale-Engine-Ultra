///@arg id
///@arg host
///@arg background
///@arg bgm*
///@arg pause_bgm*
///@arg quick*
function Shop_Set(){
	var ID=argument[0];
	var HOST=argument[1];
	var BACKGROUND = argument[2];
	var BGM=-1;
	var PAUSE_BGM=true;
	var QUICK=false;

	if(argument_count>=4){
		BGM=argument[3];
	}
	if(argument_count>=5){
		PAUSE_BGM=argument[4];
	}
	if(argument_count>=6){
		QUICK=argument[5];
	}


	if(ID>=0){
		var map=global._shop;
		var map_e=-1;
		if(ds_map_exists(map,ID)){
			map_e=ds_map_find_value(map,ID);
			ds_map_clear(map_e);
		}else{
			map_e=ds_map_create();
			ds_map_add(map,ID,map_e);
		}
		ds_map_add(map_e,"host",HOST);
		ds_map_add(map_e,"bgm",BGM);
		ds_map_add(map_e,"background",BACKGROUND);
		ds_map_add(map_e,"pause_bgm",PAUSE_BGM);
		ds_map_add(map_e,"quick",QUICK);
		return true;
	}else{
		return false;
	}
}