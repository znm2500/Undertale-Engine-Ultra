///@arg x,y,length,hspeed,vspeed,type,out,angle,rotate,auto_destroy,*duration
function Battle_MakeBone(){
	var OBJ = battle_bullet_bone
    var X = argument[0]
    var Y = argument[1]
    var LENGTH = argument[2]
    var HSPEED = argument[3]
    var VSPEED = argument[4]
    var COLOR = argument[5]
    var OUT = argument[6]
    var ANGLE = argument[7]
    var ROT = argument[8]
    var DESTROY = argument[9]
    var DURATION = -1
    if (argument_count >= 11)
        DURATION = argument[10]
    if (argument_count >= 12)
        OBJ = argument[11]
    var bone = instance_create_depth(X, Y, 0, OBJ)
    bone.length = LENGTH
    bone.hspeed = HSPEED
    bone.vspeed = VSPEED
    bone.type = COLOR
    bone.out = OUT
    bone.rotate = ROT
    bone.auto_destroy = DESTROY
    bone.angle = ANGLE
	bone._angle = ANGLE
    bone.duration = DURATION
   
    return bone;
}
