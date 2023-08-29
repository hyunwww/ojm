<%@page import="org.ojm.security.domain.CustomUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   Authentication auth = SecurityContextHolder.getContext().getAuthentication();
      Object principal = auth.getPrincipal();
      
      try{
         pageContext.setAttribute("uvo", ((CustomUser)principal).getUvo()); 
      }catch(Exception e){
         pageContext.setAttribute("uvo", null);
      }
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			table {
				border: 1px solid black;
				border-collapse: collapse;
			}
			th, td{
				border: 1px solid black;
			}
		</style>
	</head>
	<body>
		<h1>신고글 화면</h1>
		<hr>
		
		<table>
			<tr>
				<td>제목</td>
				<td><input name="rptitle" value="${rpvo.rptitle }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>신고 사유</td>
				<td><input name="state" value="${rpvo.rpreason }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input name="rpwriter" value="${rpvo.rpwriter }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="15" cols="100" name="rpcontent" readonly="readonly" style="background-color: #ccc">${rpvo.rpcontent }</textarea></td>
			</tr>
			<tr>
				<td>처리 상태</td>
				<td><input name="rpstate" value="${rpvo.rpstate }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
		</table>
		<hr>
		
		<!-- 신고 처리 -->
		<form>
			<h3>신고 처리</h3>
			<table>
				<tr>
					<td>처리 상태</td>
					<td>
						<select name="rpstate" id="rpstate">
							<option value="none" selected disabled hidden>처리 상태 선택</option>
							<option value="처리 완료" data-address="처리 완료">완료</option>
							<option value="보류" data-address="보류">보류</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>처리 내용</td>
					<td><textarea class="rpreply" rows="5" cols="50" name="rpreply"></textarea></td>
				</tr>
			</table>
		</form>
		<button name="rpReplyRegisterBtn" type="submit">등록</button>
		<hr>
		
		<!-- 처리 내역 출력 -->
		<h3>처리 내역</h3>
		<table class="rpReply">
			<tr>
			</tr>
		</table>
		<hr>
		
		<button data-oper="reportList">목록</button>
		
		<form action="/admin/reportList" method="get" id="rpActionForm">
			<input type="hidden" name="rpno" id="rpno" value="${rpvo.rpno }">			
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript" src="/resources/js/rpreply.js"></script>
	<script type="text/javascript">
	<!-- 화면 이동 스크립트 -->
		var rpActionForm = $("#rpActionForm");  

		$(function(){

			$("button[data-oper='reportList']").on('click', function(){
				rpActionForm.find("#rpno").remove();
				rpActionForm.submit();
			});
		})

	<!-- 신고 처리 관련 스크립트 -->
		$(function(){
			var rpReplyTable = $(".rpReply");
			var rpnoValue = "${rpvo.rpno }";
			var unoValue = "${uvo.uno}";
			var rpreply = $('textarea[name = rpreply]');
			var rpstate = $('select[name = rpstate]');
			
			getList();		// 댓글 리스트 바인딩 함수 호출

			// 댓글 등록 스크립트
			$("button[name='rpReplyRegisterBtn']").on('click', function(){
				if (document.getElementById("rpstate").value=="none") {
					alert("처리 상태를 선택하세요.")
					return;
				}else if (rpreply.val() == "") {
					alert("내용을 입력하세요.");
					return;
				}else {
					var rpprocess = {
						rpstate : rpstate.val(),
						rpreply : rpreply.val(),
						rpno : rpnoValue,
						uno : unoValue
					}
					ReportService.add(
						rpprocess,
						function(result){
							alert("신고 처리가 완료되었습니다.");
							rpreply.val("");
							rpActionForm.find("#rpno").remove();
							rpActionForm.submit();
						}
					);
				}
			});
			
			// 댓글 리스트 바인딩 함수
			function getList(){
				ReportService.getList(
					{'rpno' : rpnoValue},
					function(result){
						console.log(result);
						var str = '';
						if (result.rpreply == null) {
							rpReplyTable.html('<h3>처리 내역이 없습니다.</h3>');
						}else {
							str += '<tr><td>처리 상태</td><td>내용</td><td>작성일</td></tr>';
							str += '<tr>';
							str += '<td>' + result.rpstate + '</td>';
							str += '<td>' + result.rpreply + '</td>';
							str += '<td>' + displayTime(result.rpreplydate) + '</td>';
							str += '</tr>';

							rpReplyTable.html(str);
						}
					}
				);
			}
		});
	</script>
</html>