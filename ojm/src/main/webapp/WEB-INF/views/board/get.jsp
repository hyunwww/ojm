<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<h1>게시글 화면</h1>
		<hr>
		
		<table>
			<tr>
				<td>글 번호</td>
				<td><input name="bno" value="${vo.bno }" readonly="readonly"></td>
			</tr>
			<tr>
				<td>말머리</td>
				<td><input name="bcate" value="${vo.bcate }" readonly="readonly"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input name="btitle" value="${vo.btitle }" readonly="readonly"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input name="bwriter" value="${vo.bwriter }" readonly="readonly"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="15" cols="100" name="bcontent" readonly="readonly">${vo.bcontent }</textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<button name="blike">좋아요</button> ${vo.blike }
				</td>
			</tr>
			
			<!-- 첨부 파일 -->
			<tr>
				<td>첨부 파일</td>
				<td class = 'uploadResult'>
					<ul></ul>
				</td>
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
					<td><input name="brwriter" value="${uvo.username }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea class="brcontent" rows="5" cols="50" name="brcontent"></textarea></td>
				</tr>		
			</table>
		</form>
		<button name="replyregisterbtn" type="submit">댓글 달기</button>
		<hr>
		</c:if>
		
		<!-- 댓글 출력 -->
		<h3>댓글 목록</h3>
		<table class="reply">
			<tr>
			</tr>
		</table>
		<hr>
		
		<!-- 작성자 본인일 때에만 게시글 수정이 가능하도록 기능 추가해야 함 -->
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
		$("button[name='blike']").on("click", function(){
			
		});
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
						
						str += '<li>'
						str += '<a href = "/download?filename=' + fileCallPath + '">';
						str += obj.filename;
						str += '</a>'
						str += '<span data-file="' + fileCallPath + '"></span>';
						str += '</li>';
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
							str += '<tr><td>댓글 번호</td><td>작성자</td><td>내용</td><td>작성일</td><td>삭제</td></tr>';
							for (var i = 0; i < result.length; i++) {
								str += '<tr>';
								str += '<td data-brno="' + result[i].brno + '">' + result[i].brno + '</td>';
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