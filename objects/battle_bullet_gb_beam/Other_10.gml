switch (type) {
    case 0:
        Player_HurtKr();
        break;
    case 1:
        if (global.moving) {
           Player_HurtKr(); 
        }
        break;
    case 2:
        if (!global.moving) {
            Player_HurtKr();
        }
        break;
    case 3:
        Player_Heal(1)
        break;
    case 4:
		Player_HurtKr();
		disposable=1
        break;
}

if (disposable) {
    instance_destroy();
}