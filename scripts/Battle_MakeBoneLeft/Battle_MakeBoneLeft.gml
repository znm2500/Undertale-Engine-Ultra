///@arg y,length,vspeed,type,out,rotate,auto_destroy,*duration,*obj,*spr_body,*spr_end
function Battle_MakeBoneLeft(){
    var Y = argument[0]
    var LENGTH = argument[1]
    var VSPEED = argument[2]
    var COLOR = argument[3]
    var OUT = argument[4]
    var ROT = argument[5]
    var DESTROY = argument[6]
    var DURATION = -1
	var OBJ=battle_bullet_bone
	var SPR_BODY=spr_bone
	var SPR_END=spr_bone
    if (argument_count >= 8)
        DURATION = argument[7]
    if (argument_count >= 9)
        OBJ = argument[8]
    if (argument_count >= 10)
        SPR_BODY = argument[9]
    if (argument_count >= 11)
        SPR_END = argument[10]
	var bone = Battle_MakeBoneH((((battle_board.x - battle_board.left) + (LENGTH / 2)) + 5), Y, LENGTH, 0, VSPEED, COLOR, OUT, ROT, DESTROY, DURATION,OBJ,SPR_BODY,SPR_END)
    return bone;
}