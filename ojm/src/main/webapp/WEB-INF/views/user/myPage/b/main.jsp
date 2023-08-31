<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.ojm.security.domain.CustomUser" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<script type="text/javascript">

</script>
</head>

<body>
	<div id="content">
		<form action="" method="post">
			id<input type="text" name="userid" value="${uvo.userid }" readonly="readonly"><br>
			pw<input type="text" name="userpw" id="userpw" ><br>
			pw확인<input type="text" id="userpw2"><b id="pwchecked"></b><br>
			이름<input type="text" name="username" value="${uvo.username }" readonly="readonly"><br>
			생일<input type="text" name="userbirth" value="${uvo.userbirth }" readonly="readonly"><br>
			번호<input type="text" name="userphone" value="${uvo.userphone }"><br>
			이메일<input type="text" name="useremail" value="${uvo.useremail }"><br>
			
			
			<input type="button" value="수정하기" id="modifyBtn" onclick="check(this.form)">
			<input type="button" value="홈으로" id="homeBtn" onclick="location.href='/'">
			
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</div>
	<jsp:include page="myPageBfooter.jsp"></jsp:include>
	
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	
	function check(f){	// 빈칸 체크
		if(f.userpw.value==''){
			alert("비밀번호를 입력해주세요");
			return;
		}else if($("#userpw2").val()==''){
			alert("비밀번호를 확인해주세요");
			return;
		}
		
		var form1 = $("form").serialize();
		
		console.log(form1)
		$.ajax({	
	      	type : 'post',
	     	url : 'modify',
	      	data: form1,
	      	dataType : 'text',
	     	success : function(result){ 
	     		alert(result);
	     		location.href='main';
	      	},
	      	error : function(result){
	      		console.log(result.responseText);
	      	}
		});
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