/// @description
event_inherited();


if time == 10 {
	BlueSoulControl(DIR.DOWN)
	a_array = []
}

if time >= 10 and time % 50 == 0 {
	var aa = Battle_MakePlatform(576, random_range(320+30, 320-40), 30, 0, -1, 0, 1)
	Battle_MakeBoneBottom(576, 50-(aa.y-320), -1, 0, 0, 0, 1)
	var a = Battle_MakeBoneTop(576, 40+(aa.y-320), -1, 0, 0, 0, 1)
	array_insert(a_array, array_length(a_array), a)
}

if time >= 10 {
	for (var i=0;i<array_length(a_array);i++){
		var a = a_array[i]
		//a.x -= 2
	}
}

if time == 120 {
	//battle_soul_blue.dir = DIR.DOWN
}