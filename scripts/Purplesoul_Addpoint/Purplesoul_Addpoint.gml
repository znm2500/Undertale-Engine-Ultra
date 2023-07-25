function Point() constructor{
xx=battle_soul.x
yy=battle_soul.y
vertical=0
horizontal=1
}
///@arg xx,yy,vertical,horizontal
function Purplesoul_Addpoint(){
	var p=new Point()
	p.xx=argument[0]
	p.yy=argument[1]
	p.vertical=argument[2]
	p.horizontal=argument[3]
	if(instance_exists(battle_soul_purple)){array_push(battle_soul_purple.point,p)}
return p

}