function Shake_Create(target, var_name, shake_distance, shake_speed, shake_random = false, shake_decrease = 1, delay = 0) {
    var inst = instance_create_depth(x, y, 0, shaker);
    inst.target = target;
    inst.var_name = var_name;
    inst.shake_distance = shake_distance;
    inst.shake_speed = shake_speed;
    inst.shake_random = shake_random;
    inst.shake_decrease = shake_decrease;
    inst.delay = delay;
    return inst;
}