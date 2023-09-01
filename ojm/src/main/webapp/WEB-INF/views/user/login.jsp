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
<style type="text/css">
	#box{
		width:300px;
		margin:200px auto;
	}
	.input-box{
	  position:relative;
	}
	.input-box > input{
	  background:transparent;
	  border:none;
	  border-bottom: solid 1px #ccc;
	  padding:20px 0px 5px 0px;
	  font-size:14pt;
	  width:100%;
	}
	input::placeholder{
		color:transparent;
	}
	input:placeholder-shown + label{
	  color:#aaa;
	  font-size:14pt;
	  top:15px;
	}
	input:focus + label, label{
	  color:#8aa1a1;
	  font-size:10pt;
	  pointer-events: none;
	  position: absolute;
	  left:0px;
	  top:0px;
	  transition: all 0.2s ease ;
	  -webkit-transition: all 0.2s ease;
	  -moz-transition: all 0.2s ease;
	  -o-transition: all 0.2s ease;
	}
	input:focus, input:not(:placeholder-shown){
	  border-bottom: solid 1px #8aa1a1;
	  outline:none;
	}
</style>
</head>
<jsp:include page="../testHeader.jsp"></jsp:include>
<body>
	<div id="box">
		<form action="login" method="post" id="loginForm">
			<div class="input-box">
	            <input id="username" type="text" name="username" placeholder="아이디">
	            <label for="username">아이디</label>
	        </div>
			<div class="input-box">
				<input id="password" type="password" name="password" placeholder="비밀번호">
				<label for="password">비밀번호</label>
			</div>
			
			<input type="button" name="loginBtn" value="로그인">
			<input type="button" name="registerBtn" value="회원가입">
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
		</form>
	<a href="findID" style="width:100px">아이디 찾기</a> / <a href="findPw">비밀번호 찾기</a>
	</div>
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