<%@page import="org.ojm.security.domain.CustomUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%
Authentication auth = SecurityContextHolder.getContext().getAuthentication();

Object principal = auth.getPrincipal();

pageContext.setAttribute("uvo", ((CustomUser)principal).getUvo()); 
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript">
			var currentUno = "${uvo.uno}";
			if (currentUno == 0) {
				alert("로그인이 필요한 서비스입니다.");
				location.href='/';
			}
		</script>
	</head>
	<body>
		<h1>Q&A 게시글 등록</h1>
		<hr>
		
		<form action="/qboard/qregister" method="post" role="form">
			<table>
				<tr>
					<td>제목</td>
					<td><input name="qtitle" id="qtitle"></td>
				</tr>
				<tr>
					<td>말머리</td>
					<td>
						<select name="qcate" id="qcate">
							<option value="none" selected disabled hidden>말머리 선택</option>
							<!-- 관리자 계정이 아니면 공지사항 보이지 않도록 수정해야 함 -->
							<option value="공지사항">공지사항</option>
							<option value="Q&A">Q&A</option>
							<option value="비밀글" hidden>비밀글</option>
						</select>		
					</td>
				</tr>
				<tr>
					<!-- 관리자 계정이면 비밀글 보이지 않도록 수정해야 함 -->
					<td>비밀글</td>
					<td>
						<input type="checkbox" name="qhide" id="qhideChecked" value="1">
						<input type="hidden" name="qhide" id="qhideNone" value="0">
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input name="qwriter" id="qwriter" value="${uvo.username }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea rows="15" cols="100" name="qcontent" id="qcontent"></textarea>
					</td>
				</tr>
			</table>
			<hr>
			<button type="submit" data-oper="qregister">등록</button>	
			<button type="reset" data-oper="reset">취소</button>
			<button type="submit" data-oper="qlist">목록</button>
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		$(function(){
		var formObj = $("form");
		
		$("button").on('click', function(e){
			e.preventDefault();		// 동작 중단
			
			var operation = $(this).data("oper");
			
			if (operation === 'qregister') {
				if (document.getElementById("qtitle").value=="") {
					alert("제목을 입력하세요.");
					return;
				}else if (document.getElementById("qcate").value=="none") {
					alert("카테고리를 선택하세요.")
					return;
				}else if (document.getElementById("qcontent").value=="") {
					alert("내용을 입력하세요.");
					return;
				}else if(document.getElementById("qhideChecked").checked) {
				    document.getElementById("qhideNone").disabled = true;
				}

				
				formObj.attr("action", '/qboard/qregister');
				
				formObj.submit();
				
			}else if (operation === 'qlist') {
				formObj.attr("action", '/qboard/qlist');
				formObj.attr("method", 'get');
				
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var totalTag = $("input[name='total']").clone();
				
				formObj.empty();	// 해당 요소 내부 초기화
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(totalTag);
				formObj.submit();
			}else if(operation === 'reset'){
				formObj[0].reset();
				return;
			}
		});
	});
	</script>
	
	
</html>