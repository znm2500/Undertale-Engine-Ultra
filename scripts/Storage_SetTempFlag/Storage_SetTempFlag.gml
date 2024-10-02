function Storage_SetTempFlag(flag,value){
var z=Storage_GetTempGeneral();
z.Set(flag,value);
return z;
}