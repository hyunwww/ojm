<%@page import="org.ojm.security.domain.CustomUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%
   Authentication auth = SecurityContextHolder.getContext().getAuthentication();
      Object principal = auth.getPrincipal();
      
      try{
         pageContext.setAttribute("uvo", ((CustomUser)principal).getUvo()); 
      }catch(Exception e){
         pageContext.setAttribute("uvo", null);
      }
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			table {
				border: 1px solid black;
				border-collapse: collapse;
			}
			th, td{
				border: 1px solid black;
			}
		</style>
	</head>
	<body>
		<h1>구인글 화면</h1>
		<hr>
		
		<table>
			<tr>
				<td>글 번호</td>
				<td><input name="jno" value="${jvo.jno }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input name="jtitle" value="${jvo.jtitle }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input name="jwriter" value="${jvo.jwriter }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>매장</td>
				<td><input name="jaddress" value="${store.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input name="saddress" value="${store.saddress }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>시급</td>
				<td><input name="salary" value="${jvo.salary }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>근무요일</td>
				<td><input name="jday" value="${jvo.jday }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>근무시간</td>
				<td>
					<input name="starttime" value="${jvo.starttime }" readonly="readonly" style="background-color: #ccc">
					 ~ 
					<input name="endtime" value="${jvo.endtime }" readonly="readonly" style="background-color: #ccc">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="15" cols="100" name="jcontent" readonly="readonly" style="background-color: #ccc">${jvo.jcontent }</textarea></td>
			</tr>
		</table>
		<hr>
		
		<!-- 작성자 본인일 때에만 게시글 수정이 가능하도록 기능 추가해야 함 -->
		<c:if test="${jvo.jwriter eq uvo.username }">
			<button data-oper="jmodify">수정</button>
		</c:if>
		<sec:authorize access="hasRole('ROLE_user')">
			<button id="applicationBtn">지원</button>
		</sec:authorize>
		<button data-oper="jlist">목록</button>
		
		<form action="/jboard/jmodify" method="get" id="jOperForm">
			<input type="hidden" name="jno" id="jno" value="${jvo.jno }">			
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<!-- 지원하기 모달 -->
	<div id="applicationDiv">
		<h2>지원</h2>
		<hr>
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="username" id="username"></td>
			</tr>
		</table>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 화면 이동 스크립트 -->
	<script type="text/javascript">
		$(function(){
			var operForm = $("#jOperForm");  
			
			$("button[data-oper='jmodify']").on('click', function(){
				operForm.submit();
			});
			$("button[data-oper='jlist']").on('click', function(){
				operForm.find("#jno").remove();
				operForm.attr('action', '/jboard/jlist');
				operForm.submit();
			});
		})
	</script>
</html>