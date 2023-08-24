///@desc Update Position
if(xprevious!=x||yprevious!=y||_angleprevious!=_angle){
	var CHANGE_X=x-xprevious;
	var CHANGE_Y=y-yprevious;
	var proc=0;
	repeat(ds_list_size(_list_inst)){
		var INST=ds_list_find_value(_list_inst,proc);
		var XX=ds_list_find_value(_list_inst_offset,proc).x
		var YY=ds_list_find_value(_list_inst_offset,proc).y
		if(instance_exists(INST)){
			INST.x=x+lengthdir_x(
    point_distance(0, 0, XX,YY),
    point_direction(0, 0,XX,YY) + _angle
);
INST.y=y+lengthdir_y(
    point_distance(0, 0, XX,YY),
    point_direction(0, 0,XX,YY) + _angle
);
INST.angle=_angle
		}
		proc+=1;
	}
	if(instance_exists(_face)&&!_face_linked){
		_face.x+=CHANGE_X;
		_face.y+=CHANGE_Y;
	}
	xprevious=x;
	yprevious=y;
}