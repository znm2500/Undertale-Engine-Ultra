function Shop_End(){
	var room_return=Flag_Get(FLAG_TYPE.TEMP,FLAG_TEMP.SHOP_ROOM_RETURN);
	if(room_exists(room_return)){
		fader.alpha=1;
		room_goto(room_return);
		Fader_Fade(-1,0,20);
		//BGM_Resume(0);
		//BGM_SetVolume(0,0);
		//BGM_Fade(0,1,50);
	}
}