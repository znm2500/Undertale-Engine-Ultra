audio_play_sound(snd_gameover,0,1)
a=instance_create_depth(180, 320,depth-1,text_typer)
a.text="{skippable false}{color `white`}{speed 8}{space_x 2}{space_y 2}{font 1}{scale 2}{voice 3}You cannot give&up just yet...{sleep 20}{pause}{clear}"+Player_GetName()+"!!{sleep 24}&Stay determined...{pause}{end}"
