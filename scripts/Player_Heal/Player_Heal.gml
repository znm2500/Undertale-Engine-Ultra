/// @arg heal, anim
function Player_Heal() {
    var heal = argument[0];
    var anim = argument[1];
    
    if (!anim) {
        Player_SetKR(0);
        Player_SetHp((Player_GetHp() + heal > Player_GetHpMax()) ? Player_GetHpMax() : Player_GetHp() + heal);
    }
    else {
        battle.kr = Player_GetKR();
        battle.heal = heal;
        battle.hp = Player_GetHp();
        
        Anim_Create(battle, "kr", ANIM_TWEEN.CUBIC, ANIM_EASE.IN, Player_GetKR(), -Player_GetKR(), 30);
        Anim_Create(battle, "heal", 0, 0, heal, -heal, 30);
        Anim_Create(battle, "hp", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, Player_GetHp(), (Player_GetHp() + heal > Player_GetHpMax()) ? Player_GetHpMax() - Player_GetHp() : heal, 30);
    }
    
    return true;
}