<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form action="" method="post">
		id<input type="text" name="userid"><br>
		pw<input type="text" name="userpw" id="userpw"><br>
		pw확인<input type="text" id="userpw2"><b id="pwchecked"></b><br>
		이름<input type="text" name="username"><br>
		생일<input type="text" name="userbirth"><br>
		번호<input type="text" name="userphone"><br>
		이메일<input type="text" name="useremail"><br>
		<!-- 이메일 중복체크 해야함 -->
		
		
		<input type="button" value="회원가입" id="regBtn" onclick="check(this.form)">
		<input type="reset" value="다시입력">
		
		
		<input type="hidden" name="authList" value="buisness">
	</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	function check(f){
		if(f.userid.value==''){
			alert("아이디를 입력해주세요.");
			return;
		}else if(f.userpw.value==''){
			alert("비밀번호를 입력해주세요.");
			return;
		}else if($("#userpw2").val()==''){
			alert("비밀번호를 확인해주세요.");
			return;
		}else if(f.username.value==''){
			alert("이름을 입력해주세요.");
			return;
		}else if(f.userbirth.value==''){
			alert("생일을 입력해주세요.");
			return;
		}else if(f.userphone.value==''){
			alert("번호를 입력해주세요.");
			return;
		}else if(f.useremail.value==''){
			alert("이메일를 입력해주세요.");
			return;
		}
		
		f.action="reg_buisness" 
		f.submit();
	}
	$('#userpw2').focusout(function() {
		if($(this).val()==$("#userpw").val()){
			$("#pwchecked").html("");
		}else{
			$("#pwchecked").html("비밀번호를 확인해주십시오");
		}
	});
</script>
</html>