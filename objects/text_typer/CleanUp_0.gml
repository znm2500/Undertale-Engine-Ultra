text = "";


event_user(3);


_char_data_list = []; 
_list_cmd = [];


_map_macro = {}; 

// 销毁关联的 Face 实例
if (instance_exists(_face)) {
    instance_destroy(_face);
}