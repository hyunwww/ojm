<!DOCTYPE html><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="testHeader.jsp" %>

<!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs" style="margin-top: 70px;">
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
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-2 d-flex flex-column flex-shrink-0 p-3">
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
					<h3 class="sidebar-title">dist</h3>
					<div class="sidebar-item text-dark">
						<span id="distLim"></span>
						<input type="range" value="0" min="0" max="50" step="1"  style="width: -webkit-fill-available">
					</div>
					
				</div>
			</div>
			<div class="col-lg-7 p-3 min-vh-100">
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
			$("#searchResult row").html('<div id="loading"></div>');
			
			
			$.ajax({
			      type: "get",
			      url: "/store/search/filter",
			      data: {scate : scate,
			    	  	location : selectedLocation},
			      success: function (result, status, xhr) {
			    	  
			    	  
			    	  $("#searchResult .row").empty();
			    	  var str = "";
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
				    			store.str += '<p>'+store.saddress+'</p>';
				    			store.str += '</div>';
				    			store.str += '</div>';
				    			
								
				    		  storeResult.push(store);
				    		  str += store.str;
							}
				    		
				    		  
				    		
						  }
				    	  $("#searchResult .row").append(str);
				    	  console.log(storeResult);
					}
			    	  if (storeResult.length < 1) {
			    		    str += '<p>일치하는 결과가 없습니다.</p>';
							$("#searchResult .row").append(str);
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
			    				var sno = store.sno;
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
					    		
					    	    
					    	 	// 커스텀 오버레이에 표출될 내용
					    	    var content = '<div class="bubble">' +
					    	        '    <span class="title">'+store.sname+'</span>' +
					    	        '</div>';


					    	    // 커스텀 오버레이를 생성합니다
					    	    var customOverlay = new kakao.maps.CustomOverlay({
					    	        map: map,
					    	        position: coords,
					    	        content: content,
					    	        yAnchor: 0.4,
					    	        xAnchor: 0.4
					    	    });
					    	    
					    	  	//지도 레벨 변동 감지
				    			// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
				    			kakao.maps.event.addListener(map, 'zoom_changed', function() {        
				    		    
					    		    // 지도의 현재 레벨을 얻어옵니다
					    		    var level = map.getLevel();
					    		    if (level <= 6) {
					    		    	//오버레이 표시
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



						<%@ include file="testFooter.jsp"%>