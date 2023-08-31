<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<jsp:include page="../testHeader.jsp"></jsp:include>
<body>
	<form action="/user/findIDCheck" method="post" id="form">
		이름 <input type="text" name="username"><br>
		이메일 <input type="text" name="useremail"><br>
		<input type="button" name="loginBtn" value="아이디찾기">
		<input type="button" name="registerBtn" value="회원가입">
	</form>
</body>
<jsp:include page="../testFooter.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var form = $("#form");
	var uname = $("form [name='username']");
	var email = $("form [name='useremail']");
	var login = $("form [name='loginBtn']");
	var home = $("form [name='registerBtn']");

	login.on("click",function(){
		if(uname.val()==''){
			alert("이름을 입력해주세요");
			return;
		}else if(email.val()==''){
			alert("전화번호를 입력해주세요");
			return;
		}
		form.submit();
	});
	home.on("click",function(){
		location.href="/user/register";
	});
</script>
</html>