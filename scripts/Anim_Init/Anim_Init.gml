function Anim_Init() {
    enum ANIM_TWEEN {
        LINEAR,
        SINE,
        QUAD,
        CUBIC,
        QUART,
        QUINT,
        EXPO,
        CIRC,
        BACK,
        ELASTIC,
        BOUNCE,
        CUSTOM,
        BEZIER
    };

    enum ANIM_EASE {
        IN,
        OUT,
        IN_OUT
    };
    enum BEZIER_COMPONENT {
        X = 0,
        Y = 1
    }
    enum ANIMATOR_PLAY_DIREATION {
        NORMAL = 0,
        RESERVE = 1,
        ALTERNATE = 2,
        RESERVE_ALTERNATE = 3
    }
    global._anim_data = [];
    global._animators = [];
    global.anim_speed = 1;
}

function Anim_Uninit() {
    delete global._anim_data;
    delete global._animators;
    return (true);
}

function Anim_IsExists(target, var_name = undefined) {
    var i = 0;
    repeat(array_length(global._anim_data)) {
        var anim_item = global._anim_data[i++];
        if (var_name == undefined) {
            if (anim_item[$ "target"] == target) {
                return true;
            }
        } else if (anim_item[$ "target"] == target && anim_item[$ "var_name"] == var_name) {
            return true;
        }
    }
    return false;
}

function Anim_Create(target, var_name, tween_type, ease_type, start, change, duration, delay = 0, auto_destroy = 1, single_speed = 1, alone_exist = 0) {
    if (duration < 0) {
        duration = -duration;
    } else if (duration == 0) {
        duration = 1;
    }
    if (delay < 0) {
        delay = -delay;
    }
    if (alone_exist) {
        for (var i = 0; i < array_length(global._anim_data); i++) {
            var anim_item = global._anim_data[i];
            if (anim_item[$ "target"] == target && anim_item[$ "var_name"] == var_name && anim_item[$ "delay"] == delay) {
                Anim_Destroy(target, var_name);
                break;
            }
        }
    }
    if (variable_global_exists(var_name)) {
        array_push(global._anim_data, {
            target_type: 0,
            target: global,
            var_name: string(var_name),
            tween_type: tween_type,
            ease_type: ease_type,
            tweenstart: start,
            change: change,
            duration: duration,
            delay: delay,
            auto_destroy: auto_destroy,
            single_speed: single_speed,
            time: 0
        });
    } else if (is_struct(target)) {
        if (variable_struct_exists(target, var_name)) {
            array_push(global._anim_data, {
                target_type: 1,
                target: target,
                var_name: string(var_name),
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                auto_destroy: auto_destroy,
                single_speed: single_speed,
                time: 0
            });
            return (true);
        }
    } else if (is_array(target)) {
        if (var_name > -1 && array_length(target) > var_name) {
            array_push(global._anim_data, {
                target_type: 2,
                target: target,
                var_name: var_name,
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                auto_destroy: auto_destroy,
                single_speed: single_speed,
                time: 0
            });
            return (true);
        }
    } else if (object_exists(target)) {
        if (variable_instance_exists(target, var_name)) {
            array_push(global._anim_data, {
                target_type: 3,
                target: target,
                var_name: var_name,
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                auto_destroy: auto_destroy,
                single_speed: single_speed,
                time: 0
            });
        }
        return (true);
    } else if (ds_exists(target, ds_type_list)) {

        if (var_name > -1 && array_length(target) > var_name) {
            array_push(global._anim_data, {
                target_type: 4,
                target: target,
                var_name: var_name,
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                auto_destroy: auto_destroy,
                single_speed: single_speed,
                time: 0
            });
            return (true);
        }

    } else if (ds_exists(target, ds_type_map)) {

        if (ds_map_exists(target, var_name)) {
            array_push(global._anim_data, {
                target_type: 5,
                target: target,
                var_name: string(var_name),
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                auto_destroy: auto_destroy,
                single_speed: single_speed,
                time: 0
            });
            return (true);
        }

    } else if (ds_exists(target, ds_type_grid)) {
        if (is_string(var_name)) var_name = string_split(var_name, ",");
        if (var_name[0] > -1 && ds_grid_width(target) > var_name[0] && var_name[1] > -1 && ds_grid_height(target) > var_name[1]) {
            array_push(global._anim_data, {
                target_type: 6,
                target: target,
                var_name: var_name,
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                auto_destroy: auto_destroy,
                single_speed: single_speed,
                time: 0
            });
            return (true);
        }

    } else if (instance_exists(target)) {
        if (variable_instance_exists(target, var_name)) {
            array_push(global._anim_data, {
                target_type: 7,
                target: target,
                var_name: var_name,
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                auto_destroy: auto_destroy,
                single_speed: single_speed,
                time: 0
            });
        }
        return (true);
    }

    return (false);
}

function Anim_Destroy(target, var_name = undefined) {
    var ease_list = global._anim_data;
    var success = false;
    for (var i = 0; i < array_length(ease_list); i++) {
        var anim_item = ease_list[i];
        if (var_name == undefined) {
            if (target == anim_item[$ "target"]) {
                array_delete(ease_list, i--, 1);
                success = true;
            }
        } else if (var_name == anim_item[$ "var_name"] && target == anim_item[$ "target"]) {
            array_delete(ease_list, i--, 1);
            success = true;
        }
    }
    return (success);
}

function Anim_SetSingleSpeed(target, var_name, single_speed) {
    var ease_list = global._anim_data;
    var success = false;
    for (var i = 0; i < array_length(ease_list); i++) {
        var anim_item = ease_list[i];
        if (var_name == undefined) {
            if (target == anim_item[$ "target"]) {
                anim_item[$ "single_speed"] = single_speed;
                success = true;
            }
        } else if (var_name == anim_item[$ "var_name"] && target == anim_item[$ "target"]) {
            anim_item[$ "single_speed"] = single_speed;
            success = true;
        }
    }
    return (success);
}

function Anim_Step() {
    var i = 0;
    repeat(array_length(global._animators)) {
        global._animators[i++].Step();
    }
    var ease_list = global._anim_data;
    for (i = 0; i < array_length(ease_list); i++) {
        var anim_item = ease_list[i];
        anim_item[$ "time"] += anim_item[$ "single_speed"] * global.anim_speed;
        if ((anim_item[$ "time"] > anim_item[$ "duration"] + anim_item[$ "delay"] || anim_item[$ "time"] < 0) && anim_item[$ "auto_destroy"]) {
            array_delete(ease_list, i--, 1);
            continue;
        }
        if (anim_item[$ "time"] - anim_item[$ "delay"] >= 0) {
            var anim_value = Anim_GetValue(anim_item[$ "tween_type"], anim_item[$ "ease_type"], min((anim_item[$ "time"] - anim_item[$ "delay"]) / anim_item[$ "duration"], 1));
            switch (anim_item[$ "target_type"]) {
            case 0:
                {
                    variable_global_set(anim_item[$ "var_name"], anim_value * anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 1:
                {
                    variable_struct_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_value * anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 2:
                {
                    array_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_value * anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 3:
                {
                    with(anim_item[$ "target"]) variable_instance_set(id, anim_item[$ "var_name"], anim_value * anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 4:
                {
                    ds_list_replace(anim_item[$ "target"], anim_item[$ "var_name"], anim_value * anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 5:
                {
                    ds_map_replace(anim_item[$ "target"], anim_item[$ "var_name"], anim_value * anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 6:
                {
                    if (is_string(anim_item[$ "var_name"])) var var_name = string_split(anim_item[$ "var_name"], ",");
                    else if (is_array(anim_item[$ "var_name"])) var var_name = anim_item[$ "var_name"];
                    ds_grid_set(anim_item[$ "target"], var_name[0], var_name[1], anim_value * anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 7:
                {
                    variable_instance_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_value * anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            default:
                {
                    array_delete(ease_list, i--, 1);
                    break;
                }
            }
        }

    }
    return (true);
}

function Anim_Skip(target, var_name) {
    var ease_list = global._anim_data;
    var success = false;
    for (var i = 0; i < array_length(ease_list); i++) {
        var anim_item = ease_list[i];
        if (var_name == undefined) {
            if (target == anim_item[$ "target"]) {
                switch (anim_item[$ "target_type"]) {
                case 0:
                    {
                        variable_global_set(anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                        break;
                    }
                case 1:
                    {
                        variable_struct_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                        break;
                    }
                case 2:
                    {
                        array_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                        break;
                    }
                case 3:
                    {
                        variable_instance_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                        break;
                    }
                case 4:
                    {
                        ds_list_replace(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                        break;
                    }
                case 5:
                    {
                        ds_map_replace(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                        break;
                    }
                case 6:
                    {
                        if (is_string(anim_item[$ "var_name"])) var var_names = string_split(anim_item[$ "var_name"], ",");
                        else if (is_array(anim_item[$ "var_name"])) var var_names = anim_item[$ "var_name"];
                        ds_grid_set(anim_item[$ "target"], var_names[0], var_names[1], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                        break;
                    }
                case 7:
                    {
                        variable_instance_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                        break;
                    }
                default:
                    {
                        array_delete(ease_list, i, 1);
                        break;
                    }
                }
                array_delete(ease_list, i--, 1);
                success = true;
            }
        } else if (var_name == anim_item[$ "var_name"] && target == anim_item[$ "target"]) {
            switch (anim_item[$ "target_type"]) {
            case 0:
                {
                    variable_global_set(anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 1:
                {
                    variable_struct_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 2:
                {
                    array_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 3:
                {
                    variable_instance_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 4:
                {
                    ds_list_replace(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 5:
                {
                    ds_map_replace(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 6:
                {
                    if (is_string(anim_item[$ "var_name"])) var var_names = string_split(anim_item[$ "var_name"], ",");
                    else if (is_array(anim_item[$ "var_name"])) var var_names = anim_item[$ "var_name"];
                    ds_grid_set(anim_item[$ "target"], var_names[0], var_names[1], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            case 7:
                {
                    variable_instance_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_item[$ "change"] + anim_item[$ "tweenstart"]);
                    break;
                }
            default:
                {
                    array_delete(ease_list, i--, 1);
                    break;
                }
            }
            array_delete(ease_list, i--, 1);
            success = true;
        }
    }
    return (success);
}

function Anim_GetValue(TWEEN, EASE, TIME) {
    var r = 0;
    var t = TIME;
    var b = 0;
    var c = 1;
    var d = 1;

    switch (TWEEN) {
    case ANIM_TWEEN.LINEAR:
        r = (t / d) * c + b;
        break;

    case ANIM_TWEEN.SINE:
        switch (EASE) {
        case ANIM_EASE.IN:
            r = -c * cos(t / d * (pi / 2)) + c + b;
            break;
        case ANIM_EASE.OUT:
            r = c * sin(t / d * (pi / 2)) + b;
            break;
        case ANIM_EASE.IN_OUT:
            r = -c / 2 * (cos(pi * t / d) - 1) + b;
            break;
        }
        break;

    case ANIM_TWEEN.QUAD:
        switch (EASE) {
        case ANIM_EASE.IN:
            t /= d;
            r = c * t * t + b;
            break;
        case ANIM_EASE.OUT:
            t /= d;
            r = -c * t * (t - 2) + b;
            break;
        case ANIM_EASE.IN_OUT:
            t /= d / 2;
            if (t < 1) {
                r = c / 2 * t * t + b;
            } else {
                r = -c / 2 * ((--t) * (t - 2) - 1) + b;
            }
            break;
        }
        break;

    case ANIM_TWEEN.CUBIC:
        switch (EASE) {
        case ANIM_EASE.IN:
            t /= d;
            r = c * t * t * t + b;
            break;
        case ANIM_EASE.OUT:
            t = t / d - 1 r = c * (t * t * t + 1) + b;
            break;
        case ANIM_EASE.IN_OUT:
            t /= d / 2
            if (t < 1) {
                r = c / 2 * t * t * t + b;
            } else {
                t -= 2;
                r = c / 2 * (t * t * t + 2) + b;
            }
            break;
        }
        break;

    case ANIM_TWEEN.QUART:
        switch (EASE) {
        case ANIM_EASE.IN:
            t /= d;
            r = c * t * t * t * t + b;
            break;
        case ANIM_EASE.OUT:
            t = t / d - 1;
            r = -c * (t * t * t * t - 1) + b;
            break;
        case ANIM_EASE.IN_OUT:
            t /= d / 2
            if (t < 1) {
                r = c / 2 * t * t * t * t + b;
            } else {
                t -= 2;
                r = -c / 2 * (t * t * t * t - 2) + b;
            }
            break;
        }
        break;

    case ANIM_TWEEN.QUINT:
        switch (EASE) {
        case ANIM_EASE.IN:
            t /= d;
            r = c * t * t * t * t * t + b;
            break;
        case ANIM_EASE.OUT:
            t = t / d - 1;
            r = c * (t * t * t * t * t + 1) + b;
            break;
        case ANIM_EASE.IN_OUT:
            t /= d / 2
            if (t < 1) {
                r = c / 2 * t * t * t * t * t + b;
            } else {
                t -= 2;
                r = c / 2 * (t * t * t * t * t + 2) + b;
            }
            break;
        }
        break;

    case ANIM_TWEEN.EXPO:
        switch (EASE) {
        case ANIM_EASE.IN:
            if (t == 0) {
                r = b;
            } else {
                r = c * power(2, 10 * (t / d - 1)) + b;
            }
            break;
        case ANIM_EASE.OUT:
            if (t == d) {
                r = b + c;
            } else {
                r = c * ( - power(2, -10 * t / d) + 1) + b;
            }
            break;
        case ANIM_EASE.IN_OUT:
            if (t == 0) {
                r = b;
            }
            if (t == d) {
                r = b + c;
            }
            t /= d / 2;
            if (t < 1) {
                r = c / 2 * power(2, 10 * (t - 1)) + b;
            } else {
                r = c / 2 * ( - power(2, -10 * --t) + 2) + b;
            }
            break;
        }
        break;

    case ANIM_TWEEN.CIRC:
        switch (EASE) {
        case ANIM_EASE.IN:
            t /= d;
            r = -c * (sqrt(1 - t * t) - 1) + b;
            break;
        case ANIM_EASE.OUT:
            t = t / d - 1;
            r = c * sqrt(1 - t * t) + b;
            break;
        case ANIM_EASE.IN_OUT:
            t /= d / 2;
            if (t < 1) {
                r = -c / 2 * (sqrt(1 - t * t) - 1) + b;
            } else {
                t -= 2;
                r = c / 2 * (sqrt(1 - t * t) + 1) + b;
            }
            break;
        }
        break;

    case ANIM_TWEEN.BACK:
        s = 1.70158;
        switch (EASE) {
        case ANIM_EASE.IN:
            t /= d;
            r = c * t * t * ((s + 1) * t - s) + b;
            break;
        case ANIM_EASE.OUT:
            t = t / d - 1;
            r = c * (t * t * ((s + 1) * t + s) + 1) + b;
            break;
        case ANIM_EASE.IN_OUT:
            t /= d / 2;
            s *= 1.525;
            if (t < 1) {
                r = c / 2 * (t * t * ((s + 1) * t - s)) + b;
            } else {
                t -= 2;
                r = c / 2 * (t * t * ((s + 1) * t + s) + 2) + b;
            }
            break;
        }
        break;

    case ANIM_TWEEN.ELASTIC:
        var a = 0;
        var p = 0;
        switch (EASE) {
        case ANIM_EASE.IN:
            if (t == 0) {
                r = b;
                break;
            }
            t /= d;
            if (t == 1) {
                r = b + c;
                break;
            }
            if (p == 0) {
                p = d * 0.3;
            }
            if (a == 0 || a < abs(c)) {
                a = c;
                var s = p / 4;
            } else {
                var s = p / (2 * pi) * arcsin(c / a);
            }
            t -= 1;
            r = -(a * power(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b;
            break;
        case ANIM_EASE.OUT:
            if (t == 0) {
                r = b;
                break;
            }
            t /= d;
            if (t == 1) {
                r = b + c;
                break;
            }
            if (p == 0) {
                p = d * 0.3;
            }
            if (a == 0 || a < abs(c)) {
                a = c;
                var s = p / 4;
            } else {
                var s = p / (2 * pi) * arcsin(c / a);
            }
            r = a * power(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b;
            break;
        case ANIM_EASE.IN_OUT:
            if (t == 0) {
                r = b;
                break;
            }
            t /= d / 2;
            if (t == 2) {
                r = b + c;
                break;
            }
            if (p == 0) {
                p = d * (0.3 * 1.5);
            }
            if (a == 0 || a < abs(c)) {
                a = c;
                var s = p / 4;
            } else {
                var s = p / (2 * pi) * arcsin(c / a);
            }
            t -= 1;
            if (t < 1) {
                r = -0.5 * (a * power(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b;
            } else {
                r = a * power(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) * 0.5 + c + b;
            }
            break;
        }
        break;

    case ANIM_TWEEN.BOUNCE:
        switch (EASE) {
        case ANIM_EASE.IN:
            t = d - t;
            t /= d;
            if (t < 1 / 2.75) {
                r = c * (7.5625 * t * t);
            } else if (t < 2 / 2.75) {
                t -= 1.5 / 2.75;
                r = c * (7.5625 * t * t + 0.75);
            } else if (t < 2.5 / 2.75) {
                t -= 2.25 / 2.75;
                r = c * (7.5625 * t * t + 0.9375);
            } else {
                t -= 2.625 / 2.75;
                r = c * (7.5625 * t * t + 0.984375);
            }
            r = c - r + b;
            break;
        case ANIM_EASE.OUT:
            t /= d;
            if (t < 1 / 2.75) {
                r = c * (7.5625 * t * t) + b;
            } else if (t < 2 / 2.75) {
                t -= 1.5 / 2.75;
                r = c * (7.5625 * t * t + 0.75) + b;
            } else if (t < 2.5 / 2.75) {
                t -= 2.25 / 2.75;
                r = c * (7.5625 * t * t + 0.9375) + b;
            } else {
                t -= 2.625 / 2.75;
                r = c * (7.5625 * t * t + 0.984375) + b;
            }
            break;
        case ANIM_EASE.IN_OUT:
            var ease_in;
            if (t < d / 2) {
                t *= 2;
                ease_in = true;
            } else {
                t *= 2;
                t -= d;
                ease_in = false;
            }

            t /= d;
            if (t < 1 / 2.75) {
                r = c * (7.5625 * t * t);
            } else if (t < 2 / 2.75) {
                t -= 1.5 / 2.75;
                r = c * (7.5625 * t * t + 0.75);
            } else if (t < 2.5 / 2.75) {
                t -= 2.25 / 2.75;
                r = c * (7.5625 * t * t + 0.9375);
            } else {
                t -= 2.625 / 2.75;
                r = c * (7.5625 * t * t + 0.984375);
            }

            if (ease_in) {
                r = r * 0.5 + b;
            } else {
                r = r * 0.5 + c * 0.5 + b;
            }
            break;
        }
        break;
    case ANIM_TWEEN.CUSTOM:
        var ac = animcurve_get(EASE[0]);
        var channel = animcurve_get_channel(ac, EASE[1]);
        r = animcurve_channel_evaluate(channel, TIME) break;
        break;
    case ANIM_TWEEN.BEZIER:
        var bezier = EASE[0];
        var bezier_value = Bezier_GetValue(bezier, TIME);
        var bezier = bezier[EASE[1]];
        break;
    }

    return r;

}
function Bezier_CreateStruct(start_x, start_y, last_x, last_y) {
    var bezier = {};
    bezier[$ "startPoint"] = [start_x, start_y];
    bezier[$ "lastPoint"] = [last_x, last_y];
    bezier[$ "points"] = [];
    return bezier;
}

function Bezier_PointNumber(bezier) {
    return (array_length(bezier[$ "points"]) + 2);
}

function Bezier_AddPoint(bezier, x, y) {
    return (array_push(bezier[$ "points"], [x, y]));
}

function Bezier_GetValue(bezier, step) {
    var startPoint = bezier[$ "startPoint"];
    var lastPoint = bezier[$ "lastPoint"];
    var points = bezier[$ "points"];
    // 获取数据
    var allPoints = [];
    allPoints[0] = startPoint; // 添加第一个点的位置
    allPoints = array_concat(allPoints, points); // 数组链接(旧版本可以自己写一个数组连接函数)
    array_push(allPoints, lastPoint); // 添加第末尾点的位置
    // 得到要计算的所有点位置
    var normalization = step / 100; // 计算归一化百分比
    var tempPoints = allPoints; // 临时点数组
    var nextTempPoints = []; // 下一维度临时点数组
    var tempPointsNumber = array_length(tempPoints); // 临时点数量
    while (tempPointsNumber > 1) {
        nextTempPoints = [];
        for (var i = 0; i < tempPointsNumber - 1; i++) {
            var point1 = tempPoints[i];
            var point2 = tempPoints[i + 1];
            // 得到点和下一个点的位置
            var nextPoint = [];
            nextPoint[0] = lerp(point1[0], point2[0], normalization);
            nextPoint[1] = lerp(point1[1], point2[1], normalization);
            // 计算两点连线下一维度的点的位置
            nextTempPoints[i] = nextPoint;
        }
        tempPointsNumber = array_length(nextTempPoints); // 得到临时点数量
        tempPoints = nextTempPoints;
    }
    return (tempPoints[0]);
}
function Animator(tween_default = ANIM_TWEEN.LINEAR, ease_default = ANIM_EASE.IN_OUT) constructor {
    array_push(global._animators, self);
    patterns = [];
    duration = 0;
    delay = 0;
    auto_destroy = 0;
    play_speed = 0;
    play_direction = ANIMATOR_PLAY_DIREATION.NORMAL;
    play_count = 0;
    play_interval = 0;
    self.tween_default = tween_default;
    self.ease_default = ease_default;
    _step = 0;
    _played_times = 0;
    _play_speed = 0;
    function GetPattern(target, var_name) {
        var _index = 0;
        repeat(array_length(patterns)) {
            if (patterns[_index].target == target && patterns[_index].var_name = var_name) return patterns[_index];
            _index++;
        }
        return false;
    }
    ///@arg target,var_name,keyframe...
    function SetKeyframe() {
        var target = argument[0];
        var var_name = argument[1];
        var item = GetPattern(target, var_name);
        var i = 1,
        success = false;
        if (item) {
            while (argument[++i] != undefined) {
                if (is_array(argument[i])) {
                    if (argument[i][0] < 0 || argument[i][0] > 1) continue;
                    if (array_length(argument[i]) == 2) array_push(argument[i], tween_default);
                    if (array_length(argument[i]) == 3) array_push(argument[i], ease_default);
                    var l = 0,
                    r = array_length(item.keyframes) - 1,
                    mid = l;
                    while (l <= r) {
                        mid = (r + l) >> 1;
                        if (item.keyframes[mid][0] < argument[i][0]) {
                            l = mid + 1;
                        } else if (item.keyframes[mid][0] > argument[i][0]) {
                            r = mid - 1;
                        } else {
                            array_delete(item.keyframes, mid, 1);
                            l = mid;
                            break;
                        }
                    }
                    array_insert(item.keyframes, l, argument[i]);
                    success = true;
                }
            }
        } else {
            item = {
                target: target,
                var_name: var_name,
                keyframes: []
            }
            var type;
            if (variable_global_exists(var_name)) type = 0;
            else if (is_struct(target)) {
                if (variable_struct_exists(target, var_name)) {
                    type = 1;
                }
            } else if (is_array(target)) {
                if (var_name > -1 && array_length(target) > var_name) {
                    type = 2;
                }
            } else if (object_exists(target)) {
                if (variable_instance_exists(target, var_name)) type = 3;
            } else if (ds_exists(target, ds_type_list)) {

                if (var_name > -1 && array_length(target) > var_name) {
                    type = 4;
                }
            } else if (ds_exists(target, ds_type_map)) {

                if (ds_map_exists(target, var_name)) {
                    type = 5;
                }
            } else if (ds_exists(target, ds_type_grid)) {
                if (is_string(var_name)) var_name = string_split(var_name, ",");
                if (var_name[0] > -1 && ds_grid_width(target) > var_name[0] && var_name[1] > -1 && ds_grid_height(target) > var_name[1]) {
                    type = 6;
                }
            } else if (instance_exists(target)) {
                if (variable_instance_exists(target, var_name)) {
                    type = 7;
                }
            } else return false;
            item.type = type;
            while (argument[++i] != undefined) {
                if (is_array(argument[i])) {
                    if (argument[i][0] < 0 || argument[i][0] > 1) continue;
                    if (array_length(argument[i]) == 2) array_push(argument[i], tween_default);
                    if (array_length(argument[i]) == 3) array_push(argument[i], ease_default);
                    var l = 0,
                    r = array_length(item.keyframes) - 1,
                    mid = l;
                    if (r == 0) {
                        if (argument[i][0] == item.keyframes[l][0]) {
                            array_delete(item.keyframes, 0, 1);
                            continue;
                        } else if (argument[i][0] > item.keyframes[l][0]) array_push(item.keyframes, argument[i]);
                        else array_insert(item.keyframes, 0, argument[i]);
                        success = true;
                        continue;
                    }
                    while (l <= r) {
                        mid = (r + l) >> 1;
                        if (item.keyframes[mid][0] < argument[i][0]) {
                            l = mid + 1;
                        } else if (item.keyframes[mid][0] > argument[i][0]) {
                            r = mid - 1;
                        } else {
                            array_delete(item.keyframes, mid, 1);
                            l = mid;
                            break;
                        }
                    }
                    array_insert(item.keyframes, l, argument[i]);
                    success = true;
                }
            }
            if (success) {
                array_push(patterns, item);
            }
        }
        return success;
    }
    function Play(duration, delay = 0, play_speed = 1, play_direction = ANIMATOR_PLAY_DIREATION.NORMAL, play_count = 1, play_interval = 0, auto_destroy = 0) {
        self.duration = round(abs(duration));
        if (!self.duration) self.duration = 1;
        self.delay = delay;
        self.play_speed = abs(play_speed);
        self.play_direction = play_direction;
        self.play_count = play_count;
        self.play_interval = play_interval;
        self.auto_destroy = auto_destroy;
        _played_times = 0;
        if (play_direction == ANIMATOR_PLAY_DIREATION.NORMAL || play_direction == ANIMATOR_PLAY_DIREATION.ALTERNATE) _step = 0;
        else _step = self.duration;
    }
    function Step() {
        if (play_speed < 0) show_error("Cannot set play_speed negative directly!", true);
        if (play_speed && play_count > 0) {
            delay -= play_speed;
            if (delay < 0) {
                if (play_direction == 0 || (play_direction == 2 && !(_played_times & 1)) || (play_direction == 3 && _played_times & 1)) {
                    _step -= delay;
                    delay = 0;
                    if (_step > duration) _step = duration;
                    var progress = _step / duration;
                    var i = 0,
                    value;
                    repeat(array_length(patterns)) {
                        var pl = array_length(patterns[i].keyframes);
                        if (!pl) continue;
                        var _stage, l = 0,
                        r = pl - 1;
                        while (l <= r) {
                            _stage = (r + l) >> 1;
                            if (patterns[i].keyframes[_stage][0] < progress) {
                                l = _stage + 1;
                            } else if (patterns[i].keyframes[_stage][0] > progress) {
                                r = _stage - 1;
                            } else {
                                l = _stage;
                                break;
                            }
                        }
                        _stage = l;
                        if (progress <= patterns[i].keyframes[0][0]) value = patterns[i].keyframes[0][1];
                        else if (progress >= patterns[i].keyframes[pl - 1][0]) value = patterns[i].keyframes[pl - 1][1];
                        else {
                            value = Anim_GetValue(patterns[i].keyframes[_stage][2], patterns[i].keyframes[_stage][3], (progress - patterns[i].keyframes[_stage - 1][0]) / (patterns[i].keyframes[_stage][0] - patterns[i].keyframes[_stage - 1][0])) * (patterns[i].keyframes[_stage][1] - patterns[i].keyframes[_stage - 1][1]) + patterns[i].keyframes[_stage - 1][1];
                        }
                        switch (patterns[i].type) {
                        case 0:
                            {
                                variable_global_set(patterns[i].var_name, value);
                                break;
                            }
                        case 1:
                            {
                                variable_struct_set(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 2:
                            {
                                array_set(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 3:
                            {
                                variable_instance_set(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 4:
                            {
                                ds_list_replace(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 5:
                            {
                                ds_map_replace(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 6:
                            {
                                if (is_string(patterns[i].var_name)) var var_names = string_split(patterns[i].var_name, ",");
                                else if (is_array(patterns[i].var_name)) var var_names = patterns[i].var_name;
                                ds_grid_set(patterns[i].target, var_names[0], var_names[1], value);
                                break;
                            }
                        case 7:
                            {
                                variable_instance_set(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        }
                        i++;
                    }
                    if (_step == duration) {
                        _played_times++;
                        play_count--;
                        delay = play_interval;
                        if (play_direction == ANIMATOR_PLAY_DIREATION.NORMAL) _step = 0;
                        if (!play_count && auto_destroy) Destroy();
                    }
                } else {
                    _step += delay;
                    delay = 0;
                    if (_step < 0) _step = 0;
                    var progress = _step / duration;
                    var i = 0,
                    value;
                    repeat(array_length(patterns)) {
                        var pl = array_length(patterns[i].keyframes);
                        if (!pl) continue;
                        var _stage, l = 0,
                        r = pl - 1;
                        while (r - l > 1) {
                            var _stage = int64((r + l) / 2);
                            if (patterns[i].keyframes[_stage][0] > progress) {
                                r = _stage;
                            } else {
                                l = _stage;
                            }
                        }
                        _stage = r;
                        if (progress <= patterns[i].keyframes[0][0]) value = patterns[i].keyframes[0][1];
                        else if (progress >= patterns[i].keyframes[pl - 1][0]) value = patterns[i].keyframes[pl - 1][1];
                        else {
                            value = Anim_GetValue(patterns[i].keyframes[_stage][2], patterns[i].keyframes[_stage][3], (progress - patterns[i].keyframes[_stage - 1][0]) / (patterns[i].keyframes[_stage][0] - patterns[i].keyframes[_stage - 1][0])) * (patterns[i].keyframes[_stage][1] - patterns[i].keyframes[_stage - 1][1]) + patterns[i].keyframes[_stage - 1][1];
                        }
                        switch (patterns[i].type) {
                        case 0:
                            {
                                variable_global_set(patterns[i].var_name, value);
                                break;
                            }
                        case 1:
                            {
                                variable_struct_set(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 2:
                            {
                                array_set(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 3:
                            {
                                variable_instance_set(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 4:
                            {
                                ds_list_replace(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 5:
                            {
                                ds_map_replace(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        case 6:
                            {
                                if (is_string(patterns[i].var_name)) var var_names = string_split(patterns[i].var_name, ",");
                                else if (is_array(patterns[i].var_name)) var var_names = patterns[i].var_name;
                                ds_grid_set(patterns[i].target, var_names[0], var_names[1], value);
                                break;
                            }
                        case 7:
                            {
                                variable_instance_set(patterns[i].target, patterns[i].var_name, value);
                                break;
                            }
                        }
                        i++;
                    }
                }
                if (_step == 0) {
                    _played_times++;
                    play_count--;
                    delay = play_interval;
                    if (play_direction == ANIMATOR_PLAY_DIREATION.RESERVE) _step = duration;
                    if (!play_count && auto_destroy) Destroy();
                }
            }
        }
    }
    function SetPlaySpeed(play_speed) {
        if (play_speed < 0) {
            self.play_speed = -play_speed;
            switch (play_direction) {
            case 0:
                play_direction = 1;
                break;
            case 1:
                play_direction = 0;
                break;
            case 2:
                play_direction = 3;
                break;
            case 3:
                play_direction = 2;
                break;
            }
        } else {
            self.play_speed = play_speed;
        }
    }
    function SetProgress(progress) {
        if (progress > 1 || progress < 0) return;
        _step = progress * duration;
    }
    ///@arg target,var_name,progress...		
    function DeleteKeyFrame() {
        var item = GetPattern(argument[0], argument[1]);
        if (!item) return false;
        var i = 1;
        while (argument[i++] != undefined) {
            var l = 0,
            r = array_length(item.keyframes) - 1,
            mid = l;
            while (l <= r) {
                mid = (r + l) >> 1;
                if (item.keyframes[mid][0] < argument[i][0]) {
                    l = mid + 1;
                } else if (item.keyframes[mid][0] > argument[i][0]) {
                    r = mid - 1;
                } else {
                    return true;
                    break;
                }
            }
        }
        return false;
    }
    function DeletePattern(target, varname) {
        var _index = 0;
        repeat(array_length(patterns)) {
            if (patterns[_index].target == target && patterns[_index].var_name = var_name) array_delete(patterns, _index, 1);
            _index++;
        }
        return false;
    }
    function Pause() {
        _play_speed = play_speed;
        play_speed = 0;
        return bool(_play_speed);
    }
    function Continue() {
        if (_play_speed == 0) return false;
        play_speed = _play_speed;
        return true;
    }
    function Destroy() {
        var i = 0;
        repeat(array_length(global._animators)) {
            if (global._animators[i] == self) {
                array_delete(global._animators, i, 1);
                return true;
            }
            i++
        }
        return false;
    }
    function IsKeyFrameExists(pattern, progress) {
        var l = 0,
        r = array_length(pattern.keyframes) - 1,
        mid = l;
        while (r - l > 1) {
            mid = (r + l) >> 1;
            if (pattern.keyframes[l][0] == progress) {
                return true;
            } else if (pattern.keyframes[r][0] == progress) {
                return true;
            } else if (pattern.keyframes[mid][0] > progress) {
                r = mid;
            } else {
                l = mid;
            }
        }
        return false;
    }
}
function Animator_IsExist(target, var_name = undefined) {
    var i = 0;
    repeat(array_length(global._animators)) {
        var animator = global._animators[i++],
        p = 0;
        repeat(array_length(animator.patterns)) {
            var pattern = animator.patterns[p++];
            if (var_name == undefined) {
                if (pattern.target == target) {
                    return true;
                }
            } else if (pattern.target == target && pattern.var_name == var_name) {
                return true;
            }
        }
    }
    return false;
}
function Animator_Destroy(target, var_name = undefined) {
    var ease_list = global._animators;
    var success = false;
    for (var i = 0; i < array_length(ease_list); i++) {
        var animator = ease_list[i],
        p = 0;
        repeat(array_length(animator.patterns)) {
            var pattern = animator.patterns[p++];
            if (var_name == undefined) {
                if (pattern.target == target) {
                    array_delete(ease_list, i--, 1);
                    success = true;
                    break;
                }
            } else if (pattern.target == target && pattern.var_name == var_name) {
                array_delete(ease_list, i--, 1);
                success = true;
                break;
            }
        }
    }
    return (success);
}
function Animator_Delete(target, var_name = undefined) {
    var ease_list = global._animators;
    var success = false;
    for (var i = 0; i < array_length(ease_list); i++) {
        var animator = ease_list[i],
        p = 0;
        repeat(array_length(animator.patterns)) {
            var pattern = animator.patterns[p++];
            if (var_name == undefined) {
                if (pattern.target == target) {
                    array_delete(animator.patterns, p - 1, 1);
                    success = true;
                    break;
                }
            } else if (pattern.target == target && pattern.var_name == var_name) {
                array_delete(animator.patterns, p - 1, 1);
                success = true;
                break;
            }
        }
    }
    return (success);
}