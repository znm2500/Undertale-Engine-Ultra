var vsin = dsin(-angle);
var vcos = dcos(-angle);

surface_set_target(battle_board._surface);



if (rect) {
	if(battle_board.edge){
    var lx = x + lengthdir_x(ds_list_find_value(listVertex, 0)[0], -angle) + lengthdir_x(ds_list_find_value(listVertex, 0)[1], -angle + 90);
    var ly = y + lengthdir_x(ds_list_find_value(listVertex, 0)[1], -angle) + lengthdir_x(ds_list_find_value(listVertex, 0)[0], -angle - 90);
    var rx = x + lengthdir_x(ds_list_find_value(listVertex, 1)[0], -angle) + lengthdir_x(ds_list_find_value(listVertex, 1)[1], -angle + 90);
    var ry = y + lengthdir_x(ds_list_find_value(listVertex, 1)[1], -angle) + lengthdir_x(ds_list_find_value(listVertex, 1)[0], -angle - 90);
    var ux = x + lengthdir_x(ds_list_find_value(listVertex, 3)[0], -angle) + lengthdir_x(ds_list_find_value(listVertex, 3)[1], -angle + 90);
    var uy = y + lengthdir_x(ds_list_find_value(listVertex, 3)[1], -angle) + lengthdir_x(ds_list_find_value(listVertex, 3)[0], -angle - 90);
    var dx = x + lengthdir_x(ds_list_find_value(listVertex, 2)[0], -angle) + lengthdir_x(ds_list_find_value(listVertex, 2)[1], -angle + 90);
    var dy = y + lengthdir_x(ds_list_find_value(listVertex, 2)[1], -angle) + lengthdir_x(ds_list_find_value(listVertex, 2)[0], -angle - 90);

    draw_sprite_ext(spr_battle_board_edge, 0, lx, ly, 1, 1, angle, battle_board.color_frame, battle_board.alpha_frame);
    draw_sprite_ext(spr_battle_board_edge, 0, rx, ry, -1, 1, angle, battle_board.color_frame, battle_board.alpha_frame);
    draw_sprite_ext(spr_battle_board_edge, 0, ux, uy, 1, -1, angle, battle_board.color_frame, battle_board.alpha_frame);
    draw_sprite_ext(spr_battle_board_edge, 0, dx, dy, -1, -1, angle, battle_board.color_frame, battle_board.alpha_frame);
}
  for (var i = 0; i < ds_list_size(listVertex); i++) {
        var a = listVertex[| i];
        var b = listVertex[| iloop(i + 1)];

        var ax = a[0] * vcos - a[1] * vsin;
        var ay = a[0] * vsin + a[1] * vcos;
        var bx = b[0] * vcos - b[1] * vsin;
        var by = b[0] * vsin + b[1] * vcos;

        draw_sprite_ext(spr_pixel, 0, x + ax - (5 - 4 * rect) * cos(degtorad(floor(point_direction(ax, ay, bx, by)))), y + ay + (5 - 4 * rect) * sin(degtorad(floor(point_direction(ax, ay, bx, by)))), 5, point_distance(ax, ay, bx, by) + 5 + 5 * cos(degtorad((point_direction(ax, ay, bx, by) % 45))) - 2 * 4 * rect, point_direction(ax, ay, bx, by) + 90, battle_board.color_frame, battle_board.alpha_frame);
    }
}
else{
draw_primitive_begin(pr_trianglestrip)
for (var i = 0; i <= ds_list_size(listVertex_Outline); i++) {
    var a = listVertex_Outline[| iloop(i)];
    var ax = a[0] * vcos - a[1] * vsin;
    var ay = a[0] * vsin + a[1] * vcos;
  
draw_vertex_color(x+ax,y+ay,battle_board.color_frame,battle_board.alpha_frame)
}
draw_primitive_end()}

surface_reset_target();
draw_primitive_begin(pr_trianglestrip);
surface_set_target(battle_board._surface1)
gpu_set_alphatestenable(0)
gpu_set_blendmode(bm_normal)
gpu_set_blendenable(false)
gpu_set_colorwriteenable(0, 0, 0, 1)
draw_set_alpha(1)
for (var i = 0; i <= ds_list_size(listVertex); i++) {
    var a = listVertex[| iloop(i)];


    var ax = a[0] * vcos - a[1] * vsin;
    var ay = a[0] * vsin + a[1] * vcos;


    draw_vertex(ax + x, ay + y);
}
draw_set_alpha(1)
gpu_set_blendenable(true)
gpu_set_colorwriteenable(1, 1, 1, 1)
draw_primitive_end();
surface_reset_target()