///@desc Update Position
if (x != xprevious || y != yprevious || _angle_previous != _angle) {
    // 重新计算当前打字机的方向单位向量
    var X_UNIT = [lengthdir_x(1, _angle * (_type_dir == 0 ? 1 : -1)), lengthdir_y(1, _angle * (_type_dir == 0 ? 1 : -1))];
    var Y_UNIT = [lengthdir_x(1, (_angle - 90) * (_type_dir == 0 ? 1 : -1)), lengthdir_y(1, (_angle - 90) * (_type_dir == 0 ? 1 : -1))];
    
    // --- 遍历字符数据数组 ---
    var _len = array_length(_char_data_list);
    for (var i = 0; i < _len; i++) {
        var char_data = _char_data_list[i];
        
        // 更新旋转角度（如果开启了角度跟随）
        if (_angle_follow) {
            char_data.angle = _angle;
        }
        
        // 更新单位向量（用于计算字符在旋转后的相对位置）
        char_data._xUnit = X_UNIT;
        char_data._yUnit = Y_UNIT;
        
        // 如果开启了位置跟随，调用 CharUpdate 更新该字符的最终渲染坐标
        if (_position_follow) {
            CharUpdate(char_data);
        }
    }
    
    // 处理自带头像的跟随逻辑
    if (instance_exists(_face) && !_face_linked) {
        // 头像坐标随父对象偏移
        _face.x += (x - xprevious);
        _face.y += (y - yprevious);
        _face.image_angle = _angle;
    }

    // 记录上一帧的角度，以便下次对比
    _angle_previous = _angle;
}