<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="btns">
		<br><br>
		<input type="button" class="btn" value="main" data-page="main">
		<input type="button" class="btn" value="board" data-page="board">
		<input type="button" class="btn" value="book" data-page="book">
		<input type="button" class="btn" value="jboard" data-page="jboard">
		<input type="button" class="btn" value="qboard" data-page="qboard">
		<input type="button" class="btn" value="review" data-page="review">
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	// 버튼클릭	
	$(".btn").on("click",function(){
		var tv = this.value;
		if(tv=='main'){
			location.href="/user/myPage/main";
		}else if(tv=='board'){
			location.href="/user/myPage/board";
		}else if(tv=='book'){
			location.href="/user/myPage/book";
		}else if(tv=='jboard'){
			location.href="/user/myPage/jboard";
		}else if(tv=='qboard'){
			location.href="/user/myPage/qboard";
		}else if(tv=='review'){
			location.href="/user/myPage/review";
		}
	});
</script>
</html>