<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>
<jsp:include page="../testHeader.jsp"></jsp:include>
<body>
	<form action="" method="post">
		비밀번호 <input type="password" name="userpw" id="pw"><br>
		비밀번호확인 <input type="password" id="pw2"><br>
		<input type="button" value="확인" onclick="change(this.form)">
		<input type="hidden" value="${userid }" name="userid">
	</form>
</body>
<jsp:include page="../testFooter.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	function change(f){
		if(f.pw.value==''){
			alert("비밀번호를 입력해주세요.");
			return;
		}else if(f.pw2.value=='' || f.pw.value != f.pw2.value){
			alert("비밀번호를 확인해주세요.");
			return;
		}
		
		var userid = f.userid.value;
		var userpw = f.userpw.value;
		console.log(userid);
		console.log(userpw);
		
		$.ajax({	
	      	type : 'post',
	     	url : 'pwChange',
	      	data: {userid:userid,userpw:userpw},
	     	success : function(result){ 
	     		alert("비밀번호를 변경했습니다.");
	     		location.href="http://localhost:8080/user/login"
	      	},
	      	error : function(result){
	      		console.log(result.responseText);
	      	}
		});
	}
</script>
</html>