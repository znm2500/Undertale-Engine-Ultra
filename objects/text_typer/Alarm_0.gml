auto_destroy = true; // 使用布尔值更直观
var allAutoDestroy = true;

// 遍历所有 text_typer 实例
with(text_typer) {
    if (!auto_destroy) {
        allAutoDestroy = false;
        // 只要发现一个不需要自动销毁的，就跳出
        break; 
    }
}

// 注意：在 GML 中判断相等建议用 ==，赋值用 =
if (allAutoDestroy == true) {
    // 统一清理数组占用的内存（虽然 GC 会处理，但这是好习惯）
    with(text_typer) {
        _char_data_list = [];
        _list_cmd = [];
        instance_destroy();
    }
}