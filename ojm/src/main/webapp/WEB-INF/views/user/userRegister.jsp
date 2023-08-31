<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
	img{
		width: 50px;
	}
	textarea {
		width: 300px;
		height: 6.25em;
		resize: none;
	}
</style>
</head>
<jsp:include page="../testHeader.jsp"></jsp:include>
<body>
	<form action="" method="post">
		id<input type="text" name="userid" id="userid">
		<input type="button" value="중복확인" onclick="idCheck()"><br>
		
		pw<input type="password" name="userpw" id="userpw"><br>
		pw확인<input type="password" id="userpw2"><b id="pwchecked"></b><br>
		이름<input type="text" name="username"><br>
		생일<input type="text" name="userbirth" placeholder="생년월일 6자리" maxlength="6"><br>
		번호<input type="text" name="userphone"><br>
		이메일<input type="text" name="useremail"><br>
		닉네임<input type="text" name="nickname"><br>
		주소<input type="text" name="uaddress" readonly="readonly" onclick="findAddr()"><br>
		성별
		<input type="radio" value="male" name="ugender" checked="checked">남
		<input type="radio" value="female" name="ugender">여<br>
		광고여부	<input type="checkbox" value="sms" name="uads">sms
				<input type="checkbox" value="mail" name="uads">e-mail<br>
				<input type="checkbox" value=" " name="uads" hidden="hidden" checked="checked">
				
		알러지	<input type='checkbox' name='ualer' value='aler1' />갑각류
				<input type='checkbox' name='ualer' value='aler2' />견과
				<input type='checkbox' name='ualer' value='aler3' />달걀
				<input type='checkbox' name='ualer' value=' ' hidden="hidden" checked="checked"/>
		<br>
		<input type='checkbox' name='ualer' value='ualeretc' id="ualeretc"/>기타
		<br>
		<textarea rows="3" cols="10" id="etc" name="ualeretc" placeholder="기타 알레르기 직접 입력" disabled="disabled"></textarea>
		<br>
		관심 음식 카테고리	<input type='checkbox' name='ufavor' value='favor1' />한식
				<input type='checkbox' name='ufavor' value='favor2' />양식
				<input type='checkbox' name='ufavor' value='favor3' />중식
				<input type='checkbox' name='ufavor' value='' hidden="hidden" checked="checked"/>
		<br>
		프로필 이미지 선택 <br>
		<div id="divImg">
			<img src="/resources/img/profile/man.png" data-img="man">
			<img src="/resources/img/profile/woman.png" data-img="woman">
			<img src="/resources/img/profile/go.png" data-img="go">
		</div>	
		<br>
		
		
		<input type="button" value="회원가입" id="regBtn" onclick="check(this.form)">
		<input type="reset" value="다시입력">
		<input type="button" value="홈으로" id="homeBtn">
		
		
		<input type="hidden" name="uploadpath" value="resources/img/profile">
		<input type="hidden" name="filename" value="man.png">
		
		<input type="hidden" name="ulikestore" value="">
	</form>
</body>
<jsp:include page="../testFooter.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	
	var idChecked = false;
	
	function check(f){	// 빈칸 체크
		
		if(f.userid.value==''){
			alert("아이디를 입력해주세요.");
			return;
		}else if(!idChecked){
			alert("중복 확인을 해주세요.");
			return;
		}else if(f.userpw.value==''){
			alert("비밀번호를 입력해주세요.");
			return;
		}else if($("#userpw2").val()==''){
			alert("비밀번호를 확인해주세요.");
			return;
		}else if(f.username.value==''){
			alert("이름을 입력해주세요.");
			return;
		}else if(f.userbirth.value==''){
			alert("생년월일을 입력해주세요.");
			return;
		}else if(!checkBirth(f.userbirth.value)){
			alert("올바른 생년월일을 입력해주세요.");
			return;
		}else if(f.userphone.value==''){
			alert("번호를 입력해주세요.");
			return;
		}else if(!checkPhone(f.userphone.value)){
			alert("번호를 확인해주세요.");
			return;
		}else if(f.useremail.value==''){
			alert("이메일를 입력해주세요.");
			return;
		}else if(f.nickname.value==''){
			alert("닉네임를 입력해주세요.");
			return;
		}else if(!checkEmail(f.useremail.value)){
			alert("올바른 메일 주소를 입력해주세요.");
			return;
		}else if(f.uaddress.value==''){
			alert("주소를 입력해주세요.");
			return;
		}
		f.action="regUser";
		f.submit();
	}
	
	$("#homeBtn").on("click",function(){
		location.href="/";
	});
	
	$('#userpw2').focusout(function() {
		if($(this).val()==$("#userpw").val()){
			$("#pwchecked").html("");
		}else{
			$("#pwchecked").html("비밀번호를 확인해주십시오");
		}
	});
	
	// 기타 알러지 입력 제어
	$("#ualeretc").on("change",function(){
		var check = $('#etc').attr("disabled");
		if(check!=null){
			$('#etc').removeAttr("disabled");
		}else{
			$('#etc').attr("disabled",'disabled');
			$('#etc').val('');
		}
	})
	
	function idCheck(){	// id 중복체크
		var userid = $("#userid").val();
		console.log(userid);
		if(userid==''){
			alert("아이디를 입력해주세요.");
			return;
		}
		
		$.ajax({	
	      	type : 'get',
	     	url : 'userIdCheck',
	      	data: {userid:userid},
	     	success : function(){ 
	     		alert("가입 가능한 아이디입니다")
	     		idChecked=true;
	      	},
	      	error : function(result){
	      		console.log(result.responseText);
	      		alert("중복된 아이디입니다.")
	      		idChecked=false;
	      	}
		});
	}
	
	// 이미지 선택 이벤트
	$("img").on("click",function(){
		// 이미지 경로,이름 추가
		var imgName=$(this).data("img")+".png";
		console.log(imgName);
		$("input[name=filename]").val(imgName);
		
		// 이미지 div 변경
		$("#divImg").html($(this));	// 숨겨놓았다가 선택시 특정 부분으로 넣어주는 게 더 좋을듯.
	});
	
	// 유효성 검사용
	function checkEmail(email) {
		var ex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return ex.test(email);
	}
	function checkPhone(phone){
		var ex = /^(010|011|016|017|018|019)([0-9]{3,4}[0-9]{4})$/;
		return ex.test(phone);
	}
	function checkBirth(birth){
		var ex = /^([0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
		return ex.test(birth);
	}
	
	
	function findAddr(){		// 주소 찾기 
		new daum.Postcode({
	        oncomplete: function(data) {
	        	
	        	console.log(data);
	        	
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var jibunAddr = data.jibunAddress; // 지번 주소 변수
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            if(roadAddr !== ''){
	                document.getElementsByName("uaddress")[0].value = roadAddr;
	            } 
	            else if(jibunAddr !== ''){
	                document.getElementsByName("uaddress")[0].value = jibunAddr;
	            }
	        }
	    }).open();
	}


</script>

</html>