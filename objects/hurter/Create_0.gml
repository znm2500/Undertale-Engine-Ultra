
var _temp_local_var_1,time=0;

time += 1;
if(time = 2)time = 0;

if(time = 1){
if (Player_GetHp() > 1)
{
    Player_Hurt(1);
    Player_SetKR(Player_GetKR() + 1);
	if(Player_GetKR() >= 5){
		if(global.krtime = 1){
			Player_SetKR(Player_GetKR() - 1);
		}
	}
}
else
    Player_SetKR(Player_GetKR() - 1);
if (Player_GetHp() == 1)
    _temp_local_var_1 = (Player_GetKR() <= 0);
else
    _temp_local_var_1 = 0;
if _temp_local_var_1{
	if(battle_enemy_test.INF_hp = 0){
		Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.GAMEOVER_SOUL_X,battle_soul.x-camera.x);
		Flag_Set(FLAG_TYPE.TEMP,FLAG_TEMP.GAMEOVER_SOUL_Y,battle_soul.y-camera.y);
		room_goto(room_gameover)
	}
	else{
		Player_Heal(92);
		audio_play_sound(snd_item_heal,0,0);
	}
	
}
	audio_play_sound(snd_hurt,0,false);
}

global.krtime += 1
if(global.krtime = 2){
	global.krtime = 0;
}
alarm[0] = 1


