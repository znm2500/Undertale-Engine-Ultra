// text_typer args
text = "";
_line = 0; //目前所在行数
_type_dir = 0; //打字方向 0为水平 1为垂直
_halign = 0;
_valign = 0;
_speed = 0;
_char_per_frame = 1;
_position_follow = true;
_audio_clear = true;
_voice = 0;
_voice_single = -1;
_sleep = 0;
_skippable = true;
_skipping = false;
_paused = false;
_instant = false;
_space_x = 0;
_space_y = 0;
_char_frame_remain = 0;
_char_x = 0;
_char_y = 0;
_char = "";
_angle = 0;
_char_sprite = -1;
_char_sprite_image = 0;
_char_proc = 1;
_voice_played = false;

// --- 修改部分：DS List 改为 Array ---
_char_data_list = []; 
_list_cmd = [];       
// ----------------------------------

_map_macro = {}; // 如果需要，map 也可以改用 struct，此处暂保留
_face = noone;
_face_linked = -1;
_char_linked = -1;
_skip_space = true;
_choice = -1;
_choice_x[0] = 0;
_choice_y[0] = 0;
_choice_x[1] = 0;
_choice_y[0] = 0;
_choice_macro = "";
_choice_switch_direction = 0; //0为左右 1为上下
_choice_switch_key = [INPUT.LEFT, INPUT.RIGHT];
_choice_switch_sound = true;
_show_item = 0;

// text_single args
_font = 0;
_scale_x = 1;
_scale_y = 1;
_shadow = false;
_outline = false;
_color_text[0] = c_white;
_color_text[1] = c_white;
_color_text[2] = c_white;
_color_text[3] = c_white;
_color_shadow[0] = make_color_rgb(49, 49, 79);
_color_shadow[1] = make_color_rgb(49, 49, 79);
_color_shadow[2] = make_color_rgb(15, 15, 115);
_color_shadow[3] = make_color_rgb(15, 15, 115);
_color_outline[0] = make_color_rgb(110, 110, 110);
_color_outline[1] = make_color_rgb(110, 110, 110);
_color_outline[2] = make_color_rgb(110, 110, 110);
_color_outline[3] = make_color_rgb(110, 110, 110);
_alpha = 1;
_rainbow = 0;
_alpha_text = 1;
_alpha_shadow = 1;
_alpha_outline = 1;
_shadow_x = 0.5;
_shadow_y = 0.5;
_effect = -1;
_gui = false;
_angle_previous = _angle;
_angle_follow = true;
_effect_shook = 0;
// group init
event_user(5);
_surface_target = noone;
width = 0;
height = 0;
override_alpha_enabled = false;
override_alpha = 1;
override_color_text_enabled = false;
override_color_text[0] = c_white;
override_color_text[1] = c_white;
override_color_text[2] = c_white;
override_color_text[3] = c_white;
_time = 0;
torder = [];
_order = 0;

auto_destroy = false;
alarm[1] = 1;

function CharUpdate(character) {
        if (_position_follow == 1) {
            if (_type_dir == 0) {
                character.x = x + character._offset_x[0] + character._xUnit[0] * character._deltaX +character. _yUnit[0] *character. _deltaY;
                character.y = y + character. _offset_y[0] +character. _xUnit[1] * character._deltaX +character. _yUnit[1] * character._deltaY;
            } else {
                character.x = x + character._offset_x[0] +character. _xUnit[1] * character._deltaX + character._yUnit[1] *character. _deltaY;
                character.y = y + character._offset_y[0] + character._xUnit[0] *character. _deltaX +character. _yUnit[0] * character._deltaY;
            }
        }
}

function ChangeText(text) {
    event_user(3);

    id.text = text;
    _speed = 0;
    _char_per_frame = 1;
    _voice = 0;
    _voice_single = -1;
    _sleep = 0;
    _skippable = true;
    _skip_enabled = false;
    _skipping = false;
    _paused = false;
    _instant = false;
    _space_x = 0;
    _space_y = 0;
    _char_frame_remain = 0;
    _char_x = 0;
    _char_y = 0;
    _char = "";
    _char_sprite = -1;
    _char_sprite_image = 0;
    _char_proc = 1;
    _voice_played = false;

    // --- 修改部分：移除 ds_list_destroy，直接赋值为空数组 ---
    _char_data_list = []; 
    _list_cmd = [];       
    // ----------------------------------------------------

    // 假设 _map_macro 仍使用 DS Map，需先清空（或改为 struct {}）
    ds_map_clear(_map_macro); 

    _face = noone;
    _face_linked = -1;
    _char_linked = -1;
    _skip_space = true;
    _line = 0; 
    _type_dir = 0; 
    _halign = 0;
    _valign = 0;
    _position_follow = true;
    _audio_clear = true;
    _show_item = 0;
    _choice = -1;
    _choice_x[0] = 0;
    _choice_y[0] = 0;
    _choice_x[1] = 0;
    _choice_y[0] = 0;
    _choice_macro = "";
    _choice_switch_direction = 0;
    _choice_switch_key = [INPUT.LEFT, INPUT.RIGHT];
    _choice_switch_sound = true;

    // text_single args
    _font = 0;
    _scale_x = 1;
    _scale_y = 1;
    _angle = 0;
    _angle_previous = 0;
    _angle_follow = 1;
    _shadow = false;
    _outline = false;
    _color_text[0] = c_white;
    _color_text[1] = c_white;
    _color_text[2] = c_white;
    _color_text[3] = c_white;
    _color_shadow[0] = make_color_rgb(49, 49, 79);
    _color_shadow[1] = make_color_rgb(49, 49, 79);
    _color_shadow[2] = make_color_rgb(15, 15, 115);
    _color_shadow[3] = make_color_rgb(15, 15, 115);
    _color_outline[0] = make_color_rgb(110, 110, 110);
    _color_outline[1] = make_color_rgb(110, 110, 110);
    _color_outline[2] = make_color_rgb(110, 110, 110);
    _color_outline[3] = make_color_rgb(110, 110, 110);
    _alpha = 1;
    _alpha_text = 1;
    _alpha_shadow = 1;
    _alpha_outline = 1;
    _shadow_x = 0.5;
    _shadow_y = 0.5;
    _effect = -1;
    _gui = false;
    _rainbow = 0;
    _surface_target = noone;

    event_user(5);

    width = 0;
    height = 0;
    override_alpha_enabled = false;
    override_alpha = 1;
    override_color_text_enabled = false;
    override_color_text[0] = c_white;
    override_color_text[1] = c_white;
    override_color_text[2] = c_white;
    override_color_text[3] = c_white;
    _order = 0;

    alarm[1] = 1;
}