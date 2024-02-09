/// @description Insert description here
// You can write your code in this editor
map=ds_map_create()
ds_map_add(map,"sas",0)
li=ds_list_create()
ds_list_add(li,0)
grid=ds_grid_create(400,200)
ds_grid_add(grid,20,15,10)
Anim_Create(li,0,2,1,50,200,30,20)

Anim_Create(map,"sas",2,1,10,200,30,20)
Anim_Create(grid,[20,15],2,1,20,210,30,20)









// Inherit the parent event
event_inherited();

