<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<textarea rows="10" cols="50">약관</textarea>
	<br><br>
	<input type="button" value="일반 회원가입" id="reg_user">
	<input type="button" value="사업자 회원가입" id="reg_buisness">
	<input type="button" value="홈으로" id="homeBtn">
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$("#reg_user").on("click",function(){
		location.href="reg_user";
	});
	$("#reg_buisness").on("click",function(){
		location.href="regBuisness";
	});
</script>
</html>