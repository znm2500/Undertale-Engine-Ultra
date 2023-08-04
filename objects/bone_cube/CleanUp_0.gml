for (var i = 0; i < ds_list_size(edge_list); i++)
{
    var _prop = ds_list_find_value(edge_list, i)
    var _bone = ds_list_find_value(_prop, 2)
    if instance_exists(_bone)
    {
		instance_destroy()
    }
}
