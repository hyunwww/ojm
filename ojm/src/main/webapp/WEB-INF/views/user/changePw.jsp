<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>
<body>
	<form action="" method="post">
		비밀번호 <input type="text" name="userpw" id="pw"><br>
		비밀번호확인 <input type="text" id="pw2"><br>
		<input type="button" value="확인" onclick="change(this.form)">
		<input type="hidden" value="${userid }" name="userid">
	</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	function change(f){
		if(f.pw.value==''){
			alert("비밀번호를 입력해주세요.");
		}else if(f.pw2.value=='' || f.pw.value != f.pw2.value){
			alert("비밀번호를 확인해주세요.");
		}
		
		var userid = f.userid.value;
		var userpw = f.userpw.value;
		
		$.ajax({	
	      	type : 'post',
	     	url : 'pwChange',
	      	data: {userid:userid,userpw:userpw},
	     	success : function(result){ 
	     		alert("비밀번호를 변경했습니다.");
	     		location.href="redirect:/login"
	      	},
	      	error : function(result){
	      		console.log(result.responseText);
	      	}
		});
	}
</script>
</html>