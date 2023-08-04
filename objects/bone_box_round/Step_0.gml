duration -= 1
if (duration <= 0)
{
    audio_play_sound(snd_bone_out, 0, false)
    instance_destroy()
}
