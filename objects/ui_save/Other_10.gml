var s = Storage_GetInfo();
var z = Storage_GetInfoGeneral();
if (_state == 0) {
    s.ClearData();
    s.LoadFromFile();

    _inst_name = instance_create_depth((108 + 6 + 26), (118 + 6 + 16), 0, text_typer);
    _inst_name.text = _prefix + "{surface " + string(real(_surface_text)) + "}" + z.Get(FLAG_INFO_NAME, "EMPTY");

    _inst_lv = instance_create_depth((108 + 6 + 180), (118 + 6 + 16), 0, text_typer);
    _inst_lv.text = _prefix + "{surface " + string(real(_surface_text)) + "}" + $"LV {z.Get(FLAG_INFO_LV,0)}";

    _inst_time = instance_create_depth((108 + 6 + 338), (118 + 6 + 16), 0, text_typer);
    var time = z.Get(FLAG_INFO_TIME, 0);
    var minute = time div 60;
    var second = time mod 60;
    _inst_time.text = _prefix + "{surface " + string(real(_surface_text)) + "}" + string(minute) + ":" + (second < 10 ? "0": "") + string(second);

    _inst_room = instance_create_depth((108 + 6 + 26), (118 + 6 + 56), 0, text_typer);
    var roomIndex = asset_get_index(z.Get(FLAG_INFO_ROOM, ""));
    if (!room_exists(roomIndex)) {
        roomIndex = -1;
    }
    _inst_room.text = _prefix + "{surface " + string(real(_surface_text)) + "}" + Player_GetRoomName(roomIndex);

    _inst_save = instance_create_depth((108 + 6 + 56), (118 + 6 + 116), 0, text_typer);
    _inst_save.text = _prefix + "{surface " + string(real(_surface_text)) + "}" + "Save";

    _inst_return = instance_create_depth((108 + 6 + 236), (118 + 6 + 116), 0, text_typer);
    _inst_return.text = _prefix + "{surface " + string(real(_surface_text)) + "}" + "Return";
}
if (_state == 1) {
    Storage_SaveGame();

    audio_play_sound(snd_save, 0, false);

    if (instance_exists(_inst_name)) {
        instance_destroy(_inst_name);
    }
    if (instance_exists(_inst_lv)) {
        instance_destroy(_inst_lv);
    }
    if (instance_exists(_inst_time)) {
        instance_destroy(_inst_time);
    }
    if (instance_exists(_inst_room)) {
        instance_destroy(_inst_room);
    }
    if (instance_exists(_inst_save)) {
        instance_destroy(_inst_save);
    }
    if (instance_exists(_inst_return)) {
        instance_destroy(_inst_return);
    }

    _inst_name = instance_create_depth((108 + 6 + 26), (118 + 6 + 16), 0, text_typer);
    _inst_name.text = _prefix + "{color `yellow`}" + z.Get(FLAG_INFO_NAME, "EMPTY");

    _inst_lv = instance_create_depth((108 + 6 + 180), (118 + 6 + 16), 0, text_typer);
    _inst_lv.text = _prefix + "{color `yellow`}" + $"LV {z.Get(FLAG_INFO_LV,0)}";

    _inst_time = instance_create_depth((108 + 6 + 338), (118 + 6 + 16), 0, text_typer);
    var time = z.Get(FLAG_INFO_TIME, 0);
    var minute = time div 60;
    var second = time mod 60;
    _inst_time.text = _prefix + "{color `yellow`}" + string(minute) + ":" + (second < 10 ? "0": "") + string(second);
    var roomIndex = asset_get_index(z.Get(FLAG_INFO_ROOM, ""));
    if (!room_exists(roomIndex)) {
        roomIndex = -1;
    }

    _inst_room = instance_create_depth((108 + 6 + 26), (118 + 6 + 56), 0, text_typer);
    _inst_room.text = _prefix + "{color `yellow`}" + Player_GetRoomName(roomIndex);

    _inst_save = instance_create_depth((108 + 6 + 56), (118 + 6 + 116), 0, text_typer);
    _inst_save.text = _prefix + "{color `yellow`}" + "File Saved.";
}