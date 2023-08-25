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
<body>
<h1>예약내역</h1>
		<hr>
		<table>
			<thead>
				<tr>
					<th>가게이름</th>
					<th>예약자명</th>
					<th>예약일</th>
					<th>예약시간</th>
					<th>예약인원</th>
					<th>전화번호</th>
					<th>요청사항</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty blist }">
						<tr>
							<td colspan="7">예약 내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="book" items="${blist }">
							<tr>
								<td><c:out value="${book.sname }"></c:out></td>
								<td><c:out value="${book.bname }"></c:out></td>
								<td><c:out value="${book.bdate }"></c:out></td>
								<td><c:out value="${book.btime }"></c:out></td>
								<td><c:out value="${book.bman }"></c:out></td>
								<td><c:out value="${book.bphone }"></c:out></td>
								<td><c:out value="${book.breq }"></c:out></td>
							</tr>
						</c:forEach>   
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<hr>
	<br><br><jsp:include page="myPageBfooter.jsp"></jsp:include>
</body>
</html>