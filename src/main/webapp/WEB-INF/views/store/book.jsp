<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.clock{
	font-size: 20px;
	color: black;
	}
</style>
<script type="text/javascript">
	function showClock(){
		var currentshowDate = new Date();
		var divClock = document.getElementById('divClock');
		var msg = "time : ";
			msg += currentshowDate.getFullYear();
			msg += "년 ";
			msg += currentshowDate.getMonth()+1;
			msg += "월 ";
			msg += currentshowDate.getDate();
			msg += "일 ";
		if(currentshowDate.getHours()>12){
			msg += "오후 ";
			msg += currentshowDate.getHours() - 12 + "시 ";
		}else{
			msg += "오전 ";
			msg += currentshowDate.getHours() + "시 ";
		}
			msg +=  currentshowDate.getMinutes()+"분 ";
			msg +=  currentshowDate.getSeconds()+"초";
			
			divClock.innerText = msg;
			
			if(currentshowDate.getMinutes()>58){
				divClock.style.color="red";
			}
			setTimeout(showClock,1000);
	}
	function timecheck(){
		var currentDate = new Date();
		var isDate;
		var isHours;
		if(currentDate.getDate != isDate){
			
		}else if(currentDate.getHours != isHours){
			
		}
	}
</script>
</head>
<body onload="showClock()">
	<input type="date" onclick="timecheck()"><br />
	<div id="divClock" class="clock"></div>
</body>
</html>