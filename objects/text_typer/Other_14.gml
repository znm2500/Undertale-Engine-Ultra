///@desc Update Position
if( x != xprevious || y != yprevious || _angle_previous != _angle)
{
	var INST;
	var X_UNIT = [lengthdir_x(1, _angle*(_type_dir=0 ? 1 : -1)), lengthdir_y(1, _angle*(_type_dir=0 ? 1 : -1))];
	var Y_UNIT = [lengthdir_x(1, (_angle - 90)*(_type_dir=0 ? 1 : -1)), lengthdir_y(1, (_angle - 90)*(_type_dir=0 ? 1 : -1))];
	
	for (var PROC = 0; PROC < ds_list_size(_list_inst); PROC ++){
		INST = _list_inst[| PROC];
		if instance_exists(INST)
		{
			with (INST)
			{
				if(other._angle_follow)angle = other._angle;
				if(other._position_follow)other.CharUpdate(id);
				_xUnit = X_UNIT;
				_yUnit = Y_UNIT;
				
			}
		}
	}
	
	if( instance_exists(_face) && !_face_linked)
	{
		_face.x += x - xprevious;
		_face.y += y - yprevious;
		_face.image_angle = _angle;
	}

	_angle_previous = _angle;
}
