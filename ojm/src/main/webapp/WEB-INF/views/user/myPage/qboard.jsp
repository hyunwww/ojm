<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 Q&A</title>
</head>
<body>
	<h1>내 Q&A</h1>
		<hr>
		
		<table>
			<thead>
				<tr>  
					<th>번호</th>
					<th>말머리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>수정일</th>
					<th>조회</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty qlist }">
						<tr>
							<td colspan="7">게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="qboard" items="${qlist }">
							<tr>
								<td><c:out value="${qboard.qno }"></c:out></td>
								<td><c:out value="${qboard.qcate }"></c:out></td>
								<td>
									<a class="qmove" href='/qboard/qget?qno=<c:out value="${qboard.qno }"/>'>
										<c:out value="${qboard.qtitle }"></c:out>
										<b>[<c:out value="${qboard.qreplycnt }"/>]</b>
									</a>
								</td>
								<td><c:out value="${qboard.qwriter }"></c:out></td>
								<td><fmt:formatDate value="${qboard.qdate }" pattern="yyyy/MM/dd"/></td>
								<td><fmt:formatDate value="${qboard.qupdatedate }" pattern="yyyy/MM/dd"/></td>
								<td><c:out value="${qboard.qview }"></c:out></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<hr>
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
		
		<form action="qboard" method="get" id="actionForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="total" value="${total }">
		</form>
		
		<br><br><jsp:include page="myPageFooter.jsp"></jsp:include>
</body>
<script type="text/javascript">
	var actionForm = $("#actionForm");
	
	$(".paginate_button a").on('click', function(e){
		e.preventDefault();
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
</script>
</html>