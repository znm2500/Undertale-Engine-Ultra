event_inherited();

encounter_text = -1;

menu_text = "* LOL";

host_sprite = spr_shopkeeper

shop_item[0] = ITEM_TOY_KNIFE;
shop_item[1] = ITEM_STICK;
shop_item[2] = ITEM_BANDAGE;
shop_item[3] = ITEM_FADED_RIBBON;
buy_before_text = "Buy&something?";
//buy_choice_text = "Are&you&ready?";
buy_after_text = "Oh,&that's&good.";
buy_false_text_0 = "Lack money.";
buy_false_text_1 = "Too much&Items.";

sold_available = true;
//sold_before_text = -1;
//sold_choice_text = -1;
//sold_after_text = -1;
sold_false_text = "* Refuse selling.";

dialog_before_text = "Dialog.";
dialog[0] = Shop_SetDialog("111",c_rainbow,"awa");
dialog[1] = Shop_SetDialog("adadaa",c_red,"sj");
dialog[2] = Shop_SetDialog("adad",c_white,"awa");
dialog[3] = Shop_SetDialog("adrk",c_white,"awa",Shop_SetDialog("dj",c_white,"new"));
//dialog[0] = sdt_1_1;
//dialog[1] = sdt_2_1;
//dialog[2] = sdt_3_1;
//dialog[3] = sdt_4_1;
exit_text = "* ByeBye.";