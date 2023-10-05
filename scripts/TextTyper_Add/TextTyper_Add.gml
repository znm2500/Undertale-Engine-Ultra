function TextTyper_Add(x, y, depth=-1000, text) {
    var inst = instance_create_depth(x, y, depth, text_typer);
    inst.text = text;
    return inst;
}