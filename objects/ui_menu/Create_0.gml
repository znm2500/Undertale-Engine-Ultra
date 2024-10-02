depth = -9000;
//global.classic_ui=1
if (instance_exists(char_player)) {
    _top = (char_player.y - camera.y > 130 + char_player.sprite_height);
} else {
    _top = false;
}
_offset = -100;
_menu = 0;
_choice_soul = 0;
_choice = 0;
_choice_item = 0;
_choice_item_soul = 0;
_choice_item_operate = 0;
_choice_item_operate_soul = 11.5;
_choice_phone = 0;
_choice_phone_soul = 0;
_surface = surface_create(640, 480);
_surface_text = surface_create(640, 480);
_prefix = "{font 1}{shadow true}{color `white`}{instant true}{depth " + string(depth) + "}" + "{surface " + string(real(_surface_text)) + "}{scale 2}";
_inst_name = noone;
_inst_menu = noone;
_inst_item = noone;
_inst_item_use = noone;
_inst_item_info = noone;
_inst_item_drop = noone;
_inst_stat_0 = noone;
_inst_stat_1 = noone;
_inst_phone = noone;
_show_width = array_create(3, 0);
_inst_name = instance_create_depth(32 + 6 + 8, 52 + 6 + (_top ? 270 : 0) + 2, 0, text_typer);
_inst_name.text = _prefix + Player_GetName();
_destroy_time = array_create(3, 0);
_inst_menu = instance_create_depth(32 + 6 + 46, 168 + 6 + 14, 0, text_typer);
_inst_menu.text = _prefix + "{space_y 1}" + (Item_GetNumber() <= 0 ? "{color_text `gray`}": "") + "ITEM" + (Item_GetNumber() <= 0 ? "{color_text `white`}": "") + "&" + "STAT" + (Phone_GetNumber() > 0 ? "&" + "CELL": "");
audio_play_sound(snd_menu_switch, 0, false);
Anim_Create(id, "_offset", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, _offset, -_offset, 20 * !global.classic_ui);