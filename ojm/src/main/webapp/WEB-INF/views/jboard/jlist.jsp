<%@page import="org.ojm.security.domain.CustomUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
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
		<h1>구인구직 게시판</h1>
		<hr>
		
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>지역</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>수정일</th>					
					<th>조회</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty jlist }">
						<tr>
							<td colspan="8">게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="job" items="${jlist }">
							<tr>
								<td><c:out value="${job.jno }"></c:out></td>
								<td>
								<c:out value="${job.jaddress }"></c:out></td>
								<td>
									<a class="jmove" href='<c:out value="${job.jno }"/>'>
										<c:out value="${job.jtitle }"></c:out>
									</a>
								</td>
								<td><c:out value="${job.jwriter }"></c:out></td>
								<td><fmt:formatDate value="${job.jdate }" pattern="yyyy년 MM월 dd일"/></td>
								<td><fmt:formatDate value="${job.jupdatedate }" pattern="yyyy년 MM월 dd일"/></td>
								<td><c:out value="${job.jview }"></c:out></td>
							</tr>
						</c:forEach>   
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		
		<!-- page -->
		<div>
			<ul>
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous">
						<a href="${pageMaker.startPage-1 }">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" step="1">
					<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' }">
						<a href="${num }">${num }</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button">
						<a href="${pageMaker.endPage+1 }">&gt;</a>
					</li>
				</c:if>
			</ul>
		</div>
		<hr>
		
		<sec:authorize access="hasRole('ROLE_business')">
			<button id="jRegBtn">게시글 등록</button>
		</sec:authorize>
		<button onclick="location.href='/'">메인</button>
		
		<form action="/jboard/jlist" method="get" id="jActionForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		var jActionForm = $("#jActionForm");
		$("#jRegBtn").click(function(){
			jActionForm.attr('action', '/jboard/jregister');
			jActionForm.submit();
		});
		
		var result = '<c:out value = "${result}"/>';
		
		if (result != '') {
			checkResult(result);
		}
		
		history.replaceState({}, null, null);
		function checkResult(result){
			if (result === '' || history.state) {
				return;
			}
			if (result === 'ok') {
				alert("게시글 등록이 완료되었습니다.");
				return;
			}
			if (result === 'jmodify') {
				alert("게시글 수정이 완료되었습니다.");
				return;
			}
			if (result === 'jremove') {
				alert("게시글 삭제가 완료되었습니다.")
				return;
			}if (result === 'submit') {
				alert("지원서 제출이 완료되었습니다.")
				return;
			}
		}
		
		// ---------- 조회 화면 이동 이벤트 처리 ----------	
		$(".jmove").on('click', function(e){
			e.preventDefault();
			
			jActionForm.attr('action', 'jget');
			jActionForm.append("<input type='hidden' name='jno' value='" + $(this).attr('href') + "'>");

			jActionForm.submit();
		});
		
		// ---------- 페이징 버튼 이벤트 처리 ----------	 
		$(".paginate_button a").on('click', function(e){
			e.preventDefault();	//
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
	</script>
</html>