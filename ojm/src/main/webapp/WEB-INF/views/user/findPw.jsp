<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
	<form action="" method="post" id="form">
		이름 <input type="text" name="username"><br>
		휴대전화 <input type="text" name="userphone"><br>
		<input type="button" name="loginBtn" value="아이디찾기">
		<input type="button" name="registerBtn" value="회원가입">
	</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var form = $("#form");
	var name = $("form [name='username']");
	var phone = $("form [name='userphone']");
	var login = $("form [name='loginBtn']");
	var home = $("form [name='registerBtn']");

	login.on("click",function(){
		if(name.val()==''){
			alert("이름을 입력해주세요");
			return;
		}else if(phone.val()==''){
			alert("전화번호를 입력해주세요");
			return;
		}
		form.action="user/findPw";
		form.submit();
	});
	home.on("click",function(){
		location.href="/user/register";
	});
</script>
</html>