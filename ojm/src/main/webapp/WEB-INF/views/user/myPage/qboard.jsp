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
<jsp:include page="../../testHeader.jsp"></jsp:include>
<body>
<div class="div1">
	<h1>내 Q&A</h1>
		<hr>
		<div class="border d-flex justify-content-center">
		<table class="table table-bordered table-hover table-sm">
			<thead class="thead-dark">
				<tr>  
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty qlist }">
						<tr>
							<td colspan="5">게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="qboard" items="${qlist }">
							<tr>
								<td><c:out value="${qboard.qno }"></c:out></td>
								<td>
									<a class="qmove" href='/qboard/qget?qno=<c:out value="${qboard.qno }"/>'>
										<c:out value="${qboard.qtitle }"></c:out>
										<b>[<c:out value="${qboard.qreplycnt }"/>]</b>
									</a>
								</td>
								<td><fmt:formatDate value="${qboard.qdate }" pattern="yyyy/MM/dd"/></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		</div>
		</div>
		<hr>
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
		
		<form action="qboard" method="get" id="actionForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="total" value="${total }">
		</form>
		
		<br><br><jsp:include page="myPageFooter.jsp"></jsp:include>
</body>
<jsp:include page="../../testFooter.jsp"></jsp:include>
<script type="text/javascript">
	var actionForm = $("#actionForm");
	
	$(".paginate_button a").on('click', function(e){
		e.preventDefault();
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
</script>
</html>