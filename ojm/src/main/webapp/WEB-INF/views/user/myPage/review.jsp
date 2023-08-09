<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 리뷰</title>
</head>
<body>
	<h1>내 리뷰</h1>
	<c:if test="${not empty revList }">
		<c:forEach var="review" items="${revList }">
			<hr>
			<p>내용 : ${review.rvcontent }</p>	
			<p>좋 : ${review.rvlike }</p>	
			<p>평 : ${review.rvstar }</p>	
			<p>작성일 : ${review.rvdate }</p>	
			<input type="button" value="상세보기" onclick="location.href='/store/detail?sno=${review.sno}'">
		</c:forEach>
	</c:if>
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
		
		<form action="review" method="get" id="actionForm">
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