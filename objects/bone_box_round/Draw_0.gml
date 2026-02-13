draw_set_color(color)
surface_set_target(Battle_GetBoardSurface())
draw_circle(battle_board.x,battle_board.y,gap,true)
surface_reset_target()
