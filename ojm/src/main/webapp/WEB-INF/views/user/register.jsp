<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<jsp:include page="../testHeader.jsp"></jsp:include>
<body>
	<textarea rows="10" cols="50">약관</textarea>
	<br><br>
	<input type="button" value="일반 회원가입" id="reg_user">
	<input type="button" value="사업자 회원가입" id="reg_buisness">
	<input type="button" value="홈으로" id="homeBtn">
</body>
<jsp:include page="../testFooter.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$("#reg_user").on("click",function(){
		location.href="regUser";
	});
	$("#reg_buisness").on("click",function(){
		location.href="regBuisness";
	});
	$("#homeBtn").on("click",function(){
		location.href="/";
	});
</script>
</html>