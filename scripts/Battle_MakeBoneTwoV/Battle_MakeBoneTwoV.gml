///@arg x,y,hspeed,gap,auto_destroy,*duration,*obj,*spr_body,*spr_end
function Battle_MakeBoneTwoV(){
    var X = argument[0]
    var Y = argument[1]
    var HSPEED = argument[2]
    var GAP = argument[3]
    var DESTROY = argument[4]
    var DURATION = -1
	var OBJ=battle_bullet_bone
	var SPR_BODY=spr_bone
	var SPR_END=spr_bone
    if (argument_count >= 6)
        DURATION = argument[5]
    if (argument_count >= 7)
        OBJ = argument[6]
    if (argument_count >= 8)
        SPR_BODY = argument[7]
    if (argument_count >= 9)
        SPR_END = argument[8]
    Battle_MakeBoneTop(X, (((Y - battle_board.y) + battle_board.up) - GAP), HSPEED, (0 << 0), 0, 0, DESTROY, DURATION,OBJ,SPR_BODY,SPR_END)
    Battle_MakeBoneBottom(X, (((battle_board.y + battle_board.down) - GAP) - Y), HSPEED, (0 << 0), 0, 0, DESTROY, DURATION,OBJ,SPR_BODY,SPR_END)
    return;
}