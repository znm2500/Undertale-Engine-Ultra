function Purplesoul_Addpoint(x, y, vertical, horizontal, hspeed = 0, vspeed = 0) {
    var p = {
        x: x,
        y: y,
        vertical: vertical,
        horizontal: horizontal,
		hspeed: hspeed,
        vspeed: vspeed
    }

    if (instance_exists(battle_soul_purple)) {
        array_push(battle_soul_purple.point, p);
    }

    return p;
}