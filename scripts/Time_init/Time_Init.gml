function Time_Init(){
    global.delta_time_factor = 1; // 默认正常速度
    // 可以在这里设置其他时间相关变量
}

function Time_Step(){
    // 计算时间缩放因子
    // delta_time 是以微秒为单位的游戏帧时间
    // GAME_FPS 是目标帧率（通常是60）
    //global.delta_time_factor = delta_time / 1000000 * GAME_FPS;
    //global.delta_time_factor = clamp(global.delta_time_factor, 0.1, 10);
	global.delta_time_factor = GAME_FPS/game_get_speed(gamespeed_fps)
}

