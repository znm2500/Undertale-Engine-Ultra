if (_heal != 0) {
    Player_SetHp(round(_hp));
    Player_SetKr(round(_kr));
}

if (global.kr) {
    if (damage) {
        var _temp_local_var_1, time = 0;
        time += 1;
        if (time = 2) time = 0;
        if (time = 1) {
            if (Player_GetHp() > 1) {
                Player_Hurt(1);
                Player_SetKr(Player_GetKr() + 1);
                if (Player_GetKr() >= 5) {
                    if (global.krtime = 1) {
                        Player_SetKr(Player_GetKr() - 1);
                    }
                }
            } else Player_SetKr(Player_GetKr() - 1);
            if (Player_GetHp() == 1) _temp_local_var_1 = (Player_GetKr() <= 0);
            else _temp_local_var_1 = 0;
            if (_temp_local_var_1) {
                var z = Storage_SetTempFlag(FLAG_TEMP_GAMEOVER_SOUL_X, battle_soul.x - camera.x);
                z.Set(FLAG_TEMP_GAMEOVER_SOUL_Y, battle_soul.y - camera.y);
                z.Set(FLAG_TEMP_GAMEOVER_SOUL_COLOR, battle_soul.image_blend);
                room_goto(room_gameover);

            }
            audio_play_sound(snd_hurt, 0, false);
        }

        global.krtime += 1;
        if (global.krtime = 2) {
            global.krtime = 0;
        }
        damage = 0
    }
}
//菜单
if (!global.classic_ui) {
    if (_state == BATTLE_STATE.MENU) {
        //按钮
        if (_menu == BATTLE_MENU.BUTTON) {
            //左/右
            if (Input_IsPressed(INPUT.LEFT)) {
                var button = _menu_choice_button;
                button -= 1;
                if (button < 0) {
                    button = 3;
                }
                audio_play_sound(snd_menu_switch, 0, false);
                Battle_SetMenuChoiceButton(button);
            } else if (Input_IsPressed(INPUT.RIGHT)) {
                var button = _menu_choice_button;
                button += 1;
                if (button > 3) {
                    button = 0;
                }
                audio_play_sound(snd_menu_switch, 0, false);
                Battle_SetMenuChoiceButton(button);
            }

            //确定
            if (Input_IsPressed(INPUT.CONFIRM)) {
                Anim_Create(battle_soul, "image_angle", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.image_angle, 90 - battle_soul.image_angle, 20);
                audio_play_sound(snd_menu_confirm, 0, false);
                switch (_menu_choice_button) {
                case 0:
                    Battle_SetMenu(BATTLE_MENU.FIGHT_TARGET);
                    break;
                case 1:
                    Battle_SetMenu(BATTLE_MENU.ACT_TARGET);
                    break;
                case 2:
                    if (Item_GetNumber() > 0) {
                        Battle_SetMenu(BATTLE_MENU.ITEM);
                    } else {
                        Anim_Destroy(battle_soul, "image_angle");
                        audio_stop_sound(snd_menu_confirm);
                    }
                    break;
                case 3:
                    Battle_SetMenu(BATTLE_MENU.MERCY);
                    break;
                }
            }
        } else

        //战斗目标
        if (_menu == BATTLE_MENU.FIGHT_TARGET) {
            //上/下
            if (Input_IsPressed(INPUT.UP)) {
                var enemy = _menu_choice_enemy - 1;
                if (enemy >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceEnemy(enemy);
                }
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * _menu_choice_enemy)) - battle_soul.y), 20);
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var enemy = _menu_choice_enemy + 1;
                if (enemy < Battle_GetEnemyNumber()) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceEnemy(enemy);
                }
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * _menu_choice_enemy)) - battle_soul.y), 20);
            }

            //灵魂位置
            battle_soul.x = battle_board.x - battle_board.left - 5 + 40;
            if (battle_soul.y = battle_button.y + 22) {
                battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * _menu_choice_enemy;
            }

            //返回
            if (Input_IsPressed(INPUT.CANCEL)) {
                Anim_Destroy(battle_soul);
                Battle_SetMenu(BATTLE_MENU.BUTTON);
                Anim_Create(battle_soul, "image_angle", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.image_angle, -battle_soul.image_angle, 20);
            }
            //确定
            if (Input_IsPressed(INPUT.CONFIRM)) {
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_SetMenu(BATTLE_MENU.FIGHT_AIM);
                Anim_Destroy(battle_soul);
                Anim_Create(battle_soul, "image_angle", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.image_angle, -battle_soul.image_angle, 20);
            }
        } else

        //战斗动画
        if (_menu == BATTLE_MENU.FIGHT_ANIM) {
            if (_menu_fight_anim_time > 0) {
                _menu_fight_anim_time -= 1;
            } else if (_menu_fight_anim_time == 0) {
                Battle_EndMenuFightAnim();
            }
        } else

        //战斗伤害
        if (_menu == BATTLE_MENU.FIGHT_DAMAGE) {
            if (_menu_fight_damage_time > 0) {
                _menu_fight_damage_time -= 1;
            } else if (_menu_fight_damage_time == 0) {
                Battle_EndMenuFightDamage();
            }
        } else

        //行动目标
        if (_menu == BATTLE_MENU.ACT_TARGET) {
            //上/下
            if (Input_IsPressed(INPUT.UP)) {
                var enemy = _menu_choice_enemy - 1;
                if (enemy >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceEnemy(enemy);
                }
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * _menu_choice_enemy)) - battle_soul.y), 15);
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var enemy = _menu_choice_enemy + 1;
                if (enemy < Battle_GetEnemyNumber()) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceEnemy(enemy);
                }
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * _menu_choice_enemy)) - battle_soul.y), 15);
            }

            //灵魂位置
            battle_soul.x = battle_board.x - battle_board.left - 5 + 40;
            if (battle_soul.y = battle_button.y + 22) {
                battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * _menu_choice_enemy;
            }
            //返回
            if (Input_IsPressed(INPUT.CANCEL)) {
                Anim_Destroy(battle_soul);
                Anim_Create(battle_soul, "image_angle", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.image_angle, -battle_soul.image_angle, 20);
                Battle_SetMenu(BATTLE_MENU.BUTTON);
            }
            //确定
            if (Input_IsPressed(INPUT.CONFIRM)) {
                Anim_Destroy(battle_soul);
                battle_soul.x = battle_board.x - battle_board.left - 5 + 40 + 256 * (_menu_choice_action % 2);
                battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * floor(_menu_choice_action / 2);
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_SetMenu(BATTLE_MENU.ACT_ACTION);
            }
        } else

        //行动内容
        if (_menu == BATTLE_MENU.ACT_ACTION) {
            //上/下
            if (Input_IsPressed(INPUT.UP)) {
                var action = _menu_choice_action - 2;
                if (action >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceAction(action);
                }
                Anim_Create(battle_soul, "x", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.x, (((((battle_board.x - battle_board.left) - 5) + 40) + (256 * (_menu_choice_action % 2))) - battle_soul.x), 15);
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * floor((_menu_choice_action / 2)))) - battle_soul.y), 15);
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var action = _menu_choice_action + 2;
                if (action < _enemy_action_number[Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy())]) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceAction(action);
                }
                Anim_Create(battle_soul, "x", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.x, (((((battle_board.x - battle_board.left) - 5) + 40) + (256 * (_menu_choice_action % 2))) - battle_soul.x), 15);
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * floor((_menu_choice_action / 2)))) - battle_soul.y), 15);
            }
            //左/右
            if (Input_IsPressed(INPUT.LEFT)) {
                if (_menu_choice_action % 2 == 1) {
                    var action = _menu_choice_action - 1;
                    if (action >= 0) {
                        audio_play_sound(snd_menu_switch, 0, false);
                        Battle_SetMenuChoiceAction(action);
                    }
                }
                Anim_Create(battle_soul, "x", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.x, (((((battle_board.x - battle_board.left) - 5) + 40) + (256 * (_menu_choice_action % 2))) - battle_soul.x), 15);
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * floor((_menu_choice_action / 2)))) - battle_soul.y), 15);
            } else if (Input_IsPressed(INPUT.RIGHT)) {
                if (_menu_choice_action % 2 == 0) {
                    var action = _menu_choice_action + 1;
                    if (action < _enemy_action_number[Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy())]) {
                        audio_play_sound(snd_menu_switch, 0, false);
                        Battle_SetMenuChoiceAction(action);
                    }
                }
                Anim_Create(battle_soul, "x", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.x, (((((battle_board.x - battle_board.left) - 5) + 40) + (256 * (_menu_choice_action % 2))) - battle_soul.x), 15);
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * floor((_menu_choice_action / 2)))) - battle_soul.y), 15);
            }

            //返回/确定
            if (Input_IsPressed(INPUT.CANCEL)) {
                Anim_Destroy(battle_soul);
                battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * _menu_choice_enemy;
                Battle_SetMenu(BATTLE_MENU.ACT_TARGET);
            } else if (Input_IsPressed(INPUT.CONFIRM)) {
                Anim_Destroy(battle_soul);
                Anim_Create(battle_soul, "image_angle", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.image_angle, -battle_soul.image_angle, 20, , , , 1);
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_EndMenu();
            }
        } else

        //物品
        if (_menu == BATTLE_MENU.ITEM) {
            //上/下
            with(text_typer) {
                _surface_target = Battle_GetBoardSurface();
                if (round(y) != battle_board.y - battle_board.up - 5 + 20 - 32 * battle._menu_choice_item_first) Anim_Create(id, "y", ANIM_TWEEN.CUBIC, ANIM_EASE.OUT, id.y, battle_board.y - battle_board.up - 5 + 20 - 32 * battle._menu_choice_item_first - id.y, 20);
            }
            if (Input_IsPressed(INPUT.UP)) {
                var slot = Battle_GetMenuChoiceItem() - 1;
                if (slot >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    if (slot < Item_GetNumber()) {
                        battle._menu_choice_item = slot;
                        while (slot >= battle._menu_choice_item_first + 3) {
                            battle._menu_choice_item_first += 1;
                        }
                        while (slot < battle._menu_choice_item_first) {
                            battle._menu_choice_item_first -= 1;
                        }
                    }
                }
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * (Battle_GetMenuChoiceItem() - _menu_choice_item_first))) - battle_soul.y), 15);
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var slot = Battle_GetMenuChoiceItem() + 1;
                if (slot < Item_GetNumber()) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    if (slot < Item_GetNumber()) {
                        battle._menu_choice_item = slot;
                        while (slot >= battle._menu_choice_item_first + 3) {
                            battle._menu_choice_item_first += 1;
                        }
                        while (slot < battle._menu_choice_item_first) {
                            battle._menu_choice_item_first -= 1;
                        }
                    }
                }
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * (Battle_GetMenuChoiceItem() - _menu_choice_item_first))) - battle_soul.y), 15);
            }
            battle_soul.x = battle_board.x - battle_board.left - 5 + 40;
            if (battle_soul.y = battle_button.y + 22) {
                battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * _menu_choice_enemy;
            }
            if (Input_IsPressed(INPUT.CANCEL)) {
                Battle_SetMenu(BATTLE_MENU.BUTTON);
                Anim_Destroy(battle_soul);
                Anim_Create(battle_soul, "image_angle", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.image_angle, -battle_soul.image_angle, 20);
            } else if (Input_IsPressed(INPUT.CONFIRM)) {
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_EndMenu();
                Anim_Destroy(battle_soul);
                Anim_Create(battle_soul, "image_angle", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.image_angle, -battle_soul.image_angle, 20);

            }
        } else

        //仁慈
        if (_menu == BATTLE_MENU.MERCY) {
            //上/下
            if (Input_IsPressed(INPUT.UP)) {
                var mercy = Battle_GetMenuChoiceMercy() - 1;
                if (mercy >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceMercy(mercy);
                }
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * _menu_choice_mercy)) - battle_soul.y), 15);
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var mercy = Battle_GetMenuChoiceMercy() + 1;

                if ((!Battle_IsMenuChoiceMercyOverride() && mercy <= _menu_mercy_flee_enabled) || (Battle_IsMenuChoiceMercyOverride() && mercy < Battle_GetMenuChoiceMercyOverrideNumber())) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceMercy(mercy);
                }
                Anim_Create(battle_soul, "y", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.y, (((((battle_board.y - battle_board.up) - 5) + 36) + (32 * _menu_choice_mercy)) - battle_soul.y), 15);
            }

            //灵魂位置
            battle_soul.x = battle_board.x - battle_board.left - 5 + 40;
            if (battle_soul.y = battle_button.y + 22) {
                battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * _menu_choice_enemy;
            }

            //取消/确定
            if (Input_IsPressed(INPUT.CANCEL)) {
                Battle_SetMenu(BATTLE_MENU.BUTTON);
                Anim_Destroy(battle_soul);
                Anim_Create(battle_soul, "image_angle", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.image_angle, -battle_soul.image_angle, 20);
            } else if (Input_IsPressed(INPUT.CONFIRM)) {
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_EndMenu();
                Anim_Destroy(battle_soul);
                Anim_Create(battle_soul, "image_angle", ANIM_TWEEN.CIRC, ANIM_EASE.OUT, battle_soul.image_angle, -battle_soul.image_angle, 20);
            }
        }
    }
} else {
    if (_state == BATTLE_STATE.MENU) {
        //按钮
        if (_menu == BATTLE_MENU.BUTTON) {
            //左/右
            if (Input_IsPressed(INPUT.LEFT)) {
                var button = _menu_choice_button;
                button -= 1;
                if (button < 0) {
                    button = 3;
                }
                audio_play_sound(snd_menu_switch, 0, false);
                Battle_SetMenuChoiceButton(button);
            } else if (Input_IsPressed(INPUT.RIGHT)) {
                var button = _menu_choice_button;
                button += 1;
                if (button > 3) {
                    button = 0;
                }
                audio_play_sound(snd_menu_switch, 0, false);
                Battle_SetMenuChoiceButton(button);
            }

            //确定
            if (Input_IsPressed(INPUT.CONFIRM)) {
                audio_play_sound(snd_menu_confirm, 0, false);
                switch (_menu_choice_button) {
                case 0:
                    Battle_SetMenu(BATTLE_MENU.FIGHT_TARGET);
                    break;
                case 1:
                    Battle_SetMenu(BATTLE_MENU.ACT_TARGET);
                    break;
                case 2:
                    if (Item_GetNumber() > 0) {
                        Battle_SetMenu(BATTLE_MENU.ITEM);
                    } else {
                        audio_stop_sound(snd_menu_confirm);
                    }
                    break;
                case 3:
                    Battle_SetMenu(BATTLE_MENU.MERCY);
                    break;
                }
            }
        } else

        //战斗目标
        if (_menu == BATTLE_MENU.FIGHT_TARGET) {
            //上/下
            if (Input_IsPressed(INPUT.UP)) {
                var enemy = _menu_choice_enemy - 1;
                if (enemy >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceEnemy(enemy);
                }
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var enemy = _menu_choice_enemy + 1;
                if (enemy < Battle_GetEnemyNumber()) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceEnemy(enemy);
                }
            }

            //灵魂位置
            battle_soul.x = battle_board.x - battle_board.left - 5 + 40;
            battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * _menu_choice_enemy;

            //返回
            if (Input_IsPressed(INPUT.CANCEL)) {
                Battle_SetMenu(BATTLE_MENU.BUTTON);
            }
            //确定
            if (Input_IsPressed(INPUT.CONFIRM)) {
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_SetMenu(BATTLE_MENU.FIGHT_AIM);
            }
        } else

        //战斗动画
        if (_menu == BATTLE_MENU.FIGHT_ANIM) {
            if (_menu_fight_anim_time > 0) {
                _menu_fight_anim_time -= 1;
            } else if (_menu_fight_anim_time == 0) {
                Battle_EndMenuFightAnim();
            }
        } else

        //战斗伤害
        if (_menu == BATTLE_MENU.FIGHT_DAMAGE) {
            if (_menu_fight_damage_time > 0) {
                _menu_fight_damage_time -= 1;
            } else if (_menu_fight_damage_time == 0) {
                Battle_EndMenuFightDamage();
            }
        } else

        //行动目标
        if (_menu == BATTLE_MENU.ACT_TARGET) {
            //上/下
            if (Input_IsPressed(INPUT.UP)) {
                var enemy = _menu_choice_enemy - 1;
                if (enemy >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceEnemy(enemy);
                }
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var enemy = _menu_choice_enemy + 1;
                if (enemy < Battle_GetEnemyNumber()) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceEnemy(enemy);
                }
            }

            //灵魂位置
            battle_soul.x = battle_board.x - battle_board.left - 5 + 40;
            battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * _menu_choice_enemy;

            //返回
            if (Input_IsPressed(INPUT.CANCEL)) {
                Battle_SetMenu(BATTLE_MENU.BUTTON);
            }
            //确定
            if (Input_IsPressed(INPUT.CONFIRM)) {
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_SetMenu(BATTLE_MENU.ACT_ACTION);
            }
        } else

        //行动内容
        if (_menu == BATTLE_MENU.ACT_ACTION) {
            //上/下
            if (Input_IsPressed(INPUT.UP)) {
                var action = _menu_choice_action - 2;
                if (action >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceAction(action);
                }
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var action = _menu_choice_action + 2;
                if (action < _enemy_action_number[Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy())]) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceAction(action);
                }
            }
            //左/右
            if (Input_IsPressed(INPUT.LEFT)) {
                if (_menu_choice_action % 2 == 1) {
                    var action = _menu_choice_action - 1;
                    if (action >= 0) {
                        audio_play_sound(snd_menu_switch, 0, false);
                        Battle_SetMenuChoiceAction(action);
                    }
                }
            } else if (Input_IsPressed(INPUT.RIGHT)) {
                if (_menu_choice_action % 2 == 0) {
                    var action = _menu_choice_action + 1;
                    if (action < _enemy_action_number[Battle_ConvertMenuChoiceEnemyToEnemySlot(Battle_GetMenuChoiceEnemy())]) {
                        audio_play_sound(snd_menu_switch, 0, false);
                        Battle_SetMenuChoiceAction(action);
                    }
                }
            }

            //灵魂位置
            battle_soul.x = battle_board.x - battle_board.left - 5 + 40 + 256 * (_menu_choice_action % 2);
            battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * floor(_menu_choice_action / 2);

            //返回/确定
            if (Input_IsPressed(INPUT.CANCEL)) {
                Battle_SetMenu(BATTLE_MENU.ACT_TARGET);
            } else if (Input_IsPressed(INPUT.CONFIRM)) {
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_EndMenu();
            }
        } else

        //物品
        if (_menu == BATTLE_MENU.ITEM) {
            //上/下
            if (Input_IsPressed(INPUT.UP)) {
                var slot = Battle_GetMenuChoiceItem() - 1;
                if (slot >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceItem(slot);
                }
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var slot = Battle_GetMenuChoiceItem() + 1;
                if (slot < Item_GetNumber()) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceItem(slot);
                }
            } else if (Input_IsPressed(INPUT.CANCEL)) {
                Battle_SetMenu(BATTLE_MENU.BUTTON);
            } else if (Input_IsPressed(INPUT.CONFIRM)) {
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_EndMenu();
            }

            battle_soul.x = battle_board.x - battle_board.left - 5 + 40;
            battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * (Battle_GetMenuChoiceItem() - _menu_choice_item_first);
        } else

        //仁慈
        if (_menu == BATTLE_MENU.MERCY) {
            //上/下
            if (Input_IsPressed(INPUT.UP)) {
                var mercy = Battle_GetMenuChoiceMercy() - 1;
                if (mercy >= 0) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceMercy(mercy);
                }
            } else if (Input_IsPressed(INPUT.DOWN)) {
                var mercy = Battle_GetMenuChoiceMercy() + 1;
                if ((!Battle_IsMenuChoiceMercyOverride() && mercy <= _menu_mercy_flee_enabled) || (Battle_IsMenuChoiceMercyOverride() && mercy < Battle_GetMenuChoiceMercyOverrideNumber())) {
                    audio_play_sound(snd_menu_switch, 0, false);
                    Battle_SetMenuChoiceMercy(mercy);
                }
            }

            //灵魂位置
            battle_soul.x = battle_board.x - battle_board.left - 5 + 40;
            battle_soul.y = battle_board.y - battle_board.up - 5 + 36 + 32 * _menu_choice_mercy;

            //取消/确定
            if (Input_IsPressed(INPUT.CANCEL)) {
                Battle_SetMenu(BATTLE_MENU.BUTTON);
            } else if (Input_IsPressed(INPUT.CONFIRM)) {
                audio_play_sound(snd_menu_confirm, 0, false);
                Battle_EndMenu();
            }
        }
    }
}
//对话
if (_state == BATTLE_STATE.DIALOG) {
    if (!instance_exists(_dialog[0])) {
        if (!Dialog_IsEmpty()) {
            Battle_SetDialog(Dialog_Get() + "{pause}{end}");
        } else {
            if (Battle_IsDialogAutoEnd()) {
                Battle_EndDialog();
            }
        }
    }
}

//回合准备
if (_state == BATTLE_STATE.TURN_PREPARATION) {
    if (Battle_IsTurnPreparationAutoEnd()) {
        if (!instance_exists(battle_dialog_enemy) && !Battle_IsBoardTransforming()) {
            Battle_EndTurnPreparation();
        }
    }
}

//回合内
if (_state == BATTLE_STATE.IN_TURN) {
    if (_turn_time > 0) {
        _turn_time -= 1;
    } else if (_turn_time == 0) {
        Battle_EndTurn();
    }
}

//面板重置
if (_state == BATTLE_STATE.BOARD_RESETTING) {
    if (!Battle_IsBoardTransforming()) {
        Battle_CallEnemyEvent(BATTLE_ENEMY_EVENT.BOARD_RESETTING_END);
        Battle_GotoNextState();
    }
}

if (_state == BATTLE_STATE.RESULT) {
    if (!instance_exists(_dialog[0])) {
        Battle_End();
    }
}

//检查战斗结束
if (_state != BATTLE_STATE.RESULT && Battle_GetEnemyNumber() == 0) {
    Battle_SetState(BATTLE_STATE.RESULT);
    Battle_SetNextState(BATTLE_STATE.RESULT);
    BGM_Stop(5);
    var text = "{define `EXP` " + string(Battle_GetRewardExp()) + "}{define `GOLD` " + string(Battle_GetRewardGold()) + "}";
    text += "* You WON!&* You earned {insert EXP} EXP and {insert GOLD} GOLD.";
    Player_SetExp(Player_GetExp() + Battle_GetRewardExp());
    Player_SetGold(Player_GetGold() + Battle_GetRewardGold());
    if (Player_UpdateLv()) {
        text += "&" + "* Your LOVE increased.";
        audio_play_sound(snd_level_up, 0, false);
    }
    text += "{pause}{end}";
    Battle_SetDialog(text);
}