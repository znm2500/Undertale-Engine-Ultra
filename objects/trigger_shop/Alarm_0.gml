var z=Storage_SetTempFlag(FLAG_TEMP_TRIGGER_WARP_LANDMARK,target_landmark);
if(instance_exists(char_player)){
	var pdir=DIR.DOWN;
	if(player_dir==-1){
		pdir=char_player.dir;
	}else{
		pdir=player_dir;
	}
	z.Set(FLAG_TEMP_TRIGGER_WARP_DIR,pdir);
}
if(bgm_fade){
	BGM_Stop(0);
}

Shop_Start(target_shop_id);
fader.color=fade_out_color;
Fader_Fade(-1,0,fade_out_time);
with(char_player){
	while(place_meeting(x,y,trigger_shop)){
		y -= 5;
	}
}
_triggered=false
char_player._moveable_shop=1;