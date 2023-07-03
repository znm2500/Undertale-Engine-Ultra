///@arg number,point,type,out,roting,rot,extra_angle,x,y,size_x,size_y,length,rott
function Makebonecircle(){
	var Number=argument[0]
	var Size=argument[1]
	var Type=argument[2]
	var Out=argument[3]
	var Enable=argument[4]
	var Rot=argument[5]
var Ex=argument[6]
var X=argument[7]
var Y=argument[8]
var H=argument[9]
var V=argument[10]
var L=argument[11]
var II=argument[12]

bone=instance_create_depth(X,Y,0,bone_circle)
bone.number=Number
bone.type=Type
bone.point=Size
bone.out=Out
bone.roting=Enable
bone.extra_angle=Ex
bone.rot=Rot
bone.size_x=H
bone.size_y=V
bone.length=L
bone.rott=II
return bone
}