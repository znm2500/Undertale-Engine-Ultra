function Bezier_Init() {
	enum BEZIER_COMPONENT {
		X = 0,
			Y = 1
	}
	global._bezier_data = [];
}

function Bezier_Uninit() {
	if (is_array(global._bezier_data)) {
		var i = 0;
		repeat(array_length(global._bezier_data)) {
			delete(global._bezier_data[i++]);
		};
		delete(global._bezier_data);
		return (true);
	}
}

function Bezier_CreateStruct(start_x, start_y, last_x, last_y) {
	var bezier = {};
	bezier[$ "startPoint"] = [start_x, start_y];
	bezier[$ "lastPoint"] = [last_x, last_y];
	bezier[$ "points"] = [];
	return bezier;
}

function Bezier_PointNumber(bezier) {
	return (array_length(bezier[$ "points"]) + 2);
}

function Bezier_AddPoint(bezier, x, y) {
	return (array_push(bezier[$ "points"], [x, y]));
}

function Bezier_GetValue(bezier, step) {
	var startPoint = bezier[$ "startPoint"];
	var lastPoint = bezier[$ "lastPoint"];
	var points = bezier[$ "points"];
	// 获取数据
	var allPoints = [];
	allPoints[0] = startPoint; // 添加第一个点的位置
	allPoints = array_concat(allPoints, points); // 数组链接(旧版本可以自己写一个数组连接函数)
	array_push(allPoints, lastPoint); // 添加第末尾点的位置
	// 得到要计算的所有点位置
	var normalization = step / 100; // 计算归一化百分比
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
	for (var i = 0; i < array_length(global._bezier_data); i++) {
		var bezier_item = global._bezier_data[i];
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
	var ease_list = global._bezier_data;
	var success = false;
	for (var i = 0; i < array_length(ease_list); i++) {
		var bezier_item = ease_list[i];
		if (var_name == undefined) {
			if (target == bezier_item[$ "target"]) {
				delete(bezier_item);
				array_delete(ease_list, i, 1);
				success = true;
			}
		} else if (var_name == bezier_item[$ "var_name"] && target == bezier_item[$ "target"]) {
			delete(bezier_item);
			array_delete(ease_list, i, 1);
			success = true;
		}
	}
	return (success);
}

function Bezier_Delete_Point(bezier, index) {
	if (index < 0) {
		return (-1);
	}
	return (array_delete(bezier[$ "points"], index, 1));
}

function Bezier_Create(target, var_name, tween_type, ease_type, start, change, duration, delay = 0, auto_destroy = 1, single_speed = 1, alone_exist = 0) {
	if (duration < 0) {
		duration = -duration;
	} else if (duration == 0) {
		duration = 1;
	}
	if (delay < 0) {
		delay = -delay;
	}
	if (alone_exist) {
		for (var i = 0; i < array_length(global._bezier_data); i++) {
			var bezier_item = global._bezier_data[i];
			if (bezier_item[$ "target"] == target && bezier_item[$ "var_name"] == var_name && bezier_item[$ "delay"] == delay) {
				Bezier_Destroy(target, var_name);
				break;
			}
		}
	}
	if (variable_global_exists(var_name)) {
		ds_list_add(global._bezier_data, {
			target_type: 0,
			target: global,
			var_name: string(var_name),
			bezier_struct: bezier_struct,
			component: component,
			tweenstart: start,
			change: change,
			duration: duration,
			delay: delay,
			auto_destroy: auto_destroy,
			single_speed: single_speed,
			time: 0
		});
	} else if (is_struct(target)) {
		if (variable_struct_exists(target, var_name)) {
			ds_list_add(global._bezier_data, {
				target_type: 1,
				target: target,
				var_name: string(var_name),
				bezier_struct: bezier_struct,
				component: component,
				tweenstart: start,
				change: change,
				duration: duration,
				delay: delay,
				auto_destroy: auto_destroy,
				single_speed: single_speed,
				time: 0
			});
			return (true);
		}
	} else if (is_array(target)) {
		if (var_name > -1 && array_length(target) > var_name) {
			ds_list_add(global._bezier_data, {
				target_type: 2,
				target: target,
				var_name: var_name,
				bezier_struct: bezier_struct,
				component: component,
				tweenstart: start,
				change: change,
				duration: duration,
				delay: delay,
				auto_destroy: auto_destroy,
				single_speed: single_speed,
				time: 0
			});
			return (true);
		}
	} else if (object_exists(target)) {
		if (variable_instance_exists(target, var_name)) {
			ds_list_add(global._bezier_data, {
				target_type: 3,
				target: target,
				var_name: string(var_name),
				bezier_struct: bezier_struct,
				component: component,
				tweenstart: start,
				change: change,
				duration: duration,
				delay: delay,
				auto_destroy: auto_destroy,
				single_speed: single_speed,
				time: 0
			});
		}
		return (true);
	} else if (ds_exists(target, ds_type_list)) {

		if (var_name > -1 && array_length(target) > var_name) {
			ds_list_add(global._bezier_data, {
				target_type: 4,
				target: target,
				var_name: var_name,
				bezier_struct: bezier_struct,
				component: component,
				tweenstart: start,
				change: change,
				duration: duration,
				delay: delay,
				auto_destroy: auto_destroy,
				single_speed: single_speed,
				time: 0
			});
			return (true);
		}

	} else if (ds_exists(target, ds_type_map)) {

		if (ds_map_exists(target, var_name)) {
			ds_list_add(global._bezier_data, {
				target_type: 5,
				target: target,
				var_name: string(var_name),
				bezier_struct: bezier_struct,
				component: component,
				tweenstart: start,
				change: change,
				duration: duration,
				delay: delay,
				auto_destroy: auto_destroy,
				single_speed: single_speed,
				time: 0
			});
			return (true);
		}

	} else if (ds_exists(target, ds_type_grid)) {
		if (is_string(var_name)) var_name = string_split(var_name, ",");
		if (var_name[0] > -1 && ds_grid_width(target) > var_name[0] && var_name[1] > -1 && ds_grid_height(target) > var_name[1]) {
			ds_list_add(global._bezier_data, {
				target_type: 6,
				target: target,
				var_name: var_name,
				bezier_struct: bezier_struct,
				component: component,
				tweenstart: start,
				change: change,
				duration: duration,
				delay: delay,
				auto_destroy: auto_destroy,
				single_speed: single_speed,
				time: 0
			});
			return (true);
		} else if (instance_exists(target)) {
			if (variable_instance_exists(target, var_name)) {
				ds_list_add(global._bezier_data, {
					target_type: 7,
					target: target,
					var_name: string(var_name),
					bezier_struct: bezier_struct,
					component: component,
					tweenstart: start,
					change: change,
					duration: duration,
					delay: delay,
					auto_destroy: auto_destroy,
					single_speed: single_speed,
					time: 0
				});
			}
			return (true);
		}
	}
	return (false);
}

function Bezier_Step() {
	var ease_list = global._bezier_data;
	for (var i = 0; i < array_length(ease_list); i++) {
		var bezier_item = ease_list[i];
		bezier_item[$ "time"] += bezier_item[$ "single_speed"] * global.bezier_speed;
		if ((bezier_item[$ "time"] > bezier_item[$ "duration"] + bezier_item[$ "delay"] || bezier_item[$ "time"] < 0) && bezier_item[$ "auto_destroy"]) {
			delete(bezier_item);
			array_delete(ease_list, i--, 1);
			continue;
		}
		if (bezier_item[$ "time"] - bezier_item[$ "delay"] >= 0) {
			var bezier_value = Bezier_GetValue(bezier_item[$ "bezier_struct"], min((bezier_item[$ "time"] - bezier_item[$ "delay"]) / bezier_item[$ "duration"], 1) * 100);
			var bezier_value = bezier_value[bezier_item[$ "component"]];

			switch (bezier_item[$ "target_type"]) {
				case 0: {
					variable_global_set(bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 1: {
					variable_struct_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 2: {
					array_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 3: {
					with(bezier_item[$ "target"])
					variable_instance_set(id, bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 4: {
					ds_list_replace(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 5: {
					ds_map_replace(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 6: {
					if (is_string(bezier_item[$ "var_name"])) var var_name = string_split(bezier_item[$ "var_name"], ",");
					else if (is_array(bezier_item[$ "var_name"])) var var_name = bezier_item[$ "var_name"];
					ds_grid_set(bezier_item[$ "target"], var_name[0], var_name[1], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 7: {
					variable_instance_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_value * bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				default: {
					delete(bezier_item);
					array_delete(ease_list, i, 1);
					break;
				}
			}

		}
	}
	return (true);
}

function Bezier_Skip(target, var_name) {
	var ease_list = global._bezier_data;
	var success = false;
	for (var i = 0; i < array_length(ease_list); i++) {
		var bezier_item = ease_list[i];
		if (var_name == undefined) {
			if (target == bezier_item[$ "target"]) {
				switch (bezier_item[$ "target_type"]) {
					case 0: {
						variable_global_set(bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
						break;
					}
					case 1: {
						variable_struct_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
						break;
					}
					case 2: {
						array_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
						break;
					}
					case 3: {
						variable_instance_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
						break;
					}
					case 4: {
						ds_list_replace(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
						break;
					}
					case 5: {
						ds_map_replace(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
						break;
					}
					case 6: {
						if (is_string(bezier_item[$ "var_name"])) var var_names = string_split(bezier_item[$ "var_name"], ",");
						else if (is_array(bezier_item[$ "var_name"])) var var_names = bezier_item[$ "var_name"];
						ds_grid_set(bezier_item[$ "target"], var_names[0], var_names[1], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
						break;
					}
					case 7: {
						variable_instance_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
						break;
					}
					default: {
						delete(bezier_item);
						array_delete(ease_list, i, 1);
						break;
					}
				}
				delete(bezier_item);
				array_delete(ease_list, i, 1);
				success = true;
			}
		} else if (var_name == bezier_item[$ "var_name"] && target == bezier_item[$ "target"]) {
			switch (bezier_item[$ "target_type"]) {
				case 0: {
					variable_global_set(bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 1: {
					variable_struct_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 2: {
					array_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 3: {
					variable_instance_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 4: {
					ds_list_replace(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 5: {
					ds_map_replace(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 6: {
					if (is_string(bezier_item[$ "var_name"])) var var_names = string_split(bezier_item[$ "var_name"], ",");
					else if (is_array(bezier_item[$ "var_name"])) var var_names = bezier_item[$ "var_name"];
					ds_grid_set(bezier_item[$ "target"], var_names[0], var_names[1], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				case 7: {
					variable_instance_set(bezier_item[$ "target"], bezier_item[$ "var_name"], bezier_item[$ "change"] + bezier_item[$ "tweenstart"]);
					break;
				}
				default: {
					delete(bezier_item);
					array_delete(ease_list, i, 1);
					break;
				}
			}
			delete(bezier_item);
			array_delete(ease_list, i, 1);
			success = true;
		}
	}
	return (success);
}

function Bezier_SetSingleSpeed(target, var_name, single_speed) {
	var ease_list = global._bezier_data;
	var success = false;
	for (var i = 0; i < array_length(ease_list); i++) {
		var bezier_item = ease_list[i];
		if (var_name == undefined) {
			if (target == bezier_item[$ "target"]) {
				bezier_item[$ "single_speed"] = single_speed;
				success = true;
			}
		} else if (var_name == bezier_item[$ "var_name"] && target == bezier_item[$ "target"]) {
			bezier_item[$ "single_speed"] = single_speed;
			success = true;
		}
	}

	return (success);
}