//Modified from Hardmode Sans by Siki
depth=DEPTH_BATTLE.BULLET_OUTSIDE_LOW
vert_list=ds_list_create()
vert_list_draw=ds_list_create()
edge_list=ds_list_create()
anglex=0
angley=0
anglez=0
angxs=0
angys=0
angzs=0
scalex=0
scaley=0
scalez=0
obj=battle_bullet_bone

add_vert = function(argument0, argument1, argument2, argument3) //gml_Script_add_vert_gml_Object_obj_cube_Create_0
{
    if (argument3 == undefined)
        argument3 = vert_list
    var _prop = ds_list_create()
    ds_list_add(_prop, argument0)
    ds_list_add(_prop, argument1)
    ds_list_add(_prop, argument2)
    ds_list_add(argument3, _prop)
    return;
}

update_vert = function() //gml_Script_update_vert_gml_Object_obj_cube_Create_0
{
    ds_list_clear(vert_list_draw)
    for (var i = 0; i < ds_list_size(vert_list); i++)
    {
        _prop = ds_list_find_value(vert_list, i)
        var X = ds_list_find_value(_prop, 0)
        var Y = ds_list_find_value(_prop, 1)
        var Z = ds_list_find_value(_prop, 2)
        X *= scalex
        Y *= scaley
        Z *= scalez
        var YY = ((Y * dcos(anglex)) - (Z * dsin(anglex)))
        var ZZ = ((Y * dsin(anglex)) + (Z * dcos(anglex)))
        Y = YY
        Z = ZZ
        ZZ = ((Z * dcos(angley)) - (X * dsin(angley)))
        var XX = ((Z * dsin(angley)) + (X * dcos(angley)))
        Z = ZZ
        X = XX
        XX = ((X * dcos(anglez)) - (Y * dsin(anglez)))
        YY = ((X * dsin(anglez)) + (Y * dcos(anglez)))
        X = XX
        Y = YY
        self.add_vert(X, Y, Z, vert_list_draw)
    }
    return;
}

add_edge = function(argument0, argument1) //gml_Script_add_edge_gml_Object_obj_cube_Create_0
{
    _prop = ds_list_create()
    ds_list_set(_prop, 0, argument0)
    ds_list_set(_prop, 1, argument1)
    ds_list_set(_prop, 2, Battle_MakeBone(900, 900, 0, 0, 0, 0, 1, 0, 0, 0,-1,obj,spr_body,spr_end))
    ds_list_add(edge_list, _prop)
    return;
}

len = 0.3
add_vert(1, 1, 1)
add_vert(1, 1, -1)
add_vert(1, -1, 1)
add_vert(1, -1, -1)
add_vert(-1, 1, 1)
add_vert(-1, 1, -1)
add_vert(-1, -1, 1)
add_vert(-1, -1, -1)
add_edge(0, 1)
add_edge(0, 2)
add_edge(0, 4)
add_edge(1, 3)
add_edge(1, 5)
add_edge(2, 3)
add_edge(2, 6)
add_edge(3, 7)
add_edge(4, 5)
add_edge(4, 6)
add_edge(5, 7)
add_edge(6, 7)
update_vert()