<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../testHeader.jsp" %>
<style type="text/css">
#file-box {
	font-weight: bold;
	color: #00FFFF;
}

#review-content1 {
	font-size: 16px;
	font-weight: normal;
	color: black;
	height: 55px;
	border: none;
}

#review-title1 {
	font-size: 12px;
	color: gray;
}

#file {
	position: fixed;
	display: none;
}

#modal1 {
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

.modal-content1 {
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

.star {
	position: relative;
	font-size: 2rem;
	text-shadow: -1px 0px #1C1C1C, 0px 1px #1C1C1C, 1px 0px #1C1C1C, 0px
		-1px #1C1C1C;
	color: #ffffff;
}

.star input {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	opacity: 0;
	cursor: pointer;
}

.star span {
	width: 0;
	position: absolute;
	left: 0;
	color: yellow;
	overflow: hidden;
	pointer-events: none;
}

textarea {
	resize: none;
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
#cbtn {
	background-color: aqua;
	color: white;
}
</style>
<!-- <link rel="stylesheet" href="/resources/css/reviewModal.css"> -->
<script type="text/javascript">
	$("#open-modal1").click(function() {
		$("#modal1").show();
	});
//슬라이더 생성
$(function() {
	$('.owl-carousel').owlCarousel({
	    loop: false,
	    mouseDrag : false,
	    freeDrag : false,
	    margin: 10,
	    items : 1,
	    nav:false,
	    dots:false,
	    center:true
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
	
	//넘기기 버튼 비활성화
	$('.owl-carousel').on('changed.owl.carousel', function(e) {
		if (e.item.index == 0) {
			$(".owl-prev").addClass("owl-lastItem");
		}else{
			$(".owl-prev").removeClass("owl-lastItem");
		}
		if (e.item.index == e.item.count - 1) {
			$(".owl-next").addClass("owl-lastItem");
		}else{
			$(".owl-next").removeClass("owl-lastItem");
		}
		
	});
	if ($(".owl-stage .cons").length < 1) {
		$(".owl-next").addClass("owl-lastItem");
	}
});
	
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2f52d388244ff7c0c91379904a49a35&libraries=services"></script>
<script type="text/javascript"> <!-- 지도 관련 스크립트 -->
	
	//필요 유저 정보 ?
	var nowLike = '${isLike}';
	var sno = '${store.sno}';
	var slike = '${store.slike}';

	var popMap;	//지도 객체
	var kd = '${store.kd}';
	var wd = '${store.wd}';
	var bounds = new kakao.maps.LatLngBounds(); //지도 범위
	$(function() {
		
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
			var conf = confirm("로그인이 필요한 서비스입니다. 로그인하시겠습니까?");
			if (conf) {
				location.href = '/user/login';
			}
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
			    		  slike++;
			    		  $(".likeBtn").html('<i class="bi bi-hand-thumbs-up-fill"></i>'+" "+slike);
			    		  nowLike = true;
			    	  }else{//해제
			    		  slike--;
			    		  $(".likeBtn").html('<i class="bi bi-hand-thumbs-up"></i>'+" "+slike);
			    		  nowLike = false;
			    	  }
			    	  
			      },
			      error: function(xhr, status, error) {
			    	  var conf = confirm("로그인이 필요한 서비스입니다. 로그인하시겠습니까?");
						if (conf) {
							location.href = '/user/login';
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
	navigator.geolocation.getCurrentPosition(
			function(position) {
				console.log(position);
				currentPosition = {
						"latitude" : position.coords.latitude,
						"longitude" : position.coords.longitude
				};
			}, 
			function() {
				//임시 좌표 
				var geocoder = new kakao.maps.services.Geocoder();
				var x;
				var y;
				
				geocoder.addressSearch('서울특별시 구로구 서울시 구로구 시흥대로 163길 33', function(result, status) {
					if (status === kakao.maps.services.Status.OK) {
							x = result[0].road_address.x;
							y = result[0].road_address.y;
						
					}
					
					currentPosition = {
							"latitude" : y,
							"longitude" : x
					}
					
				});
				
			});
	
	$(function() {
		
		
		console.log(currentPosition);
		
		// 마커 이미지 생성
		var targetImageUrl = '/resources/img/icon/free-icon-location-pointer-2098567.png', 
		    targetImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
		    targetImageOptions = { 
		        offset : new kakao.maps.Point(13, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
		    };
		
		var targetMarkerImage = new kakao.maps.MarkerImage(targetImageUrl, targetImageSize, targetImageOptions);
		var currentLocMarker = new kakao.maps.Marker({
	         map: popMap,
	         position: new kakao.maps.LatLng(currentPosition.latitude, currentPosition.longitude),
	         image : targetMarkerImage
	     });
		
		bounds.extend(currentLocMarker.getPosition());
		distance = getDistance(kd,wd,currentPosition.latitude,currentPosition.longitude);
		
		console.log("현재 위치로부터의 거리 : " + distance + " km");
		$("#distance").html(distance+" km");
		
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
<script type="text/javascript">
	function recommendByDistance() {
		var scate = ['${store.scate}'];
		var saddr = '${store.saddress}';
		var sdel = [];
		var sres = [];
		if ('${store.sdeli}' == 0) {
			sdel.push("");
		}else{
			sdel.push("1");
		}
		if ('${store.smaxreserv}' == 0) {
			sres.push("");
		}else{
			sres.push("1");
		}
		
		//지역과 카테고리 기준으로 불러오기
		$.ajax({
		      type: "get",
		      url: "/store/search/filter",
		      data: {scate : scate,
		    	  	location : saddr.split(" ")[0],
		    	  	delivery : sdel,
		    	  	reservation : sres},
		      success: function (result, status, xhr) {
		    		console.log(result);
					for (var store of result) {
			    		if (sno == store.sno) { //현재 매장 제외
							continue;
						}
			    		//내 위치로부터 거리 *distance 는 현재 매장에 대한 정보 , 단위 : km
			    		var dist = getDistance(kd, wd, store.kd, store.wd);
			    		var empty = true;
			    		if (dist <= 5) {	//5km 범위
			    			empty = false;
					    	var str = '';
					    	
					    	str += '<div class="post-item clearfix">';
					    	str += '<img src="/resources/img/ja.jpg" alt="image">';
					    	str += '<h4><a href="/store/detail?sno='+store.sno+'">'+store.sname+'</a></h4>';
					    	str += '<time datetime="2020-01-01">detail</time>';
					    	str += '</div>';
					    	
					    	$(".recent-posts").eq(0).append(str);
						}
			    		
					}
		    	  	
					if ($(".recent-posts").eq(0).find(".post-item").length < 1) { //매칭 결과 없을 경우
					    $(".recent-posts").eq(0).append("메세지");
					}
		    	
		    		
		      },
		      error: function(xhr, state, error) {
				
			}
		});
	}
</script>
<!-- 달력 스크립트 -->
<script type="text/javascript">
		
	var getTime = "${store.openHour}";
	var times = getTime.split('~');
	
	var openHour = parseInt(times[0])+100;
	var endHour = parseInt(times[1])+100;
	
	var currentDate = new Date();
	var realDate = new Date();
	var nownowd = realDate.getDate(); 	
	var openHourm = openHour-24;
	//사용자가 시간표에서 선택한 시간
	var selectedFirstTime = 24*1;
	var doff = String('${store.dayOff}');
	var nowHour = currentDate.getHours(); // 현 시간
	var off = doff, substring0 = "0", substring1 = "1", substring2 = "2", 
	substring3 = "3", substring4 = "4", substring5 = "5", substring6 = "6";
	
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
			cell.style.color = "black";
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
				
				document.getElementById("bdate").value = clickedYMD;
				
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
				
				document.getElementById("bday").value = clickedDay;
				
				if(nowDate <= clickedDateNum && nowMonth == realDate.getMonth() || nowMonth != realDate.getMonth()){
					cntt+=1;
				}
				
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
				
				if(nowDate <= clickedDateNum && nowMonth == realDate.getMonth() || nowMonth != realDate.getMonth()){
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
		var compareTime = nowHour+100;
					// 테스트용 코드
					document.getElementById("show1").value = openHour; // 현달력 값
					document.getElementById("show2").value = compareTime;
		var cntime = 0;
		var rcellTime = 0;
		var cntcnt = 0;
		//var cnttime = overHours + endHour;
		
		while(timeTable.rows.length > 0){
			timeTable.deleteRow(timeTable.rows.length-1);
		}
		
		row = timeTable.insertRow();
		// 당일 시작후 당일날 끝날때 Time View
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
					cell.style.color= "black";
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
		
		// 전날 시작해서 다음날로 끝날때 Time View
		if(openHour > endHour){
			for(i = 0; i < overHours + endHour; i++){
				cntime += 1;
				cellTime = openHour*1 + i;
					if(cellTime < 124){					
						cellTimeText = cellTime-100 + ":00";
						inputCellText = cellTimeText;
					}else{
						cellTimeText = cellTime-124 + ":00";
						inputCellText = cellTimeText;
					}
					
				cell = row.insertCell();
				cell.setAttribute('id', cellTime);
				cell.innerHTML = inputCellText;
				cell.bgColor="#CEE3F6";
				cell.style.color= "black";
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
<main id="main">
	
    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs" style="margin-top: 70px;">
      <div class="container">

        <div class="d-flex justify-content-between align-items-center">
          <h4 style="color: white;">매장 정보</h4>
        </div>

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Single Section ======= -->
    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up">

        <div class="row">

          <div class="col-lg-8 entries">

            <article class="entry entry-single">
              <div class="row">
              	<div class="col-lg-9">
              	  <h2 class="entry-title">
	              	${store.sname }
	              </h2>
	
	              <div class="entry-meta"><!-- 우측 정렬 후 거리정보 제공  -->
	                <ul>
	                  <li class="d-flex align-items-center"><i class="bi bi-pin-map-fill"></i>${store.saddress }</li>
	                  <li class="d-flex align-items-center"><i class="bi bi-cursor-fill"></i><span id="distance">거리정보</span></li>
	                </ul>
	                <ul>
	                  <li class="d-flex align-items-center"><i class="bi bi-telephone-fill"></i>${store.sphone }</li>
	                </ul>
	              </div>
              	</div>
              	<div class="col-lg-3" style="border: 1px solid black; height: 150px;" id="mapContainer">
              	</div>
              </div>
              

              <div class="entry-content">
              	<div class="imgArea" style="width: 50%; height: 200px; overflow: hidden;"><!-- owl carousel 및 lightbox적용하여 이미지 영역 구축  -->
              		<div class="owl-carousel owl-theme owl-loaded" style="text-align: -webkit-center">
              			<c:forEach var="img" items="${store.imgList }">
              				<div class="item cons">
						          <a data-fslightbox href="/images/${img.uuid }_${img.fileName}">
						         	<img alt="image" src="/images/${img.uuid }_${img.fileName}" style="object-fit : scale-down; height: 100%">
								  </a>
					        </div>
              			</c:forEach>
				         <div class="item cons">
					          <a data-fslightbox href="/resources/img/ja.jpg">
					         	<img alt="image" src="/resources/img/ja.jpg">
							  </a>
				         </div>
				         <div class="item cons">
					          <a data-fslightbox href="/resources/img/carousel-1.jpg">
					         	<img alt="image" src="/resources/img/carousel-1.jpg">
							  </a>
				         </div>
				      </div>
				      <div class="owl-nav d-flex justify-content-between" style="text-align: center; z-index: 5; position: relative;">
				         <div class="owl-prev owl-lastItem">&lt;</div>
				         <div class="owl-next">&gt;</div>
				      </div>
              		
              	</div><br>
				<div id="utilBox" style="text-align: left;">
					<c:choose>
						<c:when test="${isLike }">
							<span class="likeBtn"><i class="bi bi-hand-thumbs-up-fill"></i> ${store.slike }</span>
						</c:when>
						<c:otherwise>
							<span class="likeBtn"><i class="bi bi-hand-thumbs-up"></i> ${store.slike }</span>
						</c:otherwise>
					</c:choose>
					<p><i class="bi bi-star-fill"></i> ${store.sstar }</p>
				</div>

              </div>

              <div class="entry-footer"><!-- tag 사용  -->
                <i class="bi bi-folder"></i>
                <ul class="cats">
                  <li><a href="#">${store.scate }</a></li>
                </ul>

                <i class="bi bi-tags"></i>
                <ul class="tags">
                  <c:if test="${store.sdeli eq 1 }">
                  	<li><a href="#">배달 가능</a></li>
                  </c:if>	
                  <c:if test="${store.smaxreserv gt 0 }">
                  	<li><a href="#">예약 가능</a></li>
                  </c:if>	
                  <li><a href="#">smallTag 1</a></li>
                  <li><a href="#">smallTag 2</a></li>
                  <li><a href="#">smallTag 3</a></li>
                </ul>
                <div class="border-bottom py-3"></div>
                <div id="btnContainer" style="text-align: right; padding: 10px;">
					<button id="reportBtn" data-bs-toggle="modal" data-bs-target="#reportModal">신고</button>
					<sec:authorize access="isAuthenticated()">
						<button id="open-modal" data-bs-toggle="modal" data-bs-target="#revModal">리뷰 작성</button>
					</sec:authorize>
					<button id="open-modal1">리뷰 작성</button>
					<sec:authorize access="isAnonymous()">
					</sec:authorize>
					<button id="open-modal2">예약</button>
					<button data-bs-toggle="modal" data-bs-target="#replyModal">test</button>
				</div>
              </div>

            </article><!-- End blog entry -->

            <article class="entry entry-single">
            	<div class="entry-content"><!-- 영업시간  -->
            		<h3 style="margin-top: 0px;">영업시간</h3>
            		<p>${store.openHour }</p>
            		<p>휴무 : ${store.dayOff }</p>
            	</div><br>
            	<div class="entry-footer"><!-- 메뉴 정보  -->
            		<br>
            		<h4>메뉴</h4>
            		<div class="menuBox">
            			<c:forEach var="menu" items="${store.menuList }">
            				<p>${menu.mname } =============== ${menu.mprice }</p>
            			</c:forEach>
            		</div>
            	</div>
            </article>

            <div class="blog-comments">

              <h4 class="comments-count">reviews</h4><br>
              <c:forEach var="review" items="${store.revList }">
              	<div class="blog-author d-flex align-items-center">
	              <img src="assets/img/blog/blog-author.jpg" class="rounded-circle float-left" alt="images"><!-- 프로필사진  -->
	              <div>
	                <h4>유저 아이디</h4>
	                <div class="social-links">
	                  <a href="https://twitters.com/#"><i class="bi bi-twitter"></i></a>
	                  <a href="https://facebook.com/#"><i class="bi bi-facebook"></i></a>
	                  <a href="https://instagram.com/#"><i class="biu bi-instagram"></i></a>
	                  <a href="https://instagram.com/#"><i class="bi bi-star-fill"></i>${review.rvstar }</a>
	                </div>
	                <p>${review.rvcontent }</p>
	              </div>
	            </div><!-- End blog author bio -->
              </c:forEach>
			  
	            
			  <div class="blog-author d-flex align-items-center">
	              <img src="assets/img/blog/blog-author.jpg" class="rounded-circle float-left" alt="">
	              <div>
	                <h4>Jane Smith</h4>
	                <div class="social-links">
	                  <a href="https://twitters.com/#"><i class="bi bi-twitter"></i></a>
	                  <a href="https://facebook.com/#"><i class="bi bi-facebook"></i></a>
	                  <a href="https://instagram.com/#"><i class="biu bi-instagram"></i></a>
	                </div>
	                <p>
	                  Itaque quidem optio quia voluptatibus dolorem dolor. Modi eum sed possimus accusantium. Quas repellat voluptatem officia numquam sint aspernatur voluptas. Esse et accusantium ut unde voluptas.
	                </p>
	              </div>
	            </div><!-- End blog author bio -->
	            
			  <div class="blog-author d-flex align-items-center">
	              <img src="assets/img/blog/blog-author.jpg" class="rounded-circle float-left" alt="">
	              <div>
	                <h4>Jane Smith</h4>
	                <div class="social-links">
	                  <a href="https://twitters.com/#"><i class="bi bi-twitter"></i></a>
	                  <a href="https://facebook.com/#"><i class="bi bi-facebook"></i></a>
	                  <a href="https://instagram.com/#"><i class="biu bi-instagram"></i></a>
	                </div>
	                <p>
	                  Itaque quidem optio quia voluptatibus dolorem dolor. Modi eum sed possimus accusantium. Quas repellat voluptatem officia numquam sint aspernatur voluptas. Esse et accusantium ut unde voluptas.
	                </p>
	              </div>
	            </div><!-- End blog author bio -->
			  
			  

				
              <div class="reply-form modal modal-sheet modal-lg" id="replyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"><!-- 숨겼다가 모달로 사용  -->
                <div class="modal-dialog modal-dialog-centered">
                	<div class="modal-content p-3">
                		<div>
	                		<h4 style="float: left;">리뷰 작성</h4>
	                		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="float: right;"></button>
                		</div><br>
		                <form action="#" method="post">
		                  <div class="row">
		                    <div class="col form-group">
		                      <input name="writer" type="text" class="form-control" placeholder="작성자">
		                    </div>
		                  </div>
		                  <div class="row">
		                    <div class="col form-group">
		                      <textarea name="comment" class="form-control" placeholder="내용을 입력해주세요" style="resize: none;"></textarea>
		                    </div>
		                  </div>
		                  <div style="text-align: right;">
			                  <button type="submit" class="btn btn-primary">작성하기</button>
		                  </div>
		                </form>
                	</div>
                </div>
                

              </div>

            </div><!-- End blog comments -->

          </div><!-- End blog entries list -->

          <div class="col-lg-4">

            <div class="sidebar">

              <h3 class="sidebar-title">비슷한 매장 추천</h3>
              <div class="sidebar-item recent-posts">
                <div class="post-item clearfix">
                  <img src="/resources/img/ja.jpg" alt="">
                  <h4><a href="blog-single.html">title</a></h4>
                  <time datetime="2020-01-01">desc</time>
                </div>

              </div><!-- End sidebar recent posts-->

              <h3 class="sidebar-title">관련 검색어</h3>
              <div class="sidebar-item tags">
                <ul>
                  <li><a href="/store/search?searchInput=1">1</a></li>
                  <li><a href="#">IT</a></li>
                  <li><a href="#">Business</a></li>
                  <li><a href="#">Mac</a></li>
                  <li><a href="#">Design</a></li>
                  <li><a href="#">Office</a></li>
                  <li><a href="#">Creative</a></li>
                  <li><a href="#">Studio</a></li>
                  <li><a href="#">Smart</a></li>
                  <li><a href="#">Tips</a></li>
                  <li><a href="#">Marketing</a></li>
                </ul>
              </div><!-- End sidebar tags-->

            </div><!-- End sidebar -->
			
			<div class="sidebar">
				<h3 class="sidebar-title">222</h3>
				<div class="sidebar-item recent-posts">
					<div class="post-item clearfix">
						<h5>111</h5>
					</div>
					<div class="post-item clearfix">
						<h5>2</h5>
					</div>
					<div class="post-item clearfix">
						<h5>3</h5>
					</div>

				</div>
			</div>
          </div><!-- End blog sidebar -->

        </div>

      </div>
    </section><!-- End Blog Single Section -->

  </main><!-- End #main -->
  <!-- 모달 test  -->
  <!-- reviewModal -->
<div class="modal fade" id="revModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">리뷰 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       	<p>ㅇㅇ</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">작성하기</button>
      </div>
    </div>
  </div>
</div>
  <!-- reportModal -->
<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">신고</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      		<form action="#" method="post">
				<p>제목</p>
				<p><input type="text" name="rptitle"></p>
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
			</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">작성하기</button>
      </div>
    </div>
  </div>
</div>
<!-- 리뷰 모달  -->
	<div id="modal1">
		<div class="modal-content1">
			<form action="/store/addrv" method="post" role="form" id="revForm">
				<div id="review-title1">
					<span>평점</span><br />
					<div class="form-group1">
						<span class="star"> ★★★★★ <span id="rvstar">★★★★★</span> <input
							type="range" name="rvstar" oninput="myFunction(this.value)"
							value="0" step="0.5" min="0" max="5">
						</span>
					</div>
					<span>내용</span>
					<div class="form-group1">
						<textarea id="review-content1" name="rvcontent" maxlength="200" placeholder="내용을 입력해주세요."></textarea>
						<input type="text" id="sno" name="sno" value="${store.sno }"><br />
						<input type="text" id="uno" name="uno" value="${store.uno }"><br />
						 <input type="hidden" name="rvlike" value="1">
					</div>
					<input type="button" value="취소" id="close-modal1" data-oper="reset" class="btn"> 
					<input type="submit" value="등록" class="btn" data-oper="revreg">
				</div>
			</form>
		</div>
	</div>
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
				<!-- 테스트용 뷰 -->
				<input type='hidden' id="show1"> <input type="hidden" id="show2">
				<!-- 가게 예약 최대 인원 -->
				<input type='hidden' id='hidesmax' value="${store.smaxreserv }">

				<p>예약 정보 입력</p>
				<!-- 예약 폼 -->
				<form action="/store/bookregister" method="post" role="form" id="bookForm">
					<select name="bman" id="bman" class="bman">
						<option id="bman1" value="none" selected disabled hidden>인원 선택</option>
					</select><br /> 
					예약자:<input type="text" id="bname" name="bname"><br />
					전화번호:<input type="text" id="bphone" name="bphone"><br />
					요청사항:<textarea id="breq" name="breq"></textarea><br />
					<h6 align="center" id="realcalendar"></h6>
					<script type="text/javascript">
						buildCalendar();
					</script>

					<input type="hidden" id="sno" name="sno" value="${store.sno }"><br />
					<input type="hidden" id="uno" name="uno" value="${store.uno }"><br />
					<input type="hidden" id="bdate" name="bdate"><br /> 
					<input type="hidden" id="bday" name="bday"><br /> 
					<input type="hidden" id="btime" name="btime"><br /> 
					<input type="hidden" id="bdepo" name="bdepo" value="${store.sdepo }"><br />
					<input type="submit" value="예약 신청" data-oper="bookreg" id="cbtn">
					<input type="button" value="취소" id="cbtn" data-oper="cancle"><br />
				</form>
			<button id="close-modal2">닫기</button>
		</div>
	</div>
	
  	<!-- 지도 팝업  -->
	<div class="map-overlay">
		<div class="mapModal"></div>
	</div>
	<!-- 리뷰 모달 -->
<script type="text/javascript"> /* review 모달 스크립트  */
	function myFunction(drawstar) {
		//const drawstar = document.querySelector('.star input');
		document.querySelector('.star span').style.width = drawstar * 20
				+ '%';
	}
	const modal1 = document.getElementById("modal1");
	const openModalBtn = document.getElementById("open-modal1");
	const closeModalBtn = document.getElementById("close-modal1");
	
	// 모달창 열기
	openModalBtn.addEventListener("click", () => {
		modal1.style.display = "block";
		document.body.style.overflow = "hidden"; // 스크롤바 제거
	});
	
	// 모달창 닫기
	closeModalBtn.addEventListener("click", () => {
		modal1.style.display = "none";
		document.getElementById("review-content1").value = "";
		document.querySelector('.star span').style.width = 0+'%';
		document.body.style.overflow = "auto"; // 스크롤바 보이기
	});
</script>
	<!-- 리뷰 모달 -->
<script type="text/javascript"> /* review 모달 스크립트  */
	function myFunction(drawstar) {
		//const drawstar = document.querySelector('.star input');
		document.querySelector('.star span').style.width = drawstar * 20
				+ '%';
	}
	const modal1 = document.getElementById("modal1");
	const openModalBtn = document.getElementById("open-modal1");
	const closeModalBtn = document.getElementById("close-modal1");
	
	// 모달창 열기
	openModalBtn.addEventListener("click", () => {
		modal1.style.display = "block";
		document.body.style.overflow = "hidden"; // 스크롤바 제거
	});
	
	// 모달창 닫기
	closeModalBtn.addEventListener("click", () => {
		modal1.style.display = "none";
		document.getElementById("review-content1").value = "";
		document.querySelector('.star span').style.width = 0+'%';
		document.body.style.overflow = "auto"; // 스크롤바 보이기
	});
</script>
<script type="text/javascript">
//	$(function()){
//		var revForm = $("#revForm");
//		$("input").on('click', function(e){
//			e.preventDefault();		// 입력 이벤트 아닐시 이벤트 비활성화
		
//			var operation = $(this).data("oper");
///			
//			if(operation = $(this).data("oper"));
//			
//			if(operation === 'revreg'){
//				if(document.getElementById(""))
//			}
//		}
//	}
	function bmanget(){
		var smax = document.getElementById('hidesmax').value;
		var numsmax = parseInt(smax);
			
					
		for(var i = 1; i <= numsmax; i++){
			var option = $("<option value="+i+">"+i+"</option>");
			$(".bman").append(option);						
		}
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
		var manman = document.getElementById("hidesmax").value;
		if(manman == "0"){	  
			document.getElementById("bman").style.display = "none";
		}
		checkedToday();
		bmanget();
	});
	// 예약 모달 닫기
	closeModalBtn2.addEventListener("click", () => {
		modal2.style.display = "none";
		document.body.style.overflow = "auto"; // 스크롤바 보이기
	});
	<!-- book -->
</script>
<script type="text/javascript">
//	$(function()){
//		var revForm = $("#revForm");
//		$("input").on('click', function(e){
//			e.preventDefault();		// 입력 이벤트 아닐시 이벤트 비활성화
		
//			var operation = $(this).data("oper");
///			
//			if(operation = $(this).data("oper"));
//			
//			if(operation === 'revreg'){
//				if(document.getElementById(""))
//			}
//		}
//	}
	function bmanget(){
		var smax = document.getElementById('hidesmax').value;
		var numsmax = parseInt(smax);
			
					
		for(var i = 1; i <= numsmax; i++){
			var option = $("<option value="+i+">"+i+"</option>");
			$(".bman").append(option);						
		}
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
		var manman = document.getElementById("hidesmax").value;
		if(manman == "0"){	  
			document.getElementById("bman").style.display = "none";
		}
		checkedToday();
		bmanget();
	});
	// 예약 모달 닫기
	closeModalBtn2.addEventListener("click", () => {
		modal2.style.display = "none";
		document.body.style.overflow = "auto"; // 스크롤바 보이기
	});
	<!-- book -->
</script>
<script type="text/javascript">
	recommendByDistance();
</script>
<script src="/resources/js/fslightbox.js"></script>
<%@ include file="../testFooter.jsp" %>