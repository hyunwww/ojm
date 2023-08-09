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
	
	    overflow: auto;
	
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
		background-color: lavenderblush;
		width: 100px;
		height: auto;
	}
	.rankingArea table{
		text-align: left;
		border: 1px solid palevioletred;
		border-collapse: collapse;
		margin: auto;
	}
	.rankingArea td{
		border: 1px solid palevioletred;
		border-collapse: collapse;
	}
	#loading {
	  display: inline-block;
	  width: 50px;
	  height: 50px;
	  border: 3px solid rgba(255,255,255,.3);
	  border-radius: 50%;
	  border-top-color: coral;
	  animation: spin 1s ease-in-out infinite;
	  -webkit-animation: spin 1s ease-in-out infinite;
	}
	@keyframes spin {
	  to { -webkit-transform: rotate(360deg); }
	}
	@-webkit-keyframes spin {
	  to { -webkit-transform: rotate(360deg); }
	}
	.mapContainer{
		display: none;
		width: 85%;
		height: 200px;
		margin-left: auto;
	}
</style>
  
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2f52d388244ff7c0c91379904a49a35&libraries=services"></script>
<script type="text/javascript"> /* 현재 위치정보 및 거리계산 스크립트 */
	var currPosition;	//현재 위치정보
	
	
	
		navigator.geolocation.getCurrentPosition(
				function(position) {
					currPosition = position;
				}, 
				function() {
					alert("geolocation error");
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
			dist = dist * 1.609344;
			
			//결과 단위 : km
			return dist.toFixed(1);
		}
	}
</script>
<script type="text/javascript">
	var storeResult = [];
	$(function() {
		
		
		
		//순위 차트 불러오기
		getRanking();
		
		//검색 버튼
		$("#searchBtn").on("click", function() {
			if ($("input[name='searchInput']").val() == '') {
				alert("검색어 입력 필요.");
				return;
			}
			$("#searchBox form").submit(); 
		});
		
		//메인으로
		$("#mainBtn").on("click", function() {
			location.href = '/';
		})
		
		//좌측 필터링 적용하여 검색하기
		$(".sideFilter input,.sideFilter select").change(function() {
			
			var selectedCate = $("input[name='scate']:checked");
			var selectedLocation = $(".sideFilter select").val();
			var distLimit = $(".sideFilter input[type='range']").val();
			//범위 표시
			$("#distLim").html("&nbsp;~ " + distLimit + "km");			
			
			
			var scate = [];
			// 카테고리 처리
			for (var i = 0; i < selectedCate.length; i++) {
				scate.push(selectedCate[i].value);
			}
			
			if (scate.length < 1) {
				scate.push("");
			}
			
			//ajax 처리가 끝날 때까지 로딩 표시
			$("#searchResult").html('<div id="loading"></div>');
			
			
			$.ajax({
			      type: "get",
			      url: "/store/search/filter",
			      data: {scate : scate,
			    	  	location : selectedLocation},
			      success: function (result, status, xhr) {
			    	  
			    	  
			    	  $("#searchResult").empty();
			    	  var str = "";
			    	  storeResult = [];
			    	  if (result.length > 0) {
				    	  for (var store of result) {
				    		  //거리 정보 부여
				    		  store.distance = getDistance(Number(store.kd), Number(store.wd), currPosition.coords.latitude, currPosition.coords.longitude)
				    		//출력될 태그 부여
				    		if (Number(store.distance) <= Number(distLimit) || Number(distLimit) == 0) {
				    		  store.str = '<hr><p>이름 : <a href="/store/detail?sno='+store.sno+'">'+store.sname+'</a></p>';
				    		  storeResult.push(store);
				    		  str += '<hr><p>이름 : <a href="/store/detail?sno='+store.sno+'">'+store.sname+'</a></p>';
							}
				    		
				    		  
				    		
						  }
				    	  $("#searchResult").append(str);
					}
			    	  if (storeResult.length < 1) {
			    		    str += '<p>일치하는 결과가 없습니다.</p>';
							$("#searchResult").append(str);
					}
			    	  
			    	  
			    	//지도 표시=========================================================================================================
			    	  	
			    		
			    		//map
			    		var bounds = new kakao.maps.LatLngBounds();
			    		var mapContainer = $(".mapContainer")[0];
			    		var options = { //지도를 생성할 때 필요한 기본 옵션
			    				center: new kakao.maps.LatLng(0, 0), //지도의 중심좌표.
			    				level: 4, //지도의 레벨(확대, 축소 정도)
			    			};

			    		var map = new kakao.maps.Map(mapContainer, options); //지도 생성 및 객체 리턴
			    		
			    		/* 
			    		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			    		var zoomControl = new kakao.maps.ZoomControl();
			    		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			    		 */
			    		
			    		for (var store of storeResult) {
			    			//이미지 마커 생성 및 지도범위 설정
			    			
			    			var outFunc = function() {	//marker 이벤트 부여를 위한 클로저함수
			    				// 마커 이미지의 주소
					    		var markerImageUrl = '/resources/img/icon/free-icon-restaurant-4552186.png', 
					    		    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
					    		    markerImageOptions = { 
					    		        offset : new kakao.maps.Point(13, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
					    		    };
					    		
					    		// 마커 이미지를 생성한다
					    		var markerImage = new kakao.maps.MarkerImage(markerImageUrl, markerImageSize, markerImageOptions);
					    		var coords = new kakao.maps.LatLng(store.kd, store.wd);
					    		var marker = new kakao.maps.Marker({
					    	        map: map,
					    	        position: coords,
					    	        image : markerImage
					    	    });
					    		//지도 범위 설정
					    		bounds.extend(coords);
					    		
					    		// 마커 이미지(이벤트 발생용)
					    	    var overImageUrl = '/resources/img/icon/free-icon-restaurant-highlight-4552186.png', 
					    		    overImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
					    		    overImageOptions = { 
					    	            offset : new kakao.maps.Point(13, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
					    	        };
					    	    var overImage = new kakao.maps.MarkerImage(overImageUrl, overImageSize, overImageOptions);
					    		
					    	 // 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
					    	    var content = '<div class="customoverlay">' +
					    	        '    <span class="title">'+store.sname+'</span>' +
					    	        '</div>';


					    	    // 커스텀 오버레이를 생성합니다
					    	    var customOverlay = new kakao.maps.CustomOverlay({
					    	        map: map,
					    	        position: coords,
					    	        content: content,
					    	        yAnchor: 1 
					    	    });
					    	    
					    	  	//지도 레벨 변동 감지
				    			// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
				    			kakao.maps.event.addListener(map, 'zoom_changed', function() {        
				    		    
					    		    // 지도의 현재 레벨을 얻어옵니다
					    		    var level = map.getLevel();
					    		    if (level <= 6) {
					    		    	customOverlay.setMap(map);
									}else{
					    		    	customOverlay.setMap(null);
									}
					    		    
				    			});
					    	    
					    	    
					    	    
					    	   	function addE() {	//마커에 이벤트 부여
						    		kakao.maps.event.addListener(marker, 'mouseout', function() {
						    		    marker.setImage(markerImage);
						    		    
						    		});
						    		kakao.maps.event.addListener(marker, 'mouseover', function() {
						    		    marker.setImage(overImage);
						    		    
						    		});
								}
			    				
			    				return addE();
			    				
							};
							
							outFunc();
						}
			    			
			    		 
			    		 if (storeResult.length > 0 && storeResult != null) {
								$(".mapContainer").show();
				    			map.relayout();
				    			map.setBounds(bounds);
						}else{
							$(".mapContainer").hide();
						}
			      }
			});
		});
		
			
		
		
		
		// 결과 정렬
		$("select[name='sort']").click(function() {
			switch ($(this).val()) {
			case 'review':
				storeResult.sort(function(a, b) {
					return b.revList.length - a.revList.length;
				})
				
				console.log(storeResult);
				var str = "";
				for (var store of storeResult) {
					str += store.str + "현재 리뷰 수 : " + store.revList.length;
				}
				$("#searchResult").empty();
				$("#searchResult").append(str);
				
				break;
			case 'star':
				storeResult.sort(function(a, b) {
					return b.sstar - a.sstar;
				})
				
				console.log(storeResult);
				var str = "";
				for (var store of storeResult) {
					str += store.str + "평균 평점 : " + store.sstar;
				}
				$("#searchResult").empty();
				$("#searchResult").append(str);
				
				
				break;
			case 'like':
				storeResult.sort(function(a, b) {
					return b.slike - a.slike;
				})
				console.log(storeResult);
				var str = "";
				for (var store of storeResult) {
					str += store.str + "현재 좋아요수 : " + store.slike;
				}
				$("#searchResult").empty();
				$("#searchResult").append(str);
				break;
			case 'distance':
				storeResult.sort(function(a, b) {
					return a.distance - b.distance;
				});
				console.log(storeResult);
				var str = "";
				for (var store of storeResult) {
					str += store.str + "거리 : " + store.distance + " km";
				}
				$("#searchResult").empty();
				$("#searchResult").append(str);
				
				break;
			case 'name' :
				storeResult.sort(function(a,b) {
					if (a.sname > b.sname) {
						return 1;
					}
					if (a.sname < b.sname) {
						return -1;
					}
					if (a.sname === b.sname) {
						return 0;
					}
				});
				console.log(storeResult);
				var str = "";
				for (var store of storeResult) {
					str += store.str;
				}
				$("#searchResult").empty();
				$("#searchResult").append(str);				
				break;
				
			default:
				break;
			}
		});
		
	});
	
	
	function getRanking() {
		
		$.ajax({
		      type: "get",
		      url: "/store/rank",
		      success: function (result, status, xhr) {
		    	  if (result != null && result.length > 0) {
		    		  $(".rankingArea table").empty();
			    	  var str = "";
			    	  for (var store of result) {
			    		  str += "<tr>";
			    		  str += "<td>";
			    		  str += store.sname;
			    		  str += "</td>";
			    		  str += "<td>";
			    		  str += store.slike;
			    		  str += "</td>";
			    		  str += "</tr>";
						}
			    	$(".rankingArea table").append(str);
				}
		      }
		});
	}

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
				    <select name="sort">
				    	<option value="name">이름</option>
				    	<option value="review">리뷰</option>
				    	<option value="star">별점</option>
				    	<option value="like">좋아요</option>
				    	<option value="distance">거리</option>
				    </select>
				</div>
				<h4 style="margin: 10px 0;">검색 결과</h4>
				<div class="mapContainer">
				</div>
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
					<h5>카테고리</h5>
					<input type="checkbox" name="scate" value="한식">한식
					<input type="checkbox" name="scate" value="일식">일식
					<input type="checkbox" name="scate" value="중식">중식
					<input type="checkbox" name="scate" value="양식">양식
					<input type="checkbox" name="scate" value="아시아">아시아
				</div>
				<br><hr>
				<div class="category two">
					<h5>거리</h5>
					<span id="distLim"></span>
					<input type="range" value="0" min="0" max="50" step="1"  style="width: -webkit-fill-available">
				</div>
				<br><hr>
				<div id="category four">
					<h5>지역</h5>
					<select name="location">
						<option value="">지역 선택</option>
						<option value="서울">서울</option>
						<option value="경기도">경기도</option>
						<option value="충청북도">충청북도</option>
						<option value="충청남도">충청남도</option>
						<option value="제주도">제주도</option>
						<option value="전라북도">전라북도</option>
						<option value="전라남도">전라남도</option>
						<option value="경상남도">경상남도</option>
						<option value="경상북도">경상북도</option>
						<option value="강원도">강원도</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	
	<div class="rankingArea">
		<!-- 좋아요 순 랭킹 나열할 예정  -->
		<p style="text-align: center; margin: 10px 0;">rank</p>
		<table>
		</table>
	</div>
	
</body>
</html>