if(instance_exists(battle_turn)){
	image_angle=battle_soul.image_angle
    image_alpha -= 0.05
    if(image_alpha <= 0){
    instance_destroy()}
}else if(!instance_exists(battle_turn)){
    instance_destroy()}