depth = DEPTH_UI.PANEL;
box_slot = 0;
_state = -1;
_choice_mode = 0;
_choice_mode_soul = 0;
_choice_item = 0;
_choice_item_soul = 0;
_surface = surface_create(640, 480);
_surface_text = surface_create(640, 480);
_prefix = "{shadow true}{color `white`}{scale 2}{font 1}{instant true}{depth " + string(depth) + "}{surface " + string(real(_surface_text)) + "}";
_show_width = 0;
_inst_inventory = noone;
_inst_box = noone;
_inst_item_inventory = noone;
_inst_item_box = noone;
_inst_finish = noone;
Anim_Create(id, "_show_width", ANIM_TWEEN.CUBIC, ANIM_EASE.IN, _show_width, 304 - _show_width, 20*!global.classic_ui);
if (instance_exists(char_player)) {
    char_player._moveable_box = false;
}