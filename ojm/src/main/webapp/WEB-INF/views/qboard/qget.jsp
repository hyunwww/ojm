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
		<h1>Q&A 게시글 화면</h1>
		<hr>
		
		<table>
			<tr>
				<td>글 번호</td>
				<td><input name="qno" value="${qvo.qno }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input name="qtitle" value="${qvo.qtitle }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>말머리</td>
				<td><input name="qcate" value="${qvo.qcate }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input name="qwriter" value="${qvo.qwriter }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="15" cols="100" name="qcontent" readonly="readonly" style="background-color: #ccc">${qvo.qcontent }</textarea></td>
			</tr>
		</table>
		<hr>
		
		<!-- 댓글 입력 -->
		<c:if test="${not empty uvo.uno}">
		<form>
			<h3>댓글 작성</h3>
				<table>
				<tr>
					<td>작성자</td>
					<td><input name="qrwriter" value="${uvo.username }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea class="qrcontent" rows="5" cols="50" name="qrcontent"></textarea></td>
				</tr>		
			</table>
		</form>
		<button name="qreplyregisterbtn" type="submit">댓글 등록</button>
		<hr>
		</c:if>
		
		<!-- 댓글 출력 -->
		<h3>댓글 목록</h3>
		<table class="qreply">
			<tr>
			</tr>
		</table>
		<hr>
		
		<!-- 작성자 본인일 때에만 게시글 수정이 가능하도록 기능 추가해야 함 -->
		<c:if test="${qvo.qwriter eq uvo.username }">
			<button data-oper="qmodify">수정</button>
		</c:if>
		<button data-oper="qlist">목록</button>
		
		<form action="/qboard/qmodify" method="get" id="qOperForm">
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
			var operForm = $("#qOperForm");  
			
			// 수정 버튼 클릭 시 bno 값을 같이 전달 → 기존 내부 input 태그 그대로 전달
			$("button[data-oper='qmodify']").on('click', function(){
				operForm.submit();
			});
			// 목록 버튼 클릭 시 bno 값 없이 이동 → 기존 내부 input 태그 삭제 후 이동
			$("button[data-oper='qlist']").on('click', function(){
				operForm.find("#qno").remove();
				operForm.attr('action', '/qboard/qlist');
				operForm.submit();
			});
		})
	</script>
	
	<script type="text/javascript" src="/resources/js/qreply.js"></script>
	<!-- 댓글 관련 스크립트 -->
	<script type="text/javascript">
		
		$(function(){
			var qreplyTable = $(".qreply");			// 댓글 리스트 table
			var qnoValue = "${qvo.qno }";
			var unoValue = "${uvo.uno}";
			var userName = "${uvo.username}";
			var qrwriter = $('input[name = qrwriter]').val();
			var qrcontent = $('textarea[name = qrcontent]');
			getQlist();		// 댓글 리스트 바인딩 함수 호출

			// 댓글 등록 스크립트
			$("button[name='qreplyregisterbtn']").on('click', function(){
				if (qrcontent.val() == "") {
					alert("내용을 입력하세요.");
					return;
				}else {
					var reply = {
						qrwriter : qrwriter,
						qrcontent : qrcontent.val(),
						qno : qnoValue,
						uno : unoValue
					}
					QboardReplyService.add(
						reply,
						function(result){
							alert("댓글 등록이 완료되었습니다.");
							qrcontent.val("");
							getQlist();
						}
					);
				}
			});
			
			// 댓글 리스트 바인딩 함수
			function getQlist(){
				QboardReplyService.getQlist(
					{'qno' : qnoValue},
					function(result){
						var str = '';
						if (result == null || result.length == 0) {
							qreplyTable.html('<h3>댓글이 없습니다.</h3>');
						}else {
							str += '<tr><td>댓글 번호</td><td>작성자</td><td>내용</td><td>작성일</td><td>삭제</td></tr>';
							for (var i = 0; i < result.length; i++) {
								str += '<tr>';
								str += '<td data-qrno="' + result[i].qrno + '">' + result[i].qrno + '</td>';
								str += '<td>' + result[i].qrwriter + '</td>';
								str += '<td>' + result[i].qrcontent + '</td>';
								str += '<td>' + displayTime(result[i].qrdate) + '</td>';
								str += '<td>';
								
								if (result[i].qrwriter == userName) {
									str += '<button name="qreplydeletebtn">삭제</button>';								
								}
								
								str += '</td>';
								str += '</tr>';

								qreplyTable.html(str);
							}
							
							$("button[name='qreplydeletebtn']").on('click', function(){
								
								var str = "";
								var tdArr = new Array();
								var btn = $(this);
								var tr = btn.parent().parent();
								var td = tr.children();
								var qrno = td.eq(0).text();
								
								var param = {
										qrno : qrno,
										qno : qnoValue
									}
								
								QboardReplyService.remove(
									param,
									function(result){
										alert("댓글 삭제가 완료되었습니다.");
										getQlist();
									}
								);
							});
						}
					}
				);
			}
		});
	</script>
</html>