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
	</head>
	<body>
		<h1>구인 게시글 수정</h1>
		<hr>
		
		<form>
			<table>
				<tr>
					<td>글 번호</td>
					<td><input id="jno" name="jno" value="${jvo.jno }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input id="jtitle" name="jtitle" value="${jvo.jtitle }"></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input id="jwriter" name="jwriter" value="${jvo.jwriter }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>
					<td>매장</td>
					<td>
						<select name="sno" id="sno">
							<option value="none" selected disabled hidden>매장 선택</option>
							<c:forEach var="stores" items="${stores}">
								<option value="${stores.sno }" data-address="${stores.saddress }">${stores.sname}</option>
							</c:forEach>
						</select>
						<input type="hidden" name="jaddress" id="jaddress">
					</td>
				</tr>
				<tr>
					<td>시급</td>
					<td><input name="salary" id="salary" value="${jvo.salary }">원</td>
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
			
			<button type="submit" data-oper="jmodify">수정</button>
			<button type="submit" data-oper="jremove">삭제</button>
			<button type="submit" data-oper="jlist">목록</button>
		
			<input type="hidden" name="qno" id="qno" value="${jvo.jno }">
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
	
		$(function () {
			
			$("#sno").on("change", function () {
				var saddress = $(this).find("option:selected").data("address");
				console.log(saddress);
				
				$("#jaddress").attr('value', saddress);
				console.log($("#jaddress").val());
			});
		});
	
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
	
	<!-- 화면 이동 스크립트 -->
	<script type="text/javascript">
		$(function(){
			var formObj = $("form");
			$("button").on('click', function(e){
				e.preventDefault();
				var operation = $(this).data("oper")
				if (operation === "jmodify") {
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
					formObj.attr('action', 'jmodify');
					formObj.attr('method', 'post');
				}else if (operation === "jremove") {
					formObj.attr('action', 'jremove');
					formObj.attr('method', 'post');
				}else if (operation == "jlist") {
					formObj.attr('action', 'jlist');
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