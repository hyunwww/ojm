<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
	<form action="/user/findPwCheck" method="post" id="form">
		아이디 <input type="text" name="userid"><br>
		이메일 <input type="text" name="useremail"><br>
		<input type="button" name="pwBtn" value="비밀번호찾기">
		<input type="button" name="homeBtn" value="홈으로">
	</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var form = $("#form");
	var id = $("form [name='userid']");
	var email = $("form [name='useremail']");
	var pwBtn = $("form [name='pwBtn']");
	var home = $("form [name='homeBtn']");

	pwBtn.on("click",function(){
		if(id.val()==''){
			alert("아이디를 입력해주세요");
			return;
		}else if(email.val()==''){
			alert("이메일을 입력해주세요");
			return;
		}
		form.submit();
	});
	home.on("click",function(){
		location.href="/";
	});
</script>
</html>