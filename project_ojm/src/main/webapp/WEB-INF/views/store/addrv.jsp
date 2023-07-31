<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
#file-box {
	font-weight: bold;
	color: #00FFFF;
}

#review-content {
	font-size: 16px;
	font-weight: normal;
	color: black;
	height: 55px;
	border: none;
}

#review-title {
	font-size: 12px;
	color: gray;
}

#file {
	position: fixed;
	display: none;
}

hr {
	width: 20%;
	position: fixed;
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
</style>
</head>
<body>
	<button id="open-modal">열기</button>
	<div id="modal">
		<div class="modal-content">

			<form action="/store/addrv" method="post" role="form">
				<div id="review-title">
					<span>평점</span><br />
					<div class="form-group">
						<span class="star"> ★★★★★ <span id="rvstar">★★★★★</span> <input
							type="range" name="rvstar" oninput="myFunction(this.value)"
							value="0" step="0.5" min="0" max="5">
						</span>
					</div>
					<span>내용</span>
					<div class="form-group">
						<textarea id="review-content" name="rvcontent"></textarea>
						<input type="hidden" name="uno" value="5"> <input
							type="hidden" name="sno" value="5"> <input type="hidden"
							name="rvlike" value="1">
						<!--<input type="hidden" name="pageNum" value="1">
			<input type="hidden" name="amount" value="10">-->
					</div>
					<button type="button" id="close-modal" data-oper="reset" class="btn-reset">취소</button>
					<button type="submit" data-oper="register" class="btn">등록</button>
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript"> /* review 모달 스크립트  */
		function myFunction(drawstar) {
			//const drawstar = document.querySelector('.star input');
			document.querySelector('.star span').style.width = drawstar * 10
					+ '%';
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
		  document.getElementById("review-content").value = "";
		  document.querySelector('.star span').style.width = 0+'%';
		  document.body.style.overflow = "auto"; // 스크롤바 보이기
		});
	</script>
	<!-- <script type="text/javascript">
		$(function()){
			var formObj = $("form");
			$("button").on('click', function(e){	// 버튼 클릭시
				e.preventDefault();					// 페이지 넘어가는거 방지
				
				var operation = $(this).data("oper");
				if (operation === 'register'){
					formObj.attr("action", '/store/addrv');
				}else if (operation === 'reset'){
					formObj.each(function(){
						this.reset();
					});
				}
				
			})
		}
	</script>-->
	<!-- 
	<div id="file-box">
		<span id="review-title">이미지</span><br /> <br /> <label for="file">이미지
			삽입</label>
		<hr />
	</div>
	<input type="file" name="file" id="file"> -->
</body>
</html>