<%@page import="org.ojm.security.domain.CustomUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
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
		<title>등록 요청</title>
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
		<h1>등록 요청글 화면</h1>
		<hr>
		
		<table>
			<tr>
				<td>요청자</td>
				<td><input name="username" value="${uvo.username }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>매장명</td>
				<td><input name="sname" value="${svo.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input name="saddress" value="${svo.saddress }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td><input name="scate" value="${svo.scate }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>배달가능 여부</td>
				<c:choose>
					<c:when test="${svo.sdeli eq 1}">
						<td><input name="sdeli" value="가능" readonly="readonly" style="background-color: #ccc"></td>
					</c:when>
					<c:otherwise>
						<td><input name="sdeli" value="불가능" readonly="readonly" style="background-color: #ccc"></td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td>사업자등록번호</td>
				<td><input name="scrn" value="${svo.scrn }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>예약금</td>
				<td><input name="sdepo" value="${svo.sdepo }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>메뉴</td>
				<td>
					<c:forEach var="mvo" items="${mvoList }">
						<input name="mname" value="${mvo.mname }" readonly="readonly" style="background-color: #ccc">
						<input name="mcate" value="${mvo.mcate }" readonly="readonly" style="background-color: #ccc">
						<input name="maler" value="${mvo.maler }" readonly="readonly" style="background-color: #ccc">
						<input name="mprice" value="${mvo.mprice }" readonly="readonly" style="background-color: #ccc">
						<br>
					</c:forEach>
				</td>
			</tr>			
			<tr>
				<td>등록 요청일</td>
				<td><fmt:formatDate value="${svo.sdate}" pattern="yyyy년 MM월 dd일"/></td>
			</tr>
		</table>
		<hr>
		
		<button data-oper="srPermmit">승인</button>
		<button data-oper="srList">목록</button>
		
		<form action="/admin/srList" method="get" id="srActionForm">
			<input type="hidden" name="sno" id="sno" value="${svo.sno }">			
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
	<!-- 화면 이동 스크립트 -->
		var srActionForm = $("#srActionForm");  

		$(function(){
			$("button[data-oper='srList']").on('click', function(){
				srActionForm.find("#sno").remove();
				srActionForm.submit();
			});
		})
		
		$(function(){
			$("button[data-oper='srPermmit']").on('click', function(){
				srActionForm.attr('action', 'srPermmit');
				srActionForm.submit();
				alert("승인 처리가 완료되었습니다.");
			});
		})
	</script>
</html>