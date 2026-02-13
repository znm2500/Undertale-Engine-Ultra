// Override GetName OnUse OnInfo OnDrop(optional) to make an useful item type.
// OnDrop already has a default implementation.
function ItemType() constructor {
    _name = "";
    _info = "";
    _price_buy = 0;
    _price_sell = 0;
    _shop_description = "";
    _use = "";
    _drop = "";
    function GetName() {
        return _name;
    }

    function OnUse(inventory, index) {}
    function OnInfo(inventory, index) {}
    function OnDrop(inventory, index) {
        var rand = irandom(18);
        var sub = "* The {insert ITEM} was&  thrown away.";
        switch (rand) {
        case 0:
            sub = "* You bid a quiet farewell&  to the {insert ITEM}.";
            break;
        case 1:
            sub = "* You put the {insert ITEM}&  on the ground and gave it a&  little pat.";
            break;
        case 2:
            sub = "* You threw the {insert ITEM}&  on the ground like the piece&  of trash it is.";
            break;
        case 3:
            sub = "* You abandoned the &  {insert ITEM}.";
            break;
        }
        Dialog_Add("{define `ITEM` `" + GetName() + "`}" + sub);
        Dialog_Start();

        inventory.Remove(index);
    }
}

// ItemTypeSimple base receives a name localization key.
// It automatically sets up GetName to show the localized name "item.key.name"
// and OnInfo to show the localized dialog "item.key.info"
function ItemTypeSimple(name, info) : ItemType() constructor {
    self._name = name;
    self._info = info;
    function OnInfo(inventory, index) {
        Dialog_Add(_info);
        Dialog_Start();
    }
}

#macro ITEM_EMPTY ""
#macro FALLBACK_ITEM_NAME_EMPTY "!EMPTY!"
#macro FALLBACK_ITEM_NAME_UNDEFINED "!UNDEFINED!"

function ItemTypeManager() : RegisterManager() constructor {
    function GetNameOrFallback(id) {
        if (id == ITEM_EMPTY) {
            return FALLBACK_ITEM_NAME_EMPTY;
        }
        var itemType = GetOrUndefined(id);
        if (is_undefined(itemType)) {
            return FALLBACK_ITEM_NAME_UNDEFINED;
        }
        return itemType.GetName();
    }
    function IsValid(itemId) {
        return itemId != ITEM_EMPTY && Contains(itemId);
    }
    function IsEmptyOrValid(itemId) {
        return itemId == ITEM_EMPTY || Contains(itemId);
    }
}