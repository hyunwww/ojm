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
			#modal {
			  position: fixed;
			  z-index: 1;
			  left: 0;
			  top: 0;
			  width: 100%;
			  height: 100%;
			  overflow: auto;
			  background-color: rgba(0, 0, 0, 0.4);
			  display: none;
			}
			.modal-content {
			  background-color: #fefefe;
			  margin: 15% auto;
			  padding: 20px;
			  border: 1px solid #888;
			  width: 80%;
			}
			.close {
			  color: #aaa;
			  float: right;
			  font-size: 28px;
			  font-weight: bold;
			}
			.close:hover,
			.close:focus {
			  color: black;
			  text-decoration: none;
			  cursor: pointer;
			}
		</style>
	</head>
	<body>
		<h1>구인글 화면</h1>
		<hr>
		
		<table>
			<tr>
				<td>글 번호</td>
				<td><input name="jno" value="${jvo.jno }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input name="jtitle" value="${jvo.jtitle }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input name="jwriter" value="${jvo.jwriter }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>매장</td>
				<td><input name="jaddress" value="${store.sname }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input name="saddress" value="${store.saddress }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>시급</td>
				<td><input name="salary" value="${jvo.salary }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>근무요일</td>
				<td><input name="jday" value="${jvo.jday }" readonly="readonly" style="background-color: #ccc"></td>
			</tr>
			<tr>
				<td>근무시간</td>
				<td>
					<input name="starttime" value="${jvo.starttime }" readonly="readonly" style="background-color: #ccc">
					 ~ 
					<input name="endtime" value="${jvo.endtime }" readonly="readonly" style="background-color: #ccc">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="15" cols="100" name="jcontent" readonly="readonly" style="background-color: #ccc">${jvo.jcontent }</textarea></td>
			</tr>
		</table>
		<hr>
		
		<!-- 작성자 본인일 때에만 게시글 수정이 가능하도록 기능 추가해야 함 -->
		<c:if test="${jvo.jwriter eq uvo.username }">
			<button data-oper="jmodify">수정</button>
		</c:if>
		<sec:authorize access="hasRole('ROLE_user')">
			<button id="applicationBtn">지원</button>
		</sec:authorize>
		<button data-oper="jlist">목록</button>
		
		<form action="/jboard/jmodify" method="get" id="jOperForm">
			<input type="hidden" name="jno" id="jno" value="${jvo.jno }">			
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<!-- 지원하기 모달 -->
	<div id="modal">
		<div class="modal-content">
			<h2>지원</h2>
			<hr>
			<form class="submit">
				<table>
					<tr>
						<td>이름</td>
						<td><input type="text" name="username" id="username" value="${uvo.username }" readonly="readonly" style="background-color: #ccc"></td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td><input type="text" name="userbirth" id="userbirth" value="${uvo.userbirth }" readonly="readonly" style="background-color: #ccc"></td>
					</tr>
					<tr>
						<td>성별</td>
						<c:choose>
							<c:when test="${uvo.info.ugender eq 'male' }">
								<td>남</td>
							</c:when>
							<c:otherwise>
								<td>여</td>
							</c:otherwise>
						</c:choose>
						
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input type="text" name="userphone" id="userphone" value="${uvo.userphone }" readonly="readonly" style="background-color: #ccc"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" name="useremail" id="useremail" value="${uvo.useremail }" readonly="readonly" style="background-color: #ccc"></td>
					</tr>
					<tr>
						<td>경력사항</td>
						<td><input type="text" name="career" id="career"></td>
					</tr>
					<tr>
						<td>하고싶은 말</td>
						<td><input type="text" name="pobu" id="pobu"></td>
					</tr>
				</table>
				<button type="submit" id="submitBtn">제출</button>
				<button id="close-modal">닫기</button>
				<input type="hidden" name="ugender" id="ugender" value="${uvo.info.ugender }">
				<input type="hidden" name="jno" value="${jvo.jno}">
				<input type="hidden" name="uno" value="${uvo.uno}">
				<input type="hidden" name="sno" value="${jvo.sno}">
			</form>
			
		</div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 화면 이동 스크립트 -->
	<script type="text/javascript">
		$(function(){
			var operForm = $("#jOperForm");  
			
			$("button[data-oper='jmodify']").on('click', function(){
				operForm.submit();
			});
			$("button[data-oper='jlist']").on('click', function(){
				operForm.find("#jno").remove();
				operForm.attr('action', '/jboard/jlist');
				operForm.submit();
			});
		})
	</script>
	
	<!-- 모달 스크립트 -->
	<script type="text/javascript">
		var modal = document.getElementById("modal");
		var openModalBtn = document.getElementById("applicationBtn");
		var closeModalBtn = document.getElementById("close-modal");
		var submitBtn = document.getElementById("submitBtn");
		var formObj = $(".submit");
		
		// 모달창 열기
		openModalBtn.addEventListener("click", () => {
			modal.style.display = "block";
			document.body.style.overflow = "hidden"; // 스크롤바 제거
		});
		
		// 모달창 닫기
		closeModalBtn.addEventListener("click", () => {
			e.preventDefault();
			modal.style.display = "none";
			document.body.style.overflow = "auto"; // 스크롤바 보이기
		});
		
		// 제출
		$("#submitBtn").on('click', function(e){
			e.preventDefault();
			formObj.attr("action", '/jsboard/jsregister');
			formObj.attr("method", 'post');
			formObj.submit();
		});
	</script>
</html>