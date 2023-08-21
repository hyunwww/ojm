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
		<h1>구인 게시글 등록</h1>
		<hr>
		
		<form action="/job/jregister" method="post" role="form">
			<table>
				<tr>
					<td>제목</td>
					<td><input name="jtitle" id="jtitle"></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input name="jwriter" id="jwriter" value="${uvo.username }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>
					<td>매장</td>
					<td>
						<select name="sno" id="sno">
							<option value="none" selected disabled hidden>매장 선택</option>
							<c:forEach var="stores" items="${stores}">
								<option value="${stores.sno }">${stores.sname}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>시급</td>
					<td><input name="salary" id="salary">원</td>
				</tr>
				<tr>
					<td>근무 요일</td>
					<td>
						<label for="monday"><input type="checkbox" class="weekday" name="jday" id="monday" value="월">월</label>
						<label for="tuesday"><input type="checkbox" class="weekday" name="jday" id="tuesday" value="화">화</label>
						<label for="wednesday"><input type="checkbox" class="weekday" name="jday" id="wednesday" value="수">수</label>
						<label for="thursday"><input type="checkbox" class="weekday" name="jday" id="thursday" value="목">목</label>
						<label for="friday"><input type="checkbox" class="weekday" name="jday" id="friday" value="금">금</label>
						<label for="saterday"><input type="checkbox" class="weekend" name="jday" id="saterday" value="토">토</label>
						<label for="sunday"><input type="checkbox" class="weekend" name="jday" id="sunday" value="일">일</label>
						<label for="weekday"><input type="checkbox" name="jday" id="weekday" value="평일">평일</label>
						<label for="weekend"><input type="checkbox" name="jday" id="weekend" value="주말">주말</label>
					</td>
				</tr>
				<tr>
					<td>근무 시간</td>
					<td>
						<input name="starttime" id="starttime">
						 ~ 
						<input name="endtime" id="endtime">
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea rows="15" cols="100" name="jcontent" id="jcontent"></textarea>
					</td>
				</tr>
			</table>
			<hr>
			<button type="submit" data-oper="jregister">등록</button>	
			<button type="reset" data-oper="reset">취소</button>
			<button type="submit" data-oper="jlist">목록</button>
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$(".weekday").click(function(){
				if(this.checked){
					$("#weekday").prop("disabled",true);
				}
				else{
					$("#weekday").prop("disabled",false);
				}
			});
		});
		
		$(document).ready(function(){
			$(".weekend").click(function(){
				if(this.checked){
					$("#weekend").prop("disabled",true);
				}
				else{
					$("#weekend").prop("disabled",false);
				}
			});
		});
		
		$(document).ready(function(){
			$("#weekday").click(function(){
				if(this.checked){
					$(".weekday").prop("disabled",true);
				}
				else{
					$(".weekday").prop("disabled",false);
				}
			});
		});
		
		$(document).ready(function(){
			$("#weekend").click(function(){
				if(this.checked){
					$(".weekend").prop("disabled",true);
				}
				else{
					$(".weekend").prop("disabled",false);
				}
			});
		});
	</script>
	
	<script type="text/javascript">
		$(function(){
		var formObj = $("form");
		
		$("button").on('click', function(e){
			e.preventDefault();		// 동작 중단
			
			var operation = $(this).data("oper");
			
			if (operation === 'jregister') {
				if (document.getElementById("jtitle").value=="") {
					alert("제목을 입력하세요.");
					return;
				}else if (document.getElementById("sno").value=="none") {
					alert("매장을 선택하세요.")
					return;
				}else if (document.getElementById("salary").value=="") {
					alert("시급을 입력하세요.");
					return;
				}else if(document.getElementById("monday").checked==false && 
						document.getElementById("tuesday").checked==false && 
						document.getElementById("wednesday").checked==false &&
						document.getElementById("thursday").checked==false &&
						document.getElementById("friday").checked==false &&
						document.getElementById("saterday").checked==false &&
						document.getElementById("sunday").checked==false &&
						document.getElementById("weekday").checked==false &&
						document.getElementById("weekend").checked==false) {
					alert("근무 요일을 선택하세요.");
					return;
				}else if(document.getElementById("starttime").value=="" || 
						document.getElementById("endtime").value==""){
					alert("근무 시간을 입력하세요.");
					return;
				}else if (document.getElementById("jcontent").value=="") {
					alert("내용을 입력하세요.");
					return;
				}
				
				formObj.attr("action", '/job/jregister');
				
				formObj.submit();
				
			}else if (operation === 'jlist') {
				formObj.attr("action", '/job/jlist');
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