///@desc New Line
_char_x = 0;

draw_set_font(_group_font[_font, 0]);

// 计算行高逻辑
var hei_char = string_height(" ");
var hei_space = _group_font_space_y[_font] + _space_y;
var scale_y = _group_font_scale_y[_font, 0] * _scale_y;
var hei_cur = (hei_char + hei_space) * scale_y;

// 预设纵向对齐偏移参考
var former_chr_offset_dict_y = [0, hei_cur / 2, hei_cur];

// 更新当前的 Y 坐标步进
switch (_valign) {
    case 0:
        _char_y += hei_cur;
        break;
    case 1:
        _char_y += hei_cur / 2;
        break;
    case 2:
        _char_y = 0;
        break;
}

_order = 0; // 每一行重置 Order（如果你的层级逻辑是按行计算的）

var former_chr_offset_y = former_chr_offset_dict_y[_valign];

// --- 修改部分：将 ds_list 遍历改为数组遍历 ---
if (_valign != 0) {
   
    var _len = array_length(_char_data_list);
    for (var i = 0; i < _len; i++) {
        var char_data = _char_data_list[i];
        
        // 更新 Struct 中的坐标偏移
        char_data._deltaY -= former_chr_offset_y;        
        CharUpdate(char_data); 
    }
}

// 更新整体高度记录
if (height < _char_y) {
    height = _char_y;
}

_line += 1;