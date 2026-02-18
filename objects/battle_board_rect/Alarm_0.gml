rect = instance_create_depth(x, y, 0, battle_board_points);
rect.listVertex = [
        [-left, -up],
        [right, -up],
        [right, down],
        [-left, down]
    ];
rect.updateDivide();