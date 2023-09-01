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
	.div1 {
		margin-bottom: 50px;
		margin-left: 100px;
		margin-right: 100px;
		text-align: center;
		display: flex ;
		justify-content: center;
	}
	tr>td:nth-child(1) {
		background-color: lightgray;
		width:200px;
	}
	.table{
		border: 1px solid;
	}
</style>
<script type="text/javascript">

</script>
</head>

<jsp:include page="../../testHeader.jsp"></jsp:include>
<body>
	<h1 style="text-align: center; font-weight: 700;">유저정보</h1>
	<div class="div1" >
	<div id="content">
		<img src="${imgRoot }">
		<table class="table">
		<tr>
			<td>아이디</td>
			<td>${uvo.userid }</td>
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
			<td>${uvo.userphone }</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${uvo.useremail }</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>${uvo.info.nickname }</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>${uvo.info.uaddress }</td>
		</tr>
		<tr>
			<td>성별</td>
			<c:choose>
				<c:when test="${uvo.info.ugender eq 'male' }">
					<td>남</td>
				</c:when>
				<c:otherwise>
					<td>여</td>
				</c:otherwise>
			</c:choose>
		</tr>
		<tr>
			<td>알러지</td>
			<td><div id="aler"></div></td>
		</tr>
		<tr>
			<td>관심 음식 카테고리</td>
			<td><div id="favor"></div></td>
		</tr>
		</table>
		<input type="button" value="수정하기" id="modifyBtn" onclick="location.href='mainModify'">
		<input type="button" value="홈으로" id="homeBtn" onclick="location.href='/'">
		
		<input type="hidden" name="uno" value="${uvo.uno }">
	</div>
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