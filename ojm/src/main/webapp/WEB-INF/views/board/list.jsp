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
		<h1>자유게시판</h1>
		<hr>
		
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>말머리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>수정일</th>					
					<th>조회</th>
					<th>추천</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty list }">
						<tr>
							<td colspan="8">게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="board" items="${list }">
							<tr>
								<td><c:out value="${board.bno }"></c:out></td>
								<td><c:out value="${board.bcate }"></c:out></td>
								<td>
									<a class="move" href='<c:out value="${board.bno }"/>'>
										<c:out value="${board.btitle }"></c:out>
										<b>[<c:out value="${board.breplycnt }"/>]</b>
									</a>
								</td>
								<td><c:out value="${board.bwriter }"></c:out></td>
								<td><fmt:formatDate value="${board.bdate }" pattern="yyyy년 MM월 dd일"/></td>
								<td><fmt:formatDate value="${board.bupdatedate }" pattern="yyyy년 MM월 dd일"/></td>
								<td><c:out value="${board.bview }"></c:out></td>
								<td><c:out value="${board.blike }"></c:out></td>
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
		
		<!-- 로그인 확인  -->
		<sec:authorize access="isAuthenticated()">
			<button id="regBtn">게시글 등록</button>
		</sec:authorize>
		<button onclick="location.href='/'">메인</button>
		
		<form action="/board/list" method="get" id="actionForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="total" value="${total }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		var actionForm = $("#actionForm");
		$("#regBtn").click(function(){
			// 게시글 등록 버튼 클릭 시 삽입 화면으로 이동
			actionForm.attr('action', '/board/register');
			actionForm.submit();
			// location.href = "/board/register?pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}";
			// 위 코드와 같다.
		});
		
		// 결과 창 출력을 위한 코드
		var result = '<c:out value = "${result}"/>';
		
		// rttr 객체를 통해 받아온 값이 빈 값이 아닐 때(데이터 변경) 알림 메소드 실행
		if (result != '') {
			checkResult(result);
		}
		
		// 뒤로가기할 때 문제가 될 수 있으므로
		// history 객체를 조작 ({정보를 담은 객체}, 뒤로가기 버튼 문자열 형태의 제목, 바꿀 url)
		history.replaceState({}, null, null);
		function checkResult(result){
			if (result === '' || history.state) {	// 뒤로가기 방지
				return;
			}
			if (result === 'ok') {			// 삽입되면
				alert("게시글 등록이 완료되었습니다.");
				return;
			}
			if (result === 'modify') {		// 수정
				alert("게시글 수정이 완료되었습니다.");
				return;
			}
			if (result === 'remove') {		// 삭제
				alert("게시글 삭제가 완료되었습니다.")
				return;
			}
		}
		
		// ---------- 조회 화면 이동 이벤트 처리 ----------	
		$(".move").on('click', function(e){
			e.preventDefault(); // <a> 클릭 시 페이지 이동이 이루어지지 않게 하기
			
			// $(this) 의 요소 중 href의 속성 값 (value)
			actionForm.attr('action', 'get'); // 경로 변경
			actionForm.append("<input type='hidden' name='uno' value='" + ${uvo.uno} +"'>");	// uno 저장
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr('href') + "'>");	// bno 저장
			actionForm.submit();
		});
		
		// ---------- 페이징 버튼 이벤트 처리 ----------	 
		$(".paginate_button a").on('click', function(e){
			e.preventDefault();	// <a> 클릭 시 페이지 이동이 이루어지지 않게 하기
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
	</script>
</html>