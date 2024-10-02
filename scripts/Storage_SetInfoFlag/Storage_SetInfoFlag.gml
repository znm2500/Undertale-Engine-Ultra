function Storage_SetInfoFlag(flag,value){
var z=Storage_GetInfoGeneral();
z.Set(flag,value);
return z;
}