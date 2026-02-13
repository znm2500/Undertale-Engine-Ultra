function Player_SetKr() {
    if (global.kr) {
        return Storage_GetStaticGeneral().Set(FLAG_STATIC_KR,argument[0]);
    }

}