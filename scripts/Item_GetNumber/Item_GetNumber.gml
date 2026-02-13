function Item_GetNumber() {
    var items = Item_GetInventoryItems();
    return items.GetCount();
}
function Phone_GetNumber() {
    var phones = Item_GetInventoryPhones();
    return phones.GetCount();
}
