if (room = room_battle) {
    if (Battle_GetMenu() == BATTLE_MENU.ITEM) {
        if (round(y) >= battle_board.y - battle_board.up - 5 + 20 - 16 && round(y) <= battle_board.y - battle_board.up - 5 + 20 + 64 + 16) {
            Anim_Create(id, "alpha", 0, 0, alpha, 1 - alpha, 5)
        } else {
            Anim_Create(id, "alpha", 0, 0, alpha, -alpha, 5)
        }
    }
}