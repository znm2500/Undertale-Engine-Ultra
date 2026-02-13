function Battle_Dialog_Enemy_Add(x, y, depth=-1000, text, template=0) {
    var inst = instance_create_depth(x, y, depth, battle_dialog_enemy);
    inst.text = text;
	inst.template=template;
    return inst;
}