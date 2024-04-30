if (Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.HP) <= 0) {
    Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_X, x - camera.x);
    Flag_Set(FLAG_TYPE.TEMP, FLAG_TEMP.GAMEOVER_SOUL_Y, y - camera.y);
    room_goto(room_gameover);
}
global.borderCount = ds_list_size(global.borders_list)
var STATE = Battle_GetState();
if (STATE == BATTLE_STATE.TURN_PREPARATION || STATE == BATTLE_STATE.IN_TURN) {
    if (instance_exists(battle_soul)) {
        var isInside1 = false;
        var isInside2 = false;
        var isInside3 = false;
        var isInside4 = false;
        var isInside1Cover = false;
        var isInside2Cover = false;
        var isInside3Cover = false;
        var isInside4Cover = false;

        for (var i = 0; i < global.borderCount; i++) {	//遍历所有框,判断是否出框
            bb = ds_list_find_value(global.borders_list, i);
            if (bb.contains(battle_soul.x - sprite_width / 2, battle_soul.y)) {
                isInside1 = true;
                break;
            }
        }
        for (var i = 0; i < global.borderCount; i++) {	//遍历所有框,判断是否出框
            bb = ds_list_find_value(global.borders_list, i);
            if (bb.contains(battle_soul.x + sprite_width / 2, battle_soul.y)) {
                isInside2 = true;
                break;
            }
        }
        for (var i = 0; i < global.borderCount; i++) {	//遍历所有框,判断是否出框
            bb = ds_list_find_value(global.borders_list, i);
            if (bb.contains(battle_soul.x, battle_soul.y - sprite_height / 2)) {
                isInside3 = true;
                break;
            }
        }
        for (var i = 0; i < global.borderCount; i++) {	//遍历所有框,判断是否出框
            bb = ds_list_find_value(global.borders_list, i);
            if (bb.contains(battle_soul.x, battle_soul.y + sprite_height / 2)) {
                isInside4 = true;
                break;
            }
        }
        var numcboard = ds_list_size(global.cover_borders_list)
        for (var i = 0; i < numcboard; i++) {    // 遍历所有框, 判断是否出框
            bb = ds_list_find_value(global.cover_borders_list, i);
            if (bb.contains(battle_soul.x - sprite_width / 2, battle_soul.y)) {
                isInside1Cover = true;
                break;
            }
        }

        for (var i = 0; i < numcboard; i++) {    // 遍历所有框, 判断是否出框
            bb = ds_list_find_value(global.cover_borders_list, i);
            if (bb.contains(battle_soul.x + sprite_width / 2, battle_soul.y)) {
                isInside2Cover = true;
                break;
            }
        }

        for (var i = 0; i < numcboard; i++) {    // 遍历所有框, 判断是否出框
            bb = ds_list_find_value(global.cover_borders_list, i);
            if (bb.contains(battle_soul.x, battle_soul.y - sprite_height / 2)) {
                isInside3Cover = true;
                break;
            }
        }

        for (var i = 0; i < numcboard; i++) {    // 遍历所有框, 判断是否出框
            bb = ds_list_find_value(global.cover_borders_list, i);
            if (bb.contains(battle_soul.x, battle_soul.y + sprite_height / 2)) {
                isInside4Cover = true;
                break;
            }
        }
	if (isInside1Cover) {    // 如果出框
            var nearestPos, nearestDis = -1;    // 最近位置和最近距离
            for (var i = 0; i < numcboard; i++) {    // 遍历所有框
                // 得到限制位置和距离
                bb = ds_list_find_value(global.cover_borders_list, i);
                var pos = bb.limit(battle_soul.x - sprite_width / 2, battle_soul.y);
                var dis = point_distance(battle_soul.x - sprite_width / 2, battle_soul.y, pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) {    // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
            battle_soul.x = nearestPos[0] + sprite_width / 2;
           // battle_soul.y = nearestPos[1];
        }

        if (isInside2Cover) {    // 如果出框
            var nearestPos, nearestDis = -1;    // 最近位置和最近距离
            for (var i = 0; i < numcboard; i++) {    // 遍历所有框
                // 得到限制位置和距离
                bb = ds_list_find_value(global.cover_borders_list, i);
                var pos = bb.limit(battle_soul.x + sprite_width / 2, battle_soul.y);
                var dis = point_distance(battle_soul.x + sprite_width / 2, battle_soul.y, pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) {    // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
            battle_soul.x = nearestPos[0] - sprite_width / 2;
           // battle_soul.y = nearestPos[1];
        }

        if (isInside3Cover) {    // 如果出框
            var nearestPos, nearestDis = -1;    // 最近位置和最近距离
            for (var i = 0; i < numcboard; i++) {    // 遍历所有框
                // 得到限制位置和距离
                bb = ds_list_find_value(global.cover_borders_list, i);
                var pos = bb.limit(battle_soul.x, battle_soul.y - sprite_height / 2);
                var dis = point_distance(battle_soul.x, battle_soul.y - sprite_height / 2, pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) {    // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
           // battle_soul.x = nearestPos[0];
            battle_soul.y = nearestPos[1] + sprite_height / 2;
        }

        if (isInside4Cover) {    // 如果出框
            var nearestPos, nearestDis = -1;    // 最近位置和最近距离
            for (var i = 0; i < numcboard; i++) {    // 遍历所有框
                // 得到限制位置和距离
                bb = ds_list_find_value(global.cover_borders_list, i);
                var pos = bb.limit(battle_soul.x, battle_soul.y + sprite_height / 2);
                var dis = point_distance(battle_soul.x, battle_soul.y + sprite_height / 2, pos[0], pos[1]);

                if (dis < nearestDis || nearestDis == -1) {    // 如果比其他更近
                    nearestPos = pos;
                    nearestDis = dis;
                }
            }
           // battle_soul.x = nearestPos[0];
            battle_soul.y = nearestPos[1] - sprite_height / 2;
        }
		if(!isInside1) {	//如果出框
			var nearestPos, nearestDis = -1;	//最近位置和最近距离
			for(var i = 0; i < global.borderCount; i++) {	//遍历所有框
				//得到限制位置和距离
				bb = ds_list_find_value(global.borders_list,i);
				var pos = bb.limit(battle_soul.x - sprite_width/2, battle_soul.y);
				var dis = point_distance(battle_soul.x - sprite_width/2, battle_soul.y, pos[0], pos[1]);
		
				if(dis < nearestDis || nearestDis == -1) {	//如果比其他更近
					nearestPos = pos;
					nearestDis = dis;
				}
			}
			battle_soul.x = nearestPos[0] + sprite_width/2;
			//battle_soul.y = nearestPos[1];
		}
		if(!isInside2) {	//如果出框
			var nearestPos, nearestDis = -1;	//最近位置和最近距离
			for(var i = 0; i < global.borderCount; i++) {	//遍历所有框
				//得到限制位置和距离
				bb = ds_list_find_value(global.borders_list,i);
				var pos = bb.limit(battle_soul.x + sprite_width/2, battle_soul.y);
				var dis = point_distance(battle_soul.x + sprite_width/2, battle_soul.y, pos[0], pos[1]);
		
				if(dis < nearestDis || nearestDis == -1) {	//如果比其他更近
					nearestPos = pos;
					nearestDis = dis;
				}
			}
			battle_soul.x = nearestPos[0] - sprite_width/2;
			//battle_soul.y = nearestPos[1];
		}
		if(!isInside3) {	//如果出框
			var nearestPos, nearestDis = -1;	//最近位置和最近距离
			for(var i = 0; i < global.borderCount; i++) {	//遍历所有框
				//得到限制位置和距离
				bb = ds_list_find_value(global.borders_list,i);
				var pos = bb.limit(battle_soul.x, battle_soul.y - sprite_height/2);
				var dis = point_distance(battle_soul.x, battle_soul.y - sprite_height/2, pos[0], pos[1]);
		
				if(dis < nearestDis || nearestDis == -1) {	//如果比其他更近
					nearestPos = pos;
					nearestDis = dis;
				}
			}
			//battle_soul.x = nearestPos[0];
			battle_soul.y = nearestPos[1] + sprite_height/2;
		}
		if(!isInside4) {	//如果出框
			var nearestPos, nearestDis = -1;	//最近位置和最近距离
			for(var i = 0; i < global.borderCount; i++) {	//遍历所有框
				//得到限制位置和距离
				bb = ds_list_find_value(global.borders_list,i);
				var pos = bb.limit(battle_soul.x,battle_soul.y + sprite_height/2);
				var dis = point_distance(battle_soul.x, battle_soul.y + sprite_height/2, pos[0], pos[1]);
		
				if(dis < nearestDis || nearestDis == -1) {	//如果比其他更近
					nearestPos = pos;
					nearestDis = dis;
				}
			}
			//battle_soul.x = nearestPos[0];
			battle_soul.y = nearestPos[1] - sprite_height/2;
		}
	
        
    }
}

if (Battle_GetState() == BATTLE_STATE.IN_TURN && moveable) {
    if (xprevious = x && yprevious = y) {
        global.moving = 0;
    }
	else {
        global.moving = 1;
    }
}
else {
    global.moving = 0;
}