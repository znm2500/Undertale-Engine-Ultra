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
        CUSTOM
    };

    enum ANIM_EASE {
        IN,
        OUT,
        IN_OUT
    };

    global.__anim_data = ds_list_create();
}

function Anim_Uninit() {
    if (ds_exists(global.__anim_data, ds_type_list)) {
        repeat(ds_list_size(global.__anim_data)) {
            delete(global.__anim_data[|0]);
        }
        ds_list_destroy(global.__anim_data);
        return (true);
    }
}

function Anim_IsExists(target, var_name) {
    var result = false;
    for (var i = 0; i < ds_list_size(global.__anim_data); i++) {
        var anim_item = ds_list_find_value(global.__anim_data, i);
        if (var_name == undefined) {
            if (anim_item[$ "target"] == target) {
                result = true;
                break;
            }
        } else if (anim_item[$ "target"] == target && anim_item[$ "var_name"] == var_name) {
            result = true;
            break;
        }
    }
    return (result);
}
function Anim_Create(target, var_name, tween_type, ease_type, start, change, duration, delay = 0) {
    if (duration < 0) {
        duration = -duration;
    } else if (duration == 0) {
        duration = 1;
    }
    if (delay < 0) {
        delay = -delay;
    }

    if (variable_global_exists(var_name)) {
        ds_list_add(global.__anim_data, {
            target_type: 0,
            target: global,
            var_name: string(var_name),
            tween_type: tween_type,
            ease_type: ease_type,
            tweenstart: start,
            change: change,
            duration: duration,
            delay: delay,
            time: 0
        });
    } else if (is_struct(target)) {
        if (variable_struct_exists(target, var_name)) {
            ds_list_add(global.__anim_data, {
                target_type: 1,
                target: target,
                var_name: string(var_name),
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                time: 0
            });
            return (true);
        }
    } else if (is_array(target)) {
        if (var_name > -1 && array_length(target) > var_name) {
            ds_list_add(global.__anim_data, {
                target_type: 2,
                target: target,
                var_name: var_name,
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                time: 0
            });
            return (true);
        }
    } else if (instance_exists(target)) {
        with(target) {
            if (variable_instance_exists(self, var_name)) {
                ds_list_add(global.__anim_data, {
                    target_type: 3,
                    target: target,
                    var_name: string(var_name),
                    tween_type: tween_type,
                    ease_type: ease_type,
                    tweenstart: start,
                    change: change,
                    duration: duration,
                    delay: delay,
                    time: 0
                });
                return (true);
            }
        }
    } else if (ds_exists(target, ds_type_list)) {

        if (var_name > -1 && ds_list_size(target) > var_name) {
            ds_list_add(global.__anim_data, {
                target_type: 4,
                target: target,
                var_name: var_name,
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                time: 0
            });
            return (true);
        }

    } else if (ds_exists(target, ds_type_map)) {

        if (ds_map_exists(target, var_name)) {
            ds_list_add(global.__anim_data, {
                target_type: 5,
                target: target,
                var_name: string(var_name),
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                time: 0
            });
            return (true);
        }

    } else if (ds_exists(target, ds_type_grid)) {
        if (is_string(var_name)) var_name = string_split(var_name, ",");
        if (var_name[0] > -1 && ds_grid_width(target) > var_name[0] && var_name[1] > -1 && ds_grid_height(target) > var_name[1]) {
            ds_list_add(global.__anim_data, {
                target_type: 6,
                target: target,
                var_name: var_name,
                tween_type: tween_type,
                ease_type: ease_type,
                tweenstart: start,
                change: change,
                duration: duration,
                delay: delay,
                time: 0
            });
            return (true);
        }

    }
    return (false);
}
function Anim_Destroy(target, var_name) {
    var ease_list = global.__anim_data;
    var success = false;
    if (Anim_IsExists(target, var_name)) {
        for (var i = 0; i < ds_list_size(ease_list); i++) {
            var anim_item = ease_list[|i];
            if (var_name == undefined) {
                if (target == anim_item[$ "target"]) {
                    ds_list_delete(ease_list, i);
                    success = true;
                }
            } else if (var_name == anim_item[$ "var_name"] && target == anim_item[$ "target"]) {
                ds_list_delete(ease_list, i);
                success = true;
            }
        }
    }
    return (success);
}
function Anim_Step() {
    var ease_list = global.__anim_data;
    for (var i = 0; i < ds_list_size(ease_list); i++) {
        var anim_item = ease_list[|i];
        if (anim_item[$ "delay"] <= 0) {
            anim_item[$ "time"]++;
            if (anim_item[$ "time"] > anim_item[$ "duration"]) {
                delete(anim_item);
                ds_list_delete(ease_list, i);
                continue;
            }
            var anim_value = Anim_GetValue(anim_item[$ "tween_type"], anim_item[$ "ease_type"], anim_item[$ "time"] / anim_item[$ "duration"]);

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
                    variable_instance_set(anim_item[$ "target"], anim_item[$ "var_name"], anim_value * anim_item[$ "change"] + anim_item[$ "tweenstart"]);
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
            default:
                {
                    delete(anim_item);
                    ds_list_delete(ease_list, i);
                    break;
                }
            }

        } else {
            anim_item[$ "delay"]--;
        }
    }
    return (true);
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
        var ac = animcurve_get(EASE[0]) var channel = animcurve_get_channel(ac, EASE[1]) r = animcurve_channel_evaluate(channel, TIME) break;
    }

    return r;

}