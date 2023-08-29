<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#real {
	
}

#breq {
	resize: none;
}

document body {
	position: absolute;
	width: 100%;
	height: 100%;
}

#btnContainer button {
	color: white;
	background-color: purple;
	border-radius: 3px;
}

.wrapper {
	width: 800px;
	text-align: center;
	border: 1px solid black;
	margin: auto;
}

#reportBtn {
	color: white;
	background: maroon;
}

#storeDetail {
	text-align: left;
}

.enabledLike { /* 체크 되어있음  */
	color: white;
	background: teal;
}

#likeBtn { /* 체크 안되어있음  */
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

.map-overlay {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.8);
	display: none;
	z-index: 1;
}

.reportOverlay {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.8);
	display: none;
	z-index: 1;
}

.reportModal {
	width: fit-content;
	height: auto;
	margin: auto;
	background-color: white;
	padding: 15px;
	border-radius: 5px;
	position: relative;
	top: 10%;
}

.recContainer {
	width: 100%;
	height: auto;
	border: 1px solid black;
}

p {
	position: relative;
}

#distance {
	position: absolute;
	padding: 10px;
	right: 0;
}

.customInfo {
	padding: 2px;
	background-color: whitesmoke;
	border: 2px solid indianred;
	border-radius: 5px;
	font-family: sans-serif;
}

.card {
	height: auto;
	width: -webkit-fill-available;
	border-radius: 15px;
	display: inline-block;
	position: relative;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
	overflow: hidden;
	padding: 15px;
	background-color: floralwhite;
}

.owl-next, .owl-prev {
	background-color: rgba(245, 126, 100, 0.6);
	color: white;
	border-radius: 10px;
	width: auto;
	display: inline-block;
	padding: 10px;
	cursor: pointer;
	position: relative;
	transform: translateY(-50%);
}

.owl-prev {
	left: -24rem;
	top: -3rem;
	z-index: 5;
}

.owl-next {
	right: -24rem;
	top: -3rem;
	z-index: 5;
}

.owl-lastItem {
	background-color: rgba(245, 126, 100, 0.2);
}

#modal2 {
	position: fixed;
	z-index: 7;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
	display: none;
}

.modal-content2 {
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

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

#cbtn {
	background-color: aqua;
	color: white;
}
</style>
<link rel="stylesheet" href="/resources/css/imgPopup.css">
<link rel="stylesheet" href="/resources/css/reviewModal.css">
<link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
<link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2f52d388244ff7c0c91379904a49a35&libraries=services"></script> -->
<script type="text/javascript" src="/resources/js/imgPopup.js"></script>
<script type="text/javascript" src="/resources/js/owl.carousel.min.js"></script>
<!-- 지도 관련 스크립트 -->
<script type="text/javascript">
	
	//필요 유저 정보 ?
	var nowLike = '${isLike}';
	var sno = '${store.sno}';
	var slike = '${store.slike}';

	var popMap;	//지도 객체
	var kd = '${store.kd}';
	var wd = '${store.wd}';
	//var bounds = new kakao.maps.LatLngBounds(); //지도 범위
	$(function() {
		
		/* // 마커 이미지의 주소(현재 위치)
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
		 */
		
		
		
		
		
		
		//리뷰버튼(비로그인) 이벤트
		$("#revBtn").on("click", function() {
			alert("로그인이 필요한 서비스입니다.");
			location.href = '/user/login';
		});
		 $("#open-modal").click(function() {
			$("#modal").show();
		});
		
		
		//뒤로가기 버튼 이벤트
		$("#backBtn").on("click", function() {
			history.go(-1);
		});
		
		
		//신고 버튼 이벤트 
		$("#reportBtn").on("click", function() {
			$(".reportOverlay").show();
		});
		//신고 모달 내 버튼 이벤트
		$(".reportOverlay input[value='뒤로']").click(function() {
			$(".reportOverlay").hide();
			$(".reportOverlay form")[0].reset();
		});
		$(".reportOverlay input[value='신고하기']").click(function() {
			
			var form = $(".reportOverlay form")[0];
			if (form.rptitle.value == '') {
				alert("제목 필수작성");
				return;
			}
			if (form.rpcontent.value == '') {
				alert("내용은 필수작성");
				return;
			}
			
			var check = confirm("신고내용을 제출하시겠습니까?"); // 확인 메세지
			if (check) {
				var formData = $(".reportOverlay form").serialize() ;

				$.ajax({
					type : 'post',
					url : '/store/report',
					data : formData,
					error: function(xhr, status, error){
						alert(error);
					},
					success : function(result){
						alert("제출되었습니다.");
						$(".reportOverlay").hide();
						$(".reportOverlay form")[0].reset();
					}
				});
			}
		});
		
		
		
		//좋아요 버튼 이벤트
		$("#utilBox span").on("click", function() {
			
			
			console.log("nowLike : " + nowLike);
			//uno, sno 전달 , 버튼 css 변경
			$.ajax({
			      type: "get",
			      url: "/store/likeStore",
			      data: {sno : sno,
			    	  	 current : nowLike},
			      success: function (result, status, xhr) {
			    	  if(result){// 좋아요 적용
			    		  $("#utilBox span").addClass("enabledLike");
			    		  $("#utilBox span").removeAttr("id");
			    		  slike++;
			    		  $("#utilBox span").html("좋아요 " + slike);
			    		  nowLike = true;
			    	  }else{//해제
			    		  $("#utilBox span").removeClass("enabledLike");
			    		  $("#utilBox span").attr("id", "likeBtn");
			    		  slike--;
			    		  $("#utilBox span").html("좋아요 " + slike);
			    		  nowLike = false;
			    	  }
			    	  
			      },
			      error: function(xhr, status, error) {
					alert("로그인이 필요한 서비스입니다.");
				}
			});
		});
		
		
		//예약하기 버튼 이벤트
		//$("#bookBtn").on("click", function() {
		//	alert("예약 버튼 이벤트!");
		//});
		
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
			var reportOverlay = $(".reportOverlay")[0];
            if (event.target == mapOverlay) {
            	$(".map-overlay").hide();
            }
            if (event.target == reportOverlay) {
            	$(".reportOverlay").hide();
            	$(".reportOverlay form")[0].reset();
            }
        }
	});

</script>

<script type="text/javascript">  /* 현재 위치 및 거리 계산*/
	var distance;	//현재 위치로부터의 거리
	var currentPosition;
	$(function() {
		navigator.geolocation.getCurrentPosition(
				function(position) {
					currentPosition = position.coords;
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
<script type="text/javascript">/* 거리 기반 추천 로직 */
	$(function() {
		//슬라이더
		recommendByDistance();
		
		
		 
	});
	
	
	function recommendByDistance() {
		
		var scate = ['${store.scate}'];
		var saddr = '${store.saddress}';
		//지역과 카테고리 기준으로 불러오기
		$.ajax({
		      type: "get",
		      url: "/store/search/filter",
		      data: {scate : scate,
		    	  	location : saddr.split(" ")[0]},
		      success: function (result, status, xhr) {
		    	
		    	  
		    	  for (var store of result) {
		    		if (sno == store.sno) {
						continue;
					}
		    		//내 위치로부터 거리 *distance 는 현재 매장에 대한 정보
		    		var dist = getDistance(kd, wd, store.kd, store.wd);
		    		var empty = true;
		    		if (dist <= 5) {
		    			empty = false;
				    	var str = '';
				    	str += '<div class="card item">';
				    	str += '<h2><a href="/store/detail?sno='+store.sno+'">'+store.sname+'</a></h2>';
				    	str += '</div>';
				    	
					    $(".owl-carousel").append(str);
					}
		    		
		    		
		    		
				}
		    	
		    	
		    	  $('.owl-carousel').owlCarousel({
		    		    loop: false,
		    		    mousedrag : false,
		    		    touchdrag : false,
		    		    pulldrag : false,
		    		    margin: 50,
		    		    items : 1,
		    		    nav:false,
		    		    dots:false,
		    		    center:true,
		    		    responsive:{
		    		        0:{
		    		            items:1
		    		        },
		    		        600:{
		    		            items:2
		    		        },
		    		        1000:{
		    		            items:3
		    		        }
		    		    }
		    		});
		    		//이벤트 부여
		    		$('.owl-carousel').on('changed.owl.carousel', function(e) {
		    			console.log(e.item.index);
		    			console.log(e.item.count);
		    			if (e.item.index == 0) {
							$(".owl-prev").addClass("owl-lastItem");
						}else if (e.item.index == e.item.count - 1) {
							$(".owl-next").addClass("owl-lastItem");
						}else{
							$(".owl-next").removeClass("owl-lastItem");
							$(".owl-prev").removeClass("owl-lastItem");
						}
		    			
		    		});
		    		// Go to the next item
		    		$('.owl-next').click(function() {
		    		    $(".owl-carousel").trigger('next.owl.carousel');
		    		});
		    		// Go to the previous item
		    		$('.owl-prev').click(function() {
		    		    // With optional speed parameter
		    		    // Parameters has to be in square bracket '[]'
		    		     $(".owl-carousel").trigger('prev.owl.carousel', [300]);
		    		});  
		    	  	
		    		if ($(".owl-stage .card").length < 2) {
						$(".owl-next").addClass("owl-lastItem");
					}
		    		
		      },
		      error: function(xhr, state, error) {
				
			}
		});
	
		
	}
	
</script>
</head>
<!-- 달력 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
		
		
	var openHour = 109;
	var endHour = 118;
	var currentDate = new Date();
	var realDate = new Date();
	var nownowd = realDate.getDate(); 	
	 var openHourm = openHour-24;
	 //사용자가 시간표에서 선택한 시간
	 var selectedFirstTime = 24*1;
	 var doff = String(${store.dayOff});
	 var off = doff, substring0 = "0", substring1 = "1", substring2 = "2", 
	 substring3 = "3", substring4 = "4", substring5 = "5", substring6 = "6";
	 
	 
	function checkDayOff(){
	}
	
	function buildCalendar() { // 달력 만드는 함수
		var row = null; // 높이
		var cnt = 0; // 요일 카운트 일 1 월 2 화 3 수 4 목 5 금 6 토 7 cnt를 7로 나눌시 
		var cntt = 0;
		var cnttt = -1;
		var cntDate = 0;
	 	var myday = 0;
	 	var rememberId = nownowd;
		var nowYear = currentDate.getFullYear(); // 현 연도
		var nowMonth = currentDate.getMonth(); // 현 월
		var nowDate = currentDate.getDate(); // 현 일
		var nowHours = currentDate.getHours(); // 현 시간
		var calendarTable = document.getElementById("bookcalendar");
		var calendarCurrentDate = document.getElementById("maincalendar");
		var realcalendar = document.getElementById("realcalendar");
		calendarCurrentDate.innerHTML = nowYear + "년 " + (nowMonth + 1) + "월"; // 현재 달력 몇년도 몇월 정보 출력
		var firstDate = new Date(nowYear, nowMonth, 1); // 달력의 첫 날 ex) 2023 08 01 
		var lastDate = new Date(nowYear, nowMonth + 1, 0);// 달력의 마지막 날
					
		// 사용자가 선택한 셀의 월, 일
		var selectedMonth = null;
		var selectedDate = null;
		while (calendarTable.rows.length > 2) { // 달력 테이블의 전체 행(height) 길이가 2보다 클때 
			calendarTable.deleteRow(calendarTable.rows.length - 1);
			// 달력 테이블 전체 행 이가 2이하가 될때 까지 삭제 (요일표시 직전까지 초기화)
		}
		// 나머지 값에 따라 0이면 토 1이면 일 
		row = calendarTable.insertRow(); //셀 변수 지정 = 달력 테이블에 insertRow() 메소드

		for (i = 0; i < firstDate.getDay(); i++) { // 현 달의 첫 요일 인덱스값 이용 해당 달에 없는 일의 셀 공백처리
			cell = row.insertCell(); // cell 은 달력테이블에 insertRow 메소드? 현달력의 없는 일표시 칸은 공백처리
			cnt += 1; // cnt는 2
			cnttt += 1;
		}

		for (i = 1; i <= lastDate.getDate(); i++) {
			cell = row.insertCell(); // 셀을 date가 31이 마지막이면 30까지 반복 셀 입력?
			cnt += 1; // 31
			cntDate += 1; // 31
			cell.setAttribute('id', i); // 달력의 셀마다(일수) id 값 적용 1일 id = "1" 
			cell.innerHTML = i; // cell 입력란에 i 값 입력
			cell.align = "center"; // cell 입력이 되면 cell 가운데 정렬
			if (cnt % 7 == 1) { // 일요일 조건
				cell.innerHTML = "<font color=red>" + i + "</font>";
			}

			if (cnt % 7 == 0) { // 토요일 조건
				cell.innerHTML = "<font color=skyblue>" + i + "</font>";
				row = calendarTable.insertRow();
			}
			if (i <= nowDate-1 && nowMonth == realDate.getMonth()){	// 일수가 현 일수보다 전이고 표시된 월과 현재 월이 같을 경우 
				document.getElementById(i).style.color = "#585858";	// 표시되는 일수 회색 표시
				//document.getElementById(i).readOnly = true; // readonly 활성화
			}
			if (i == nowDate && nowMonth == realDate.getMonth()){
				document.getElementById(i).style.color = "#FFFFFF";
				document.getElementById(i).style.backgroundColor = "#00FF00";
			} 
			
			if(off.includes(substring0) == true){	// 일요일
				if(cnt % 7 == 1){					
					cell.innerHTML = "<font color=#585858>" + i + "</font>";
				}
			}
			if(off.includes(substring6) == true){	// 토요일
				if(cnt % 7 == 0){					
					cell.innerHTML = "<font color=#585858>" + i + "</font>";	
					}
			}
			if(off.includes(substring1) == true){	// 월요일
				if(cnt % 7 == 2){					
					cell.innerHTML = "<font color=#585858>" + i + "</font>";	
					}
			}
			if(off.includes(substring2) == true){	// 화요일
				if(cnt % 7 == 3){					
					cell.innerHTML = "<font color=#585858>" + i + "</font>";	
					}
			}
			if(off.includes(substring3) == true){	// 수요일
				if(cnt % 7 == 4){					
					cell.innerHTML = "<font color=#585858>" + i + "</font>";	
					}
			}
			if(off.includes(substring4) == true){	// 목요일
				if(cnt % 7 == 5){					
					cell.innerHTML = "<font color=#585858>" + i + "</font>";	
					}
			}
			if(off.includes(substring5) == true){	// 금요일
				if(cnt % 7 == 6){					
					cell.innerHTML = "<font color=#585858>" + i + "</font>";	
					}
			}
		//	if (nowMonth > realDate.getMonth()+1){					// 표시된 월이 현재 월보다 2이상 큰경우 (예약 가능날짜 이번달 기준 다음달까지 제한)
		//		document.getElementById(i).style.color = "#585858";
				//document.getElementById(i).readOnly = true; // readonly 활성화
		//	}
	
			cell.onclick = function(){
				// 셀 클릭시 월, 일 값 전역변수에 저장 
				
				cellTime = this.getAttribute('id');
				cellTime = cellTime*1;
				selectedMonth = currentDate.getMonth() + 1;
				selectedDate = this.getAttribute('id');
				//-------------------------------------------------------
				clickedYear = currentDate.getFullYear();//currentDate.getFullYear();
				clickedMonth = currentDate.getMonth() + 1;
				clickedDateId = this.getAttribute('id'); // this=cell에 있는 id 속성 변수에적용
				clickedDate = clickedDateId;
				clickedDateNum = parseInt(clickedDateId);
				clickedDateNumPlus = clickedDateNum + cnttt;
				clickedDayqs = parseInt(clickedDateId)+cnttt;
				clickedrealDate = parseInt(clickedDateId)-cnttt;
				clickedDate = clickedDate >= 10 ? clickedDate : '0'
						+ clickedDate;
				clickedMonth = clickedMonth >= 10 ? clickedMonth : '0'
						+ clickedMonth;
				clickedYMD = clickedYear + "/" + clickedMonth + "/"
						+ clickedDate;
				if(clickedDate != nowDate){	
				clearAll();
				}
				
				if(clickedDayqs < 7){ // 1째 주 getDay 값 무슨요일인지 판별 ex) getDay가 0이면 일요일 토요일은 6
					clickedDay = clickedDayqs;
				}
				else if(7 <= clickedDayqs && clickedDayqs < 14){ // 2번째 주 
					clickedDay = clickedDayqs - 7;
				}
				else if(14 <= clickedDayqs && clickedDayqs < 21){ // 3번째 주 
					clickedDay = clickedDayqs - 14;
				}
				else if(21 <= clickedDayqs && clickedDayqs < 28){ // 4번째 주 
					clickedDay = clickedDayqs - 21;
				}
				else if(28 <= clickedDayqs && clickedDayqs < 35){ // 5번째 주 
					clickedDay = clickedDayqs - 28;
				}
				document.getElementById("bdate").value = clickedYMD;
				if(nowDate <= clickedDateNum && nowMonth == realDate.getMonth() || nowMonth != realDate.getMonth()){
					cntt+=1;
				}
				
				document.getElementById("bday").value = clickedDay;
				if(cntt == 1){
					rememberId = clickedDateId;	
				}
				
				showTimeTable();
				if(nowDate > clickedDateNum && nowMonth == realDate.getMonth()){
					document.getElementById(rememberId).style.color = "black";
					document.getElementById(rememberId).style.backgroundColor = "#FFFFFF";
					alert("예약할 수 없는 날짜입니다.");
					hideTimeTable();
					clearAll();
				}
				if(clickedDateNum > nowDate && nowMonth == realDate.getMonth()){
					document.getElementById(nowDate).style.color = "black";
					document.getElementById(nowDate).style.backgroundColor = "#FFFFFF";
				}	
				if (nowDate < clickedDateNum && nowMonth == realDate.getMonth()){
					document.getElementById(clickedDateNum).style.color = "black";
					document.getElementById(clickedDateNum).style.backgroundColor = "#FFFFFF";
				}
				if(nowDate <= clickedDateNum && nowMonth == realDate.getMonth() || realDate.getMonth() + 1 == nowMonth){					
					document.getElementById(rememberId).style.color = "black";
					document.getElementById(rememberId).style.backgroundColor = "#FFFFFF";
					document.getElementById(clickedDateId).style.color = "#FFFFFF";
					document.getElementById(clickedDateId).style.backgroundColor = "#00FF00";
					rememberId = clickedDateId;
				}
				if(nowDate <= clickedDateNum || nowMonth == realDate.getMonth()){
				// dayoff에 해당 요일 해당할시 이벤트
				if(off.includes(substring0) == true){	// 일요일
					if(clickedDateNumPlus % 7 == 0){
						document.getElementById(rememberId).style.color = "black";
						document.getElementById(rememberId).style.backgroundColor = "#FFFFFF";
						alert("예약할 수 없는 날짜입니다.");
						hideTimeTable();
						clearAll();
					}
				}
				if(off.includes(substring6) == true){	// 토요일 
					if(clickedDateNumPlus % 7 == 6){
						document.getElementById(rememberId).style.color = "black";
						document.getElementById(rememberId).style.backgroundColor = "#FFFFFF";
						alert("예약할 수 없는 날짜입니다.");
						hideTimeTable();
						clearAll();
						}
				}
				if(off.includes(substring1) == true){	// 월요일
					if(clickedDateNumPlus % 7 == 1){	
						document.getElementById(rememberId).style.color = "black";
						document.getElementById(rememberId).style.backgroundColor = "#FFFFFF";
						alert("예약할 수 없는 날짜입니다.");
						hideTimeTable();
						clearAll();
						}
				}
				if(off.includes(substring2) == true){	// 화요일
					if(clickedDateNumPlus % 7 == 2){	
						document.getElementById(rememberId).style.color = "black";
						document.getElementById(rememberId).style.backgroundColor = "#FFFFFF";
						alert("예약할 수 없는 날짜입니다.");
						hideTimeTable();
						clearAll();
						}
				}
				if(off.includes(substring3) == true){	// 수요일
					if(clickedDateNumPlus % 7 == 3){		
						document.getElementById(rememberId).style.color = "black";
						document.getElementById(rememberId).style.backgroundColor = "#FFFFFF";
						alert("예약할 수 없는 날짜입니다.");
						hideTimeTable();
						clearAll();
						}
				}
				
				if(off.includes(substring4) == true){	// 목요일
					if(clickedDateNumPlus % 7 == 4){	
						document.getElementById(rememberId).style.color = "black";
						document.getElementById(rememberId).style.backgroundColor = "#FFFFFF";
						alert("예약할 수 없는 날짜입니다.");
						hideTimeTable();
						clearAll();
						}
				}
				if(off.includes(substring5) == true){	// 금요일
					if(cnt % 7 == 5){		
						document.getElementById(rememberId).style.color = "black";
						document.getElementById(rememberId).style.backgroundColor = "#FFFFFF";
						alert("예약할 수 없는 날짜입니다.");
						hideTimeTable();
						clearAll();
						}
				} 
				}
				document.getElementById("show1").value =  "${store.smaxreserv}"; // 현달력 값
				document.getElementById("show2").value = clickedDateNum;	
				
				if(nowDate-1 < clickedDateId || realDate.getMonth() + 1 == nowMonth || nowDate < clickedDateNum && nowMonth != realDate.getMonth()){			
					buildTimeTable();
				}			
			}
		}

		if (cnt % 7 != 0) { // 마지막주에 공백포함 마지막날까지 33 % 7
			for (i = 0; i < 7 - (cnt % 7); i++) {
				cell = row.insertCell();
			}
		}
	}
	function buildTimeTable(selectedMonth, selectedDate){
		row = null;
		month = selectedMonth;
		date = selectedDate;
		var timeTable = document.getElementById("timeTable");
		var alltime = 24*1;
		var	overHours = alltime - openHour;
		var cntime = 0;
		var rcellTime = 0;
		var cntcnt = 0;
		//var cnttime = overHours + endHour;
		
		while(timeTable.rows.length > 0){
			timeTable.deleteRow(timeTable.rows.length-1);
		}
		
		row = timeTable.insertRow();
		
		if(openHour < endHour){
			for (i = 0; i < endHour - openHour; i++){
				cntime += 1;
				cellTime = openHour*1 + i;
				cellTimeText = cellTime-100 + ":00";
				inputCellText = cellTimeText;
				
				cell = row.insertCell();
				cell.setAttribute('id', cellTime);
				cell.innerHTML = inputCellText;
				cell.bgColor="#CEE3F6";
				
				if(cntime % 5 == 0){
					row = timeTable.insertRow();
				}
				cell.onclick = function(){
					cntcnt+=1;
					cellTime = this.getAttribute('id');
					document.getElementById("btime").value = cellTime-100;
					cellTime = cellTime*1;
					if(cntcnt == 1){
						rcellTime = cellTime;
					}
					document.getElementById(rcellTime).style.color = "black";
					document.getElementById(rcellTime).style.backgroundColor = "#CEE3F6";
					document.getElementById(cellTime).style.color = "#FFFFFF";
					document.getElementById(cellTime).style.backgroundColor = "#81F781";
					rcellTime = cellTime;
				}
			}
		}
		
		if(openHour > endHour){
			for(i = 0; i < overHours + endHour; i++){
				cntime += 1;
				cellTime = openHourm*1 + i;
				cellTimeText = cellTime-100 + ":00";
				inputCellText = cellTimeText;
				
				cell = row.insertCell();
				cell.setAttribute('id', cellTime);
				cell.innerHTML = inputCellText;
				cell.bgColor="#CEE3F6";
				
				if(cntime % 5 == 0){
					row = timeTable.insertRow();
				}
				cell.onclick = function(){
					cntcnt+=1;
					//cellTime = cellTime*1;
					cellTime = this.getAttribute('id');
					document.getElementById("btime").value = cellTime;
					

					if(cntcnt == 1){
						rcellTime = cellTime;
					}
					document.getElementById(rcellTime).style.color = "black";
					document.getElementById(rcellTime).style.backgroundColor = "#CEE3F6";
					document.getElementById(cellTime).style.color = "#FFFFFF";
					document.getElementById(cellTime).style.backgroundColor = "#81F781";
					rcellTime = cellTime;
				}
			}
		}
		
		
						
	}
	
	function backCalendar() {
		currentDate = new Date(currentDate.getFullYear(), currentDate
				.getMonth() - 1, currentDate.getDate())
		if(realDate.getMonth() > currentDate.getMonth()){
			alert("지난 달은 예약이 불가능합니다")
			currentDate = new Date(currentDate.getFullYear(), currentDate
				.getMonth() + 1, currentDate.getDate())
			return;
		}
		buildCalendar();	// 달력 생성
		clearAll();			// 전달로 이동시 초기화
		checkedToday();		// 초기화와 동시에 오늘 날짜 선택
	}
	
	function nextCalendar() {
		currentDate = new Date(currentDate.getFullYear(), currentDate
				.getMonth() + 1, currentDate.getDate())
		rememberId = null;
		if(realDate.getMonth()+1 < currentDate.getMonth()){
			alert("예약은 오늘날부터 다음달까지 가능합니다.")
			currentDate = new Date(currentDate.getFullYear(), currentDate
				.getMonth() - 1, currentDate.getDate())
			return;	
		}
		buildCalendar();
		clearAll();
	}
	function check() {
		console.log("current : " + currentDate.getMonth() + ", " + realDate.getMonth());
	}
	function checkedToday(){
		var nowYear = currentDate.getFullYear();
		var crMonth = parseInt(currentDate.getMonth())+1;
		var nowDate = currentDate.getDate();
		var nowday = currentDate.getDay();
		if(currentDate.getMonth() == realDate.getMonth()){
				
				var ak12 = nowYear + "/" + crMonth + "/" + nowDate;
				
				
				document.getElementById("bdate").value = ak12;
				document.getElementById("bday").value = nowday;
				buildTimeTable();
			}
		
	}
	function clearAll(){		// 다음으로 넘어가거나 이전할때 테이블 데이터 남아있으므로 해당 함수 필요 
		document.getElementById("bdate").value = '';
		document.getElementById("bday").value = '';
		document.getElementById("bman").value = 'none';
		document.getElementById("bname").value = '';
		document.getElementById("bphone").value = '';
		document.getElementById("breq").value = '';
		document.getElementById("btime").value = '';
		buildTimeTable();
	}
	function hideTimeTable(){
		const row = document.getElementById('timeTable');
		row.style.display = 'none';
	}
	function showTimeTable(){
		const row = document.getElementById('timeTable');
		row.style.display = '';	
	}
</script>

<body>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="user" />
	</sec:authorize>

	<!-- 매장 정보 -->
	<div class="wrapper">
		<h2>detail</h2>
		<div id="storeDetail">
			<c:if test="${not empty store.imgList }">
				<link rel="stylesheet" href="/resources/css/slide.css">
				<!-- 이미지슬라이드 css  -->
				<script type="text/javascript" src="/resources/js/slide.js"></script>
				<!-- 이미지슬라이드 js  -->
				<div class="slide slide_wrap">
					<c:forEach var="img" items="${store.imgList }">
						<div class="slide_item item">
							<img alt="${img.sino }"
								src="/images/${img.uuid }_${img.fileName}"
								style="height: -webkit-fill-available">
						</div>
					</c:forEach>
					<div class="slide_prev_button slide_button">◀</div>
					<div class="slide_next_button slide_button">▶</div>
					<ul class="slide_pagination"></ul>
				</div>
			</c:if>
			<p>
				이름 : ${store.sname }<span id="distance"></span>
			</p>
			<p>주소 : ${store.saddress }</p>
			<p>휴무일 : ${dayOff }</p>
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
		<br>
		<hr>
		<div id="menuContainer" style="text-align: left;">
			<h4>메뉴</h4>
			<ul id="menuUL" type="disc">
				<c:forEach var="menu" items="${store.menuList }">
					<li>${menu.mname }--${menu.mprice }<c:if
							test="${menu.mprice eq null}">가격 정보 없음</c:if>
					</li>
				</c:forEach>
			</ul>

		</div>

		<div id="btnContainer" style="text-align: right; padding: 10px;">
			<button id="backBtn">뒤로</button>
			<button id="reportBtn" style="background-color: maroon;">신고</button>
			<button id="delBtn" style="background-color: maroon;"
				onclick="location.href='/store/delete?sno=${store.sno}&uno=${store.uno }'">삭제test</button>
			<sec:authorize access="isAuthenticated()">
				<button id="open-modal">리뷰 작성</button>
			</sec:authorize>
			<sec:authorize access="isAnonymous()">
				<button id="revBtn">리뷰 작성</button>
			</sec:authorize>
			<button id="open-modal2">예약</button>
			<div id="modal2">
				<div class="modal-content2">
					<table id="bookcalendar">
						<tr>
							<td align="center"><label onclick="backCalendar()">&lt;</label></td>
							<td colspan="5" align="center" id="maincalendar"></td>
							<td align="center"><label onclick="nextCalendar()">&gt;</label></td>
						</tr>
						<tr id="date">
							<td>일</td>
							<td>월</td>
							<td>화</td>
							<td>수</td>
							<td>목</td>
							<td>금</td>
							<td>토</td>
						</tr>
					</table>
					<table id="timeTable"></table>

					<input type='text' id="show1"> <input type="text"
						id="show2"><input type='hidden' id='hidesmax' value="${store.smaxreserv }">

					<p>예약 정보 입력</p>
					<!-- 예약 폼 -->
					<form action="/store/bookregister" method="post" role="form" id="bookForm">
						<select name="bman" id="bman" class="bman">
							<option value="none" selected disabled hidden>인원 선택</option>
						</select><br /> 예약자:<input type="text" id="bname" name="bname"><br />
						전화번호:<input type="text" id="bphone" name="bphone"><br />
						요청사항:
						<textarea id="breq" name="breq"></textarea>
						<br />
						<h6 align="center" id="realcalendar"></h6>
						<script type="text/javascript">
							buildCalendar();
						</script>

						<input type="text" id="sno" name="sno" value="${store.sno }"><br />
						<input type="text" id="uno" name="uno" value="${store.uno }"><br />
						<input type="text" id="bdate" name="bdate"><br /> 
						<input type="text" id="bday" name="bday"><br /> 
						<input type="text" id="btime" name="btime"><br /> 
						<input type="text" id="bdepo" name="bdepo" value="${store.sdepo }"><br />
						<input type="submit" value="예약 신청" data-oper="bookreg" id="cbtn">
						<input type="button" value="취소" id="cbtn" data-oper="cancle"><br />
					</form>
					<button id="close-modal2">닫기</button>
				</div>
			</div>
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
			<script type="text/javascript">
			function bmanget(){
				var smax = document.getElementById('hidesmax').value;
				var numsmax = parseInt(smax);
			
					
				for(var i = 1; i <= numsmax; i++){
					var option = $("<option value="+i+">"+i+"</option>");
					$(".bman").append(option);						
				}
			}
			function bmanclear(){
				
			}
			$(function(){
			var bookForm = $("#bookForm");
			
				$("input").on('click', function(e){
					e.preventDefault();		//  입력 이벤트 아닐시 이벤트 비활성화
				
					var operation = $(this).data("oper");
					
					if(operation === 'bookreg'){
						var maxreserv = "${store.smaxreserv}";
						if(document.getElementById("bman").value == 'none' && maxreserv != 0){
							alert("예약 인원을 선택해야합니다.");
							return;
						}
						else if(document.getElementById("bname").value == ''){
							alert("예약자 이름 입력");
							return;
						}
						else if(document.getElementById("bphone").value == ''){
							alert("휴대폰 번호 입력");
							return;
						}
						else if(document.getElementById("bdate").value == ''){
							alert("날짜 선택");
							return;
						}
						else if(document.getElementById("btime").value == ''){
							alert("시간 선택");
							return;
						}

						bookForm.attr("action", "/store/bookregister");	
						
							
						
						bookForm.submit();
					
				
						}
					});
				});
			
			</script>
			<script type="text/javascript"> 
	const modal2 = document.getElementById("modal2");
	const openModalBtn2 = document.getElementById("open-modal2");
	const closeModalBtn2 = document.getElementById("close-modal2");
	
	// 예약 모달 열기
	openModalBtn2.addEventListener("click", () => {
	  modal2.style.display = "block";
	  document.body.style.overflow = "hidden"; // 스크롤바 제거
	  checkedToday();
	  bmanget();
	});
	// 예약 모달 닫기
	closeModalBtn2.addEventListener("click", () => {
	  modal2.style.display = "none";
	  document.body.style.overflow = "auto"; // 스크롤바 보이기
	});
</script>
		</div>

		<br> <br>
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
		<br> <br>

		<!-- 비슷한 매장  -->
		<h3>recommend</h3>
		<div id="owlContainer">
			<div class="owl-carousel owl-theme owl-loaded"></div>
			<div class="owl-nav">
				<div class="owl-prev owl-lastItem">prev</div>
				<div class="owl-next">next</div>
			</div>
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
						<input type="hidden" name="uno" value="5"> <input
							type="hidden" name="rvlike" value="1">
						<!--<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="amount" value="10">-->
					</div>
					<input type="button" value="취소" id="close-modal" data-oper="reset"
						class="btn-reset"> <input type="button" value="등록"
						data-oper="bookreg" class="btn">
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
					<li><img alt="${img.sino }"
						src="/images/${img.uuid }_${img.fileName}"></li>
				</c:forEach>
			</ul>
		</div>
	</div>

	<!-- 지도 팝업  -->
	<div class="map-overlay">
		<div class="mapModal"></div>
	</div>

	<!-- 신고  -->
	<div class="reportOverlay">
		<div class="reportModal">
			<form action="#" method="post">
				<p>제목</p>
				<p>
					<input type="text" name="rptitle">
				</p>
				<p>사유</p>
				<p>
					<select name="state">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
					</select>
				</p>
				<p>내용</p>
				<textarea rows="12" cols="30" name="rpcontent" style="resize: none;"></textarea>
				<br> <br>
				<div style="text-align: right;">
					<input type="button" value="뒤로"> <input type="button"
						value="신고하기">
				</div>
			</form>
		</div>
	</div>


	<!-- 리뷰 모달 -->
	<script type="text/javascript"> /* review 모달 스크립트  */
		function myFunction(drawstar) {
			//const drawstar = document.querySelector('.star input');
			document.querySelector('.star span').style.width = drawstar * 20
					+ '%';
		}
		const modal = document.getElementById("modal");
		const closeModalBtn = document.getElementById("close-modal");
		
		
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