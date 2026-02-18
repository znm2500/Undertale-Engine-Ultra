if(!_ended){
	alarm[0]=20 / global.delta_time_factor;
	Fader_Fade(-1,1,18);
	BGM_SetVolume(5,0,18);
	_ended=true;
}