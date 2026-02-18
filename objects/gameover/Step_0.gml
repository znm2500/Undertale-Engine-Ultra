time += global.delta_time_factor;
if (time >= 300 && !instance_exists(a)) {
    image_alpha -= 0.02*global.delta_time_factor;
}
if (time >= 400 && image_alpha <= 0) {
    room_goto(room_battle);
    instance_exists(gameover);
    audio_stop_all();
}
if(image_alpha<1&&time>=220)image_alpha+=0.01*global.delta_time_factor;