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
		<input type="button" class="btn" value="store" data-page="board">
		<input type="button" class="btn" value="book" data-page="book">
		<input type="button" class="btn" value="jboard" data-page="jboard">
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	// 버튼클릭	
	$(".btn").on("click",function(){
		var tv = this.value;
		if(tv=='main'){
			location.href="/user/myPage/b/main";
		}else if(tv=='store'){
			location.href="/user/myPage/b/store";
		}else if(tv=='book'){
			location.href="/user/myPage/b/book";
		}else if(tv=='jboard'){
			location.href="/user/myPage/b/jboard";
		}
	});
</script>
</html>