for (var i = 0; i < array_length(edge_list); i++) {
    var _prop = edge_list[i];      // 直接通过索引访问
    var _bone = _prop[2];          // 获取骨骼对象

    if (instance_exists(_bone)) {  // 检查骨骼对象是否存在
        instance_destroy(_bone);    // 销毁骨骼对象
    }
}
