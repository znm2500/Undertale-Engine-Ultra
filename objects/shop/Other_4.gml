var BGM=Shop_GetBGM(Storage_GetTempFlag(FLAG_TEMP_SHOP));
if(audio_exists(BGM)){
	BGM_Play(0,BGM);
}

instance_create_depth(0,0,99,shop_ui_deeperpart);