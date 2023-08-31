<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/javascript">
	console.log('${errorMessage}')
	if('${errorMessage}' != ''){
		alert('${errorMessage}');
		location.href='/user/login';
	}
</script>
</head>
<jsp:include page="../testHeader.jsp"></jsp:include>
<body>
	<form action="login" method="post" id="loginForm">
		id <input type="text" name="username"><br>
		pw<input type="password" name="password"><br>
		<input type="button" name="loginBtn" value="로그인">
		<input type="button" name="registerBtn" value="회원가입">
		
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
	</form>
	<a href="findID">아이디 찾기</a> / <a href="findPw">비밀번호 찾기</a>
</body>
<jsp:include page="../testFooter.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var form = $("#loginForm");
	var id = $("form [name='username']");
	var pw = $("form [name='password']");
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