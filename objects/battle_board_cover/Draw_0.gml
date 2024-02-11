var vsin = dsin(-angle);
var vcos = dcos(-angle);

surface_set_target(battle_board._surface);

if (rect&&battle_board.edge) {
        var left = RotateAround(x, y, x + listVertex[|0][0], y + listVertex[|0][1], x, y, angle);
        var right = RotateAround(x, y, x + listVertex[|1][0], y + listVertex[|1][1], x, y, angle);
        var up = RotateAround(x, y, x + listVertex[|3][0], y + listVertex[|3][1], x, y, angle);
        var down = RotateAround(x, y, x + listVertex[|2][0], y + listVertex[|2][1], x, y, angle);
        draw_sprite_ext(spr_battle_board_edge, 0, left[0], left[1], 1, 1, angle, battle_board.color_frame, battle_board.alpha_frame);
        draw_sprite_ext(spr_battle_board_edge, 0, right[0], right[1], -1, 1, angle, battle_board.color_frame, battle_board.alpha_frame);
        draw_sprite_ext(spr_battle_board_edge, 0, up[0], up[1], 1, -1, angle, battle_board.color_frame, battle_board.alpha_frame);
        draw_sprite_ext(spr_battle_board_edge, 0, down[0], down[1], -1, -1, angle, battle_board.color_frame, battle_board.alpha_frame);

        for (var i = 0; i < ds_list_size(listVertex); i++) {
            var a = listVertex[|i];
            var b = listVertex[|iloop(i + 1)];

            var ax = a[0] * vcos - a[1] * vsin;
            var ay = a[0] * vsin + a[1] * vcos;
            var bx = b[0] * vcos - b[1] * vsin;
            var by = b[0] * vsin + b[1] * vcos;

            draw_sprite_ext(spr_pixel, 0, x + ax - (5 - 4 * battle_board.edge) * cos(degtorad(floor(point_direction(ax, ay, bx, by)))), y + ay + (5 - 4 * battle_board.edge) * sin(degtorad(floor(point_direction(ax, ay, bx, by)))), 5, point_distance(ax, ay, bx, by) + 5 + 5 * cos(degtorad((point_direction(ax, ay, bx, by) % 45))) - 2 * 4 * battle_board.edge, point_direction(ax, ay, bx, by) + 90, battle_board.color_frame, battle_board.alpha_frame);
    }
}
else{
var size = ds_list_size(listDivideIndex);
    for (var i = 0; i < size; i++) {	//遍历所有的三角
        var di = listDivideIndex[| i];
        draw_primitive_begin(pr_trianglelist);
        for (var j = 0; j < 3; j++) {
            var pos = listVertex_Outline[| di[j]];
            var resultx = pos[0] * vcos - pos[1] * vsin;
            var resulty = pos[0] * vsin + pos[1] * vcos;
            draw_vertex_color(x + resultx, y + resulty,battle_board.color_frame,battle_board.alpha_frame);
        }
        draw_primitive_end();
    }}

surface_reset_target();
surface_set_target(battle_board._surface1)
gpu_set_alphatestenable(0)
gpu_set_blendmode(bm_normal)
gpu_set_blendenable(false)
gpu_set_colorwriteenable(0, 0, 0, 1)
draw_set_alpha(1)
var size = ds_list_size(listDivideIndex);
    for (var i = 0; i < size; i++) {	//遍历所有的三角
        var di = listDivideIndex[| i];
        draw_primitive_begin(pr_trianglelist);
        for (var j = 0; j < 3; j++) {
            var pos = listVertex[| di[j]];
            var resultx = pos[0] * vcos - pos[1] * vsin;
            var resulty = pos[0] * vsin + pos[1] * vcos;
            draw_vertex(x + resultx, y + resulty);
        }
        draw_primitive_end();
    }
draw_set_alpha(1)
gpu_set_blendenable(true)
gpu_set_colorwriteenable(1, 1, 1, 1)
surface_reset_target()