
Anim_Create(id,"image_index",0,0,0,3,6);
Anim_Create(id,"_beam_scale",0,0,0,_beam_scale_default,8);

audio_stop_sound(snd_gb_release);
audio_play_sound(snd_gb_release,0,0);

_inst=instance_create_depth(x,y,0,battle_bullet_gb_beam);
var sid=audio_play_sound(snd_gb_release,0,0);
audio_sound_pitch(sid,1.2);

Camera_Shake(5,5,1,1,1,1);
gamepad_set_vibration(0,0.5,0.5);
alarm[11] = 10 / global.delta_time_factor; // 修正：除法而不是乘法
alarm[3] = 6 / global.delta_time_factor;   // 修正：除法而不是乘法
alarm[4] = 8 / global.delta_time_factor;   // 修正：除法而不是乘法
alarm[5] = time_release_stay / global.delta_time_factor + 1;