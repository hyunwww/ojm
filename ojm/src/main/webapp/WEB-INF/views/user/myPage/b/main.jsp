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
<style type="text/css">
	.div1 {
		margin-bottom: 50px;
		margin-left: 100px;
		margin-right: 100px;
		display: flex ;
		justify-content: center;
	}
	tr>td:nth-child(1) {background-color: lightgray;}
</style>
</head>
<jsp:include page="../../../testHeader.jsp"></jsp:include>
<body>
	<div class="div1">
	<div id="content">
		<form action="" method="post">
			<table class="table table-bordered">
				<tr>
					<td>아이디</td>
					<td>${uvo.userid }</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td><input type="password" name="userpw" id="userpw" ></td>
				</tr>
				<tr>
					<td>패스워드확인</td>
					<td><input type="password" id="userpw2">
						<b id="pwchecked"></b></td>
				</tr>
				<tr>
					<td>이름</td>
					<td>${uvo.username }</td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td>${uvo.userbirth }</td>
				</tr>
				<tr>
					<td>번호</td>
					<td><input type="text" name="userphone" value="${uvo.userphone }"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="useremail" value="${uvo.useremail }" style="width:250px;"></td>
				</tr>
			</table>
			<input type="button" value="수정하기" id="modifyBtn" onclick="check(this.form)">
			<input type="button" value="홈으로" id="homeBtn" onclick="location.href='/'">
			
			<input type="hidden" name="userbirth" value="${uvo.userbirth }">
			<input type="hidden" name="username" value="${uvo.username }">
			<input type="hidden" name="userid" value="${uvo.userid }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</div>
	</div>
	<jsp:include page="myPageBfooter.jsp"></jsp:include>
</body>
<jsp:include page="../../../testFooter.jsp"></jsp:include>
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
			$("#pwchecked").html("확인필요");
		}
	});
	
	

</script>

</html>