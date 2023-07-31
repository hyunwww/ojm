<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	html, body {
	
	    margin: 0;
	
	    height: 100%;
	
	    overflow: hidden;
	
	}
	.wrapper{
		width: 750px;
		height: 100%;
		margin: auto; 
	}
	.header{
		background-color: gray;
		height: 10%;
	}
	.sideFilter{
		background-color: silver;
		position: absolute;
		width: 15%;
		height: 100%;
		z-index: 5;
	}	
	.content{
		position: absolute;
		z-index: 1;
		width: 100%;
		height: 100%;
		text-align: center;
	}
	.mainContainer{
		height: 100%;
		position: relative;
		
	}
	.rankingArea{
		position: fixed;
		top: 20%;
		right: 10%;
		background-color: orange;
		width: 100px;
		height: 200px;
	}
	
</style>
  
  
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		
		//검색 버튼
		$("#searchBtn").on("click", function() {
			if ($("input[name='searchInput']").val() == '') {
				alert("검색어 입력 필요.");
				return;
			}
			
			
			$("#searchBox form").submit(); 
		});
		
		$("#mainBtn").on("click", function() {
			location.href = '/';
		})
	});


</script>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<p>header</p>
		</div>
		<div class="mainContainer">
			<div class="content">
				<div id="searchBox">
					<form method="get" action="/store/search">
					      <input type="text" name="searchInput" placeholder="검색어 입력">
					      <button type="button" title="Search" id="searchBtn">search</button>
					      <button type="button" id="mainBtn">goMain</button>
				    </form>
				</div>
				<h4>검색 결과</h4>
				<div id="searchResult">
					<c:choose>
						<c:when test="${not empty stores }">
							<c:forEach var="store" items="${stores }">
								<hr><br>
								<p>이름 : <a href="/store/detail?sno=${store.sno }">${store.sname }</a></p>
								<p>주소 : ${store.saddress }</p>
								<p>카테고리 : ${store.scate }</p>
								<p>
									<c:choose>
										<c:when test="${store.sdepo != 0 }">
											예약금 : ${store.sdepo }
										</c:when>
										<c:otherwise>
											예약금 : 없음
										</c:otherwise>
									</c:choose>
								</p>
								<p><c:choose>
									<c:when test="${store.sdeli eq 1 }">
										배달 : o
									</c:when>
									<c:otherwise>
										배달 : x
									</c:otherwise>
								</c:choose></p>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<p>일치 결과 없음</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="sideFilter">
				<div class="category one">
					<h5>one</h5>
					<input type="checkbox" name="" value="check">1
					<input type="checkbox" name="" value="check">2
					<input type="checkbox" name="" value="check">3
					<input type="checkbox" name="" value="check">4
					<input type="checkbox" name="" value="check">5
				</div>
				<br><hr>
				<div class="category two">
					<h5>one</h5>
					<input type="checkbox" name="" value="check">1
					<input type="checkbox" name="" value="check">2
					<input type="checkbox" name="" value="check">3
					<input type="checkbox" name="" value="check">4
					<input type="checkbox" name="" value="check">5
				</div>
				<br><hr>
				<div class="category three">
					<h5>one</h5>
					<input type="checkbox" name="" value="check">1
					<input type="checkbox" name="" value="check">2
					<input type="checkbox" name="" value="check">3
					<input type="checkbox" name="" value="check">4
					<input type="checkbox" name="" value="check">5
				</div>
				<br><hr>
				<div id="category four">
					<h5>one</h5>
					<select name="scate">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	
	<div class="rankingArea">
	
	</div>
	
</body>
</html>