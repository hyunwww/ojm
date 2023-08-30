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
	img{
		width: 50px;
	}
</style>
<script type="text/javascript">

</script>
</head>

<body>
<jsp:include page="../../testHeader.jsp"></jsp:include>
	<h1>유저정보</h1>
	<div id="content">
		<form action="" method="post">
			프로필 이미지 <br><img src="${imgRoot }"><br>	<!-- 수정도 가능하게 바꿔야함 -->
			id<input type="text" name="userid" value="${uvo.userid }" readonly="readonly"><br>
			이름<input type="text" name="username" value="${uvo.username }" readonly="readonly"><br>
			생년월일<input type="text" name="userbirth" value="${uvo.userbirth }" readonly="readonly"><br>
			번호<input type="text" name="userphone" value="${uvo.userphone }" readonly="readonly"><br>
			이메일<input type="text" name="useremail" value="${uvo.useremail }" readonly="readonly"><br>
			닉네임<input type="text" name="nickname" value="${uvo.info.nickname }" readonly="readonly"><br>
			주소<input type="text" name="uaddress" value="${uvo.info.uaddress }" readonly="readonly"><br>
			성별 : 
			<c:choose>
				<c:when test="${uvo.info.ugender eq 'male' }">
					남
				</c:when>
				<c:otherwise>
					여
				</c:otherwise>
			</c:choose>
			<br>
			<b>알러지</b>	
			<div id="aler">
			</div>
			<b>관심 음식 카테고리</b>
			<div id="favor">
			</div>	
			
			<input type="button" value="수정하기" id="modifyBtn" onclick="location.href='mainModify'">
			<input type="button" value="홈으로" id="homeBtn" onclick="location.href='/'">
			
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</div>
	<jsp:include page="myPageFooter.jsp"></jsp:include>
</body>
<jsp:include page="../../testFooter.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(function(){
		console.log(${now.uno})
		
		var ualer = '${uvo.info.ualer}';
		var ufavor = '${uvo.info.ufavor}';
		
		var forDiv ='';
		
		if(ualer.includes("aler1")){
			forDiv+='갑각류 ';
		}
		if(ualer.includes("aler2")){
			forDiv+='견과류 ';
		}
		if(ualer.includes("aler3")){
			forDiv+='달걀';
		}
		forDiv+='${uvo.info.ualeretc}'
		console.log(forDiv)
		$("#aler").append(forDiv);
		
		
		forDiv ='';
		if(ufavor.includes("favor1")){
			forDiv+='한식 ';
		}
		if(ufavor.includes("favor2")){
			forDiv+='양식 ';
		}
		if(ufavor.includes("favor3")){
			forDiv+='중식';
		}
		console.log(forDiv)
		$("#favor").append(forDiv);
	});

</script>

</html>