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
		width: fit-content;
		border: 1px solid black;
		margin: auto;
	}
	
	
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	$(function() {
			
		$("#listBtn").on("click", function() {
			history.go(-1);
		});
		$("#delBtn").on("click", function() {
			
			
			if ($("input[name='pw']").val() == '') {
				alert("비밀번호를 입력하세요.");
				return;
			}
			var sno = $("input[name='sno']").val();
			var password = $("input[name='pw']").val();
			
			//ajax를 통한 비밀번호 검증
			$.ajax({
			      type: "post",
			      url: "/store/delete",
			      data: {sno : sno,
			    	  	pw : password},
			      success: function (result, status, xhr) {
			    	  alert(result);
			    	  
			    	  //성공 시 store 삭제, 목록으로 이동
			      }
			});
		
			
			
		});
		
	});

</script>
</head>
<body>
	<div class="wrapper">
		<form action="/store/delete" method="post">
			<table>
				<tr>
					<td>삭제하려는 매장명</td> 
					<td><c:out value="${store.sname }"></c:out></td> 
				</tr>
				<tr>
					<td>비밀번호 확인</td> 
					<td><input type="password" name="pw"></td> 
				</tr>
				<tr>
					<td></td> 
					<td>
						<input type="button" id="listBtn" value="목록으로">
						<input type="button" id="delBtn" value="삭제하기">
					</td> 
				</tr>
			</table>
			<input type="hidden" value="${store.sno }" name="sno">
		</form>
	</div>
</body>
</html>