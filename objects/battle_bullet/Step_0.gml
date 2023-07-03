
if(follow){xx+=hs
	yy+=vs
angle=_angle+battle_board.angle
dis=point_distance(xx,yy,320,320)
_angle+=rotate
x=battle_board.x-lengthdir_x(dis,point_direction(xx,yy,320,320)+battle_board.angle)
y=battle_board.y-lengthdir_y(dis,point_direction(xx,yy,320,320)+battle_board.angle)}
else{xx=x
	yy=y
	angle += rotate
	}
if(place_meeting(x,y,battle_soul)){
	Battle_CallSoulEventBulletCollision();
}

