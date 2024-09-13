switch (_type) {
case 0:
    Player_HurtKR();
    break;
case 1:

    if (global.moving) {
        Player_HurtKR();
    }
    break;
case 2:
    if ! (global.moving) {
        Player_HurtKR();
    }
    break;
case 3:
    Player_Heal(1);
    break;
case 4:
    Player_Hurt(1);
    break;
}