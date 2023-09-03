<!DOCTYPE html><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../testHeader.jsp" %>

<section id="register" class="cta" style="margin-top: 35px;">
	<div class="container">
		<div class="row">
			<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<h3 style="text-align: center; font-weight: 500;">매장정보 수정</h3>
				<div class="border-top border-dark py-3"></div>
				<form action="#" id="regForm" method="post" novalidate>
					<div class="mb-3 row">
					    <label for="snameInput" class="col-sm-2 col-form-label">매장명<span style="color: red; font-size: 7px;">*</span></label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control" id="snameInput" name="sname" readonly="readonly" value="${store.sname }">
					      <div class="invalid-feedback">매장명을 입력해주세요.</div>
					    </div>
					  </div>
					<div class="mb-3 row">
						<label for="saddrInput" class="col-sm-2 col-form-label">주소<span style="color: red; font-size: 7px;">*</span></label>
						<div class="col-10">
						    <label for="saddrInput" class="visually-hidden"></label>
						    <input type="text" class="form-control" id="saddrInput" readonly="readonly" name="addr" value="${store.saddress }">
						    <div class="invalid-feedback">주소를 입력해주세요.</div>
						</div>
					</div>
					<div class="mb-3 row">
					    <label for="sphoneInput" class="col-sm-2 col-form-label">전화번호<span style="color: red; font-size: 7px;">*</span></label>
					    <div class="col-auto">
					      <input type="text" class="form-control" id="sphoneInput" name="sphone" required value="${store.sphone }">
					      <div class="invalid-feedback">전화번호를 입력해주세요.</div>
					    </div>
					    <div class="col-auto">
					    	<span style="font-size: 12px; color: gray;">하이픈 없이 입력</span>
					    </div>
					  </div>
					<div class="row mb-3">
						<div class="col-sm-2">
							<label for="scateInput" class="visually-hidden"></label>
						    <input type="text" readonly class="form-control-plaintext" id="scateInput" value="카테고리">
						</div>
						<div class="col-sm-2">
							<select class="form-select" aria-label="Default select example" name="scate" style="width: auto;">
							  <option value="한식">한식</option>
							  <option value="중식">중식</option>
							  <option value="양식">양식</option>
							  <option value="일식">일식</option>
							  <option value="아시아">아시아</option>
							</select>
						</div>
						<div class="col-auto"></div>
					</div>
					
					
					<div class="row mb-3">
						<div class="col-2">
							휴무
						</div>
						<div class="col-auto">
							<div class="input-group dayOff">
								<input class="btn-check" type="checkbox" id="monday" autocomplete="off" value="1">
								<label class="btn btn-outline-secondary" for="monday">월요일</label> 
								<input class="btn-check" type="checkbox" id="tuesday" autocomplete="off" value="2">
								<label class="btn btn-outline-secondary" for="tuesday">화요일</label> 
								<input class="btn-check" type="checkbox" id="wednesday" autocomplete="off" value="3">
								<label class="btn btn-outline-secondary" for="wednesday">수요일</label>
								<input class="btn-check" type="checkbox" id="thursday" autocomplete="off" value="4">
								<label class="btn btn-outline-secondary" for="thursday">목요일</label>
								<input class="btn-check" type="checkbox" id="friday" autocomplete="off" value="5">
								<label class="btn btn-outline-secondary" for="friday">금요일</label>
								<input class="btn-check" type="checkbox" id="saturday" autocomplete="off" value="6">
								<label class="btn btn-outline-secondary" for="saturday">토요일</label>
								<input class="btn-check" type="checkbox" id="sunday" autocomplete="off" value="0">
								<label class="btn btn-outline-secondary" for="sunday">일요일</label>
								<input class="btn-check"> <!-- 의미 x  -->
							</div>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-2">영업시간<span style="color: red; font-size: 7px;">*</span></div>
						<div class="col-auto">
							<select class="form-select" aria-label="Default select example" name="openHour">
								  <c:forEach var="num" begin="0" end="23">
									<option value="${num }:00">${num }:00</option>
									<option value="${num }:10">${num }:10</option>
									<option value="${num }:20">${num }:20</option>
									<option value="${num }:30">${num }:30</option>
									<option value="${num }:40">${num }:40</option>
									<option value="${num }:50">${num }:50</option>
								  </c:forEach>
							</select>
						</div>
						<div class="col-auto">
							<span style="font-weight: 500;">~</span>
						</div>
						<div class="col-auto">
							<select class="form-select" aria-label="Default select example" name="closeHour">
								  <c:forEach var="num" begin="0" end="23">
									<option value="${num }:00">${num }:00</option>
									<option value="${num }:10">${num }:10</option>
									<option value="${num }:20">${num }:20</option>
									<option value="${num }:30">${num }:30</option>
									<option value="${num }:40">${num }:40</option>
									<option value="${num }:50">${num }:50</option>
								  </c:forEach>
							</select>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-2">사업자등록번호<span style="color: red; font-size: 7px;">*</span></div>
						<div class="col-auto">
							<input type="text" class="form-control" name="scrn" required value="${store.scrn }">
							<div class="invalid-feedback">사업자등록번호를 입력해주세요.</div>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-2">
							예약 가능 인원
						</div>
						<div class="col-auto">
							<div class="input-group mb-3">
							  <button class="btn btn-outline-secondary downBtn" type="button">-</button>
							  <input class="btn-check" type="checkbox" name="smaxreserve" id="smaxInput" autocomplete="off" disabled="disabled">
							  <label class="btn btn-outline-secondary" for="smaxInput" id="reserveValue">0</label> 
							  <button class="btn btn-outline-secondary upBtn" type="button">+</button>
							</div>
						</div>
						<div class="col-auto">
							<span style="font-size: 12px; color: gray;">예약 불가능한 경우에는 0명 설정</span>
						</div>
					</div>
					<div class="row mb-3 depositRow" style="display: none;">
						<div class="col-2">예약금</div>
						<div class="col-auto">
							<input type="text" class="form-control" name="sdepo" id="depoInput" readonly="readonly" required>
							<input type="range" name="deposit" id="depoYes" value="1" min="0" max="100000" step="1000" style="width: -webkit-fill-available">
							<div class="invalid-feedback">예약금을 입력해주세요.</div>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-2">배달</div>
						<div class="col-auto">
							<input type="radio" class="form-check-input" name="sdeli" id="deliYes" value="1">
							<label class="form-check-label" for="deliYes">
							    y
							</label>
							<input type="radio" class="form-check-input" name="sdeli" value="0" id="deliNo" checked="checked">
							<label class="form-check-label" for="deliNo">
							    n
							</label>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-2">이미지<span style="color: red; font-size: 7px;">*</span></div>
						<div class="col-auto">
							<input class="form-control" type="file" multiple name="uploadImgs" required>
							<div class="invalid-feedback">1개 이상의 이미지를 등록해주세요.</div>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-12" id="imgContainer">
							<c:forEach var="img" items="${store.imgList }">
								<div class="imgBox">
									<img alt="1" src="/images/${img.uuid }_${img.fileName}" class="thumbnail"
									 data-name="${img.fileName }" data-type="local" data-inumber="${img.sino }"
									 data-path="${img.uploadPath }" data-uuid="${img.uuid }">
									<button class="imgBtn">x</button>
								</div>
							</c:forEach>
							<div id="newImgs" style="display: inline-block;"></div>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-1">메뉴</div>
						<div class="btn-group btn-group-sm col-1" role="group">
						  <button type="button" class="btn btn-outline-dark" id="menuAddBtn" data-bs-toggle="modal" data-bs-target="#menuModal">+</button>
						</div>
					</div>
					<div id="menuContainer"></div>
					<div id="btnBox" style="text-align: right;">
						<button type="button" class="btn btn-dark" data-cmd="back">뒤로가기</button>
						<button type="button" class="btn btn-dark" data-cmd="reg">수정하기</button>
					</div>
					<input type="hidden" value="${store.sno }" name="sno">
					<input type="hidden" value="${store.uno }" name="uno">
				</form>
			</div>
			<div class="col-lg-2">
				<div id="mapContainer" style="width: 300px; height: 200px; margin-top: 70px;"></div>
			</div>
		</div>
	</div>
</section>


			<!-- 메뉴 모달  -->
			<div class="reply-form modal modal-sheet" id="menuModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"><!-- 숨겼다가 모달로 사용  -->
                <div class="modal-dialog modal-dialog-centered">
                	<div class="modal-content p-3">
                		<div>
	                		<h4 style="float: left;">메뉴 등록</h4>
	                		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="float: right;"></button>
                		</div><br>
		                <form action="#" method="post">
		                  <div class="row mb-2">
		                  	<div class="col-2 form-group">메뉴명</div>
		                    <div class="col-auto form-group">
		                      <input name="mname" type="text" class="form-control" >
		                    </div>
		                  </div>
		                  <div class="row mb-2">
		                  	<div class="col-2 form-group">분류</div>
		                    <div class="col-auto form-group">
		                      <input name="mcate" type="text" class="form-control" >
		                    </div>
		                  </div>
		                  <div class="row mb-2">
		                  	<div class="col-2 form-group">가격</div>
		                    <div class="col-auto form-group">
		                      <input name="mprice" type="text" class="form-control" >
		                    </div>
		                  </div>
		                  <div class="row mb-2">
		                  	<div class="col">알레르기 유발물질</div>
		                  </div>
		                  <div class="row mb-2">
		                  	<div class="col-auto">
		                  		<input class="btn-check" type="checkbox" name="maler" id="aler1" autocomplete="off" value="갑각류">
								<label class="btn btn-outline-warning" for="aler1">갑각류</label> 
		                  		<input class="btn-check" type="checkbox" name="maler" id="aler2" autocomplete="off" value="달걀">
								<label class="btn btn-outline-warning" for="aler2">달걀</label> 
		                  		<input class="btn-check" type="checkbox" name="maler" id="aler3" autocomplete="off" value="견과류">
								<label class="btn btn-outline-warning" for="aler3">견과류</label> 
		                  		<input class="btn-check" type="checkbox" id="aleretc" autocomplete="off" value="">
								<label class="btn btn-outline-warning" for="aleretc">기타</label> 
								<div class="form-floating mt-2" style="display: none;" id="aleretcInput">
								  <textarea class="form-control" placeholder="직접 입력" id="floatingTextarea" style="resize: none;"></textarea>
								  <label for="floatingTextarea">기타 알레르기</label>
								</div>
		                  	</div>
		                  </div>
		                  <div style="text-align: right;">
			                  <button type="button" id="addMenuBtn" class="btn btn-dark">작성하기</button>
		                  </div>
		                </form>
                	</div>
                </div>
              </div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2f52d388244ff7c0c91379904a49a35&libraries=services"></script>
<script type="text/javascript" src="../resources/js/menuAjax.js"></script>
<script type="text/javascript">
var sno = '${store.sno}';
var deleteTarget = [];
	$(function() {
		menuService.getMenuList();
		
		//주소검색 버튼 이벤트
		$("#searchBtn").on("click" , function() {
			execPostcode();
		});
		//예약금
		$("input[name='deposit']").on("change", function() {
			$("#depoInput").val($(this).val());
			$("input[name='sdepo']").removeClass("is-invalid");
		});
		//예약 인원 조정 버튼
		$(".upBtn").click(function() {
			var value = $("#reserveValue").text();
			if (value == 0) {
				$(".depositRow").show();
			}
			$("#reserveValue").html(++value);
		});
		$(".downBtn").click(function() {
			var value = $("#reserveValue").text();
			if (value == 1) {
				$(".depositRow").hide();
				$("input[name='sdepo']").attr("disbaled", true);
				$("input[name='sdepo']").val("");
				$(".depositRow input[type='range']").val(0);
				
			}
			if (value > 0) {
				$("#reserveValue").html(--value);
			}
		});
		
		
		//regForm 제어
		$("form button").on("click", function() {
			var regForm = $("#regForm")[0];
			if ($(this).data("cmd") == 'reg') {	//등록 클릭 시
				
				
				
				
				// 공백 input 제어
				if (regForm.sname.value == '' || regForm.openHour.value == '' || regForm.closeHour.value == ''
						|| regForm.scrn.value == '' || regForm.sphone.value == '') {
					alert("필수입력항목을 작성해야합니다.");
					
					regForm.classList.add('was-validated');
					return;
				}
				
				if ($("#reserveValue").text() > 0 && regForm.sdepo.value == '') {
					alert("예약금을 입력해주세요.");
					$("input[name='sdepo']").addClass("is-invalid");
					return;
				}else{
					$("input[name='sdepo']").removeClass("is-invalid");
				}				
				
				
				$("#regForm").attr("method", "post");
				$("#regForm").attr("action", "/store/update");
				
				//메뉴데이터
				var menuInput = '';
				for (var i = 0; i < menuList.length; i++) {
					menuInput += '<input type="hidden" name="menuList['+i+'].mname" value="'+menuList[i].mname+'" />';
					menuInput += '<input type="hidden" name="menuList['+i+'].mcate" value="'+menuList[i].mcate+'" />';
					menuInput += '<input type="hidden" name="menuList['+i+'].maler" value="'+menuList[i].maler+'" />';
					menuInput += '<input type="hidden" name="menuList['+i+'].mprice" value="'+menuList[i].mprice+'" />';
					
				}
				
				//기존 파일
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
				
				
				sendFile(files, function() {
					var dayInput = '';
					for (var i = 0; i < $(".dayOff input").length; i++) {
						if ($(".dayOff input")[i].checked) {
							dayInput += $(".dayOff input")[i].value;
						}
					}
					$("#regForm").append('<input type="hidden" name="dayOff" value="'+dayInput+'"/>'); 
					$("#regForm").append('<input type="hidden" name="smaxreserv" value="'+$("#reserveValue").text()+'"/>');
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
		
		var regex = new RegExp("(.*?)\.(PNG|jpg|gif)$"); //파일타입 정규식
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
				 $("#newImgs").empty();
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
					      $("#newImgs").append(imgBox);
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
<script type="text/javascript"> /* 메뉴 관련 */
	var menuForm = $("#menuModal form")[0];
	var menuModal = new bootstrap.Modal('#menuModal', {
		  focus: false
		})
	
	//메뉴 + 버튼
	$("#menuAddBtn").click(function() {
		menuModal.show();
		$("#menuModal form")[0].reset();
		$("#aleretcInput").hide();
	});
	
	$("#aleretc").click(function() {
		console.log($(this));
		if ($(this)[0].checked) {
			$("#aleretcInput").show();
		}else{
			$("#aleretcInput").hide();
			$("#floatingTextarea").val("");
		}
	});
	
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
		selectedAlrg += $("#floatingTextarea").val();
		if ($("#floatingTextarea").val() == '') {
			selectedAlrg = selectedAlrg.substring(0, selectedAlrg.length-1);
		}
		
		menuService.add({
			mname : menuForm.mname.value,
			mcate : menuForm.mcate.value,
			maler : selectedAlrg,
			mprice : menuForm.mprice.value
		}, function() {
			alert("good");
		})
		
		alert("추가되었습니다.");
		menuForm.reset();
		menuModal.hide();
		
	});
	
	//메뉴 삭제
    $(function() {
        $("#menuContainer").on("click", "button[type='button']", function() {
			
			for (var i = 0; i < menuList.length; i++) {
				if (menuList[i].mname == $(this).closest(".row").find(".col-2").text()) { //해당 요소 데이터 삭제 및 목록에서 삭제
					menuList.splice(i,1);
					$(this).closest(".row").remove();
				}
			}
		});
	});
	
</script>
<script type="text/javascript"> //기본값 불러오기
		(function() {
			
			var storeCategory = '${store.scate}';
			var categories = $("select[name='scate'] option")
			
			//배달 유무
			if ('${store.sdeli}' == '1') {
				$("input[name='sdeli']")[0].setAttribute("checked", true);
			}
			
			//카테고리 선택
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
			
			
			
			
			var dayOff = '${store.dayOff}'; //값 형태 : 월요일,화요일, ... 
			console.log(dayOff.split(","));
			for (var day of dayOff.split(",")) {
				switch (day) {
				case "월요일":
					$(".dayOff input[value='1']").attr("checked", true);
					break;
				case "화요일":
					$(".dayOff input[value='2']").attr("checked", true);
					break;
				case "수요일":
					$(".dayOff input[value='3']").attr("checked", true);
					break;
				case "목요일":
					$(".dayOff input[value='4']").attr("checked", true);
					break;
				case "금요일":
					$(".dayOff input[value='5']").attr("checked", true);
					break;
				case "토요일":
					$(".dayOff input[value='6']").attr("checked", true);
					break;
				case "일요일":
					$(".dayOff input[value='0']").attr("checked", true);
					break;
				default:
					break;
				}
			}
			
			
			
			
		})();
	
	
	
</script>
<%@ include file="../testFooter.jsp"%>