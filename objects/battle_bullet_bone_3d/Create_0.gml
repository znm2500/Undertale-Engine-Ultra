enum SHAPE {
    CUBE = 0,
    REGULAR_TETRAHEDRON = 1,
    REGULAR_OCTAHEDRON = 2,
    REGULAR_DODECAHEDRON = 3,
    REGULAR_ICOSAHEDRON = 4
}
depth = DEPTH_BATTLE.BULLET_OUTSIDE_LOW;
enable = 0;
vert_list = ds_list_create();
vert_list_draw = ds_list_create();
edge_list = ds_list_create();
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
duration = -1;
type = 0;
gap = 40;
alarm[0] = duration;

add_vert = function(argument0, argument1, argument2, argument3) // 添加顶点坐标
{
    if (argument3 == undefined)
        argument3 = vert_list;
    var _prop = ds_list_create();
    ds_list_add(_prop, argument0);
    ds_list_add(_prop, argument1);
    ds_list_add(_prop, argument2);
    ds_list_add(argument3, _prop);
    return;
}

update_vert = function()
{
    ds_list_clear(vert_list_draw);
    for (var i = 0; i < ds_list_size(vert_list); i++)
    {
        _prop = ds_list_find_value(vert_list, i);
        var X = ds_list_find_value(_prop, 0);
        var Y = ds_list_find_value(_prop, 1);
        var Z = ds_list_find_value(_prop, 2);
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

add_edge = function(argument0, argument1) // 添加边（不同点的序列）
{
    _prop = ds_list_create();
    ds_list_set(_prop, 0, argument0);
    ds_list_set(_prop, 1, argument1);
    ds_list_set(_prop, 2, Battle_MakeBone(900, 900, 0, 0, 0, type, out, 0, 0, 0, -1));
    ds_list_add(edge_list, _prop);
    return;
}
