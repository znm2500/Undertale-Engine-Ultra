function Shop_End(){
	var room_return=Storage_GetTempGeneral().Get(FLAG_TEMP_SHOP_ROOM_RETURN);
	if(room_exists(room_return)){
		fader.alpha=1;
		room_goto(room_return);
		Fader_Fade(-1,0,20);
	}
}