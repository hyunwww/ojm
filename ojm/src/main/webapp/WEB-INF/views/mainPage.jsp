<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>ojm</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="/resources/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Muli:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="/resources/vendor/animate.css/animate.min.css" rel="stylesheet">
  <link href="/resources/vendor/aos/aos.css" rel="stylesheet">
  <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/resources/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/resources/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="/resources/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="/resources/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="/resources/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: Flattern
  * Updated: Jul 27 2023 with Bootstrap v5.3.1
  * Template URL: https://bootstrapmade.com/flattern-multipurpose-bootstrap-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	var user = '${uvo}';
	var errorcode = '${errorCode}';
	switch (errorcode) {
	case 'noInfo':
		alert("존재하지 않는 매장입니다.");
		break;
	case 'access':
		alert("잘못된 접근입니다.");
		break;
	
	default:
		break;
	}
	
	
</script>
<jsp:include page="testHeader.jsp"></jsp:include>
<body>
<%--   <!-- ======= Header ======= -->
  <header id="header" class="d-flex align-items-center">
    <div class="container d-flex justify-content-between">

      <div class="logo">
        <h1 class="text-light"><a href="/">OJM</a></h1>
        <!-- Uncomment below if you prefer to use an image logo -->
        <!-- <a href="index.html"><img src="/resources/img/logo.png" alt="" class="img-fluid"></a>-->
      </div>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="active" href="/">Home</a></li>
          <li class="dropdown"><a href="#"><span>Community</span><i class="bi bi-chevron-down"></i></a>
          	<ul>  
			  <li><a href="/board/list">자유게시판</a></li>
			  <li><a href="/qboard/qlist">Q&A 게시판</a></li>
			  <li><a href="/jboard/jlist">구인구직 게시판</a></li>
			</ul>
          </li>
          <li><a href="/store/search">Search</a></li>
          <li><a href="/store/register">Register</a></li>
          <sec:authorize access="hasRole('ROLE_user')">
          	<li><a href="/user/myPage/main">myPage</a></li>
          </sec:authorize>
          <sec:authorize access="hasRole('ROLE_business')">
          	<li><a href="/user/myPage/main">myPage</a></li>
          </sec:authorize>
          <sec:authorize access="hasRole('ROLE_admin')">
			<li class="dropdown"><a href="#"><span>adminPage</span><i class="bi bi-chevron-down"></i></a>
				<ul>
					<li><a href="/admin/reportList">신고 관리</a></li>
					<li><a href="/qboard/qlist">Q&A 관리</a></li>
					<li><a href="/admin/storeRegisterList">등록 요청 관리</a></li>
				</ul>
			</li>
          </sec:authorize>
          <sec:authorize access="isAuthenticated()">
          	<li><a href="/logout">Logout</a></li>
          </sec:authorize>
          <sec:authorize access="isAnonymous()">
          	<li><a href="/user/login">Login</a></li>
          </sec:authorize>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

    </div>
  </header><!-- End Header -->
 --%>
  <!-- ======= Hero Section ======= -->
  <section id="hero">
    <div id="heroCarousel" data-bs-interval="2500" class="carousel slide carousel-fade" data-bs-ride="carousel">

      <div class="carousel-inner" role="listbox">
		
		<sec:authorize access="isAnonymous()">
		<!-- 대표 이미지(비로그인) -->
			<div class="carousel-item active" style="background-image: url(/resources/img/sam.jpg);">
	          <div class="carousel-container">
	            <div class="carousel-content">
	              <h2>오늘 점심 뭐 먹을까?</h2>
	              <p>더 상세한 추천을 받고 싶다면?</p>
	              <div class="text-center"><a href="/user/register" class="btn-get-started">회원되기</a></div>
	            </div>
	          </div>
	        </div>
        </sec:authorize>
        
		<sec:authorize access="isAuthenticated()">
			<div class="carousel-item active" style="background-image: url(/resources/img/sam.jpg);">
	          <div class="carousel-container">
	            <div class="carousel-content">
	              <h2>오늘 점심 뭐 먹을까?</h2>
	              <p></p>
	              <div class="text-center"><a href="" class="btn-get-started">추천받기</a></div>
	            </div>
	          </div>
	        </div>
        </sec:authorize>
		
		<div class="carousel-item" style="background-image: url(/resources/img/ja.jpg);">
		    <div class="carousel-container">
		      <div class="carousel-content">
		        <h2>오늘 점심 뭐 먹을까?</h2>
		        <p></p>
		        <div class="text-center"><a href="/store/recommend?category=중식," class="btn-get-started">중식?</a></div>
		      </div>
		    </div>
		</div>
		<div class="carousel-item" style="background-image: url(/resources/img/sam.jpg);">
		    <div class="carousel-container">
		      <div class="carousel-content">
		        <h2>오늘 점심 뭐 먹을까?</h2>
		        <p></p>
		        <div class="text-center"><a href="/store/recommend?category=한식," class="btn-get-started">한식</a></div>
		      </div>
		    </div>
		</div>
		<!-- 가게 이미지 반복 -->
		<c:forEach var="store" items="${slist }">
			<div class="carousel-item" style="background-image: url('/images/${store.imgList[0].uuid }_${store.imgList[0].fileName}');">
	          <div class="carousel-container">
	            <div class="carousel-content">
	              <h2>${store.sname }</h2>
	              <p>${store.saddress }</p>
	              <div class="text-center"><a href="/store/detail?sno=${store.sno }" class="btn-get-started">가게 보기</a></div>
	            </div>
	          </div>
	        </div>
		</c:forEach>
<!--         
        Slide 2
        <div class="carousel-item" style="background-image: url(/resources/img/service-2.jpg);">
          <div class="carousel-container">
            <div class="carousel-content">
              <h2>Lorem Ipsum Dolor</h2>
              <p>Ut velit est quam dolor ad a aliquid qui aliquid. Sequi ea ut et est quaerat sequi nihil ut aliquam. Occaecati alias dolorem mollitia ut. Similique ea voluptatem. Esse doloremque accusamus repellendus deleniti vel. Minus et tempore modi architecto.</p>
              <div class="text-center"><a href="" class="btn-get-started">Read More</a></div>
            </div>
          </div>
        </div>

        Slide 3
        <div class="carousel-item" style="background-image: url(/resources/img/service-3.jpg);">
          <div class="carousel-container">
            <div class="carousel-content">
              <h2>Sequi ea ut et est quaerat</h2>
              <p>Ut velit est quam dolor ad a aliquid qui aliquid. Sequi ea ut et est quaerat sequi nihil ut aliquam. Occaecati alias dolorem mollitia ut. Similique ea voluptatem. Esse doloremque accusamus repellendus deleniti vel. Minus et tempore modi architecto.</p>
              <div class="text-center"><a href="" class="btn-get-started">Read More</a></div>
            </div>
          </div>
        </div>
       -->
      
      </div>

      <a class="carousel-control-prev" href="#heroCarousel" role="button" data-bs-slide="prev">
        <span class="carousel-control-prev-icon bx bx-left-arrow" aria-hidden="true"></span>
      </a>

      <a class="carousel-control-next" href="#heroCarousel" role="button" data-bs-slide="next">
        <span class="carousel-control-next-icon bx bx-right-arrow" aria-hidden="true"></span>
      </a>

      <ol class="carousel-indicators" id="hero-carousel-indicators"></ol>

    </div>
  </section><!-- End Hero -->
	<div class="min-vh-100"></div>
	
<!-- 
  Vendor JS Files
  <script src="/resources/vendor/aos/aos.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="/resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="/resources/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="/resources/vendor/waypoints/noframework.waypoints.js"></script>
  <script src="/resources/vendor/php-email-form/validate.js"></script>

  Template Main JS File
  <script src="/resources/js/main.js"></script>
 -->
</body>
<jsp:include page="testFooter.jsp"></jsp:include>
</html>