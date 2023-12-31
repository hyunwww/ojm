<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<jsp:include page="../testHeader.jsp"></jsp:include>
<body>
	<form action="/user/findPwCheck" method="post" id="form">
		아이디 <input type="text" name="userid"><br>
		이메일 <input type="text" name="useremail"><br>
		<input type="button" name="pwBtn" value="비밀번호찾기">
		<input type="button" name="homeBtn" value="홈으로">
	</form>
</body>
<jsp:include page="../testFooter.jsp"></jsp:include>
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
		}else if(email.val()==''){	// 메일 정규식 필요, 아이디 메일 일치여부 확인 필요
			alert("이메일을 입력해주세요");
			return;
		}else if(!checkEmail(email.val())){
			alert("이메일 형식이 올바르지 않습니다.");
			return;
		}
		form.submit();
	});
	home.on("click",function(){
		location.href="/";
	});
	
	function checkEmail(email) {
		var ex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return ex.test(email);
	}
</script>
</html>