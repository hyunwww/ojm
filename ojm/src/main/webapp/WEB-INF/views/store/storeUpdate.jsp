<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#wrapper{
		width: fit-content;
		border: 1px solid black;
		margin: auto;
	}
	.thumbnail{
		width: 100px;
		background-size: contain;
	}
	.imgBox{
		display: inline-block;
		position: relative;
	}
	.imgBox button{
		position: absolute;
		top: 0%;
		right: 0%;
	}
	.modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 10px;
            border: 1px solid #888;
            width: fit-content; /* Could be more or less, depending on screen size */                          
        }
        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .dayOff{
		border: 1px solid black;
		border-collapse: collapse;
		background-color: rgba(171, 171, 171, 0.5);
	}
	.dayOff td{
		border: 1px solid black;
		padding: 5px;
		 
	}
	.dayClicked{
		background-color: cadetblue;
		color: white;
	}
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="../resources/js/menuAjax.js"></script>
<script type="text/javascript">
	var sno = '${store.sno}';
	$(function() {
		menuService.getMenuList();
		
		$("input[name='deposit']").on("change", function() {
			$("#depoInput").val($(this).val());
		});
		
		//예약금 없음 버튼 이벤트
		$("#noDeposit").on("click", function() {
			if ($(this)[0].checked) {
				$("#depoInput").attr("disabled", true);
				$("#depoInput").val("");
				$("input[name='deposit']").attr("disabled", true);
			}else{
				$("#depoInput").attr("disabled", false);
				$("input[name='deposit']").attr("disabled", false);
			}
		});
		$(".upBtn").click(function() {
			var value = $("#reserveValue").text();
			
			$("#reserveValue").html(++value);
		});
		$(".downBtn").click(function() {
			var value = $("#reserveValue").text();
			if (value > 0) {
				$("#reserveValue").html(--value);
			}
		});
		//휴무
		$(".dayOff td").click(function() {
			$(this).toggleClass("dayClicked");
		});
		
		//regForm 제어
		$("form input").on("click", function() {
			var regForm = $("#regForm")[0];
			if ($(this).data("cmd") == 'register') {	//등록 클릭 시
				
				
				// 공백 input 제어
				if (regForm.sname.value == '' || regForm.addr.value == '' || regForm.openHour.value == '' || regForm.closeHour.value == ''
						|| regForm.scrn.value == '' || regForm.sphone.value == '') {
					alert("입력해야됨.");
					return;
				}
				
				$("#regForm").attr("method", "post");
				$("#regForm").attr("action", "/store/update");
				
				//메뉴관련 데이터 처리
				var menuInput = '';
				for (var i = 0; i < menuList.length; i++) {
					menuInput += '<input type="hidden" name="menuList['+i+'].mname" value="'+menuList[i].mname+'" />';
					menuInput += '<input type="hidden" name="menuList['+i+'].mcate" value="'+menuList[i].mcate+'" />';
					menuInput += '<input type="hidden" name="menuList['+i+'].maler" value="'+menuList[i].maler+'" />';
					menuInput += '<input type="hidden" name="menuList['+i+'].mprice" value="'+menuList[i].mprice+'" />';
				}
				
				
				if (deleteTarget != null) {
					//ajax를 통해 기존파일 삭제된 부분 처리
					console.log("deleteTarget is not null");
					
					$.ajax({
					      type: "post",
					      url: "/store/deleteImg",
					      data: JSON.stringify(deleteTarget),
					      contentType: "application/json",
					      success: function (result, status, xhr) {
					    	  console.log(result);
					      }
					});
					 
				}
				
				
				
				//img파일이 담긴 formdata 전송 함수
				sendFile(files, function() {
					if (menuInput != '') {
						$("#regForm").append(menuInput);
					}
					//휴무일 처리
					var dayInput = '';
					for (var i = 0; i < $(".dayOff td").length; i++) {
						if ($(".dayOff td")[i].classList.contains("dayClicked")) {
							var day = $(".dayOff td")[i].innerHTML;
							switch (day) {
							case '월':
								dayInput += 1;
								break;
							case '화':
								dayInput += 2;
								break;
							case '수':
								dayInput += 3;
								break;
							case '목':
								dayInput += 4;
								break;
							case '금':
								dayInput += 5;
								break;
							case '토':
								dayInput += 6;
								break;
							case '일':
								dayInput += 0;
								break;
							default:
								break;
							}
							
						}
					}
					$("#regForm").append('<input type="hidden" name="dayOff" value="'+dayInput+'"/>');
					$("#regForm").append('<input type="hidden" name="smaxreserv" value="'+$("#reserveValue").text()+'"/>');
					$("#regForm").submit();
				});
				
				
			}else if ($(this).data("cmd") == 'goList') {	// 뒤로가기 클릭 시 
				history.go(-1);
			} 
		});
		
	});

</script>

</head>
<body>
	<div id="wrapper">
		<h2 style="text-align: center;">register</h2>
		<form action="#" id="regForm" method="post">
			<table id="storeTable">
				<tr>
					<td>가게명<span style="color: red;">*</span></td>
					<td><input type="text" name="sname" value="${store.sname }" readonly="readonly"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" readonly="readonly" value="${store.saddress }"></td>
				</tr>
				<tr>
					<td>전화번호<span style="color: red;">*</span></td>
					<td><input type="text" name="sphone" value="${store.sphone }"></td>
				</tr>
				<tr>
					<td>카테고리</td>
					<td>
						<select name="scate">
							<option value="한식">kor</option>
							<option value="중식">chn</option>
							<option value="양식">western</option>
							<option value="일식">jap</option>
							<option value="아시아">asia</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>예약</td>
					<td>
						<button type="button" class="downBtn">-</button>
						<span id="reserveValue">${store.smaxreserv }</span>
						<button type="button" class="upBtn">+</button>
					</td>
				</tr>
				<tr>
					<td>휴무</td>
					<td>
						<table class="dayOff">
							<tr>
								<td data-day="1">월</td>
								<td data-day="2">화</td>
								<td data-day="3">수</td>
								<td data-day="4">목</td>
								<td data-day="5">금</td>
								<td data-day="6">토</td>
								<td data-day="0">일</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>영업시간<span style="color: red;">*</span></td>
					<td>
						<select name="openHour">
							<c:forEach var="num" begin="0" end="23">
								<option value="${num }:00">${num }:00</option>
								<option value="${num }:00">${num }:10</option>
								<option value="${num }:00">${num }:20</option>
								<option value="${num }:00">${num }:30</option>
								<option value="${num }:00">${num }:40</option>
								<option value="${num }:00">${num }:50</option>
							</c:forEach>
						</select>
						~
						<select name="closeHour">
							<c:forEach var="num" begin="0" end="23">
								<option value="${num }:00">${num }:00</option>
								<option value="${num }:00">${num }:10</option>
								<option value="${num }:00">${num }:20</option>
								<option value="${num }:00">${num }:30</option>
								<option value="${num }:00">${num }:40</option>
								<option value="${num }:00">${num }:50</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>사업자등록번호<span style="color: red;">*</span></td>
					<td><input type="text" name="scrn" value="${store.scrn }"></td>
				</tr>
				<tr>
					<td>예약금</td>
					<td><input type="text" name="sdepo" id="depoInput" readonly="readonly" value="${store.sdepo }">&nbsp;예약금 없음<input type="checkbox" name="sdepo" value="0" id="noDeposit"></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="range" id="deposit" name="deposit" min="0" max="100000" step="1000" value="${store.sdepo }">
  					</td>
				</tr>
				<tr>
					<td colspan="2">
						배달가능 <input type="radio" name="sdeli" value="1" checked="checked">y
						<input type="radio" name="sdeli" value="0">n
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;">
						<input type="button" value="등록" data-cmd="register">
						<input type="button" value="목록으로" data-cmd="goList">
					</td>
				</tr>
			</table>
			<input type="hidden" value="${store.sno }" name="sno">
			<input type="hidden" value="${store.uno }" name="uno">
		</form>
		<table>
			<tr>
				<td>대표 이미지</td>
				<td></td>
			</tr>
			<tr>
				<td><input type="file" multiple="multiple" name="uploadImgs"></td>
				<td></td>
			</tr>
			<tr>
				<td>메뉴<input type="button" value="+" id="modalOpenBtn"></td>
				<td></td>
			</tr>
		</table>
		<div id="imgContainer">
			<c:forEach var="img" items="${store.imgList }">
				<div class="imgBox">
					<img alt="1" src="/images/${img.uuid }_${img.fileName}" class="thumbnail"
					 data-name="${img.fileName }" data-type="local" data-inumber="${img.sino }"
					 data-path="${img.uploadPath }" data-uuid="${img.uuid }">
					<button class="imgBtn">x</button>
				</div>
			</c:forEach>
		</div>
		<div id="menuContainer">
			<ul>
			</ul>
		</div>
		<div id="mapContainer" style="width: 250px; height: 250px;"></div>
	</div>
	
	
    <!-- The Modal -->
    <div id="myModal" class="modal">
      <!-- Modal content -->
      <div class="modal-content">
      	<p onclick="modalClose()" style="text-align: right; margin: 0px;">x</p>
      	<form action="#" method="post">
	      	<table id="menuTable">
	      		<tr>
	      			<td>메뉴명</td>
	      			<td><input type="text" name="mname"></td>
	      		</tr>
	      		<tr>
	      			<td>분류</td>
	      			<td>
	      				<select name="mcate">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
						</select>
					</td>
	      		</tr>
	      		<tr>
	      			<td>알레르기 유발물질</td>
	      			<td>
	      				<input type="checkbox" name="maler" value="1">1
	      				<input type="checkbox" name="maler" value="2">2
	      				<input type="checkbox" name="maler" value="3">3
	      				<input type="checkbox" name="maler" value="4">4
	      				<input type="checkbox" name="maler" value="5">5
	      				<input type="checkbox" name="maler" value="6">6
	      			</td>
	      		</tr>
	      		<tr>
	      			<td>가격</td>
	      			<td><input type="number" name="mprice"></td>
	      		</tr>
	      	</table>
	      	<div style="text-align: right;">
		      	<input type="button" value="추가하기" id="addMenuBtn">
	      	</div>
      	</form>
      </div>
    </div>
	<script type="text/javascript"> //기본값 불러오기
		(function() {
			
			var storeCategory = '${store.scate}';
			var categories = $("select[name='scate'] option")
			var sdepo = '${store.sdepo}';
			if ('${store.sdeli}' == '0') {
				$("#depoInput").attr("disabled", true);
				$("#depoInput").val("");
				$("#deposit").attr("disabled", true);
				$("#noDeposit").attr("checked", true);
			}
			
			//배달 유무
			if ('${store.sdeli}' == '0') {
				$("input[name='sdeli']")[1].setAttribute("checked", true);
			}
			for (var i = 0; i < categories.length; i++) {
				if (categories[i].value == storeCategory) {
					categories[i].setAttribute("selected", true);
				}
			}
			
			//영업 시간
			if ('${store.openHour}' != '') {
				var openHour = '${store.openHour}';
				var list = openHour.split(" ");
				console.log(list);
				$('select[name="openHour"]').val(list[0]).attr("selected","selected");
				$('select[name="closeHour"]').val(list[2]).attr("selected","selected");
				
			}
			
			var dayOff = '${store.dayOff}'; // 값 ex) 월요일 일요일
			console.log(dayOff.split(","));
			for (var day of dayOff.split(",")) {
				switch (day) {
				case "월요일":
					$(".dayOff td[data-day='1']").addClass("dayClicked");
					break;
				case "화요일":
					$(".dayOff td[data-day='2']").addClass("dayClicked");
					break;
				case "수요일":
					$(".dayOff td[data-day='3']").addClass("dayClicked");
					break;
				case "목요일":
					$(".dayOff td[data-day='4']").addClass("dayClicked");
					break;
				case "금요일":
					$(".dayOff td[data-day='5']").addClass("dayClicked");
					break;
				case "토요일":
					$(".dayOff td[data-day='6']").addClass("dayClicked");
					break;
				case "일요일":
					$(".dayOff td[data-day='0']").addClass("dayClicked");
					break;
				default:
					break;
				}
			}
			
			
			
			
		})();
	
	
	
	</script>
	
	<script type="text/javascript"> /* modal 및 메뉴 추가 비동기로 */
	var menuForm = $("#myModal form")[0];
	
		
        var modal = document.getElementById('myModal');
        var btn = $("#modalOpenBtn")[0];
 
        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];                                          
 
        // modalopen버튼
        btn.onclick = function() {
            modal.style.display = "block";
        }
 
        // 모달 x 버튼
 		function modalClose() {
            modal.style.display = "none";
            menuForm.reset();
		}
        // 모달창 밖 클릭 시 닫힘
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
                menuForm.reset();
            }
        }
		
        
        //메뉴 추가하기 버튼
		$("#addMenuBtn").on("click", function() {
			
			if (menuForm.mname.value == '') {
				alert("메뉴명을 입력해야합니다.");
				return;
			}
			if (menuForm.mcate.value == 0) {
				alert(2);
				return;
			}
			
			
			var selectedAlrg = "";
			for (var sel of menuForm.maler) {
				if (sel.checked) {
					selectedAlrg += sel.value+",";
				}
			}
			selectedAlrg = selectedAlrg.substring(0, selectedAlrg.length-1);
			
			menuService.add({
				mname : menuForm.mname.value,
				mcate : menuForm.mcate.value,
				maler : selectedAlrg,
				mprice : menuForm.mprice.value 
			}, function() {
				alert("good");
			})
			
			modal.style.display = "none";
			alert("추가되었습니다.");
			menuForm.reset();
		});
        
        
        //메뉴 삭제
        $(function() {
	        $("#menuContainer ul").on("click", "input[type='button']", function() {
				
				console.log($(this).closest("li").text());
				for (var i = 0; i < menuList.length; i++) {
					if (menuList[i].mname == $(this).closest("li").text()) { //해당 요소 데이터 삭제 및 목록에서 삭제
						menuList.splice(i,1);
						$(this).closest("li").remove();
					}
				}
			});
		});
        
        
        
        
        
		
</script>
<script type="text/javascript">	// 파일 업로드 스크립트
	var files = [];
	var deleteTarget = [];
	//파일 ajax를 통해 저장하는 함수
	function sendFile(files, submit) {
		var formData = new FormData();
		for (var file of files) {
			formData.append('uploadImgs', file);
		}
		
		$.ajax({
		      type: "post",
		      url: "/store/uploadStoreImg",
		      data: formData,
		      dataType : 'json',
		      contentType : false,	//formData 전달 시 contentType과 processData는 false 설정
		      processData : false,
		      success: function (result, status, xhr) {
					var fileInput = '';
		    	  	for (var i = 0; i < result.length; i++) {
						fileInput += '<input type="hidden" name="imgList['+i+'].uuid" value="'+result[i].uuid+'" />';
						fileInput += '<input type="hidden" name="imgList['+i+'].uploadPath" value="'+result[i].uploadPath+'" />';
						fileInput += '<input type="hidden" name="imgList['+i+'].fileName" value="'+result[i].fileName+'" />';
					}
					$("#regForm").append(fileInput);
					submit();
		      }
		}); 
		
	}
	
	$(function() {
		// input=file 변경 시 fileInputChange() 함수 실행
		$("input[type='file']").change(function() {
			fileInputChange();
		});
		
		var regex = new RegExp("(.*?)\.(png|jpg|gif)$"); //파일타입 정규식
		var maxSize = 31457280; //파일 최대크기 (단위 : byte) 약 30MB
		var copy = $("input[name='uploadImgs']").clone();
		var names;
		//파일 체크 함수
		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("30MB 이하의 이미지만 업로드 가능합니다.");
				return false;
			}
			if (!regex.test(fileName)) {
				alert("jpg,png,gif 형식의 파일만 업로드 가능합니다.");
				return false;
			}
			
			return true;
		}
		
		//이미지 파일 files에 등록하는 부분
		function fileInputChange() {
			
			var inputFile = $("input[name='uploadImgs']");
			for (var file of inputFile[0].files) {
				if (checkExtension(file.name, file.size)) {
					files.push(file);
				}else{
					return false;
				}
			}
			
			fileThumbnails(inputFile[0].files);
			console.log(files);
			//썸네일 보여주기(업로드하려는 파일 시각화)
			function fileThumbnails(files) {
				 for (var image of files) {
			          var reader = new FileReader();
			          reader.fileName = image.name;
			          reader.onload = function(event) {
					      var img = document.createElement("img");
					      var imgBox = $('<div class="imgBox"></div>');
					      var btn = $('<button class="imgBtn">x</button>');
					      img.setAttribute("data-name", event.target.fileName);
				          img.setAttribute("src", event.target.result);
				          img.classList.add('thumbnail');
				          imgBox.append(img);
				          imgBox.append(btn);
					      $("#imgContainer").append(imgBox);
			          };

			          reader.readAsDataURL(image);
			        }
			}
			
		}
		
		//썸네일에 있는 삭제버튼 >> 해당 썸네일에 해당하는 파일을 files에서 지워줌 + 썸네일 제거
		$("#imgContainer").on("click", "button", function() {
			
			console.log($(this).closest("div").find("img").data("name"));
			
			//기존의 파일
			if ($(this).closest("div").find("img").data("type") == 'local') {
				alert("기존 파일입니다.");
				
				//기존 파일 삭제
				var fName  = $(this).closest("div").find("img").data("name");
				var uuid  = $(this).closest("div").find("img").data("uuid");
				var path = $(this).closest("div").find("img").data("path");
				var imgNo = $(this).closest("div").find("img").data("inumber");
				deleteTarget.push({uuid : uuid,
									uploadPath : path,
									sino : imgNo,
									fileName : fName});
				console.log(deleteTarget);
				$(this).closest("div").remove();
				
				
				
			}else{	//추가 이미지 파일
				// submit할 배열에서 제거
				for (var i = 0; i < files.length; i++) {
					if (files[i].name == $(this).closest("div").find("img").data("name")) {
						files.splice(i,1);
						$(this).closest("div").remove();
						console.log(files);
						return;
					}
				}
				
			}
			
		});
		
		
		
	});
</script>
</body>
</html>