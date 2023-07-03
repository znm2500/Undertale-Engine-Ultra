///@arg heal
function Heal_Anim(){var HEAL=argument[0];

 var HEAL = argument[0]
    if (HEAL >= 0)
    {
        if ((Player_GetHp() + HEAL) >= Player_GetHpMax())
        {
            h = instance_create_depth(0, 0, 0, healer)
            h.alarm[0] = 1
        }
        else if ((Player_GetHp() + HEAL) >= (Player_GetHp() + Player_GetKR()))
        {
            h = instance_create_depth(0, 0, 0, healer)
            h.alarm[1] = 1
            h.heal = HEAL
        }
        else
        {
            h = instance_create_depth(0, 0, 0,  healer)
            h.alarm[2] = 1
            h.heal = HEAL
        }
        return 1;
    }
    else
    {
        if ((Player_GetHp() + Player_GetKR()) >= Player_GetHpMax())
        {
            h = instance_create_depth(0, 0, 0,  healer)
            h.alarm[3] = 1
            h.heal = HEAL
        }
        return Player_Hurt((-HEAL));


}}