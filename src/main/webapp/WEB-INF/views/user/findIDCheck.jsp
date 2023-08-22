<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
	<c:choose>
		<c:when test="${userid eq null }">
			해당 사용자 정보가 없습니다 <br>
			<input type="button" value="뒤로가기" onclick="history.go(-1)">
		</c:when>
		<c:otherwise>
			<form action="" method="post" id="form">
				인증코드<input type="text" name="code"><br>
				<div id="idArea">
				</div>
				<input type="button" name="checkBtn" value="확인">
				<input type="button" name="registerBtn" value="홈으로">
			</form>
		</c:otherwise>
	</c:choose>
	
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var form = $("#form");
	var code = $("form [name='code']");
	var check = $("form [name='checkBtn']");
	var home = $("form [name='registerBtn']");
	var useremail='${useremail}';
	var mail_key='${mail_key}';
	
	console.log('${userid}');
	console.log(useremail);
	console.log(mail_key);
	
	check.on("click",function(){
		if(code.val()==''){
			alert("인증코드를 입력해주세요");
			return;
		}
		if(code.val()=='${mail_key}'){
			// ajax로 확인 시 mailtable auth 1로 바꾸는 코드 실행할 것.
			$.ajax({	
		      	type : 'post',
		     	url : 'mail_keyCheck',
		      	data: {mail_key:mail_key,useremail:useremail},
		     	success : function(result){ 
		     		alert('당신의 아이디 : ${userid}');
		     		console.log($("#idArea").html());
		     		$("#idArea").html('당신의 아이디 : ${userid}'
		     				+ '<input type="button" id="pwBtn" value="비밀번호 변경">');
		      	},
		      	error : function(result){
		      		console.log(result.responseText);
		      	}
			});
		}else{
			alert('${mail_key}');
		}
	});
	
	home.on("click",function(){
		location.href="/";
	});
	
	$(document).on("click","#pwBtn", function(){	// 동적 추가된 요소에 이벤트 걸기
		console.log("pwBtn");
		form.attr("method","Post");
		form.attr("action","changePw");	// 비밀번호 변경 url로
		
		form.append($('<input>', {type: 'hidden', name: 'userid', value: '${userid}'}));
		form.append($('<input>', {type: 'hidden', name: 'useremail', value: '${useremail}'}));
		
		form.submit();
	});
		
</script>
</html>