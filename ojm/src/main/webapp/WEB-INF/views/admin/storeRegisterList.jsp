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
<%@ include file="../testHeader.jsp" %>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
		<title>Insert title here</title>
		<style type="text/css">
			.div1 {
				margin-top: 120px;
				margin-bottom: 50px;
				margin-left: 100px;
				margin-right: 100px;
				text-align: center;
			}
			.div2 {
				margin-bottom: 50px;
			}
			.div3 {
				text-align: right;
				margin-bottom: 50px;
				margin-right: 100px;
			}
			a:hover {
				color: #ff9999;
			}
		</style>
	</head>
	<body>
		<div class="div1">
		<h2 style="text-align: center; font-weight: 700;">등록 요청 관리 페이지</h2>
		<hr>
		<div class="border d-flex justify-content-center">
		<table class="table table-bordered table-hover table-sm">
			<thead class="thead-dark">
				<c:choose>
					<c:when test="${empty srList}">
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
		</div>
		</div>
		
		<!-- page -->
		<div class="div2">
			<ul class="pagination justify-content-center">
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous page-item">
						<a class="page-link" href="${pageMaker.startPage-1 }">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" step="1">
					<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' } page-item">
						<a class="page-link" href="${num }">${num }</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button page-item">
						<a class="page-link" href="${pageMaker.endPage+1 }">&gt;</a>
					</li>
				</c:if>
			</ul>
		</div>
		<hr>
		
		<div class="div3">
			<button class="btn btn-dark" onclick="location.href='/'">메인</button>
		</div>
			
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
			
			srActionForm.find("input[name='pageNum']").val($(this).attr("href"));
			srActionForm.submit();
		});
	</script>
</html>
<%@ include file="../testFooter.jsp"%>