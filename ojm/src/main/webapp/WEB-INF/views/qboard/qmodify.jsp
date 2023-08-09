<%@page import="org.ojm.security.domain.CustomUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Authentication auth = SecurityContextHolder.getContext().getAuthentication();

Object principal = auth.getPrincipal();

pageContext.setAttribute("uvo", ((CustomUser)principal).getUvo()); 
   // jsp 원래 있던 코드 그대로 쓰려고 (uvo 변수) 자바 코드 사용함
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>Q&A 게시글 수정</h1>
		<hr>
		
		<form>
			<table>
				<tr>
					<td>글 번호</td>
					<td><input id="qno" name="qno" value="${qvo.qno }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input id="qtitle" name="qtitle" value="${qvo.qtitle }"></td>
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
					<td>비밀글</td>
					<td>
						<input type="checkbox" name="qhide" id="qhideChecked" value="1">
						<input type="hidden" name="qhide" id="qhideNone" value="0">
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input id="qwriter" name="qwriter" value="${qvo.qwriter }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="15" cols="100" id="qcontent" name="qcontent">${qvo.qcontent }</textarea></td>
				</tr>
			</table>
			<hr>
			
			<button type="submit" data-oper="qmodify">수정</button>
			<button type="submit" data-oper="qremove">삭제</button>
			<button type="submit" data-oper="qlist">목록</button>
		
			<input type="hidden" name="qno" id="qno" value="${qvo.qno }">
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 화면 이동 스크립트 -->
	<script type="text/javascript">
		$(function(){
			var formObj = $("form");
			$("button").on('click', function(e){
				e.preventDefault();		// 기본 이벤트 방지
				var operation = $(this).data("oper")	// operation = 내가 누른 버튼의 data-oper
				if (operation === "qmodify") {
					if (document.getElementById("qtitle").value=="") {
						alert("제목을 입력하세요.");
						return;
					}else if (document.getElementById("qcate").value=="none") {
						alert("카테고리를 선택하세요.")
						return;
					}else if (document.getElementById("qcontent").value=="") {
						alert("내용을 입력하세요.");
						return;
					}
					formObj.attr('action', 'qmodify');
					formObj.attr('method', 'post');
				}else if (operation === "qremove") {
					formObj.attr('action', 'qremove');
					formObj.attr('method', 'post');
				}else if (operation == "qlist") {
					formObj.attr('action', 'qlist');
					formObj.attr('method', 'get');
					
					var pageNumTag = $("input[name='pageNum']").clone();
					var amountTag = $("input[name='amount']").clone();
					var totalTag = $("input[name='total']").clone();
					
					formObj.empty();	// 해당 요소 내부 초기화
					
					formObj.append(pageNumTag);
					formObj.append(amountTag);
					formObj.append(totalTag);
				}
				formObj.submit();
			});
		});
	</script>
</html>