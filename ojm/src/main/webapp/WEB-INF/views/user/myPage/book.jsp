<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약내역</title>
</head>
<jsp:include page="../../testHeader.jsp"></jsp:include>
<body>
	<h1>내 예약내역</h1>
		<hr>
		
		<table>
			<thead>
				<tr>
					<th>가게이름</th>
					<th>예약자명</th>
					<th>예약일</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty blist }">
						<tr>
							<td colspan="8">게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="book" items="${blist }">
							<tr>
								<td><c:out value="${book.sname }"></c:out></td>
								<td><c:out value="${book.bname }"></c:out></td>
								<td><c:out value="${book.bdate }"></c:out></td>
							</tr>
						</c:forEach>   
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<hr>
	
	<br><br><jsp:include page="myPageFooter.jsp"></jsp:include>
</body>
<script type="text/javascript">
	console.log('${blist}');
</script>
</html>