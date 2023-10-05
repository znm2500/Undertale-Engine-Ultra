///@arg index
function Shop_GetDialogTitle() {
var INDEX = argument[0];

if (INDEX < 4 && INDEX >= 0) {
    var blt = shop._host.dialog[INDEX];

    var TITLE = string(blt.title);

    var BLEND = blt.title_blend;

    switch (BLEND) {
        case c_white:
            BLEND = "`white`";
            break;
        case c_yellow:
            BLEND = "`yellow`";
            break;
        case c_red:
            BLEND = "`red`";
            break;
        case c_rainbow:
            BLEND = "`rainbow`";
            break;
    }

    var RESULT = "{color " + BLEND + "}" + TITLE;

   
    return RESULT;
} else
    return false;
}