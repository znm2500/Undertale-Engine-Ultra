function Player_HurtKR() {
    if (global.kr) battle.damage = 1
    return
}
function Player_GetKR() {
    return Flag_Get(FLAG_TYPE.STATIC, FLAG_STATIC.KR);

}
function Player_SetKR() {
    if (global.kr) {
        Flag_Set(FLAG_TYPE.STATIC, FLAG_STATIC.KR, argument[0]);
    }

}
