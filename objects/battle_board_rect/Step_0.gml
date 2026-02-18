angle += rotate;

if (instance_exists(rect)) {
    // 直接重新赋值数组，这会自动覆盖旧数据并触发内存回收
    rect.listVertex = [
        [-left, -up],
        [right, -up],
        [right, down],
        [-left, down]
    ];
    
    rect.angle = angle;
    rect.x = x;
    rect.y = y;
    rect.rect = 1;
    rect.cover = cover;
    rect.board_depth = board_depth;
    
    // 调用重构后的 updateDivide
    rect.updateDivide();
}