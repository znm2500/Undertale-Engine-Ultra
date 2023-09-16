var numObjects = instance_number(obj_effect_blur)

if (numObjects > 1) {
   if (id != instance_id[0]) {
            instance_destroy();}
}