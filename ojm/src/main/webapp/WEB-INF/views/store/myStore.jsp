<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.wrapper{
		width: 800px;
		border: 1px solid black;
		margin: auto;
	}
	
	
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	

</script>
</head>
<body>
	<div class="wrapper">
		<div class="storeListContainer">
			<c:if test="${empty storeList }">
				<p>보유 중인 매장 없음.</p>
			</c:if>
			<c:forEach var="store" items="${storeList }">
				<p>
					<a href="/store/detail?sno=${store.sno }">${store.sname }</a>
					<a href="/store/delete?sno=${store.sno }">삭제</a>
					<a href="/store/update?sno=${store.sno }">수정</a>
				</p>
				<hr>
			</c:forEach>
		</div>
	
	
	</div>
</body>
</html>