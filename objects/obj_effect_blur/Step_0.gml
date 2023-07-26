var numObjects = instance_number(obj_effect_blur)

// 判断物体数量是否大于1
if (numObjects > 1) {
   if (id != instance_id[0]) {
            instance_destroy();}
}