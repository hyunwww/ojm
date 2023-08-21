<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../testHeader.jsp" %>
<script type="text/javascript">
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
			alert("로그인이 필요한 서비스입니다.");
			location.href = '/user/login';
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
<main id="main">
	
    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs" style="margin-top: 70px;">
      <div class="container">

        <div class="d-flex justify-content-between align-items-center">
          <h2>매장 정보</h2>
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
	              </div>
              	</div>
              	<div class="col-lg-3" style="border: 1px solid black; height: 150px;" id="mapContainer">
              	</div>
              </div>
              

              <div class="entry-content">
              	<div class="imgArea" style="width: 50%; height: 200px; overflow: hidden;"><!-- owl carousel 및 lightbox적용하여 이미지 영역 구축  -->
              		<div class="owl-carousel owl-theme owl-loaded" style="text-align: -webkit-center">
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
              		
              	</div>
                <p>이름 : ${store.sname }<span id="distance"></span></p>
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
							<span class="enabledLike"><i class="bi bi-hand-thumbs-up-fill"></i> ${store.slike }</span>
						</c:when>
						<c:otherwise>
							<span id="likeBtn"><i class="bi bi-hand-thumbs-up"></i> ${store.slike }</span>
						</c:otherwise>
					</c:choose>
					<p><i class="bi bi-star-fill"></i> ${store.sstar }</p>
				</div>

              </div>

              <div class="entry-footer"><!-- tag 사용  -->
                <i class="bi bi-folder"></i>
                <ul class="cats">
                  <li><a href="#">bigTag</a></li>
                </ul>

                <i class="bi bi-tags"></i>
                <ul class="tags">
                  <li><a href="#">smallTag 1</a></li>
                  <li><a href="#">smallTag 2</a></li>
                  <li><a href="#">smallTag 3</a></li>
                </ul>
                <div id="btnContainer" style="text-align: right; padding: 10px;">
					<button id="reportBtn" data-bs-toggle="modal" data-bs-target="#reportModal">신고</button>
					<sec:authorize access="isAuthenticated()">
						<button id="open-modal" data-bs-toggle="modal" data-bs-target="#revModal">리뷰 작성</button>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						<button id="revBtn">리뷰 작성</button>
					</sec:authorize>
					<button id="bookBtn">예약</button>
				</div>
              </div>

            </article><!-- End blog entry -->

            

            <div class="blog-comments">

              <h4 class="comments-count">reviews</h4><br>
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
			  
			  


              <div class="reply-form" style="display: none;"><!-- 숨겼다가 모달로 사용  -->
                <h4>Leave a Reply</h4>
                <p>Your email address will not be published. Required fields are marked * </p>
                <form action="">
                  <div class="row">
                    <div class="col-md-6 form-group">
                      <input name="name" type="text" class="form-control" placeholder="Your Name*">
                    </div>
                    <div class="col-md-6 form-group">
                      <input name="email" type="text" class="form-control" placeholder="Your Email*">
                    </div>
                  </div>
                  <div class="row">
                    <div class="col form-group">
                      <input name="website" type="text" class="form-control" placeholder="Your Website">
                    </div>
                  </div>
                  <div class="row">
                    <div class="col form-group">
                      <textarea name="comment" class="form-control" placeholder="Your Comment*"></textarea>
                    </div>
                  </div>
                  <button type="submit" class="btn btn-primary">Post Comment</button>

                </form>

              </div>

            </div><!-- End blog comments -->

          </div><!-- End blog entries list -->

          <div class="col-lg-4">

            <div class="sidebar">

              <h3 class="sidebar-title">비슷한 매장 추천</h3>
              <div class="sidebar-item recent-posts">
                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-1.jpg" alt="">
                  <h4><a href="blog-single.html">Nihil blanditiis at in nihil autem</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-2.jpg" alt="">
                  <h4><a href="blog-single.html">Quidem autem et impedit</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-3.jpg" alt="">
                  <h4><a href="blog-single.html">Id quia et et ut maxime similique occaecati ut</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-4.jpg" alt="">
                  <h4><a href="blog-single.html">Laborum corporis quo dara net para</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

                <div class="post-item clearfix">
                  <img src="assets/img/blog/blog-recent-5.jpg" alt="">
                  <h4><a href="blog-single.html">Et dolores corrupti quae illo quod dolor</a></h4>
                  <time datetime="2020-01-01">Jan 1, 2020</time>
                </div>

              </div><!-- End sidebar recent posts-->

              <h3 class="sidebar-title">Tags</h3>
              <div class="sidebar-item tags">
                <ul>
                  <li><a href="#">App</a></li>
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
  	<!-- 지도 팝업  -->
	<div class="map-overlay">
		<div class="mapModal"></div>
	</div>
<script src="/resources/js/fslightbox.js"></script>
<%@ include file="../testFooter.jsp" %>    