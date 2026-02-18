_voice_played = false;
event_user(4);

// 遍历已生成的字符数据
for (var i = 0; i < array_length(_char_data_list); i++) {
    var char_data = _char_data_list[i];
    char_data.surface_target = _surface_target;
}

// 暂停与跳过逻辑
if (_paused && Input_IsPressed(INPUT.CONFIRM)) {
    _paused = false;
}
if (_skippable && !_paused && Input_IsPressed(INPUT.CANCEL)) {
    _skipping = true;
    _sleep = 0;
    _char_frame_remain = 0;
}

// 选项处理
if (_choice != -1) {
    if ((_choice == 0 && Input_IsPressed(INPUT.RIGHT)) || (_choice == 1 && Input_IsPressed(INPUT.LEFT))) {
        _choice = !_choice;
        audio_play_sound(snd_menu_switch, 0, false);
    }
    if (Input_IsPressed(INPUT.CONFIRM)) {
        if (is_string(_choice_macro)) {
            // --- Map 改为 Struct 操作 ---
            if (variable_struct_exists(_map_macro, _choice_macro)) {
                variable_struct_remove(_map_macro, _choice_macro);
            }
            _map_macro[$ _choice_macro] = _choice;
        }
        Storage_SetTempFlag(FLAG_TEMP_TEXT_TYPER_CHOICE, _choice);
        _choice = -1;
        audio_play_sound(snd_menu_confirm, 0, false);
    }
}

// 字符处理核心循环
if (_char_proc < string_length(text) + 1) {
    if (!_paused) {
        if (_sleep > 0) {
            _sleep -= 1 * global.delta_time_factor;
        } else {
            if (_char_frame_remain > 0) {
                _char_frame_remain -= 1 * global.delta_time_factor;
            } else {
                do {
                    repeat(_char_per_frame) {
                       
                        while ((string_char_at(text, _char_proc) == "{" || string_char_at(text, _char_proc) == "&" || (_skip_space && (string_char_at(text, _char_proc) == " " || string_char_at(text, _char_proc) == "　"))) && ((_sleep == 0 || _skipping || _instant) && !_paused && _char_proc <= string_length(text))) {
                            
                            // 解析指令 {command arg1 arg2}
                            while (string_char_at(text, _char_proc) == "{" && ((_sleep == 0 || _skipping || _instant) && !_paused && _char_proc <= string_length(text))) {
                                _char_proc += 1;
                                
                                // --- List 改为 Array 清空 ---
                                _list_cmd = []; 
                                
                                var loop = true;
                                var cmd = "";
                                var str_mode = false;
                                var str_input = false;
                                
                                while (_char_proc <= string_length(text) && loop) {
                                    var cmd_char = string_char_at(text, _char_proc);
                                    
                                    if ((cmd_char == " " || cmd_char == "}") && !str_input) {
                                        if (!str_mode) {
                                            // --- 修改：检查数组是否为空及�?Struct 获取�?---
                                            if (array_length(_list_cmd) != 0) {
                                                if (variable_struct_exists(_map_macro, cmd)) {
                                                    cmd = _map_macro[$ cmd];
                                                } else {
                                                    // 尝试转为数字，如果不是数字则保持字符�?
                                                    var val = string_digits(cmd);
                                                    if (val != "" || cmd == "0") cmd = real(cmd);
                                                }
                                            }
                                        }
                                        // --- List 改为 Array 添加 ---
                                        array_push(_list_cmd, cmd);
                                        str_mode = false;
                                        str_input = false;
                                        cmd = "";
                                    } else if (cmd_char == "`") {
                                        str_mode = true;
                                        str_input = !str_input;
                                    } else {
                                        if (!str_mode || (str_mode && str_input)) {
                                            if (cmd_char == "\\") {
                                                _char_proc += 1;
                                                cmd_char = string_char_at(text, _char_proc);
                                            }
                                            cmd += cmd_char;
                                        }
                                    }
                                    
                                    if (cmd_char == "}" && !str_input) {
                                        event_user(2); // 执行指令逻辑
                                        loop = false;
                                    }
                                    _char_proc += 1;
                                }
                            }
                            
                            // 换行�?&
                            while (string_char_at(text, _char_proc) == "&" && ((_sleep == 0 || _skipping || _instant) && !_paused && _char_proc <= string_length(text))) {
                                event_user(1);
                                _char_proc += 1;
                            }
                            
                            // 空格处理
                            while (_skip_space && (string_char_at(text, _char_proc) == " " || string_char_at(text, _char_proc) == "　") && ((_sleep == 0 || _skipping || _instant) && !_paused && _char_proc <= string_length(text))) {
                                _char = " ";
                                event_user(0);
                                _char_proc += 1;
                            }
                        }
                        
                        // 打印普通字�?
                        if ((_sleep == 0 || _skipping || _instant) && !_paused && _char_proc <= string_length(text)) {
                            _char = string_char_at(text, _char_proc);
                            if (_char == "\\") {
                                _char_proc += 1;
                                _char = string_char_at(text, _char_proc);
                            }
                            event_user(0);
                            _char_frame_remain = _speed;
                            _char_proc += 1;
                        }
                    }
                } until (_char_proc > string_length(text) || _paused || (!_skipping && !_instant));
            }
        }
    }
}

// Face 表情更新逻辑
if (instance_exists(_face)) {
    _face.gui = _gui;
    _face.depth = depth;
    _face.talking = (!_sleep && !_paused && _char_proc <= string_length(text));
}

// 关联对象（Face/Char）的 Talking 状态更�?
var is_currently_talking = (!_sleep && !_paused && _char_proc <= string_length(text));

if (_face_linked != -1 && instance_exists(face)) {
    var fid = _face_linked;
    with(face) {
        if (face_id == fid) talking = is_currently_talking;
    }
}

if (_char_linked != -1 && instance_exists(char)) {
    var cid = _char_linked;
    with(char) {
        if (char_id == cid) talking = is_currently_talking;
    }
}


if (override_alpha_enabled || override_color_text_enabled) {
    for (var i = 0; i < array_length(_char_data_list); i++) {
        var char_data = _char_data_list[i];
        if (override_alpha_enabled) char_data.alpha = override_alpha;
        if (override_color_text_enabled) {
            if (is_array(override_color_text)) {
                array_copy(char_data.color_text, 0, override_color_text, 0, 4);
            } else {
                for (var j = 0; j < 4; j++) char_data.color_text[j] = override_color_text;
            }
        }
    }
}


_time += 9 * global.delta_time_factor;
for (var i = 0; i < 10; i += 1) {
    torder[i] = _time + i * 36;
}



