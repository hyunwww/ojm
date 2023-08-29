<%@page import="org.ojm.security.domain.CustomUser"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	</head>
	<body>
		<h1>게시글 수정</h1>
		<hr>
		<form>
			<table>
				<tr>
					<td>제목</td>
					<td><input id="btitle" name="btitle" value="${vo.btitle }"></td>
				</tr>
				<tr>
					<td>말머리</td>
					<td>
						<select name="bcate" id="bcate">
							<option value="none" selected disabled hidden>말머리 선택</option>
							<sec:authorize access="hasRole('ROLE_admin')">
								<option value="공지사항">공지사항</option>
							</sec:authorize>
							<option value="추천">추천</option>
							<option value="정보">정보</option>
							<option value="자유">자유</option>
							<option value="기타">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input id="bwriter" name="bwriter" value="${vo.bwriter }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="15" cols="100" id="bcontent" name="bcontent">${vo.bcontent }</textarea></td>
				</tr>
				<tr>
					<!-- 첨부 파일 -->
					<td>첨부 파일</td>
					<td class = 'uploadResult'>
						<ul></ul>
					</td>
				</tr>
			</table>
			<hr>
			
			<button type="submit" data-oper="modify">수정</button>
			<button type="submit" data-oper="remove">삭제</button>
			<button type="submit" data-oper="list">목록</button>
		
			<input type="hidden" name="bno" id="bno" value="${vo.bno }">
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
				if (operation === "modify") {
					if (document.getElementById("btitle").value=="") {
						alert("제목을 입력하세요.");
						return;
					}else if (document.getElementById("bcate").value=="none") {
						alert("카테고리를 선택하세요.")
						return;
					}else if (document.getElementById("bcontent").value=="") {
						alert("내용을 입력하세요.");
						return;
					}
					formObj.attr('action', 'modify');
					formObj.attr('method', 'post');
				}else if (operation === "remove") {
					formObj.attr('action', 'remove');
					formObj.attr('method', 'post');
				}else if (operation == "list") {
					formObj.attr('action', 'list');
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
</html>