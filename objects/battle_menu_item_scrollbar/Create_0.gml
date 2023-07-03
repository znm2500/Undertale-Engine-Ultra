depth=DEPTH_BATTLE.UI_HIGH;
x=battle_board.x+battle_board.right-16;
y=battle_board.y;
moveable=0;
_arrow=0;

NUMBER=Item_GetNumber();
alpha=0
yy1=y-10*floor(1/2)-10-_arrow
yy2=y-10*floor(1/2)+10*1+_arrow
yy=[]
yd=y
Anim_Create(id,"alpha",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,0,1,30)
text_typer.intro=0
Anim_Create(id,"yy1",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,yy1,y-10*floor(NUMBER/2)-10-_arrow-yy1,20);
Anim_Create(id,"yy2",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,yy2,y-10*floor(NUMBER/2)+10*NUMBER+_arrow-yy2,20)
var proc=0;



var a=0
repeat(NUMBER){a+=1
	yy[a]=instance_create_depth(x,y,0,battle_menu_item_dot)
	Anim_Create(yy[a],"y",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,y,-10*floor(NUMBER/2)+10*proc,20)
	proc+=1;
}

alarm[0]=21;