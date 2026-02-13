if (!enable) {
    var phi = ((1 + sqrt(5)) / 2);
    
    switch (shape) {
        case 0:
            add_vert(1, 1, 1);
            add_vert(1, 1, -1);
            add_vert(1, -1, 1);
            add_vert(1, -1, -1);
            add_vert(-1, 1, 1);
            add_vert(-1, 1, -1);
            add_vert(-1, -1, 1);
            add_vert(-1, -1, -1);
            add_edge(0, 1);
            add_edge(0, 2);
            add_edge(0, 4);
            add_edge(1, 3);
            add_edge(1, 5);
            add_edge(2, 3);
            add_edge(2, 6);
            add_edge(3, 7);
            add_edge(4, 5);
            add_edge(4, 6);
            add_edge(5, 7);
            add_edge(6, 7);
            break;
        
        case 1:
            add_vert(((-2 * sqrt(2)) / 3), 0, -1/3);
            add_vert((sqrt(2) / 3), (sqrt(6) / 3), -1/3);
            add_vert((sqrt(2) / 3), ((-sqrt(6)) / 3), -1/3);
            add_vert(0, 0, 1);
            add_edge(0, 1);
            add_edge(0, 2);
            add_edge(0, 3);
            add_edge(1, 2);
            add_edge(1, 3);
            add_edge(3, 2);
            break;
        
        case 2:
            add_vert(0, 1, 0);
            add_vert(0, 0, 1);
            add_vert(0, 0, -1);
            add_vert(1, 0, 0);
            add_vert(-1, 0, 0);
            add_vert(0, -1, 0);
            add_edge(0, 1);
            add_edge(0, 2);
            add_edge(0, 3);
            add_edge(0, 4);
            add_edge(5, 1);
            add_edge(5, 2);
            add_edge(5, 3);
            add_edge(5, 4);
            break;

        case 3:
            add_vert(1, 1, 1);
            add_vert(1, 1, -1);
            add_vert(-1, 1, 1);
            add_vert(-1, 1, -1);
            add_vert((1 / phi), phi, 0);
            add_vert((-1 / phi), phi, 0);
            add_vert(0, (1 / phi), phi);
            add_vert(0, (1 / phi), (-phi));
            add_vert(phi, 0, (1 / phi));
            add_vert((-phi), 0, (1 / phi));
            add_vert(phi, 0, (-1 / phi));
            add_vert((-phi), 0, (-1 / phi));
            add_vert(1, -1, 1);
            add_vert(1, -1, -1);
            add_vert(-1, -1, 1);
            add_vert(-1, -1, -1);
            add_vert(0, (-1 / phi), phi);
            add_vert(0, (-1 / phi), (-phi));
            add_vert((1 / phi), (-phi), 0);
            add_vert((-1 / phi), (-phi), 0);
            add_edge(4, 5);
            add_edge(0, 4);
            add_edge(1, 4);
            add_edge(2, 5);
            add_edge(3, 5);
            add_edge(0, 6);
            add_edge(2, 6);
            add_edge(1, 7);
            add_edge(3, 7);
            add_edge(6, 16);
            add_edge(7, 17);
            add_edge(0, 8);
            add_edge(1, 10);
            add_edge(2, 9);
            add_edge(3, 11);
            add_edge(8, 10);
            add_edge(9, 11);
            add_edge(8, 12);
            add_edge(9, 14);
            add_edge(10, 13);
            add_edge(11, 15);
            add_edge(12, 16);
            add_edge(13, 17);
            add_edge(14, 16);
            add_edge(15, 17);
            add_edge(18, 19);
            add_edge(12, 18);
            add_edge(13, 18);
            add_edge(14, 19);
            add_edge(15, 19);
            break;

        case 4:
            var points = [
                [0, 1, phi], 
                [0, -1, phi], 
                [0, 1, (-phi)], 
                [0, -1, (-phi)], 
                [1, phi, 0], 
                [-1, phi, 0], 
                [1, (-phi), 0], 
                [-1, (-phi), 0], 
                [phi, 0, 1], 
                [(-phi), 0, 1], 
                [phi, 0, -1], 
                [(-phi), 0, -1]
            ];
            
            for (var i = 0; i < 12; i++) {
                var xx = points[i][0];
                var yy = points[i][1];
                var z = points[i][2];
                add_vert(xx, yy, z);
            }

            var p = 0;
            repeat(4) {
                add_edge(p, (p + 1));
                p += 2;
            }
            add_edge(4, 0);
            add_edge(4, 2);
            add_edge(4, 8);
            add_edge(4, 10);
            add_edge(5, 0);
            add_edge(5, 2);
            add_edge(5, 9);
            add_edge(5, 11);
            add_edge(6, 1);
            add_edge(6, 3);
            add_edge(6, 8);
            add_edge(6, 10);
            add_edge(7, 1);
            add_edge(7, 3);
            add_edge(7, 9);
            add_edge(7, 11);
            add_edge(0, 8);
            add_edge(0, 9);
            add_edge(1, 8);
            add_edge(1, 9);
            add_edge(2, 10);
            add_edge(2, 11);
            add_edge(3, 10);
            add_edge(3, 11);
            add_edge(8, 10);
            add_edge(9, 11);
            break;
    }
    
    alarm[1] = duration; // 设置警报
    update_vert();       // 更新顶点
    enable = 1;         // 启用标志
}
