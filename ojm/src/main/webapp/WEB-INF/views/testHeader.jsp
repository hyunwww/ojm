<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html lang="en">
<head>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Flattern Bootstrap Template - Index</title>
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
  <link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="/resources/css/owl.carousel.min.css">

  <!-- Template Main CSS File -->
  <link href="/resources/css/style.css" rel="stylesheet">
  
  <!-- Vendor JS Files -->
  <script src="/resources/vendor/aos/aos.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="/resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="/resources/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="/resources/vendor/waypoints/noframework.waypoints.js"></script>
  <script src="/resources/vendor/php-email-form/validate.js"></script>
  <script src="/resources/js/owl.carousel.min.js"></script>


  <!-- Template Main JS File -->
  <script src="/resources/js/main.js"></script>

  <!-- =======================================================
  * Template Name: Flattern
  * Updated: Jul 27 2023 with Bootstrap v5.3.1
  * Template URL: https://bootstrapmade.com/flattern-multipurpose-bootstrap-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  
<style type="text/css">
.card {
	height: auto;
	width: auto;
	display: inline-block;
	position: relative;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
	overflow: hidden;
	padding: 15px;
}
.store:focus{
	border: 2px solid indianred;
}
.store:hover{
	transform: scale(1.01);
	transition: transform 0.2s ease-out;
}
.mapContainer {
	display: none;
	width: 100%;
	height: 250px;
	margin: auto;
}
.owl-next, .owl-prev{
		background-color: rgba(245, 126, 100, 0.6);
		color: white;
		border-radius : 10px; 
		width: auto;
		display: inline-block;
		padding: 10px;
		cursor: pointer;
		position: relative;
		transform: translateY(-50%);
		top: -8rem;
	}
.owl-lastItem{
	background-color: rgba(245, 126, 100, 0);
	color: rgba(0, 0, 0, 0);
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
	  z-index: 997;
	}
	.reportOverlay{
	  position: fixed;
	  top: 0;
	  left: 0;
	  right: 0;
	  bottom: 0;
	  background-color: rgba(0, 0, 0, 0.8);
	  display: none;
	  z-index: 1;
	}
	.reportModal{
		width: fit-content;
		height: auto;
		margin: auto;
		background-color: white;
		padding: 15px;
		border-radius: 5px; 
		position: relative;
		top: 10%; 
	}
	.cons{
		width: 100%;
		height: 200px;
	}
	.sideFilter{
		position: sticky;
		top: 0;
		transition : all 0.3s ease-out 0s;
	}	
	.bubble{
		width: fit-content;
		height: auto;
		background-color: white;
		border: 2px solid indianred;
		border-radius: 15px;
		padding: 3px;
		position: relative;
		top: -42px;
		right: 2px;
	}
	.imgBox{
		display: inline-block;
		position: relative;
		border: 8px solid lightgray;
		border-radius: 5px;
	}
	.imgBox button{
		position: absolute;
		top: 0%;
		right: 0%;
	}
	.imgBox img{
		width: 150px;
		height: 150px;
		object-fit : fill;
	}
	.warning-message{
		font-size: .875em;
		color: #dc3545;
	}
</style>
</head>
<script type="text/javascript">
	var user = '${uvo}';
	
	
	
</script>
<body>
  <!-- ======= Header ======= -->
  <header id="header" class="d-flex align-items-center fixed-top">
    <div class="container-fluid mx-5 d-flex justify-content-between">

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
			  <li><a href="#">3</a></li>
			</ul>
          </li>
          <li><a href="/store/search">Search</a></li>
          <li><a href="/store/register">Register</a></li>
          <li><a href="/user/myPage/main">myPage</a></li>
          <li><a href="/user/login">Login</a></li>
          <li>
          	<a href="#">
		        <i class="bi bi-person"></i>
          	</a>
	        <i class="bi bi-list mobile-nav-toggle"></i>
          </li>
        </ul>
      </nav><!-- .navbar -->

    </div>
  </header><!-- End Header -->