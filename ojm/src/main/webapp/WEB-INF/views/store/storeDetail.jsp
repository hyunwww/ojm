<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	button{
		color: white;
		background-color: purple;
		border-radius: 3px;
	}
	.wrapper{
		width: 800px;
		text-align: center;
		border: 1px solid black;
		margin: auto;
	}
	#reportBtn{
		color: white;
		background: maroon;
	}
	#storeDetail{
		text-align: left;
	}
	.enabledLike{ /* 체크 되어있음  */
		color: white;
		background: teal;
	}
	#likeBtn{ /* 체크 안되어있음  */
		color: white;
		background: purple;
	}
	
	
</style>
<link rel="stylesheet" href="/resources/css/slide.css">
<link rel="stylesheet" href="/resources/css/reviewModal.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2f52d388244ff7c0c91379904a49a35&libraries=services"></script>
<!-- 지도 관련 스크립트 -->
<script type="text/javascript">
	$(function() {
		
		
		var kd = '${store.kd}';
		var wd = '${store.wd}';
		var coords = new kakao.maps.LatLng(kd, wd);
		//map
		var mapContainer = $("#mapContainer")[0];
		var options = { //지도를 생성할 때 필요한 기본 옵션
				center: coords, //지도의 중심좌표.
				level: 4 //지도의 레벨(확대, 축소 정도)
			};

		var map = new kakao.maps.Map(mapContainer, options); //지도 생성 및 객체 리턴
		
		var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });
		
		 // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();
		geocoder.coord2Address(coords.getLng(), coords.getLat(), function(result, status) {
			
			if (status === kakao.maps.services.Status.OK) {
			}else{
				//해당하는 주소가 없는 경우
				$("#mapContainer").hide();
			}
		});
		
		
		//뒤로가기 버튼 이벤트
		$("#backBtn").on("click", function() {
			location.href = '/store/storeList';
		});
		
		
		//신고 버튼 이벤트 
		$("#reportBtn").on("click", function() {
			alert("신고버튼이벤트");
		});
		
		//좋아요 버튼 이벤트
		$("#likeBtn").on("click", function() {
			alert("좋아요 버튼 이벤트!");
			
			//uno, sno 전달 , 버튼 css 변경
			$.ajax({
			      type: "get",
			      url: "/store/likeStore",
			      data: {sno : sno,
			    	  	 uno : 1},	//uno 일단 임의로 설정해놓음.
			      success: function (result, status, xhr) {
			    	  console.log(result);
			    	  
			    	  if(result){
			    		  $("#likeBtn").addClass("enabledLike");
			    	  }else{
			    		  $("#likeBtn").removeClass("enabledLike");
			    	  }
			      }
			});
			
			
			
			
		});
		
		//리뷰작성 버튼 이벤트
		$("#revBtn").on("click", function() {
			alert("작성 버튼 이벤트!");
		});
		
		//예약하기 버튼 이벤트
		$("#bookBtn").on("click", function() {
			alert("예약 버튼 이벤트!");
		});
		
		
	});

</script>
<script type="text/javascript" src="/resources/js/slide.js"></script>
<script type="text/javascript">
	var sno = '${store.sno}';
	//imgLoad(sno);
	
</script>
</head>
<body>
	<!-- 매장 정보 -->
	<div class="wrapper">
		<h2>detail</h2>
		<div id="storeDetail">
			<div class="slide slide_wrap">
			  <c:forEach var="img" items="${store.imgList }">
			      <div class="slide_item item">
			      	<img alt="${img.sino }" src="/images/${img.uuid }_${img.fileName}" style="height: -webkit-fill-available">
			      </div>
			  </c:forEach>
		      <div class="slide_prev_button slide_button">◀</div>
		      <div class="slide_next_button slide_button">▶</div>
		      <ul class="slide_pagination"></ul>
		    </div>
			<p>이름 : ${store.sname }</p>
			<p>주소 : ${store.saddress }</p>
			<p>영업시간 : ${store.openHour }</p>
			<p>예약금 : ${store.sdepo }</p>
			<p>
				<c:choose>
					<c:when test="${store.sdeli eq 1 }">
						배달 o
					</c:when>
					<c:otherwise>
						배달 x
					</c:otherwise>
				</c:choose>
			</p>
			<div id="utilBox" style="text-align: left;">
				<span id="likeBtn">좋아요 ${store.slike }</span>
				<p>평점 평균 ${store.sstar }</p>
			</div>
		</div>
		<div id="mapContainer" style="width: 250px; height: 250px;"></div>
		<br><hr>
		<div id="menuContainer" style="text-align: left;">
			<h4>메뉴</h4>
			<ul id="menuUL" type="disc">
				<c:forEach var="menu" items="${store.menuList }">
					<li>${menu.mname }				-- ${menu.mprice }<c:if test="${menu.mprice eq null}">가격 정보 없음</c:if> </li>
				</c:forEach>
			</ul>

		</div>
		<div style="text-align: right; padding: 10px;">
			<button id="backBtn">뒤로</button>
			<button id="reportBtn">신고</button>
			<button id="open-modal">리뷰 작성</button>
			<button id="bookBtn">예약</button>
		</div>
		
		<br><br>
		<!-- 리뷰 container  -->
		<div class="reviewContainer">
			<c:if test="${not empty store.revList }">
				<c:forEach var="review" items="${store.revList }">
					<hr>
					<p>작성자 : ${review.uno }</p>	
					<p>내용 : ${review.rvcontent }</p>	
					<p>좋 : ${review.rvlike }</p>	
					<p>평 : ${review.rvstar }</p>	
					<p>작성일 : ${review.rvdate }</p>	
				</c:forEach>
			</c:if>
		</div>
	</div>
	
	
	<!-- 리뷰 모달  -->
	<div id="modal">
		<div class="modal-content">

			<form action="/store/addrv" method="post" role="form">
				<div id="review-title">
					<span>평점</span><br />
					<div class="form-group">
						<span class="star"> ★★★★★ <span id="rvstar">★★★★★</span> <input
							type="range" name="rvstar" oninput="myFunction(this.value)"
							value="1" step="1" min="1" max="10">
						</span>
					</div>
					<span>내용</span>
					<div class="form-group">
						<textarea id="review-content" name="rvcontent"></textarea>
						<input type="hidden" name="uno" value="5">
						<input type="hidden" name="rvlike" value="1">
						<!--<input type="hidden" name="pageNum" value="1">
			<input type="hidden" name="amount" value="10">-->
					</div>
					<button type="button" id="close-modal" data-oper="reset" class="btn-reset">취소</button>
					<button type="submit" data-oper="register" class="btn">등록</button>
				</div>
				<input type="hidden" name="sno" value="${store.sno }">
			</form>
		</div>
	</div>

	<script type="text/javascript"> /* review 모달 스크립트  */
		function myFunction(drawstar) {
			//const drawstar = document.querySelector('.star input');
			document.querySelector('.star span').style.width = drawstar * 10
					+ '%';
		}
		const modal = document.getElementById("modal");
		const openModalBtn = document.getElementById("open-modal");
		const closeModalBtn = document.getElementById("close-modal");
		// 모달창 열기
		openModalBtn.addEventListener("click", () => {
		  modal.style.display = "block";
		  document.body.style.overflow = "hidden"; // 스크롤바 제거
		});
		// 모달창 닫기
		closeModalBtn.addEventListener("click", () => {
		  modal.style.display = "none";
		  document.getElementById("review-content").value = "";
		  document.querySelector('.star span').style.width = 0+'%';
		  document.body.style.overflow = "auto"; // 스크롤바 보이기
		});
	</script>
</body>
</html>