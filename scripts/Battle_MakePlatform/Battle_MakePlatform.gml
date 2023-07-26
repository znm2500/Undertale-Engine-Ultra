///@arg x,y,*obj,*sticky,*width,*angle,*hspeed,*vspeed,*bounce,*auto_destroy
function Battle_MakePlatform(){
var OBJ=battle_platform
var _x=argument[0]
var _y=argument[1]
if(argument_count>2){
OBJ=argument[2]}
var a=instance_create_depth(_x,_y,0,OBJ)
if(argument_count>3){
a.sticky=argument[3]}
if(argument_count>4){
a.width=argument[4]}
if(argument_count>5){
a.angle=argument[5]}
if(argument_count>6){
a.hspeed=argument[6]}
if(argument_count>7){
a.vspeed=argument[7]}
if(argument_count>8){
a.bounce=argument[8]}
if(argument_count>9){
a.auto_destroy=argument[9]}
return a
}