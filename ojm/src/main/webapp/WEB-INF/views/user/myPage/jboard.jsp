<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>내 구인구직</title>
</head>
<body>
	<h1>내 구직 현황</h1>
		<hr>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>가게이름</th>
					<th>신청일</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty jlist }">
						<tr>
							<td colspan="3">구직 신청 이력이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="job" items="${jlist }" varStatus="i">
							<tr>
								<td><c:out value = "${i.count }"/></td>
								<td style="color: blue" onclick="show('${job.jsno}')">
									<c:out value="${job.sname }"></c:out>
								</td>
								<td><fmt:formatDate value="${job.jsdate }" pattern="yyyy년 MM월 dd일"/></td>	
							</tr>
						</c:forEach>   
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		
		<!-- 지원하기 모달 -->
		<div id="modal">
			<div class="modal-content">
				<h2>지원</h2>
				<hr>
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
					<button id="close-modal">닫기</button>
					<input type="hidden" name="ugender" id="ugender" value="${uvo.info.ugender }">
					<input type="hidden" name="jno" value="${jvo.jno}">
					<input type="hidden" name="uno" value="${uvo.uno}">
					<input type="hidden" name="sno" value="${jvo.sno}">
					<input type="hidden" name="sname" value="${store.sname}">
			</div>
		</div>
		
		<hr>
		
		<button onclick="location.href='/'">메인</button>
		
	
	<br><br><jsp:include page="myPageFooter.jsp"></jsp:include>
</body>
	
	<!-- 모달 스크립트 -->
	<script type="text/javascript">
		var modal = document.getElementById("modal");
		var openModal = document.getElementById("applicationBtn");
		var closeModalBtn = document.getElementById("close-modal");
		
		
		// 모달창 열기
		function show(t) {
			console.log(t);
			modal.style.display = "block";
			document.body.style.overflow = "hidden"; // 스크롤바 제거
		}
		
		// 모달창 닫기
		closeModalBtn.addEventListener("click", () => {
			modal.style.display = "none";
			document.body.style.overflow = "auto"; // 스크롤바 보이기
		});
	</script>
</html>