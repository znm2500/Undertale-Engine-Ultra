/// @arg x, y, vertical, horizontal, [hspeed], [vspeed]
function Purplesoul_Addpoint(){
    var p = instance_create_depth(argument[0], argument[1], 0, soul_line);
    
    p.vertical = argument[2];
    p.horizontal = argument[3];
    p.hspeed = argument_count > 4 ? argument[4] : 0; // 可选参数 hspeed
    p.vspeed = argument_count > 5 ? argument[5] : 0; // 可选参数 vspeed
    
    if(instance_exists(battle_soul_purple)){
        array_push(battle_soul_purple.point, p);
    }
    
    return p;
}