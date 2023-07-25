event_inherited();

_distance -= _speed;
if (!follow) {
    x = battle_soul.x + lengthdir_x(_distance, _direction);
    y = battle_soul.y + lengthdir_y(_distance, _direction);
}
else{
	xx = battle_soul.x + lengthdir_x(_distance, _direction);
    yy = battle_soul.y + lengthdir_y(_distance, _direction);}
if(type&&_distance<=220&&_dir==_direction){Anim_Create(id,"_direction",ANIM_TWEEN.SINE,ANIM_EASE.IN_OUT,_direction,180,30)
}

if(abs(_distance)>range){instance_destroy()}
