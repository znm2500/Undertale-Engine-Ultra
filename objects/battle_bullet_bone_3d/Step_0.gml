if (enable) {
    angle += rotate;
    anglex += angxs;  
    angley += angys;  
    anglez += angzs;
    update_vert();
    
    for (var i = 0; i < array_length(edge_list); i++) {
        var _prop = edge_list[i];
        
        // 获取 x1, y1, z1
        var vert_index1 = _prop[0]; // 取出索引
        var vert1 = vert_list_draw[vert_index1]; // 获取 vert_list_draw 中的对应顶点
        var x1 = vert1[0];
        var y1 = vert1[1];
        var z1 = vert1[2];

        // 获取 x2, y2, z2
        var vert_index2 = _prop[1]; // 取出索引
        var vert2 = vert_list_draw[vert_index2]; // 获取 vert_list_draw 中的对应顶点
        var x2 = vert2[0];
        var y2 = vert2[1];
        var z2 = vert2[2];

        // 获取 _bone
        var _bone = _prop[2];

        if (instance_exists(_bone) ) {
            var len3 = point_distance_3d(x1, y1, z1, x2, y2, z2);
            
            //设置 _bone 的位置和属性
            _bone.x = (x + ((x1 + x2) / 2));  
            _bone.y = (y + ((y1 + y2) / 2));  
            _bone.depth = (depth + ((z1 + z2) / 2));                       
            _bone.length = max(0, (point_distance(x1, y1, x2, y2) + 10 - gap) - (len3 / ((abs((z1 - z2)) / 50) + 5)));  
            _bone.angle = point_direction(x1, y1, x2, y2);  
            _bone.type = type;   
            _bone.out = out;  
        }  
    }  
}
