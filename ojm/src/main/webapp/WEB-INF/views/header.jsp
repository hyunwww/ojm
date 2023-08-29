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
</head>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<body>
  <!-- ======= Header ======= -->
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
			  <li><a href="/board/list">1</a></li>
			  <li><a href="/qboard/qlist">2</a></li>
			  <li><a href="/jboard/jlist">3</a></li>
			</ul>
          </li>
          <li><a href="/store/storeList">Search</a></li>
          <li><a href="/store/register">Register</a></li>
          <sec:authorize access="hasRole('ROLE_user')">
          	<li><a href="/user/myPage/main">myPage</a></li>
          </sec:authorize>
          <sec:authorize access="hasRole('ROLE_business')">
          	<li><a href="/user/myPage/main">myPage</a></li>
          </sec:authorize>
          <sec:authorize access="hasRole('ROLE_admin')">
			<li><a href="/admin/main">adminPage</a></li>
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

  <!-- Vendor JS Files -->
  <script src="/resources/vendor/aos/aos.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="/resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="/resources/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="/resources/vendor/waypoints/noframework.waypoints.js"></script>
  <script src="/resources/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="/resources/js/main.js"></script>

</body>

</html>