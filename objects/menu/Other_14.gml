///@desc Name Check
var text="";
var valid=true;
switch(string_lower(_naming_name)){
	default:
		text="Is this name correct?";
		break;
	case "aaaaaa":
		text="Not very creative...?";
		break;
	case "alphys":
		text="D-don't do that.";
		valid=false;
		break;
	case "alphy":
		text="Uh.... OK?";
		break;
	case "asgore":
		text="You cannot.";
		valid=false;
		break;
	case "toriel":
		text="I think you should&think of your own&name, my child.";
		valid=false;
		break;
	case "asriel":
		text="...";
		valid=false;
		break;
	case "flowey":
		text="I already CHOSE&that name.";
		valid=false;
		break;
	case "sans":
		text="nope.";
		valid=false;
		break;
	case "papyru":
		text="I'LL ALLOW IT!!!!";
		break;
	case "undyne":
		text="Get your OWN name!";
		valid=false;
		break;
	case "mtt":
	case "metta":
	case "mett":
		text="OOOOH!!! ARE YOU&PROMOTING MY BRAND?";
		break;
	case "chara":
		text="The true name.";
		break;
}

_confirm_title=text;
_confirm_valid=valid;