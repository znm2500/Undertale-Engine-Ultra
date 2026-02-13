/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event

event_inherited();
type=0
length=50
scale=0.4
extra_angle=30
out=0
duration=-1
b[0]=Battle_MakeBone(x,y,length,hspeed,vspeed,type,out,angle,0,0)
b[0].point=1
b[1]=Battle_MakeBone(x,y,length*scale,hspeed,vspeed,type,out,angle+extra_angle,0,0)
b[1].point=1
b[2]=Battle_MakeBone(x,y,length*scale,hspeed,vspeed,type,out,angle-extra_angle,0,0)
b[2].point=1
