audio_play_sound(snd_gameover,0,1)
a=instance_create_depth(220, 320,depth-1,text_typer)
a.text="{skippable false}{color `white`}{speed 8}{space_x 2}{space_y 2}{font 1}{scale 2}{voice 2}你还不能放弃...{sleep 20}{pause}{clear}"+Player_GetName()+"！{sleep 24}&保持你的决心...{pause}{end}"
