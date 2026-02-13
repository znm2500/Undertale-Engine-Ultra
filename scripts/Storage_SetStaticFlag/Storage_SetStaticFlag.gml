function Storage_SetStaticFlag(flag,value){
var z=Storage_GetStaticGeneral();
z.Set(flag,value);
return z;
}