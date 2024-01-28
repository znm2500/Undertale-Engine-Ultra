function Battle_MakePlatform(x, y, sticky, width, angle, hspeed, vspeed, bounce=0, auto_destroy=1) {
    var a = instance_create_depth(x, y, 0, battle_platform);

    a.sticky = sticky;
    a.width = width;
    a.angle = angle;
    a.hspeed = hspeed;
    a.vspeed = vspeed;
    a.bounce = bounce;
    a.auto_destroy = auto_destroy;

    return a;
}
