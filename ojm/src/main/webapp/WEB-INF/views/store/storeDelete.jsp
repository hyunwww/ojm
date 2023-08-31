<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
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
	.wrapper{
		width: fit-content;
		margin: auto;
		background-color: white;
		border-radius: 10px;
		box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
		padding: 10px;
	}
	
	
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	$(function() {
			
		$("#listBtn").on("click", function() {
			history.go(-1);
		});
		$("#delBtn").on("click", function() {
			
			
			if ($("input[name='pw']").val() == '') {
				alert("비밀번호를 입력하세요.");
				return;
			}
			var sno = $("input[name='sno']").val();
			var password = $("input[name='pw']").val();
			
			//ajax를 통한 비밀번호 검증
			$.ajax({
			      type: "post",
			      url: "/store/delete",
			      data: {sno : sno,
			    	  	pw : password},
			      success: function (result, status, xhr) {
			    	  alert(result);
			    	  
			    	  //성공 시 store 삭제, myPage목록으로 이동(현재는 홈으로 이동)
			    	  location.href="/";
			      },
			      error: function(xhr, status, error) {
			    	//실패 시 알림
					alert(xhr.responseText);
				}
			});
		
			
			
		});
		
	});

</script>
</head>
<body>
	<section id="pwCheck" class="section-bg">
		<div class="container">
			<div class="row">
				<div class="col-12 min-vh-100 align-items-center d-flex">
					<div class="wrapper">
						<form action="/store/delete" method="post" style="padding: 3px 20px">
							<div class="row mb-3">
								<div class="col-auto p-1">매장명</div>
								<div class="col-auto p-1"><c:out value="${store.sname }"></c:out></div>
							</div>
							<div class="row mb-3">
								<div class="col-auto p-1">비밀번호 확인</div>
								<div class="col-auto p-1"><input type="password" name="pw"></div>
							</div>
							<div class="border-top py-3"></div>
							<div class="row justify-content-end">
								<div class="col-auto p-1">
									<input type="button" id="listBtn" class="btn btn-sm btn-secondary" value="목록으로">
									<input type="button" id="delBtn" class="btn btn-sm btn-secondary" value="삭제하기">
								</div>
							</div>
							
							<input type="hidden" value="${store.sno }" name="sno">
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
</body>
</html>