<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<button id="my-button1">리뷰모달</button>
<button id="my-button2">예약모달</button>
<button id="my-button3">게임 1 랜덤추천</button>
<button id="my-button4">월드컵 게임</button>
<button id="my-button5">시험페이지</button>

<script>
	document.getElementById("my-button1").onclick = function(){
		location.href="/store/addrvpage"
	}
	document.getElementById("my-button2").onclick = function(){
		location.href="/store/bookpage"
	}
	document.getElementById("my-button3").onclick = function(){
		location.href="/game/game1page"
	}
	document.getElementById("my-button4").onclick = function(){
		location.href="/game/game2page"
	}
	document.getElementById("my-button5").onclick = function(){
		location.href="/store/testpage"
	}
</script>
</body>
</html>