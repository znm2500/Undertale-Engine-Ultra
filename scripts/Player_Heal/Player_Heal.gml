/// @arg heal,anim
function Player_Heal() {
    var heal = argument[0];
    var anim = argument[1];
    
    if (!anim) {
        if (heal >= 0) {
            if (Player_GetHp() + heal >= Player_GetHpMax()) {
                Player_SetKR(0);
                Player_SetHp(Player_GetHpMax());
            } else {
                var hp = Player_GetHp() + heal;
                if (hp >= Player_GetHp() + Player_GetKR()) {
                    Player_SetHp(hp);
                    Player_SetKR(0);
                } else {
                    Player_SetHp(hp);
                    Player_SetKR(Player_GetKR() - heal);
                }
            }
            return true;
        } else {
            if (Player_GetHp() + Player_GetKR() >= Player_GetHpMax()) {
                Player_SetKR(0);
                Player_SetHp(Player_GetHpMax());
            }
            return Player_Hurt(-heal);
        }
    } else {
        if (heal >= 0) {
            var hp = Player_GetHp() + heal;
            if (hp >= Player_GetHpMax()) {
                var Healer = instance_create_depth(0, 0, 0, healer);
                Healer.alarm[0] = 1;
            } else if (hp >= Player_GetHp() + Player_GetKR()) {
                var Healer = instance_create_depth(0, 0, 0, healer);
                Healer.alarm[1] = 1;
                Healer.heal = heal;
            } else {
                var Healer = instance_create_depth(0, 0, 0, healer);
                Healer.alarm[2] = 1;
                Healer.heal = heal;
            }
            return true;
        } else {
            if (Player_GetHp() + Player_GetKR() >= Player_GetHpMax()) {
                var Healer = instance_create_depth(0, 0, 0, healer);
                Healer.alarm[3] = 1;
                Healer.heal = heal;
            }
            return Player_Hurt(-heal);
        }
    }
}