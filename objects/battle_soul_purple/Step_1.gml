px = [];
py = [];

for (var i = 0; i < array_length(point); i++) { 
	if(point[i].horizontal){array_push(py,point[i].yy)}
	if(point[i].vertical){array_push(px,point[i].xx)}
    
}


h_moving = 0;
v_moving = 0;

for (var i = 0; i < array_length(px); i++) {
    if (x >= px[i] - 5 && x <= px[i] + 5 ) {
        v_moving = 1;
        x_on = px[i];
    }}
for (var i = 0; i < array_length(py); i++) {
    if (y >= py[i] - 5 && y <= py[i] + 5 ) {
        y_on = py[i];
        h_moving = 1;
    }      
	
}
array_sort(px,true)
array_sort(py,true)
for (var i = 0; i < array_length(px); i++) {
   if(x_on=px[i]){x_index=i}
    }
for (var i = 0; i < array_length(py); i++) {
   if(y_on=py[i]){y_index=i}
    }      
	

