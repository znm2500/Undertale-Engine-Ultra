/// @param start_point_x
/// @param start_point_y
/// @param last_point_x
/// @param last_point_y
function scr_bezier_create(_sx,_sy,_lx,_ly)
{
	var bezier = {};
	bezier[$ "startPoint"]=[_sx,_sy];
	bezier[$ "lastPoint"]=[_lx,_ly];
	// 起始点/终点位置
	
	bezier[$ "points"]=[];
	// 多个控制点位置
	
	return(bezier);
}
// 创建一个贝塞尔曲线