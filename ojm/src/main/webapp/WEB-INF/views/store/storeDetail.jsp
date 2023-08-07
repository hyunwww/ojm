<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	document body{
		position : absolute;
		width: 100%;
		height: 100%;
	}
	#btnContainer button{
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
	.mapModal {
	  position: absolute;
	  width: 1000px;
	  height: 700px;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  overflow: hidden;
	}
	.map-overlay{
	  position: fixed;
	  top: 0;
	  left: 0;
	  right: 0;
	  bottom: 0;
	  background-color: rgba(0, 0, 0, 0.8);
	  display: none;
	  z-index: 1;
	}
	p{
		position: relative;
	}
	#distance{
		position: absolute;
		padding: 10px;
		right: 0;
	
	
	}
	.customInfo{
		padding: 2px;
		background-color: whitesmoke;
		border: 2px solid indianred;
		border-radius: 5px; 
		font-family: sans-serif;
	
	}
</style>
<link rel="stylesheet" href="/resources/css/imgPopup.css">
<link rel="stylesheet" href="/resources/css/slide.css">
<link rel="stylesheet" href="/resources/css/reviewModal.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2f52d388244ff7c0c91379904a49a35&libraries=services"></script>
<script type="text/javascript" src="/resources/js/imgPopup.js"></script>

<!-- 지도 관련 스크립트 -->
<script type="text/javascript">
	
	//필요 유저 정보 ?
	var nowLike = '${isLike}';
	var sno = '${store.sno}';

	var popMap;	//지도 객체
	var kd = '${store.kd}';
	var wd = '${store.wd}';
	var bounds = new kakao.maps.LatLngBounds(); //지도 범위
	$(function() {
		var user = '${user}';
		console.log(user);
		
		
		// 마커 이미지의 주소(현재 위치)
		var markerImageUrl = '/resources/img/icon/free-icon-restaurant-4552186.png', 
		    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
		    markerImageOptions = { 
		        offset : new kakao.maps.Point(13, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
		    };
		
		// 마커 이미지를 생성한다
		var markerImage = new kakao.maps.MarkerImage(markerImageUrl, markerImageSize, markerImageOptions);
		
		
		
		
		var coords = new kakao.maps.LatLng(kd, wd);
		//map
		var mapContainer = $("#mapContainer")[0];
		var mapModal = $(".mapModal")[0];
		var options = { //지도를 생성할 때 필요한 기본 옵션
				center: coords, //지도의 중심좌표.
				level: 4, //지도의 레벨(확대, 축소 정도)
				draggable: false
			};

		var map = new kakao.maps.Map(mapContainer, options); //지도 생성 및 객체 리턴
		popMap = new kakao.maps.Map(mapModal, {
			center: coords,
			level: 3,
		});
		bounds.extend(coords);
		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		popMap.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		var marker = new kakao.maps.Marker({
            map: map,
            position: coords,
            image : markerImage
        });
		var popMarker = new kakao.maps.Marker({
            map: popMap,
            position: coords,
            image : markerImage
        });
		
		 // 주소-좌표 변환 객체를 생성합니다
		 // 매장 주소에 해당하는 위치정보가 없는 경우 지도 숨김
        var geocoder = new kakao.maps.services.Geocoder();
		geocoder.coord2Address(coords.getLng(), coords.getLat(), function(result, status) {
			
			if (status === kakao.maps.services.Status.OK) {
			}else{
				//해당하는 주소가 없는 경우
				$("#mapContainer").hide();
			}
		});
		
		
		
		
		
		
		
		//리뷰버튼(비로그인) 이벤트
		$("#revBtn").on("click", function() {
			alert("로그인이 필요한 서비스입니다.");
			location.href = '/user/login';
		});
		
		
		//뒤로가기 버튼 이벤트
		$("#backBtn").on("click", function() {
			history.go(-1);
		});
		
		
		//신고 버튼 이벤트 
		$("#reportBtn").on("click", function() {
			alert("신고버튼이벤트");
		});
		
		//좋아요 버튼 이벤트
		$("#utilBox span").on("click", function() {
			alert("좋아요 버튼 이벤트!");
			console.log("nowLike : " + nowLike);
			//uno, sno 전달 , 버튼 css 변경
			$.ajax({
			      type: "get",
			      url: "/store/likeStore",
			      data: {sno : sno,
			    	  	 current : nowLike},
			      success: function (result, status, xhr) {
			    	  if(result){
			    		  $("#utilBox span").addClass("enabledLike");
			    		  $("#utilBox span").removeAttr("id");
			    		  nowLike = true;
			    	  }else{
			    		  $("#utilBox span").removeClass("enabledLike");
			    		  $("#utilBox span").attr("id", "likeBtn");
			    		  nowLike = false;
			    	  }
			    	  
			      }
			});
		});
		
		
		//예약하기 버튼 이벤트
		$("#bookBtn").on("click", function() {
			alert("예약 버튼 이벤트!");
		});
		
		//이미지 클릭 이벤트
		$("#storeDetail img").on("click", function() {
			$(".slide-overlay").show();
		});
		$(".close-btn").click(function() {
			$(".slide-overlay").hide();
		});
		
		//지도 클릭 이벤트
		$("#mapContainer").click(function() {
			$(".map-overlay").show();
			popMap.relayout();
			popMap.setBounds(bounds);
			//popMap.panTo(coords);
			
		});
		
		
		// 지도 모달 바깥 클릭 시 닫힘
        window.onclick = function(event) {
			var mapOverlay = $(".map-overlay")[0];
            if (event.target == mapOverlay) {
            	$(".map-overlay").hide();
            }
        }
	});

</script>
<script type="text/javascript" src="/resources/js/slide.js"></script>
<script type="text/javascript">  /* 현재 위치 및 거리 계산*/
	var distance;	//현재 위치로부터의 거리
	$(function() {
		navigator.geolocation.getCurrentPosition(
				function(position) {
					
					// 마커 이미지 생성
					var targetImageUrl = '/resources/img/icon/free-icon-location-pointer-2098567.png', 
					    targetImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
					    targetImageOptions = { 
					        offset : new kakao.maps.Point(13, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
					    };
					
					var targetMarkerImage = new kakao.maps.MarkerImage(targetImageUrl, targetImageSize, targetImageOptions);

					
					var currentLocMarker = new kakao.maps.Marker({
			            map: popMap,
			            position: new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude),
			            image : targetMarkerImage
			        });
					bounds.extend(currentLocMarker.getPosition());
					distance = getDistance(kd,wd,position.coords.latitude,position.coords.longitude);
					console.log("현재 위치로부터의 거리 : " + distance + " km");
					$("#distance").html(distance+" km");
					
					// 커스텀 오버레이를 생성합니다
					var customOverlay = new kakao.maps.CustomOverlay({
					    map: popMap,
					    position: currentLocMarker.getPosition(),
					    content: '<div class="customInfo" style="padding:3px;">현재 위치</div>',
					    xAnchor: 0.45,
					    yAnchor: 2.5
					});

					
				}, 
				function() {
					alert("geolocation error");
				}
				);
	});
	
	//거리계산함수
	function getDistance(lat1, lon1, lat2, lon2) {
		if ((lat1 == lat2) && (lon1 == lon2)) {
			return 0;
		}
		else {
			var radlat1 = Math.PI * lat1/180;
			var radlat2 = Math.PI * lat2/180;
			var theta = lon1-lon2;
			var radtheta = Math.PI * theta/180;
			var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
			if (dist > 1) {
				dist = 1;
			}
			dist = Math.acos(dist);
			dist = dist * 180/Math.PI;
			dist = dist * 60 * 1.1515;
			dist = dist * 1.609344 
			
			//결과 단위 : km
			return dist.toFixed(1);
		}
	}

</script>
</head>
<body>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="user"/>
	</sec:authorize>
	
	<!-- 매장 정보 -->
	<div class="wrapper">
		<h2>detail</h2>
		<c:if test="${not empty user }">
			<h3>${user }</h3>
		</c:if>
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
			<p>이름 : ${store.sname }<span id="distance"></span></p>
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
				<c:choose>
					<c:when test="${isLike }">
						<span class="enabledLike">좋아요 ${store.slike }</span>
					</c:when>
					<c:otherwise>
						<span id="likeBtn">좋아요 ${store.slike }</span>
					</c:otherwise>
				</c:choose>
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
		<div id="btnContainer" style="text-align: right; padding: 10px;">
			<button id="backBtn">뒤로</button>
			<button id="reportBtn" style="background-color: maroon;">신고</button>
			
			<sec:authorize access="isAuthenticated()">
				<button id="open-modal">리뷰 작성</button>
			</sec:authorize>
			<sec:authorize access="isAnonymous()">
				<button id="revBtn">리뷰 작성</button>
			</sec:authorize>
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
							value="0" step="0.5" min="0" max="5">
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
	
	
	<!-- 이미지 팝업  -->
	<div class="slide-overlay">
		<button class="close-btn">close</button>
		<button class="slide-btn --prev">prev</button>
		<button class="slide-btn --next">next</button>
		<div class="slide__container">
			<ul class="slides">
				<c:forEach var="img" items="${store.imgList }">
					<li>
						<img alt="${img.sino }" src="/images/${img.uuid }_${img.fileName}">
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<!-- 지도 팝업  -->
	<div class="map-overlay">
		<div class="mapModal"></div>
	</div>
	
	
	
	
	
	
	
	<script type="text/javascript"> /* review 모달 스크립트  */
		function myFunction(drawstar) {
			//const drawstar = document.querySelector('.star input');
			document.querySelector('.star span').style.width = drawstar * 20
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