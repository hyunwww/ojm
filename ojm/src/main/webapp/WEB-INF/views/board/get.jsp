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
<%@ include file="../testHeader.jsp" %>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
		<title>Insert title here</title>
		<style type="text/css">
			.div1 {
				margin-top: 120px;
				margin-bottom: 50px;
				margin-left: 100px;
				margin-right: 100px;
				text-align: center;
			}
			.div2 {
				margin-bottom: 50px;
			}
			.div3 {
				text-align: right;
				margin-bottom: 50px;
				margin-right: 100px;
			}
			a:hover {
				color: #ff9999;
			}
		</style>
	</head>
	<body>
		<div class="div1">
		<hr>
		<div class="border d-flex justify-content-center">
		<table class="table table-bordered">
			<tr>
				<td class="table-dark w-25 p-3">제목</td>
				<td>${vo.btitle }</td>
			</tr>
			<tr>
				<td class="table-dark">말머리</td>
				<td>${vo.bcate }</td>
			</tr>
			<tr>
				<td class="table-dark">작성자</td>
				<td>${vo.bwriter }</td>
			</tr>
			<tr>
				<td class="table-dark">내용</td>
				<td>${vo.bcontent }</td>
			</tr>
			
			<!-- 첨부 이미지 -->
			<tr>
				<td class="table-dark">이미지</td>
				<td class = 'uploadResult'>
					<ul></ul>
				</td>
			</tr>
			<c:choose>
				<c:when test="${not empty uvo.uno and like == 0}">
					<tr id="blike">
						<td colspan="2">
							<input class="like" type="hidden" value="${like }">
							<button class="btn btn-primary" name="blikeBtn">추천</button>
							${vo.blike}
						</td>
					</tr>
				</c:when>
				<c:when test="${not empty uvo.uno and like == 1}">
					<tr id="blike">
						<td colspan="2">
							<input class="like" type="hidden" value="${like }">
							<button class="btn btn-primary" name="blikeBtn">추천 취소</button>
							${vo.blike}
						</td>
					</tr>
				</c:when>
			</c:choose>
		</table>
		</div>
		</div>
		<hr>
		
		<!-- 댓글 입력 -->
		<c:if test="${not empty uvo.uno}">
		<form>
			<h3>댓글 작성</h3>
				<table>
				<tr>
					<td>작성자</td>
					<td><input name="brwriter" value="${uvo.username }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea class="brcontent" rows="5" cols="50" name="brcontent"></textarea></td>
				</tr>		
			</table>
		</form>
		<button name="replyregisterbtn" type="submit">댓글 등록</button>
		<hr>
		</c:if>
		
		<!-- 댓글 출력 -->
		<h3>댓글 목록</h3>
		<table class="reply">
			<tr>
			</tr>
		</table>
		<hr>
		
		<c:if test="${vo.bwriter eq uvo.username }">
			<button data-oper="modify">수정</button>
		</c:if>
		<button data-oper="list">목록</button>
		
		<form action="/board/modify" method="get" id="operForm">
			<input type="hidden" name="bno" id="bno" value="${vo.bno }">			
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 좋아요 버튼 클릭 이벤트 스크립트 -->
	<script type="text/javascript">
		var bno = "${vo.bno }";
		var uno = "${uvo.uno}";

		$(function(){
			$("#blike").on("click","button[name='blikeBtn']", function(){
				if ($(".like").val() == 1) {
					down();
				}else if ($(".like").val() == 0) {
					up();
				};
				
			});
		
		});
		
		function down(down, callback, error){
			$.ajax({
				type : 'post',
				url : '/like/bLikeDown',
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(
					{
						"bno" : bno,
						"uno" : uno
					}
				),
				success : function(result, status, xhr){
					$('#blike').load(location.href+' #blike');
					$(".like").val(0);
				},
				error : function(xhr, status, er){
					if (error) {
						error(er);
					}
				}
			});
		}
		
		function up(up, callback, error){
				$.ajax({
					type : 'post',
					url : '/like/bLikeUp',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(
						{
							"bno" : bno,
							"uno" : uno
						}
					),
					success : function(result, status, xhr){
						$('#blike').load(location.href+' #blike');
						$(".like").val(1);
					},
					error : function(xhr, status, er){
						if (error) {
							error(er);
						}
					}
				});
			}
		
	</script>
	
	<!-- 화면 이동 스크립트 -->
	<script type="text/javascript">
		$(function(){
			var operForm = $("#operForm");  
			
			// 수정 버튼 클릭 시 bno 값을 같이 전달 → 기존 내부 input 태그 그대로 전달
			$("button[data-oper='modify']").on('click', function(){
				operForm.submit();
			});
			// 목록 버튼 클릭 시 bno 값 없이 이동 → 기존 내부 input 태그 삭제 후 이동
			$("button[data-oper='list']").on('click', function(){
				operForm.find("#bno").remove();
				operForm.attr('action', '/board/list');
				operForm.submit();
			});
		})
	</script>
	
	<!-- 첨부 파일 스크립트 -->
	<script type="text/javascript">
		$(function(){
			// ajax로 파일 목록 받아오기
			$.ajax({
				type : 'get',
				url : '/board/getImgList',
				data : {bno : ${vo.bno}},
				dataType : "json",
				contentType : 'application/json; charset=utf-8',
				success : function(result){
					var str = '';
					$(result).each(function(i, obj){
						// 인코딩
						var fileCallPath = encodeURIComponent(obj.uploadpath + "/" + obj.uuid + "_" + obj.filename);
						str += '<img class="img-thumbnail" style="height: 200px" alt="' + obj.filename + '" src="/ojm/' + obj.uploadpath + '/' + obj.uuid + '_' + obj.filename + '">';
					});
					$(".uploadResult ul").html(str);
				}			
			});
		});
	</script>
	
	<script type="text/javascript" src="/resources/js/reply.js"></script>
	<!-- 댓글 관련 스크립트 -->
	<script type="text/javascript">
		
		$(function(){
			var replyTable = $(".reply");			// 댓글 리스트 table
			var bnoValue = "${vo.bno }";
			var unoValue = "${uvo.uno}";
			var userName = "${uvo.username}";
			var brwriter = $('input[name = brwriter]').val();
			var brcontent = $('textarea[name = brcontent]');
			getList();		// 댓글 리스트 바인딩 함수 호출

			// 댓글 등록 스크립트
			$("button[name='replyregisterbtn']").on('click', function(){
				if (brcontent.val() == "") {
					alert("내용을 입력하세요.");
					return;
				}else {
					var reply = {
						brwriter : brwriter,
						brcontent : brcontent.val(),
						bno : bnoValue,
						uno : unoValue
					}
					BoardReplyService.add(
						reply,
						function(result){
							alert("댓글 등록이 완료되었습니다.");
							brcontent.val("");
							getList();
						}
					);
				}
			});
			
			// 댓글 리스트 바인딩 함수
			function getList(){
				BoardReplyService.getList(
					{'bno' : bnoValue},
					function(result){
						var str = '';
						if (result == null || result.length == 0) {
							replyTable.html('<h3>댓글이 없습니다.</h3>');
						}else {
							str += '<tr><td>작성자</td><td>내용</td><td>작성일</td><td>삭제</td></tr>';
							for (var i = 0; i < result.length; i++) {
								str += '<tr>';
								str += '<td style="display: none;" data-brno="' + result[i].brno + '">' + result[i].brno + '</td>';
								str += '<td>' + result[i].brwriter + '</td>';
								str += '<td>' + result[i].brcontent + '</td>';
								str += '<td>' + displayTime(result[i].brdate) + '</td>';
								str += '<td>';
								
								if (result[i].brwriter == userName) {
									str += '<button name="replydeletebtn">삭제</button>';								
								}
								
								str += '</td>';
								str += '</tr>';

								replyTable.html(str);
							}
							
							$("button[name='replydeletebtn']").on('click', function(){
								
								var str = "";
								var tdArr = new Array();
								var btn = $(this);
								var tr = btn.parent().parent();
								var td = tr.children();
								var brno = td.eq(0).text();
								
								var param = {
										brno : brno,
										bno : bnoValue
									}
								
								BoardReplyService.remove(
									param,
									function(result){
										alert("댓글 삭제가 완료되었습니다.");
										getList();
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
<%@ include file="../testFooter.jsp"%>