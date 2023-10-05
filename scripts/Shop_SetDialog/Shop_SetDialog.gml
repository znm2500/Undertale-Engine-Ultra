function Shop_SetDialog(title, title_blend, text, next_dialog=noone) {
    var inst = instance_create_depth(0, 0, 0, shop_dialog);
    inst.title = title;
    inst.title_blend = title_blend;
    inst.text = text;
    inst.next_dialog = next_dialog;
	return inst;
}
