
/// @param bezier
/// @param percentage
function scr_bezier_get_value(_bezier,perc)
{
	var startPoint = _bezier[$ "startPoint"];
	var lastPoint = _bezier[$ "lastPoint"];
	var points = _bezier[$ "points"];
	// 获取数据
	
	var allPoints=[];
	allPoints[0] = startPoint; // 添加第一个点的位置
	allPoints=array_concat(allPoints,points); // 数组链接(旧版本可以自己写一个数组连接函数)
	array_push(allPoints,lastPoint); // 添加第末尾点的位置
	// 得到要计算的所有点位置
	
	var normalization = perc/100; // 计算归一化百分比
	var tempPoints=allPoints; // 临时点数组
	var nextTempPoints=[]; // 下一维度临时点数组
	var tempPointsNumber = array_length(tempPoints); // 临时点数量
	while(tempPointsNumber>1){
		nextTempPoints=[];
		for(var i=0;i<tempPointsNumber-1;i++){
			var point1 = tempPoints[i];
			var point2 = tempPoints[i+1];
			// 得到点和下一个点的位置
			var nextPoint=[];
			nextPoint[0]=lerp(point1[0],point2[0],normalization);
			nextPoint[1]=lerp(point1[1],point2[1],normalization);
			// 计算两点连线下一维度的点的位置
			
			nextTempPoints[i]=nextPoint;
		}
		tempPointsNumber=array_length(nextTempPoints); // 得到临时点数量
		tempPoints=nextTempPoints;
	}
	return(tempPoints[0]);
}

// 传入一个贝塞尔曲线,返回进度 百分之"perc" 的点位置