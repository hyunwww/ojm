<%@page import="org.ojm.security.domain.CustomUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="../../testHeader.jsp"></jsp:include>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내 신고 페이지</title>
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
		<h1>내 신고 페이지</h1>
		<hr>
		
		<table>
			<thead>
				<tr>
					<th>제목</th>
					<th>신고 사유</th>
					<th>신고일</th>
					<th>처리 상태</th>					
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty reportList }">
						<tr>
							<td colspan="4">신고내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="rpvo" items="${reportList }">
							<tr>
								<td>
									<a class="move" href='<c:out value="${rpvo.rpno }"/>'>
										<c:out value="${rpvo.rptitle }"></c:out>
									</a>
								</td>
								<td><c:out value="${rpvo.rpreason }"></c:out></td>
								<td><fmt:formatDate value="${rpvo.rpdate}" pattern="yyyy년 MM월 dd일"/></td>								
								<td><c:out value="${rpvo.rpstate }"></c:out></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
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
		
		
		<form action="/admin/reportList" method="get" id="rpActionForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="total" value="${total }">
		</form>
		
		<br><br><jsp:include page="myPageFooter.jsp"></jsp:include>
		
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		// ---------- 조회 화면 이동 이벤트 처리 ----------	
		var rpActionForm = $("#rpActionForm");
		
		$(".move").on('click', function(e){
			e.preventDefault(); // <a> 클릭 시 페이지 이동이 이루어지지 않게 하기
			
			// $(this) 의 요소 중 href의 속성 값 (value)
			rpActionForm.attr('action', 'rpGet'); // 경로 변경
			rpActionForm.append("<input type='hidden' name='uno' value='" + ${uvo.uno} +"'>");	// uno 저장
			rpActionForm.append("<input type='hidden' name='rpno' value='" + $(this).attr('href') + "'>");	// bno 저장
			rpActionForm.submit();
		});
		
		// ---------- 페이징 버튼 이벤트 처리 ----------	 
		$(".paginate_button a").on('click', function(e){
			e.preventDefault();	// <a> 클릭 시 페이지 이동이 이루어지지 않게 하기
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
	</script>
</html>