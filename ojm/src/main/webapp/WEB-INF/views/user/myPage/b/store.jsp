<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가게</title>
</head>
<body>
	<h1>내 가게</h1>
		<hr>
		
		<table>
			<thead>
				<tr>  
					<th>이름</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty slist }">
						<tr>
							<td colspan="1">게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="store" items="${slist }">
							<tr>
								<td>
									<a class="qmove" href='/store/detail?sno=<c:out value="${store.sno }"/>'>
										<c:out value="${store.sname }"></c:out>
									</a>
								</td>
								<td><button onclick="location.href='/store/update?sno=${store.sno}'">정보 수정</button></td>
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