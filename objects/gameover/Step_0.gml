/// @description Insert description here
// You can write your code in this editor
time+=1
if(time>=300&&!instance_exists(a)){image_alpha-=0.02}
if(time>=400&&image_alpha<=0){room_goto(room_battle)
	instance_exists(gameover)
	audio_stop_all()}







