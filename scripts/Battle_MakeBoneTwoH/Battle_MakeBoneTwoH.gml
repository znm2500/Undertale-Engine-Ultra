///@arg x,y,vspeed,gap,auto_destroy,*duration
function Battle_MakeBoneTwoH(){
    var X = argument[0]
    var Y = argument[1]
    var VSPEED = argument[2]
    var GAP = argument[3]
    var DESTROY = argument[4]
    var DURATION = -1
    if (argument_count >= 6)
        DURATION = argument[5]
    Battle_MakeBoneLeft(Y, (((X - battle_board.x) + battle_board.left) - GAP), VSPEED, (0 << 0), 0, 0, DESTROY, DURATION)
    Battle_MakeBoneRight(Y, (((battle_board.x + battle_board.right) - GAP) - X), VSPEED, (0 << 0), 0, 0, DESTROY, DURATION)
    return;
}