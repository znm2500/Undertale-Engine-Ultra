/// @description 在此处插入描述 
// 你可以在此编辑器中写入
BlueSoulControl(DIR.RIGHT)
//Battle_MakeGB(0,0,320,320,-90,0,2,2,0)
var a=new Bezier_Struct(0,0,1,1)
a.AddPoint(0.1,0.2)
a.AddPoint(0.3,0.6)
a.AddPoint(1.7,0.8)
Anim_Create(battle_board,"x",ANIM_TWEEN.BEZIER,[a,BEZIER_COMPONENT.X],10,300,120)
Anim_Create(battle_board,"y",ANIM_TWEEN.BEZIER,[a,BEZIER_COMPONENT.Y],10,300,120)