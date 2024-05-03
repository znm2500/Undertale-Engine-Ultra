



if (enable)
{
    anglex += angxs
    angley += angys
    anglez += angzs
    update_vert()
    for (i = 0; i < ds_list_size(edge_list); i++)
    {
        var _prop = ds_list_find_value(edge_list, i)
        var x1 = ds_list_find_value(ds_list_find_value(vert_list_draw, ds_list_find_value(_prop, 0)), 0)
        var y1 = ds_list_find_value(ds_list_find_value(vert_list_draw, ds_list_find_value(_prop, 0)), 1)
        var z1 = ds_list_find_value(ds_list_find_value(vert_list_draw, ds_list_find_value(_prop, 0)), 2)
        var x2 = ds_list_find_value(ds_list_find_value(vert_list_draw, ds_list_find_value(_prop, 1)), 0)
        var y2 = ds_list_find_value(ds_list_find_value(vert_list_draw, ds_list_find_value(_prop, 1)), 1)
        var z2 = ds_list_find_value(ds_list_find_value(vert_list_draw, ds_list_find_value(_prop, 1)), 2)
        var _bone = ds_list_find_value(_prop, 2)
        if instance_exists(_bone)
        {
            var len3 = point_distance_3d(x1, y1, z1, x2, y2, z2)
            _bone.x = (x + ((x1 + x2) / 2))
            _bone.y = (y + ((y1 + y2) / 2))
            _bone.length = max(0,(point_distance(x1, y1, x2, y2) +10-gap) - (len3 / ((abs((z1 - z2)) / 50) + 5)))
            _bone.angle = point_direction(x1, y1, x2, y2)
            _bone.type = type
            _bone.out = out
        }
    }

}
