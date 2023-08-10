<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div{
		text-align: center;
	}
	input[name="smaxreserv"]{
		display: none;
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
	
	
	
	.thumbnail{
		width: 100px;
		background-size: contain;
	}
	#wrapper{
		border: 1px solid black;
		width: 800px;
		margin: auto;
	}
	#storeTable{
		width: -webkit-fill-available;
		text-align: left;
	}
	#menuTable{
		width: fit-content;
		text-align: left;
		
	}
	#mapContainer{
		display: none;
	}
	#menuContainer li{
		text-align: left;
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
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2f52d388244ff7c0c91379904a49a35&libraries=services"></script>
<script type="text/javascript" src="../resources/js/menuAjax.js"></script>
<script type="text/javascript">
	$(function() {
		
		
		
		//주소검색 버튼 이벤트
		$("#searchBtn").on("click" , function() {
			execPostcode();
		});
		
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
		
		//예약 가능 ox
		$("input[name='checkReserv']").on("change", function() {
			console.log($(this)[0].checked);
			if ($(this)[0].checked) {
				$("input[name=smaxreserv]").show();
			}else{
				$("input[name=smaxreserv]").hide();
				$("input[name=smaxreserv]").attr("disabled", true);
				
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
				$("#regForm").attr("action", "/store/register");
				
				var menuInput = '';
				for (var i = 0; i < menuList.length; i++) {
					menuInput += '<input type="hidden" name="menuList['+i+'].mname" value="'+menuList[i].mname+'" />';
					menuInput += '<input type="hidden" name="menuList['+i+'].mcate" value="'+menuList[i].mcate+'" />';
					menuInput += '<input type="hidden" name="menuList['+i+'].maler" value="'+menuList[i].maler+'" />';
					menuInput += '<input type="hidden" name="menuList['+i+'].mprice" value="'+menuList[i].mprice+'" />';
				}
				
				
				sendFile(files, function() {
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
					$("#regForm").append(menuInput);
					$("#regForm").submit();
				});
				
				
			}else if ($(this).data("cmd") == 'back') {	// 뒤로가기 클릭 시 
				location.href='/';
			} 
		});
		
		
		
	});
	
	
	
	//주소 검색
	function execPostcode() {
		new daum.Postcode({
			oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                
                } else {
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $("input[name='addr']").val(addr);
                
                
              	//map
              	$("#mapContainer").show();
        		var mapContainer = $("#mapContainer")[0];
        		var options = { //지도를 생성할 때 필요한 기본 옵션
        				center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
        				level: 5 //지도의 레벨(확대, 축소 정도)
        			};

        		var map = new kakao.maps.Map(mapContainer, options); //지도 생성 및 객체 리턴
        		// 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
        		map.setDraggable(false);
                
                
                // 주소-좌표 변환 객체를 생성합니다
                var geocoder = new kakao.maps.services.Geocoder();
                
                geocoder.addressSearch(addr, function(result, status) {
					
                	if (status === kakao.maps.services.Status.OK) {
                		var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                		// 결과값으로 받은 위치를 마커로 표시합니다
                        var marker = new kakao.maps.Marker({
                            map: map,
                            position: coords
                        });
                		map.setCenter(coords);
                		
                		var kd = '<input type="hidden" name="kd" value="'+result[0].y+'">'
                		var wd = '<input type="hidden" name="wd" value="'+result[0].x+'">'
                		$("#regForm").append(kd);
                		$("#regForm").append(wd);
					}else{
						alert("지도 오류");
					}
                	
				});
	
               	
            
                        

                
                
            },
            onclose: function(state) {
                //state는 우편번호 찾기 화면이 어떻게 닫혔는지에 대한 상태 변수 이며, 상세 설명은 아래 목록에서 확인하실 수 있습니다.
                if(state === 'FORCE_CLOSE'){
					alert("주소 선택 안함.");
                } else if(state === 'COMPLETE_CLOSE'){
                	// 커서를 상세주소 필드로 이동한다.
                    $("input[name='addrDet']").focus();
                }
            }
		}).open();
	}
	
	

</script>
</head>
<body>
	<!-- 로그인 확인  -->
	<sec:authorize access="isAnonymous()">
		<script type="text/javascript">
			alert("로그인이 필요한 서비스입니다.");
			location.href='/user/login';
		</script>
	</sec:authorize>
	
	
	<div id="wrapper">
		<h2>register</h2>
		<form action="#" id="regForm" method="post">
			<table id="storeTable">
				<tr>
					<td>가게명</td>
					<td><input type="text" name="sname"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" readonly="readonly">&nbsp;&nbsp;<button type="button" id="searchBtn">주소 검색</button></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="text" name="addrDet" placeholder="상세 주소"></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="sphone"></td>
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
					<td>예약<input type="checkbox" value="1" name="checkReserv"></td>
					<td>
						<input type="number" name="smaxreserv" placeholder="예약 최대 가능 인원" value="0">
					</td>
				</tr>
				<tr>
					<td>휴무</td>
					<td>
						<table class="dayOff">
							<tr>
								<td>월</td>
								<td>화</td>
								<td>수</td>
								<td>목</td>
								<td>금</td>
								<td>토</td>
								<td>일</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>영업시간</td>
					<td><input type="text" name="openHour"> ~ <input type="number" name="closeHour"></td>
				</tr>
				<tr>
					<td>사업자등록번호</td>
					<td><input type="text" name="scrn"></td>
				</tr>
				<tr>
					<td>예약금</td>
					<td><input type="number" name="sdepo" id="depoInput" readonly="readonly">&nbsp;예약금 없음<input type="checkbox" name="sdepo" value="0" id="noDeposit"></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="range" id="deposit" name="deposit" min="0" max="100000" step="1000" value="0">
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
						<input type="reset" value="다시 작성">
						<input type="button" value="메인으로" data-cmd="back">
					</td>
				</tr>
			</table>
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

</body>
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
		}
        // 모달창 밖 클릭 시 닫힘
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
		
        
        //메뉴 추가하기 버튼
		$("#addMenuBtn").on("click", function() {
			
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
			fileThumbnails(files);
			 
			//썸네일 보여주기(업로드하려는 파일 시각화)
			function fileThumbnails(files) {
				 $("#imgContainer").empty();
				 for (var image of files) {
			          var reader = new FileReader();
			          reader.fileName = image.name;
			          reader.onload = function(event) {
					      var img = document.createElement("img");
					      var imgBox = $('<div class="imgBox"></div>');
					      var btn = $('<button class="imgBtn">x</button>');
					      img.setAttribute("data-name", event.target.fileName);
					      console.log(event);
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
			
			for (var i = 0; i < files.length; i++) {
				if (files[i].name == $(this).closest("div").find("img").data("name")) {
					files.splice(i,1);
					$(this).closest("div").remove();
					console.log(files);
					return;
					
				}
			}
			  
		});
		
		
		// 파일 삭제 버튼 클릭 이벤트 
		$(".uploadResult ul").on("click", "button", function() {
			var targetFile = $(this).data("file");
			var targetLi = $(this).closest("li");
			
			
			$.ajax({
			      type: "post",
			      url: "/deleteFile",
			      data: {fileName : targetFile},
			      dataType : 'text',
			      success: function (result, status, xhr) {
			    	 	targetLi.remove();
			      }
			});
			 
			
		});
		
		
	});
</script>
</html>