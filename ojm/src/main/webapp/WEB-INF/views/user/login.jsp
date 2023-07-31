<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<form action="login" method="post" id="loginForm">
		id <input type="text" name="id"><br>
		pw<input type="password" name="pw"><br>
		<input type="button" name="loginBtn" value="로그인">
		<input type="button" name="registerBtn" value="회원가입">
	</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var form = $("#loginForm");
	var id = $("form [name='id']");
	var pw = $("form [name='pw']");
	var login = $("form [name='loginBtn']");
	var home = $("form [name='registerBtn']");

	login.on("click",function(){
		if(id.val()==''){
			alert("아이디를 입력해주세요");
			return;
		}else if(pw.val()==''){
			alert("비밀번호를 입력해주세요");
			return;
		}
		form.submit();
	});
	home.on("click",function(){
		location.href="/user/register";
	});
</script>
</html>