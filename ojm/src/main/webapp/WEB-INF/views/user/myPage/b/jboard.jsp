<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 구인구직</title>
</head>
<body>
	<h1>내 구직</h1>
		<hr>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>지역</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty jlist }">
						<tr>
							<td colspan="7">게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="job" items="${jlist }">
							<tr>
								<td><c:out value="${job.jno }"></c:out></td>
								<td>
								<c:out value="${job.jaddress }"></c:out></td>
								<td>
									<a class="jmove" onclick='preventClick(event,"${job.jno}")' href='<c:out value="${job.jno }" />'>
										<c:out value="${job.jtitle }"></c:out>
									</a>
								</td>
								<td><c:out value="${job.jwriter }"></c:out></td>
								<td><fmt:formatDate value="${job.jdate }" pattern="yyyy년 MM월 dd일"/></td>
								<td><c:out value="${job.jview }"></c:out></td>
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
		
		<button onclick="location.href='/'">메인</button>
		
		<form action="jboard" method="get" id="jActionForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	<br><br><jsp:include page="myPageBfooter.jsp"></jsp:include>
</body>
<script type="text/javascript">

	var jActionForm = $("#jActionForm");
	var jno;
	
	function preventClick(e,j){
		e.preventDefault();
		jno=j;
	}
	// 새창으로 조회화면 띄우기
	$(".jmove").on('click', function (){
	    var gsWin = window.open("/jboard/jget?jno="+jno, "winName");
	    jActionForm.target="winName";
	});
	
	// ---------- 페이징 버튼 이벤트 처리 ----------	 
	$(".paginate_button a").on('click', function(e){
		e.preventDefault();	//
		
		jActionForm.find("input[name='pageNum']").val($(this).attr("href"));
		jActionForm.submit();
	});
	
</script>
</html>