///@arg x,y,scale,hspeed,vspeed,type,out,angle
function Makefire(){
var obj=fire
var X=argument[0]
var Y=argument[1]
var SCALE=argument[2]
var HSPEED=argument[3]
var VSPEED=argument[4]
var COLOR=argument[5]
var OUT=argument[6]
var ANGLE=argument[7]
var jk=instance_create_depth(X,Y,0,obj)
jk.out=OUT
jk.image_xscale=SCALE
jk.image_yscale=SCALE
jk.hspeed=HSPEED
jk.vspeed=VSPEED
jk.image_angle=ANGLE
jk.type=COLOR
return jk
}