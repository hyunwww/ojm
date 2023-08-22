<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>




<style type="text/css">
.star {
	position: relative;
	font-size: 2rem;
	color: #FFFFFF;
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
	text-shadow: -1px 0px #848484, 0px 1px #848484, 1px 0px #848484, 0px
		-1px #848484;
	color: yellow;
	overflow: hidden;
	pointer-events: none;
}

#modal {
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

.modal-content {
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
</style>
</head>
<body>
	<span class="star"> ★★★★★ <span>★★★★★</span> <input type="range"
		oninput="myFunction(this.value)" value="1" step="1" min="1" max="10">
	</span>
	<button id="open-modal">열기</button>
	<div id="modal">
		<div class="modal-content">
			<h2>모달창 제목</h2>
			<p>모달창 내용</p>
			<button id="close-modal">닫기</button>
		</div>
	</div>
<script type="text/javascript"> 
	function myFunction(drawstar){
		//const drawstar = document.querySelector('.star input');
		document.querySelector('.star span').style.width = drawstar * 10+'%';
    }
	const modal = document.getElementById("modal");
	const openModalBtn = document.getElementById("open-modal");
	const closeModalBtn = document.getElementById("close-modal");
	// 모달창 열기
	openModalBtn.addEventListener("click", () => {
	  modal.style.display = "block";
	  document.body.style.overflow = "hidden"; // 스크롤바 제거
	});
	// 모달창 닫기
	closeModalBtn.addEventListener("click", () => {
	  modal.style.display = "none";
	  document.body.style.overflow = "auto"; // 스크롤바 보이기
	});
</script>
</body>

</html>