///@desc Soul Collision
Battle_CallSoulEventHurt();
switch (type) {
    case 0:
        
        break;
    case 1:
        if (battle_soul.moving) {
            
        }
        break;
    case 2:
        if (!battle_soul.moving) {
            
        }
        break;
    case 3:
        
        break;
    case 4:
       disposable=1
        break;
}

if (disposable) {
    instance_destroy();
}