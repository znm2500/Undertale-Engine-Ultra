///@desc Menu Switch
if (_menu == 0) {
    var s = Storage_GetInfo();
    _mode = s.IsFileExists();
    if (!_mode) {
        _inst_instruction = instance_create_depth(85, 20, 0, text_typer);
        _inst_instruction.text = _prefix + "{color_text `gray_light`} --- Instruction ---{space_y -1}&&{space_y 2}[Z or ENTER] - Confirm&[X or SHIFT] - Cancel&[C or CTRL] - Menu (In-game)&[F4] - Fullscreen&[Hold ESC] - Quit&When HP is 0, you lose.";
        _inst_begin = instance_create_depth(85, 172, 0, text_typer);
        _inst_begin.text = _prefix + "{color `white`}Begin Game";
        _inst_settings = instance_create_depth(85, 192, 0, text_typer);
        _inst_settings.text = _prefix + "{color `white`}Settings";
        with(text_typer) {
            event_user(15);
        }
        event_user(2);
    } else {
        s.ClearData();
        s.LoadFromFile();
        var z = Storage_GetInfoGeneral();
        _inst_name = instance_create_depth(70, 62, 0, text_typer);
        _inst_name.text = _prefix + z.Get(FLAG_INFO_NAME, "EMPTY");
        _inst_lv = instance_create_depth(154, 62, 0, text_typer);
        _inst_lv.text = _prefix + $"LV {z.Get(FLAG_INFO_LV,0)}";
        _inst_time = instance_create_depth(226, 62, 0, text_typer);
        var time_in_steps = z.Get(FLAG_INFO_TIME, 0);
        var time_in_seconds = time_in_steps / GAME_FPS;
        var minute = floor(time_in_seconds / 60);
        var second = floor(time_in_seconds mod 60);
        _inst_time.text = _prefix + $"{minute}:{second<10 ? "0 " : ""}{second}";
        _inst_room = instance_create_depth(70, 80, 0, text_typer);
        var roomIndex = asset_get_index(z.Get(FLAG_INFO_ROOM, ""));
        if (!room_exists(roomIndex)) {
            roomIndex = -1;
        }
        _inst_room.text = _prefix + Player_GetRoomName(roomIndex);
        _inst_continue = instance_create_depth(85, 105, 0, text_typer);
        _inst_continue.text = _prefix + "{color `white`}Continue";
        _inst_continue.override_color_text_enabled = true;
        _inst_reset = instance_create_depth(195, 105, 0, text_typer);
        _inst_reset.text = _prefix + "{color `white`}Reset";
        _inst_reset.override_color_text_enabled = true;
        _inst_settings = instance_create_depth(132, 125, 0, text_typer);
        _inst_settings.text = _prefix + "{color `white`}Settings";
        _inst_settings.override_color_text_enabled = true;
        event_user(2);
    }
} else {
    if (instance_exists(_inst_instruction)) instance_destroy(_inst_instruction);
    if (instance_exists(_inst_begin)) instance_destroy(_inst_begin);
    if (instance_exists(_inst_settings)) instance_destroy(_inst_settings);
    if (instance_exists(_inst_name)) instance_destroy(_inst_name);
    if (instance_exists(_inst_lv)) instance_destroy(_inst_lv);
    if (instance_exists(_inst_time)) instance_destroy(_inst_time);
    if (instance_exists(_inst_room)) instance_destroy(_inst_room);
    if (instance_exists(_inst_continue)) instance_destroy(_inst_continue);
    if (instance_exists(_inst_reset)) instance_destroy(_inst_reset);
}

if (_menu == 1) {
    _inst_naming_title = instance_create_depth(90, 30, 0, text_typer);
    _inst_naming_title.text = _prefix + "{color `white`}Name the fallen human.";
    _inst_naming_letters = instance_create_depth(60, 76, 0, text_typer);
    _inst_naming_letters.text = _prefix + "{font 0}{effect 0}{space_x 24}{space_y -2}ABCDEFG&HIJKLMN&OPQRSTU&VWXYZ{space_y -7}&&{space_y -2}abcdefg&hijklmn&opqrstu&vwxyz";
    _inst_naming_quit = instance_create_depth(60, 200, 0, text_typer);
    _inst_naming_quit.text = _prefix + "Quit";
    _inst_naming_backspace = instance_create_depth(120, 200, 0, text_typer);
    _inst_naming_backspace.text = _prefix + "Backspace";
    _inst_naming_done = instance_create_depth(220, 200, 0, text_typer);
    _inst_naming_done.text = _prefix + "Done";
    with(text_typer) {
        event_user(15);
    }
    event_user(3);
} else {
    if (instance_exists(_inst_naming_title)) instance_destroy(_inst_naming_title);
    if (instance_exists(_inst_naming_letters)) instance_destroy(_inst_naming_letters);
    if (instance_exists(_inst_naming_quit)) instance_destroy(_inst_naming_quit);
    if (instance_exists(_inst_naming_backspace)) instance_destroy(_inst_naming_backspace);
    if (instance_exists(_inst_naming_done)) instance_destroy(_inst_naming_done);
}

if (_menu == 2) {
    _inst_confirm_title = instance_create_depth(90, 30, 0, text_typer);
    _inst_confirm_title.text = _prefix + _confirm_title;
    _inst_confirm_no = instance_create_depth(73, 200, 0, text_typer);
    _inst_confirm_no.text = _prefix + "No";
    _inst_confirm_yes = instance_create_depth(230, 200, 0, text_typer);
    _inst_confirm_yes.text = _prefix + "Yes";
    _confirm_name_x = 280;
    _confirm_name_y = 110;
    _confirm_name_scale = 2;
    Anim_Destroy(id, "_confirm_name_x");
    Anim_Destroy(id, "_confirm_name_y");
    Anim_Destroy(id, "_confirm_name_scale");
    Anim_Create(id, "_confirm_name_x", 0, 0, 280, -80, 270);
    Anim_Create(id, "_confirm_name_y", 0, 0, 110, 120, 270);
    Anim_Create(id, "_confirm_name_scale", 0, 0, 2, 5, 270);
    _choice_confirm = 0;
    with(text_typer) {
        event_user(15);
    }
    event_user(5);
} else {
    if (instance_exists(_inst_confirm_title)) instance_destroy(_inst_confirm_title);
    if (instance_exists(_inst_confirm_no)) instance_destroy(_inst_confirm_no);
    if (instance_exists(_inst_confirm_yes)) instance_destroy(_inst_confirm_yes);
}

if (_menu == 3) {
    fader.color = c_white;
    Fader_Fade(-1, 1, 240);
    alarm[0] = 240 / global.delta_time_factor;
}