array_delete(global.boards_array, array_find_index(global.boards_array, function(a,index){
return a==self;
}), 1);
ds_list_destroy(listVertex);
ds_list_destroy(listVertex_Outline);
ds_list_destroy(listDivideIndex);