if(bounce){
var isInside = array_create(3, array_create(4, false));
var limit_index = array_create(4, 0);
var boardcount = array_length(global.boards_array);
var isContains = array_create(4, false);
var pos = [RotateAround(0, 0, width / 2, sprite_height / 2, 0, 0, angle), RotateAround(0, 0, width / 2, -sprite_height / 2, 0, 0, angle)];
var bounced = false;
for (var i = 0; i < boardcount; i++) { //遍历所有框,判断是否出框
	global.boards_array[i].isCollide = array_create(4, false);
	isContains[0] = global.boards_array[i].contains(x - pos[0][0], y - pos[0][1]);
	isContains[1] = global.boards_array[i].contains(x + pos[0][0], y + pos[0][1]);
	isContains[2] = global.boards_array[i].contains(x - pos[1][0], y - pos[1][1]);
	isContains[3] = global.boards_array[i].contains(x + pos[1][0], y + pos[1][1]);
	if (isContains[0]) {
		global.boards_array[i].isCollide[0] = true;
		isInside[global.boards_array[i].cover][0] = true;
		isInside[2 - global.boards_array[i].cover][0] = isInside[1][0] || isInside[2 - global.boards_array[i].cover][0];
		if (global.boards_array[i].cover) isInside[2][0] = false;
	}
	if (isContains[1]) {
		global.boards_array[i].isCollide[1] = true;
		isInside[global.boards_array[i].cover][1] = true;
		isInside[2 - global.boards_array[i].cover][1] = isInside[1][1] || isInside[2 - global.boards_array[i].cover][1];
		if (global.boards_array[i].cover) isInside[2][1] = false;
	}
	if (isContains[2]) {
		global.boards_array[i].isCollide[2] = true;
		isInside[global.boards_array[i].cover][2] = true;
		isInside[2 - global.boards_array[i].cover][2] = isInside[1][2] || isInside[2 - global.boards_array[i].cover][2];
		if (global.boards_array[i].cover) isInside[2][2] = false;
	}
	if (isContains[3]) {
		global.boards_array[i].isCollide[3] = true;
		isInside[global.boards_array[i].cover][3] = true;
		isInside[2 - global.boards_array[i].cover][3] = isInside[1][3] || isInside[2 - global.boards_array[i].cover][3];
		if (global.boards_array[i].cover) isInside[2][3] = false;
	}
	if (!global.boards_array[i].cover)
		for (var j = 0; j < 4; j++) {
			if (!isContains[j] && isInside[1][j] && !array_equals(global.boards_array[i].isCollide, [false, false, false, false])) {
				limit_index[j] = i;
			}
		}
}

if (!(isInside[2][0] || isInside[2][1] || isInside[2][2] || isInside[2][3])) {
	if (isInside[1][0]) {
		bounced = true;
	}

	if (isInside[1][1]) {
		bounced = true;
	}

	if (isInside[1][2]) {
		bounced = true;
	}

	if (isInside[1][3]) {
		bounced = true;
	}
}
if ((isInside[2][0] || isInside[2][1] || isInside[2][2] || isInside[2][3]) && (isInside[1][0] && isInside[1][1] && isInside[1][2] && isInside[1][3])) {
	if (!isInside[2][0]) {
		bounced = true;

	}

	if (!isInside[2][1]) {
		bounced = true;

	}

	if (!isInside[2][2]) {
		bounced = true;
	}

	if (!isInside[2][3]) {
		bounced = true;
	}
}
if (!isInside[0][0]) {
	bounced = true;
}

if (!isInside[0][1]) {
	bounced = true;
}

if (!isInside[0][2]) {
	bounced = true;
}

if (!isInside[0][3]) {
	bounced = true;
}
if (bounced) {
	vspeed = -vspeed;
	hspeed = -hspeed;
}
}