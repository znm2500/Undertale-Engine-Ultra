depth=-9000;

_state=-1;
_choice=0;
_choice_soul=0;
_prefix="{shadow false}{scale 1}{font 1}{instant true}{depth "+string(-9999)+"}";

_inst_name=noone;
_inst_lv=noone;
_inst_time=noone;
_inst_room=noone;
_inst_save=noone;
_inst_return=noone;

if(instance_exists(char_player)){
	char_player._moveable_save=false;
}