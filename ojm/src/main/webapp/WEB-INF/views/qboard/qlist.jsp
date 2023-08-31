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
		<h2 style="text-align: center; font-weight: 700;">Q&A 게시판</h2>
		<hr>
		
		<div class="border d-flex justify-content-center">
		<table class="table table-bordered table-hover table-sm">
			<thead class="thead-dark">
				<tr>  
					<th>말머리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>수정일</th>
					<th>조회</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty qlist }">
						<tr>
							<td colspan="6">게시글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="qboard" items="${qlist }">
							<tr>
								<c:choose>
									<c:when test="${qboard.qhide eq '0' }">
										<td><c:out value="${qboard.qcate }"></c:out></td>
									</c:when>
									<c:otherwise>
										<td>비밀글</td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${qboard.qhide eq '0' }">
										<td>
											<a class="qmove" href='<c:out value="${qboard.qno }"/>'>
												<c:out value="${qboard.qtitle }"></c:out>
												<b>[<c:out value="${qboard.qreplycnt }"/>]</b>
											</a>
										</td>
									</c:when>
									<c:when test="${uvo.username eq qboard.qwriter }">
										<td>
											<a class="qmove" href='<c:out value="${qboard.qno }"/>'>
												<c:out value="${qboard.qtitle }"></c:out>
												<b>[<c:out value="${qboard.qreplycnt }"/>]</b>
											</a>
										</td>
									</c:when>
									<c:otherwise>
										<sec:authorize access="hasRole('ROLE_admin')">
											<td>
												<a class="qmove" href='<c:out value="${qboard.qno }"/>'>
													<c:out value="${qboard.qtitle }"></c:out>
													<b>[<c:out value="${qboard.qreplycnt }"/>]</b>
												</a>
											</td>
										</sec:authorize>
										<sec:authorize access="hasRole('ROLE_user')">
											<td>비밀글입니다.</td>
										</sec:authorize>
										<sec:authorize access="hasRole('ROLE_business')">
											<td>비밀글입니다.</td>
										</sec:authorize>
										<c:if test="${uvo.uno eq null }">
											<td>비밀글입니다.</td>
										</c:if>
									</c:otherwise>
								</c:choose>
								<td><c:out value="${qboard.qwriter }"></c:out></td>
								<td><fmt:formatDate value="${qboard.qdate }" pattern="yyyy년 MM월 dd일"/></td>
								<td><fmt:formatDate value="${qboard.qupdatedate }" pattern="yyyy년 MM월 dd일"/></td>
								<td><c:out value="${qboard.qview }"></c:out></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		</div>
		</div>
		
		<!-- page -->
		<div class="div2">
			<ul class="pagination justify-content-center">
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous page-item">
						<a class="page-link" href="${pageMaker.startPage-1 }">&lt;</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" step="1">
					<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' } page-item">
						<a class="page-link" href="${num }">${num }</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button page-item">
						<a class="page-link" href="${pageMaker.endPage+1 }">&gt;</a>
					</li>
				</c:if>
			</ul>
		</div>
		<hr>
		
		<!-- 로그인 확인  -->
		<div class="div3">
			<sec:authorize access="isAuthenticated()">
				<button id="qRegBtn" class="btn btn-dark">게시글 등록</button>
			</sec:authorize>
			<button class="btn btn-dark" onclick="location.href='/'">메인</button>
		</div>
		
		<form action="/qboard/qlist" method="get" id="qActionForm">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="total" value="${total }">
		</form>
	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		var qActionForm = $("#qActionForm");
		$("#qRegBtn").click(function(){
			qActionForm.attr('action', '/qboard/qregister');
			qActionForm.submit();
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
			if (result === 'qModify') {
				alert("게시글 수정이 완료되었습니다.");
				return;
			}
			if (result === 'qRemove') {
				alert("게시글 삭제가 완료되었습니다.")
				return;
			}
		}
		
		// ---------- 조회 화면 이동 이벤트 처리 ----------	
		$(".qmove").on('click', function(e){
			e.preventDefault();
			
			qActionForm.attr('action', 'qget');
			qActionForm.append("<input type='hidden' name='qno' value='" + $(this).attr('href') + "'>");
			qActionForm.submit();
		});
		
		// ---------- 페이징 버튼 이벤트 처리 ----------	 
		$(".paginate_button a").on('click', function(e){
			e.preventDefault();	
			
			qActionForm.find("input[name='pageNum']").val($(this).attr("href"));
			qActionForm.submit();
		});
	</script>
</html>
<%@ include file="../testFooter.jsp"%>