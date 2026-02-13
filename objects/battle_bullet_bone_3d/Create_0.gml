enum SHAPE {
    CUBE = 0,
    REGULAR_TETRAHEDRON = 1,
    REGULAR_OCTAHEDRON = 2,
    REGULAR_DODECAHEDRON = 3,
    REGULAR_ICOSAHEDRON = 4
}

event_inherited();

depth = DEPTH_BATTLE.BULLET_OUTSIDE_LOW;
enable = 0;
vert_list = [];          // 创建一个空数组
vert_list_draw = [];    // 创建一个空数组
edge_list = [];         // 创建一个空数组
anglex = 0;
angley = 0;
anglez = 0;
angxs = 0;
angys = 0;
angzs = 0;
scalex = 0;
scaley = 0;
scalez = 0;
shape = 0;
out = 0;
type = 0;
gap = 40;

#region
add_vert = function(argument0, argument1, argument2, argument3) { // 添加顶点坐标
    if (argument3 == undefined)
        argument3 = vert_list; // 默认使用 vert_list

    var _prop = [argument0, argument1, argument2]; // 创建顶点数组
    array_push(argument3, _prop); // 将顶点数组添加到指定的顶点列表
    return;
}

update_vert = function() {
    vert_list_draw = []; // 清空 vert_list_draw
    for (var i = 0; i < array_length(vert_list); i++) {
        var _prop = vert_list[i];
        var X = _prop[0];
        var Y = _prop[1];
        var Z = _prop[2];

        X *= scalex;
        Y *= scaley;
        Z *= scalez;

        var YY = ((Y * dcos(anglex)) - (Z * dsin(anglex)));
        var ZZ = ((Y * dsin(anglex)) + (Z * dcos(anglex)));
        Y = YY;
        Z = ZZ;

        ZZ = ((Z * dcos(angley)) - (X * dsin(angley)));
        var XX = ((Z * dsin(angley)) + (X * dcos(angley)));
        Z = ZZ;
        X = XX;

        XX = ((X * dcos(anglez)) - (Y * dsin(anglez)));
        YY = ((X * dsin(anglez)) + (Y * dcos(anglez)));
        X = XX;
        Y = YY;

        self.add_vert(X, Y, Z, vert_list_draw);
    }
    return;
}

add_edge = function(argument0, argument1) { // 添加边（不同点的序列）
    var _prop = [argument0, argument1, Battle_MakeBone(900, 900, 0, 0, 0, type, out, 0, 0, 0, -1)];
    array_push(edge_list, _prop); // 将边压入 edge_list
    return;
}
#endregion
