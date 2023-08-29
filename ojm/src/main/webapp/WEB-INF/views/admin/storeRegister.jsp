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
			.banner {
				position: fixed;
				right: 10%;
				text-align: center;
			}
		</style>
	</head>
	<body>
		<h1>등록 요청 관리 페이지</h1>
		<hr>
		
		<div class="banner">
			<table>
				<tr><td><a href="/admin/reportList">신고 관리</a></td></tr>
				<tr><td><a href="/qboard/qlist">Q&A 관리</a></td></tr>
				<tr><td><a href="/admin/srList">등록 요청 관리</a></td></tr>
			</table>
		</div>
		
		<table>
			<thead>
				<c:choose>
					<c:when test="${empty srList }">
						<tr>
							<td colspan="2">등록 요청 내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<th>매장명</th>
							<th>요청일</th>
						</tr>
					</c:otherwise>
				</c:choose>
			</thead>
			<tbody>
				<c:forEach var="srvo" items="${srList }">
					<c:if test="${srvo.spermmit eq 0 }">
						<tr>
							<td>
								<a class="move" href='<c:out value="${srvo.sno }"/>'>
									<c:out value="${srvo.sname }"></c:out>
								</a>
							</td>
							<td><fmt:formatDate value="${srvo.sdate}" pattern="yyyy년 MM월 dd일"/></td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
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