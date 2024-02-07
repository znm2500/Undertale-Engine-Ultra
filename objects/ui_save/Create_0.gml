depth=-9000;
_show_width=0
_state=-1;
_choice=0;
_choice_soul=0;
_prefix="{shadow true}{color `white`}{scale 2}{font 1}{instant true}{depth "+string(-9999)+"}";
_surface=surface_create(room_width*2,room_height*2)
_inst_name=noone;
_inst_lv=noone;
_inst_time=noone;
_inst_room=noone;
_inst_save=noone;
_inst_return=noone;

if(instance_exists(char_player)){
	char_player._moveable_save=false;
}