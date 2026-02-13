function Shop_Start(shop_id) {

    if (Shop_IsExists(shop_id)) {

        var z = Storage_SetTempFlag(FLAG_TEMP_SHOP, shop_id);
		z.Set(FLAG_TEMP_SHOP_ROOM_RETURN, room);
        room_persistent = true;

        room_goto(room_shop);

        return true;
    } else {

        return false;
    }
}