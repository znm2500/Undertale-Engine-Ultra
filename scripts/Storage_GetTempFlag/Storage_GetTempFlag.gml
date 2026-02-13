
function Storage_GetTempFlag(flag,defaultValue=0){
return Storage_GetTempGeneral().Get(flag,defaultValue);
}