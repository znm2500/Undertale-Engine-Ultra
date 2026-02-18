visible = false;
image_alpha = 0;
repeat(6) {
    instance_create_depth(x, y, 0, gameover_shard);
}
gameover_shard.image_blend = image_blend;
audio_play_sound(snd_break_1, 0, false);

alarm[2] = 100 / global.delta_time_factor;
alarm[3] = 120 / global.delta_time_factor;