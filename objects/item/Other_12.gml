///@desc Drop
var rand=irandom(18);
var sub=0;
if(rand>3){
	sub="* The {insert ITEM} was&  thrown away.";
}else if(rand==0){
	sub="* You bid a quiet farewell&  to the {insert ITEM}.";
}else if(rand==1){
	sub="* You put the {insert ITEM}&  on the ground and gave it a&  little pat.";
}else if(rand==2){
	sub="* You threw the {insert ITEM}&  on the ground like the piece&  of trash it is.";
}else if(rand==3){
	sub="* You abandoned the &  {insert ITEM}.";
}
Dialog_Add("{define `ITEM` `"+_name+"`}"+sub);
Dialog_Start();

Item_Remove(_item_slot);

instance_destroy();