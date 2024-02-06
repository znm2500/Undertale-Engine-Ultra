function Bezier_Init() {
	enum BEZIER_COMPONENT{
	X=0,
	Y=1
	}
	global.__bezier_data = ds_list_create()
}
function Bezier_Uninit() {
	if (ds_exists(global.__bezier_data, ds_type_list)) {
		repeat(ds_list_size(global.__bezier_data)) {
			delete(global.__bezier_data[|0]);
		};
		ds_list_destroy(global.__bezier_data);
		return (true);
	}
}
/// @param start_point_x
/// @param start_point_y
/// @param last_point_x
/// @param last_point_y
function Bezier_CreateStruct(_sx, _sy, _lx, _ly) {
	var bezier = {};
	bezier[$ "startPoint"] = [_sx, _sy];
	bezier[$ "lastPoint"] = [_lx, _ly];
	// 起始点/终点位置
	bezier[$ "points"] = [];
	// 多个控制点位置
	return (bezier);
}
/// @param bezier
function Bezier_PointNumber(_bezier) {
	return (array_length(_bezier[$ "points"]) + 2);
}
// 创建一个贝塞尔曲线
/// @param bezier
/// @param x
/// @param y
function Bezier_AddPoint(_bezier, _x, _y) {
	return (array_push(_bezier[$ "points"], [_x, _y]));
}

/// @param bezier
/// @param step
function Bezier_GetValue(_bezier, perc) {
	var startPoint = _bezier[$ "startPoint"];
	var lastPoint = _bezier[$ "lastPoint"];
	var points = _bezier[$ "points"];
	// 获取数据
	var allPoints = [];
	allPoints[0] = startPoint; // 添加第一个点的位置
	allPoints = array_concat(allPoints, points); // 数组链接(旧版本可以自己写一个数组连接函数)
	array_push(allPoints, lastPoint); // 添加第末尾点的位置
	// 得到要计算的所有点位置
	var normalization = perc / 100; // 计算归一化百分比
	var tempPoints = allPoints; // 临时点数组
	var nextTempPoints = []; // 下一维度临时点数组
	var tempPointsNumber = array_length(tempPoints); // 临时点数量
	while (tempPointsNumber > 1) {
		nextTempPoints = [];
		for (var i = 0; i < tempPointsNumber - 1; i++) {
			var point1 = tempPoints[i];
			var point2 = tempPoints[i + 1];
			// 得到点和下一个点的位置
			var nextPoint = [];
			nextPoint[0] = lerp(point1[0], point2[0], normalization);
			nextPoint[1] = lerp(point1[1], point2[1], normalization);
			// 计算两点连线下一维度的点的位置
			nextTempPoints[i] = nextPoint;
		}
		tempPointsNumber = array_length(nextTempPoints); // 得到临时点数量
		tempPoints = nextTempPoints;
	}
	return (tempPoints[0]);
}
function Bezier_IsExists(target, var_name) {
	var result = false;
	for (var i = 0; i < ds_list_size(global.__bezier_data); i++) {
		var bezier_item = ds_list_find_value(global.__bezier_data, i);
		if (var_name == undefined) {
			if (bezier_item[$ "target"] == target) {
				result = true;
				break;
			}
		} else if (bezier_item[$ "target"] == target && bezier_item[$ "var_name"] == var_name) {
			result = true;
			break;
		}
	}
	return (result);
}
function Bezier_Destroy(target, var_name) {
	var ease_list = global.__bezier_data;
	var success = false;
	if (Bezier_IsExists(target, var_name)) {
		for (var i = 0; i < ds_list_size(ease_list); i++) {
			var bezier_item = ease_list[|i];
			if (var_name == undefined) {
				if (target == bezier_item[$ "target"]) {
					ds_list_delete(ease_list, i);
					success = true;
				}
			} else if (var_name == bezier_item[$ "var_name"] && target == bezier_item[$ "target"]) {
				ds_list_delete(ease_list, i);
				success = true;
			}
		}
	}
	return (success);
}
/// @param bezier
/// @param index
function Bezier_Delete_Point(_bezier, _ind) {
	if (_ind < 0) {
		return ( - 1);
	}
	return (array_delete(_bezier[$ "points"], _ind, 1));
}
function Bezier_Create(target, var_name, bezier_struct, component, start, change, duration, delay = 0) {
	if (duration < 0) {
		duration = -duration;
	} else if (duration == 0) {
		duration = 1;
	}
	if (delay < 0) {
		delay = -delay;
	}

	for (var i = 0; i < ds_list_size(global.__bezier_data); i++) {
		var bezier_item = ds_list_find_value(global.__bezier_data, i);
		if (bezier_item[$ "target"] == target && bezier_item[$ "var_name"] == var_name && bezier_item[$ "delay"] == delay) {
			Bezier_Destroy(target, var_name) break
		}
	}

	if (variable_global_exists(var_name)) {
		ds_list_add(global.__bezier_data, {
			target_type: 0,
			target: global,
			var_name: string(var_name),
			bezier_struct: bezier_struct,
			component: component,
			tweenstart: start,
			change: change,
			duration: duration,
			delay: delay,
			time: 0
		});
	} else if (is_struct(target)) {
		if (variable_struct_exists(target, var_name)) {
			ds_list_add(global.__bezier_data, {
				target_type: 1,
				target: target,
				var_name: string(var_name),
				bezier_struct: bezier_struct,
				component: component,
				tweenstart: start,
				change: change,
				duration: duration,
				delay: delay,
				time: 0
			});
			return (true);
		}
	} else if (is_array(target)) {
		if (var_name > -1 && array_length(target) > var_name) {
			ds_list_add(global.__bezier_data, {
				target_type: 2,
				target: target,
				var_name: string(var_name),
				bezier_struct: bezier_struct,
				component: component,
				tweenstart: start,
				change: change,
				duration: duration,
				delay: delay,
				time: 0
			});
			return (true);
		}
	} else if (instance_exists(target)) {
		with(target) {
			if (variable_instance_exists(self, var_name)) {
				ds_list_add(global.__bezier_data, {
					target_type: 3,
					target: target,
					var_name: string(var_name),
					bezier_struct: bezier_struct,
					component: component,
					tweenstart: start,
					change: change,
					duration: duration,
					delay: delay,
					time: 0
				});
				return (true);
			}
		}
	}
	return (false);
}
function Bezier_Step() {
	var ease_list = global.__bezier_data;
	for (var i = 0; i < ds_list_size(ease_list); i++) {
		var bezier_item = ease_list[|i];
		if (bezier_item[$ "delay"] <= 0) {
			bezier_item[$ "time"]++;
			if (bezier_item[$ "time"] > bezier_item[$ "duration"]) {
				delete(bezier_item);
				ds_list_delete(ease_list, i);
				continue;
			}
			var bezier_value = Bezier_GetValue(bezier_item[$ "bezier_struct"], bezier_item[$ "time"] / bezier_item[$ "duration"] * 100);
			var bezier_value =bezier_value[bezier_item[$ "component"]];
//show_debug_message(bezier_value)
			switch (bezier_item[$ "target_type"]) {
			case 0:
				{
					variable_global_set(bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
			case 1:
				{
					variable_struct_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
			case 2:
				{
					array_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
			case 3:
				{
					variable_instance_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
			default:
				{
					delete(bezier_item);
					ds_list_delete(ease_list, i);
					break;
				}
			}

		} else {
			bezier_item[$ "delay"]--;
		}
	}
	return (true);
}