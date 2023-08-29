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
				<td>매장명</td>
				<td><input name="sname" value="${svo.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>매장명</td>
				<td><input name="sname" value="${svo.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>매장명</td>
				<td><input name="sname" value="${svo.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>매장명</td>
				<td><input name="sname" value="${svo.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>매장명</td>
				<td><input name="sname" value="${svo.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>매장명</td>
				<td><input name="sname" value="${svo.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>매장명</td>
				<td><input name="sname" value="${svo.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			
		</table>
		
				<!-- page -->
		<div>
			<ul>
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous">
						<a href="${pageMaker.startPage-1 }">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" step="1">
					<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' }">
						<a href="${num }">${num }</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button">
						<a href="${pageMaker.endPage+1 }">&gt;</a>
					</li>
				</c:if>
			</ul>
		</div>
		<hr>
		
		<button onclick="location.href='/'">메인</button>
		
		<form action="/admin/srList" method="get" id="srActionForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="total" value="${total }">
		</form>
		
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		// ---------- 조회 화면 이동 이벤트 처리 ----------	
		var srActionForm = $("#srActionForm");
		
		$(".move").on('click', function(e){
			e.preventDefault(); // <a> 클릭 시 페이지 이동이 이루어지지 않게 하기
			
			// $(this) 의 요소 중 href의 속성 값 (value)
			srActionForm.attr('action', 'srGet'); // 경로 변경
			srActionForm.append("<input type='hidden' name='uno' value='" + ${uvo.uno} +"'>");	// uno 저장
			srActionForm.append("<input type='hidden' name='sno' value='" + $(this).attr('href') + "'>");	// bno 저장
			srActionForm.submit();
		});
		
		// ---------- 페이징 버튼 이벤트 처리 ----------	 
		$(".paginate_button a").on('click', function(e){
			e.preventDefault();	// <a> 클릭 시 페이지 이동이 이루어지지 않게 하기
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
	</script>
</html>