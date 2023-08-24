///@arg string
function GetColorFromString() {
	var STR=argument[0];

	var color=c_white;
	switch(STR){
		case "white":
			color=c_white;
			break;
		case "black":
			color=c_black;
			break;
		case "red":
			color=c_red;
			break;
		case "yellow":
			color=c_yellow;
			break;
		case "gray":
			color=c_gray;
			break;
		case "gray_dark":
			color=c_dkgray;
			break;
		case "gray_light":
			color=c_ltgray;
			break;
			case "rainbow":
			color=9000;
			break;
	}
	return color;


}
/// @arg col1,col2
function Blend_Color(){
    var c1 = argument[0];
    var c2 = argument[1];
    var red = color_get_red(c1) * color_get_red(c2) / 255;
    var green = color_get_green(c1) * color_get_green(c2) / 255;
    var blue = color_get_blue(c1) * color_get_blue(c2) / 255;
    return make_color_rgb(red, green, blue);
}

