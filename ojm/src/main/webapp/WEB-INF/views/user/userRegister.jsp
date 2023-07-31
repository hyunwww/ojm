<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form action="" method="post">
		id<input type="text" name="userid"><br>
		pw<input type="text" name="userpw" id="userpw"><br>
		pw확인<input type="text" id="userpw2"><b id="pwchecked"></b><br>
		이름<input type="text" name="username"><br>
		생일<input type="text" name="userbirth"><br>
		번호<input type="text" name="userphone"><br>
		이메일<input type="text" name="useremail"><br>
		닉네임<input type="text" name="nickname"><br>
		주소<input type="text" name="uaddress" readonly="readonly" onclick="findAddr()"><br>
		<!-- 주소찾기 api로 새 창에서 동작 후 채워줄 것 
			배달기능까지 추가한다면 상세주소까지.
		-->
		성별<br>
		<input type="radio" value="male" name="ugender">남
		<input type="radio" value="female" name="ugender">여<br>
		광고여부	<input type="checkbox" value="sms" name="uads">sms
				<input type="checkbox" value="mail" name="uads">e-mail<br>
				<input type="checkbox" value="" name="uads" hidden="hidden" checked="checked">
				
		알러지	<input type='checkbox' name='ualer' value='aler1' />갑각류
				<input type='checkbox' name='ualer' value='aler2' />견과
				<input type='checkbox' name='ualer' value='aler3' />달걀
				<input type='checkbox' name='ualer' value='' hidden="hidden" checked="checked"/>
				<br>
		<input type='checkbox' name='ualer' value='ualeretc' />
		<textarea rows="3" cols="10" name="ualeretc" placeholder="기타 알레르기 직접 입력"></textarea>
		<!-- aleretc가 체크되면 ualeretc를 submit할 거임 -->
		<br>
		관심 음식 카테고리	<input type='checkbox' name='ufavor' value='favor1' />한식
				<input type='checkbox' name='ufavor' value='favor2' />양식
				<input type='checkbox' name='ufavor' value='favor3' />중식
				<input type='checkbox' name='ufavor' value='' hidden="hidden" checked="checked"/>
				<br>
		
		
		
		<input type="button" value="회원가입" id="regBtn" onclick="check(this.form)">
		<input type="reset" value="다시입력">
		
		
		<input type="hidden" name="auth" value="user">
		<input type="hidden" name="ulikestore" value="">
		<input type="hidden" name="ulikejob" value="">
	</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	
	function check(f){	// 빈칸 체크
		
		// 체크박스 값 가져와서 문자열로 저장하기
		
/* 		alert(typeof("f.uads"))
		
		var uads = "";
		for(var ck of f.uads){
			if(ck.checked){
				uads+=ck.value + ",";
			}
		}
		uads = uads.slice(0, -1);	// 마지막 쉼표 제거
		
		var ufavor = "";
		for(var ck of f.ufavor){
			if(ck.checked){
				ufavor+=ck.value + ",";
			}
		}
		ufavor = ufavor.slice(0, -1);  */
		if(f.userid.value==''){
			alert("아이디를 입력해주세요.");
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
			alert("생일을 입력해주세요.");
			return;
		}else if(f.userphone.value==''){
			alert("번호를 입력해주세요.");
			return;
		}else if(f.useremail.value==''){
			alert("이메일를 입력해주세요.");
			return;
		}else if(f.uaddress.value==''){
			alert("주소를 입력해주세요.");
			return;
		}
		f.action="regUser";
		f.submit();
	}
	
	$('#userpw2').focusout(function() {
		if($(this).val()==$("#userpw").val()){
			$("#pwchecked").html("");
		}else{
			$("#pwchecked").html("비밀번호를 확인해주십시오");
		}
	});
	
	
	
	
	
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