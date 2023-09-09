duration -= 1
if (duration <= 0)
{
    audio_play_sound(snd_bone_out, 0, false)
    instance_destroy()
}
xx=(x1+x2)/2
yy=(y1+y2)/2
dis=point_distance(xx,yy,320,320)
diss=abs(point_distance(xx,yy,x1,y1))

if(follow){
angle=battle_board.angle
x=battle_board.x-lengthdir_x(dis,point_direction(xx,yy,320,320)+battle_board.angle)
y=battle_board.y-lengthdir_y(dis,point_direction(xx,yy,320,320)+battle_board.angle)
}
else{x=xx
y=yy}

