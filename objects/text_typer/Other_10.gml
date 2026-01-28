///@desc New Char
var font = 0;
if(ord(_char) < 128){
    font = 0;
} else {
    font = 1;
}

draw_set_font(_group_font[_font, font]);

// 计算宽度
var wid_char = sprite_exists(_char_sprite) ? sprite_get_width(_char_sprite) : string_width(_char);
var wid_space = _group_font_space_x[_font, font] + _space_x;
var scale_x = _group_font_scale_x[_font, font] * _scale_x;
var scale_y = _group_font_scale_y[_font, font] * _scale_y;
var wid_cur = (wid_char + wid_space) * scale_x;

// 预设对齐偏移参考
var former_chr_offset_dict_x = [0, wid_cur / 2, wid_cur];

if(_halign == 1){
    _char_x += wid_cur / 2;
}

if(_char != " " && _char != "　"){
    draw_set_font(_group_font[_font, 0]);
    var H1 = string_height(" ");
    draw_set_font(_group_font[_font, font]);
    var H2 = string_height(" ");
    
    // 微调偏移逻辑
    var OFFSET_X = (_font == 0 && font == 0 && (_char == "(" || _char == ")") ? -4 : 0);
    var OFFSET_Y = (H1 - H2) / 2 * _scale_y + (_font == 2 && font == 1 ? 3.5 : 0);
    
    // 构造字符数据 Struct (包含数组引用)
    var char_data = {
        text: _char,
        font: _group_font[_font, font],
        scale_x: scale_x,
        scale_y: scale_y,
        angle: _angle,
        shadow: _shadow,
        outline: _outline,
        // 注意：颜色数组需要复制，防止后续修改 _color_text 时所有字符颜色一起变
        color_text: [_color_text[0], _color_text[1], _color_text[2], _color_text[3]],
        color_shadow: [_color_shadow[0], _color_shadow[1], _color_shadow[2], _color_shadow[3]],
        color_outline: [_color_outline[0], _color_outline[1], _color_outline[2], _color_outline[3]],
		color_tick:0,
        shadow_x: _shadow_x,
        shadow_y: _shadow_y,
        alpha: _alpha,
        alpha_text: _alpha_text,
        alpha_shadow: _alpha_shadow,
        alpha_outline: _alpha_outline,
        effect: _effect,
        gui: _gui,
        typer: id,
        halign: _halign,
        valign: _valign,
        rainbow: _rainbow,
		_processed:0,
        surface_target: _surface_target,
        _line: _line,
        _deltaX: _char_x + OFFSET_X,
        _deltaY: _char_y + OFFSET_Y,
        _xUnit: [lengthdir_x(1, _angle * (_type_dir == 0 ? 1 : -1)), lengthdir_y(1, _angle * (_type_dir == 0 ? 1 : -1))],
        _yUnit: [lengthdir_x(1, (_angle - 90) * (_type_dir == 0 ? 1 : -1)), lengthdir_y(1, (_angle - 90) * (_type_dir == 0 ? 1 : -1))],
        order: _order,
        show_item: _show_item,
        sprite: -1,
        sprite_image: 0,
        _offset_x: [0, 0, 0],
        _offset_y: [0, 0, 0]
    };
    
    _order += 1;
    
    // 处理 Sprite 字符
    if (sprite_exists(_char_sprite)){
        char_data.sprite = _char_sprite;
        char_data.sprite_image = _char_sprite_image;
        char_data._deltaX += sprite_get_xoffset(_char_sprite) * _scale_x;
        char_data._deltaY += sprite_get_yoffset(_char_sprite) * _scale_y;
    }
    
    // 推入数组
    array_push(_char_data_list, char_data);
    
    // 播放打字音逻辑
    if(!_voice_played && !_skipping && !_instant && _voice >= 0){
        var sound = -1;
        // 获取语音数组长度 (使用 array_length 替代 array_length_2d)
        var voice_array = _group_voice[_voice];
        var voice_count = array_length(voice_array);
        
        if(_voice_single >= 0 && _voice_single < voice_count){
            sound = voice_array[_voice_single];
        } else if (voice_count > 0) {
            sound = voice_array[irandom(voice_count - 1)];
        }
        
        if(audio_exists(sound)){
            if(_audio_clear == 1) audio_stop_sound(sound);
            audio_play_sound(sound, 0, false);
            _voice_played = true;
        }
    }
}

// 步进 X 坐标
if(_halign == 0){
    _char_x += wid_cur;
}

// 处理对齐偏移
if(_halign != 0){
    var range_fix = (_char != " " && _char != "　") ? -1 : 0;
    var offset_val = former_chr_offset_dict_x[_halign];
    
    for(var i = 0; i < array_length(_char_data_list) + range_fix; i++){
        var char_data = _char_data_list[i];
        if(char_data._line == _line){
            char_data._deltaX -= offset_val;
        }
    }
}

if(width < _char_x){
    width = _char_x;
}