depth = DEPTH_UI.PANEL;
_show_width = 0;
_state = -1;
_choice = 0;
_choice_soul = 0;
_prefix = "{shadow true}{color `white`}{font 1}{scale 2}{instant true}{depth " + string(depth) + "}";
_surface = surface_create(640, 480);
_surface_text = surface_create(640, 480);
_inst_name = noone;
_inst_lv = noone;
_inst_time = noone;
_inst_room = noone;
_inst_save = noone;
_inst_return = noone;

if (instance_exists(char_player)) {
    char_player._moveable_save = false;
}