function Storage_GetStaticFlag(flag,defaultValue=0){
return Storage_GetStaticGeneral().Get(flag,defaultValue);
}