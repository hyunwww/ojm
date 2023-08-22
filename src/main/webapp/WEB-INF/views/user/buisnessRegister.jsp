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
		id<input type="text" name="userid" id="userid">
		<input type="button" value="중복확인" onclick="idCheck()"><br>
		
		pw<input type="text" name="userpw" id="userpw"><br>
		pw확인<input type="text" id="userpw2"><b id="pwchecked"></b><br>
		이름<input type="text" name="username"><br>
		생일<input type="text" name="userbirth" placeholder="생년월일 6자리" maxlength="6"><br>
		번호<input type="text" name="userphone"><br>
		이메일<input type="text" name="useremail"><br>
		
		<input type="button" value="회원가입" id="regBtn" onclick="check(this.form)">
		<input type="reset" value="다시입력">
		<input type="button" value="홈으로" id="homeBtn">
	</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var idChecked=false;
	
	
	
	function check(f){
		if(f.userid.value==''){
			alert("아이디를 입력해주세요.");
			return;
		}else if(!idChecked){
			alert("중복 확인을 해주세요.");
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
			alert("생년월일을 입력해주세요.");
			return;
		}else if(!checkBirth(f.userbirth.value)){
			alert("올바른 생년월일을 입력해주세요.");
			return;
		}else if(f.userphone.value==''){
			alert("번호를 입력해주세요.");
			return;
		}else if(!checkPhone(f.userphone.value)){
			alert("번호를 확인해주세요.");
			return;
		}else if(f.useremail.value==''){
			alert("이메일를 입력해주세요.");
			return;
		}else if(!checkEmail(f.useremail.value)){
			alert("올바른 메일 주소를 입력해주세요.");
			return;
		}
		
		f.action="regBuisness" 
		f.submit();
	}
	
	$("#homeBtn").on("click",function(){
		location.href="/";
	});
	
	$('#userpw2').focusout(function() {
		if($(this).val()==$("#userpw").val()){
			$("#pwchecked").html("");
		}else{
			$("#pwchecked").html("비밀번호를 확인해주십시오");
		}
	});
	
	function idCheck(){
		var userid = $("#userid").val();
		console.log(userid);
		if(userid==''){
			alert("아이디를 입력해주세요.");
			return;
		}
		
		$.ajax({	
	      	type : 'post',
	     	url : 'userIdCheck',
	      	data: {userid:userid},
	     	success : function(){ 
	     		alert("가입 가능한 아이디입니다")
	     		idChecked=true;
	      	},
	      	error : function(result){
	      		console.log(result.responseText);
	      		alert("중복된 아이디입니다.")
	      		idChecked=false;
	      	}
		});
	}
	
	function checkEmail(email) {
		var ex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return ex.test(email);
	}
	function checkPhone(phone){
		var ex = /^(010|011|016|017|018|019)([0-9]{3,4}[0-9]{4})$/;
		return ex.test(phone);
	}
	function checkBirth(birth){
		var ex = /^([0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
		return ex.test(birth);
	}
</script>
</html>