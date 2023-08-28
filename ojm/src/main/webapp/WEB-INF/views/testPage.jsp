<!DOCTYPE html><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="testHeader.jsp" %>


<!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs" style="margin-top: 70px;">
    	<c:choose>
    		<c:when test="${not empty filterData }">
	    		<script type="text/javascript">
	    			$(function() {
	    				//새로고침 판단
	    		    	var refreshCheck = performance.getEntriesByType("navigation")[0];
	    		    	if (refreshCheck.type === 'reload') {
	    		    		getStoreListByRownum();
	    		    	}else{
	    					loadFromSession(); 
	    		    	}
					})
	    		</script>
    		</c:when>
    		<c:otherwise>
	    		<script type="text/javascript">
	    			$(function() {
	    				getStoreListByRownum();
					})
	    		</script>
    		</c:otherwise>
    	</c:choose>
      <div class="container">
        <div class="d-flex justify-content-between align-items-center">
          <h2>매장 찾기</h2>
          <ol>
            <li><a href="index.html">Home</a></li>
            <li><a href="blog.html">Blog</a></li>
            <li>Blog Single</li>
          </ol>
        </div>

      </div>
    </section><!-- End Breadcrumbs -->

<section id="structure" class="blog">
	<div class="container-xl">
		<div class="row">
			<div class="col-lg-3 d-flex flex-column flex-shrink-0 p-3">
				<div class="sidebar sideFilter blog">
					<h3 class="sidebar-title">title</h3>
					<div class="sidebar-item search-form">
						<form action="#">
							<input type="text" name="keyword">
							<button type="submit">
								<i class="bi bi-search"></i>
							</button>
						</form>
					</div>
					<h3 class="sidebar-title">location</h3>
					<div class="sidebar-item text-dark">
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
					<div class="border-top py-3"></div>
					<h3 class="sidebar-title">categories</h3>
					<div class="sidebar-item text-dark">
						<input type="checkbox" name="scate" value="한식">한식
						<input type="checkbox" name="scate" value="일식">일식
						<input type="checkbox" name="scate" value="중식">중식
						<br><br>
						<input type="checkbox" name="scate" value="양식">양식
						<input type="checkbox" name="scate" value="아시아">아시아
					</div>
					<div class="border-top py-3"></div>
					<h3 class="sidebar-title">dist</h3>
					<div class="sidebar-item text-dark">
						<span id="distLim"></span>
						<input type="range" value="0" min="0" max="50" step="1"  style="width: -webkit-fill-available">
					</div>
					<div class="border-top py-3"></div>
					<h3 class="sidebar-title">etc</h3>
					<div class="sidebar-item">
						<span>예약 가능</span>&nbsp;<input type="checkbox" name="smaxreserv" value="1">
						<br>
						<span>배달 가능</span>&nbsp;<input type="checkbox" name="sdeli" value="1">
						<br>
					</div>
					
				</div>
			</div>
			<div class="col-lg-8 p-3 min-vh-100">
				<div class="mapBox" style="position: sticky; background-color: white;">
					<div class="mapContainer"></div>
					<div style="text-align: right; padding: 10px;">
						<select class="form-select form-select-sm" name="sort" style="width: 15%; display: inline-block;">
							<option selected>정렬기준</option>
							<option value="review">리뷰</option>
							<option value="star">평점</option>
							<option value="distance">거리</option>
							<option value="like">좋아요</option>
							<option value="name">이름</option>
						</select>
					</div>
				</div>
				<section id="searchResult" class="testimonial">
					<div class="row mx-auto">
					</div>
				</section>
			</div>
			<div class="col p-3">
				<div class="row mx-auto align-items-center">
					<div class="col-12 card rankingArea">
						<table>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>


<!-- =====================================script===========================================================================================  -->

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
	var map;
	var bounds;
	var filterState = false;
	
	
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
			filterState = false; //필터 체크 전 상태 초기화
			point = 1;
			//필터 state 체크
			for (var i = 0; i < $(".sideFilter input").length; i++) {
				if ($(".sideFilter input")[i].checked) {
					filterState = true;
					break;
				}
			}
			if ($(".sideFilter select").val() != '') {
				filterState = true;
			}
			if ($(".sideFilter input[type='range']").val() != 0) {
				filterState = true;
			}
			
			if (!filterState) {
				point = 1;
				storeResult = [];
				$("#searchResult .row").empty();
				getStoreListByRownum();
				return;
			}
			
			
			var selectedCate = $("input[name='scate']:checked");
			var selectedLocation = $(".sideFilter select").val();
			var distLimit = $(".sideFilter input[type='range']").val();
			
			//범위 표시
			$("#distLim").html("&nbsp;~ " + distLimit + "km");			
			
			
			saveFilterData();
			
			var scate = [];
			// 카테고리 처리
			for (var i = 0; i < selectedCate.length; i++) {
				scate.push(selectedCate[i].value);
			}
			
			if (scate.length < 1) {
				scate.push("");
			}
			
			//예약 및 배달 처리
			var delivery = [];
			var reservation = [];
			if ($("input[name='sdeli']").is(":checked")) {
				delivery.push("1");
			}else{
				delivery.push("");
			}
			if ($("input[name='smaxreserv']").is(":checked")) {
				reservation.push("1");
			}else{
				reservation.push("");
			}
			
			
			
			//ajax 처리가 끝날 때까지 로딩 표시
			$("#searchResult row").html('<div id="loading"></div>');
			
			
			$.ajax({
			      type: "get",
			      url: "/store/search/filter",
			      data: {scate : scate,
			    	  	location : selectedLocation,
			    	  	delivery : delivery,
			    	  	reservation : reservation},
			      success: function (result, status, xhr) {
			    	  
			    	bounds = new kakao.maps.LatLngBounds();
			  		map = new kakao.maps.Map($(".mapContainer")[0],
			  				{ 
			  					center: new kakao.maps.LatLng(0, 0), 
			  					level: 4
			  				}); //지도 생성 및 객체 리턴
			    	  
			    	  $("#searchResult .row").empty();
			    	  storeResult = [];
			    	  if (result.length > 0) {
				    	  for (var store of result) {
				    		  //거리 정보(현재 위치 기준)부여
				    		  store.distance = getDistance(Number(store.kd), Number(store.wd), currPosition.coords.latitude, currPosition.coords.longitude)
				    		//출력될 태그 부여
				    		if (Number(store.distance) <= Number(distLimit) || Number(distLimit) == 0) {
				    			store.str = '';
				    			store.str += '<div class="col-lg-12 aos-init aos-animate mb-3" data-aos="fade-up">';
				    			store.str += '<div class="entry store mb-4" data-sno="'+store.sno+'" tabindex="0">';
				    			store.str += '<h2><a href="/store/detail?sno='+store.sno+'">'+store.sname+'</a></h2>';
				    			store.str += '<p class="d-flex justify-content-between">'+store.saddress+'<i class="bi bi-cursor-fill">'+store.distance+" km"+'</i></p>';
				    			store.str += '<p style="text-align : right; margin : 0;">';
				    			store.str += '<i class="bi bi-star-fill">'+store.sstar+'</i>  ';
				    			store.str += '<i class="bi bi-hand-thumbs-up">'+store.slike+'</i>  ';
				    			store.str += '</p>';
				    			store.str += '</div>';
				    			store.str += '</div>';
				    			
								
				    		  storeResult.push(store);
							}
				    		
				    		  
				    		
						  }
					}
				   	getFromStoreResult(point, 5);
			    	  
			    	  
			    	  
			    	
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
				point = 1;
				getFromStoreResult(point, 5);
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
				$("#searchResult .row").empty();
				point = 1;
				getFromStoreResult(point, 5);
				
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
<script type="text/javascript">/* 매장 append */
	var point = 1;
	function getStoreListByRownum() {
		$(".mapContainer").hide();
		$.ajax({
		      type: "get",
		      url: "/store/storeList",
		      data: {point : point},
		      success: function (result, status, xhr) {
		    	  point++; //페이지와 같은 역할
		    	  if (!$("#blank")[0]) { //감지할 blank div 최초 생성
		    		  $("#searchResult .row").append('<div id="blank"><div>');
		    		  observer.observe($("#blank")[0]);
		    		  }
		    	  var str = "";
		    	  if (result.length > 0) {
			    	  for (var store of result) {
			    		  	//거리 정보(현재 위치 기준)부여
			    		    store.distance = getDistance(Number(store.kd), Number(store.wd), currPosition.coords.latitude, currPosition.coords.longitude)
			    			//출력될 태그 부여
			    			store.str = '';
			    			store.str += '<div class="col-lg-12 aos-init aos-animate mb-3" data-aos="fade-up">';
			    			store.str += '<div class="entry store mb-4" data-sno="'+store.sno+'" tabindex="0">';
			    			store.str += '<h2><a href="/store/detail?sno='+store.sno+'">'+store.sname+'</a></h2>';
			    			store.str += '<p>'+store.saddress+'</p>';
			    			store.str += '</div>';
			    			store.str += '</div>';
							
				    		storeResult.push(store);
				    		str += store.str;
					  }
			    	  $("#blank").before(str);
			    	  console.log(storeResult);
				}
		    	  
		      }
		}); 
		
	}
	//amount 만큼 불러오기  
	function getFromStoreResult(current, amount) {
		point++;
		console.log("point : " + current);
		
		if (storeResult.length > 0 && storeResult != null) {
			$(".mapContainer").show();
			map.relayout();
			var str = '';
			if (!$("#blank")[0]) { //감지할 blank div 최초 생성
	  		  $("#searchResult .row").append('<div id="blank"><div>');
	  		  observer.observe($("#blank")[0]);
	  		  }
			console.log("============================================================");
			if ((current*amount) > storeResult.length || storeResult.length < amount) {
				for (var i = amount*(current-1); i < storeResult.length; i++) {
					str += storeResult[i].str;
					makeMarker(storeResult[i]);
				}
				$("#blank").before(str);
			}else{
				for (var i = amount*(current-1); i < current*amount; i++) {
					str += storeResult[i].str;
					makeMarker(storeResult[i]);
				}
				$("#blank").before(str);
			}
		}else{
			console.log("결과없음");
			$(".mapContainer").hide();
			$("#searchResult .row").empty();
			$("#searchResult .row").append('<p>일치하는 결과가 없습니다.</p>');
		}
		
		
		
	}
	
	function loadFromSession() {
		if ('${filterData}' != '') {
			filterState = true;
			var dist = '${filterData.distance}';
			$("#distLim").html("&nbsp;~ " + dist + "km");
			$(".sidebar input[type='range']").val(dist);
			var cate = '${filterData.categories}';
			var cates = cate.substring(0,cate.length-1).split(",");
			var loc = '${filterData.location}';
			$("select[name='location']").val(loc);
			//예약 및 배달 처리
			var del = [];
			var res = [];
			if ('${filterData.delivery}' ==  '1') {
				del.push("1");
				$("input[name='sdeli']").attr("checked", true);
			}else{
				del.push("");
			}
			if ('${filterData.reservation}' ==  '1') {
				$("input[name='smaxreserv']").attr("checked", true);
				res.push("1");
			}else{
				res.push("");
			}
			for (var category of cates) {
				$("input[value='"+category+"']").attr("checked", true);
			}
			 
			$.ajax({
			      type: "get",
			      url: "/store/search/filter",
			      data: {scate : cates,
			    	  	location : loc,
			    	  	delivery : del,
			    	  	reservation : res},
			      success: function (result, status, xhr) {
			    	  	bounds = new kakao.maps.LatLngBounds();
				  		map = new kakao.maps.Map($(".mapContainer")[0],
				  				{ 
				  					center: new kakao.maps.LatLng(0, 0), 
				  					level: 4
				  				}); //지도 생성 및 객체 리턴
			    	  $("#searchResult .row").empty();
			    	  
			    	  storeResult = [];
			    	  if (result.length > 0) {
				    	  for (var store of result) {
				    		  //거리 정보(현재 위치 기준)부여
				    		  store.distance = getDistance(Number(store.kd), Number(store.wd), currPosition.coords.latitude, currPosition.coords.longitude)
				    		//출력될 태그 부여
				    		if (Number(store.distance) <= dist || dist == 0) {
				    			store.str = '';
				    			store.str += '<div class="col-lg-12 aos-init aos-animate mb-3" data-aos="fade-up">';
				    			store.str += '<div class="entry store mb-4" data-sno="'+store.sno+'" tabindex="0">';
				    			store.str += '<h2><a href="/store/detail?sno='+store.sno+'">'+store.sname+'</a></h2>';
				    			store.str += '<p>'+store.saddress+'</p>';
				    			store.str += '</div>';
				    			store.str += '</div>';
				    			
								
				    		  storeResult.push(store);
							}
				    		
				    		  
				    		
						  }
				    	  getFromStoreResult(point, 5);
					}
			    	  
			    	  
			    	  
			    	
			      }
			}); 
		}
	}
	function saveFilterData() {
		var filterData = {};
		filterData.location = $("select[name='location']").val();
		filterData.delivery = ($("input[name='sdeli']")[0].checked) ? "1" : "0";
		filterData.reservation = ($("input[name='smaxreserv']")[0].checked) ? "1" : "0";
		filterData.distance = $("#distLim").text();
		var cates = "";
		for (var i = 0; i < $("input[name='scate']").length; i++) {
			if ($("input[name='scate']")[i].checked) {
				cates += $("input[name='scate']")[i].value+",";
			}
		}
		filterData.categories = cates;
		
		$.ajax({
			  type: "post",
		      url: "/store/filterData",
		      data: JSON.stringify(filterData),
		      contentType : "application/json",
		      success: function (result, status, xhr) {
		    	  console.log("saved!");
		      }
		});
	}
	
</script>
<script type="text/javascript">/* 스크롤 */
	
	//화면 하단 observe
	const onIntersect = (entries, observer) => { 
	    // entries는 IntersectionObserverEntry 객체의 리스트로 배열 형식을 반환합니다.
	    entries.forEach(entry => {
	        if(entry.isIntersecting){
	        	if (filterState) {
	        		getFromStoreResult(point, 5);
				}else{
		        	getStoreListByRownum();
				}
	        }
	    });
	};
	//breadcrumble observe
	const breadObserver = (entries, observer) => { 
	    // entries는 IntersectionObserverEntry 객체의 리스트로 배열 형식을 반환합니다.
	    entries.forEach(entry => {
	        if(!entry.isIntersecting){
	        	console.log("check");
	        	$("#structure").css("overflow", "unset");
	        	$(".sideFilter").css("top", "10%");
	        	$(".mapBox").css("top", "7%");
	        }else{
	        	console.log("back");
	        	$("#structure").css("overflow", "hidden");
	        	$(".sideFilter").css("top", "0");
	        	$(".mapBox").css("top", "0");
	        }
	    });
	};
	
	
	var observer = new IntersectionObserver(onIntersect, {
	    root: null,
	    rootMargin: "0px 0px 0px 0px",
	    thredhold: 0,
	});
	
	var breadObs = new IntersectionObserver(breadObserver, {
	    root: null,
	    rootMargin: "0px 0px 0px 0px",
	    thredhold: 0,
	});
	
	
	breadObs.observe($("#breadcrumbs")[0]);
	
</script>
<script type="text/javascript"> /* 지도에 마커 생성  */
	var makeMarker = function(object) {	//marker 이벤트 부여를 위한 클로저함수
		// 마커 이미지의 주소
		
		var sno = object.sno;
		var markerImageUrl = '/resources/img/icon/free-icon-restaurant-4552186.png', 
		    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
		    markerImageOptions = { 
		        offset : new kakao.maps.Point(13, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
		    };
		
		// 마커 이미지를 생성한다
		var markerImage = new kakao.maps.MarkerImage(markerImageUrl, markerImageSize, markerImageOptions);
		var coords = new kakao.maps.LatLng(object.kd, object.wd);
		var marker = new kakao.maps.Marker({
	        map: map,
	        position: coords,
	        image : markerImage
	    });
		//지도 범위 설정
		bounds.extend(coords);
		map.setBounds(bounds);
		
		// 마커 이미지(이벤트 발생용)
	    var overImageUrl = '/resources/img/icon/free-icon-restaurant-highlight-4552186.png', 
		    overImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
		    overImageOptions = { 
	            offset : new kakao.maps.Point(13, 42)// 마커 좌표에 일치시킬 이미지 안의 좌표
	        };
	    var overImage = new kakao.maps.MarkerImage(overImageUrl, overImageSize, overImageOptions);
		
	    
	 	// 커스텀 오버레이에 표출될 내용
	    var content = '<div class="bubble">' +
	        '    <span class="title" style="margin-left : 25px; font-weight : 600;">'+object.sname+'</span>' +
	        '</div>';
	
	
	    // 커스텀 오버레이를 생성합니다
	    var customOverlay = new kakao.maps.CustomOverlay({
	        map: map,
	        position: coords,
	        content: content,
	        yAnchor: 0,
	        xAnchor: 0,
	        zIndex: -1
	    });
	    customOverlay.setMap(null);
	  	//지도 레벨 변동 감지
		// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'zoom_changed', function() {        
	    
		    // 지도의 현재 레벨을 얻어옵니다
		    var level = map.getLevel();
		    if (level <= 7) {
		    	//오버레이 표시 추후에 추가 필요
		    	customOverlay.setMap(map);
			}else{
				//오버레이 숨기기
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
			kakao.maps.event.addListener(marker, 'click', function() {
				$("#searchResult div[data-sno='"+sno+"']").focus();
			});
		}
		
		return addE();
		
	};
</script>

<%@ include file="testFooter.jsp"%>