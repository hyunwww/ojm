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
		<input type="button" class="btn" data-page="main" value="내 정보">
		<input type="button" class="btn" data-page="board" value="내 게시글">
		<input type="button" class="btn" data-page="book" value="예약목록">
		<input type="button" class="btn" data-page="jboard" value="내 구직">
		<input type="button" class="btn" data-page="qboard" value="Q&A">
		<input type="button" class="btn" data-page="review" value="내 리뷰">
		<input type="button" class="btn" data-page="report" value="신고목록">
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	// 버튼클릭	
	$(".btn").on("click",function(){
		var tv = $(this).data("page");
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
		}else if(tv=='report'){
			location.href="/user/myPage/report";
		}
	});
</script>
</html>