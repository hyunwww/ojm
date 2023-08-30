<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.ojm.security.domain.CustomUser" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<style type="text/css">
	img{
		width: 50px;
	}
</style>
<script type="text/javascript">

</script>
</head>

<body>
<jsp:include page="../../testHeader.jsp"></jsp:include>
	<div id="content">
		<form action="" method="post">
			프로필 이미지 <br><img src="${imgRoot }"><br>	<!-- 수정도 가능하게 바꿔야함 -->
			id<input type="text" name="userid" value="${uvo.userid }" readonly="readonly"><br>
			pw<input type="password" name="userpw" id="userpw" ><br>
			pw확인<input type="password" id="userpw2"><b id="pwchecked"></b><br>
			이름<input type="text" name="username" value="${uvo.username }" readonly="readonly"><br>
			생일<input type="text" name="userbirth" value="${uvo.userbirth }" readonly="readonly"><br>
			번호<input type="text" name="userphone" value="${uvo.userphone }"><br>
			이메일<input type="text" name="useremail" value="${uvo.useremail }"><br>
			닉네임<input type="text" name="nickname" value="${uvo.info.nickname }" readonly="readonly"><br>
			주소<input type="text" name="uaddress" value="${uvo.info.uaddress }" readonly="readonly" onclick="findAddr()"><br>
			<!-- 주소찾기 api로 새 창에서 동작 후 채워줄 것 
				배달기능까지 추가한다면 상세주소까지.
			-->
			성별 : 
			<c:choose>
				<c:when test="${uvo.info.ugender eq 'male' }">
					남
				</c:when>
				<c:otherwise>
					여
				</c:otherwise>
			</c:choose>
			<br>
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
			<br>
			관심 음식 카테고리	<input type='checkbox' name='ufavor' value='favor1' />한식
					<input type='checkbox' name='ufavor' value='favor2' />양식
					<input type='checkbox' name='ufavor' value='favor3' />중식
					<input type='checkbox' name='ufavor' value='' hidden="hidden" checked="checked"/>
					<br>
			
			
			
			<input type="button" value="수정하기" id="modifyBtn" onclick="check(this.form)">
			<input type="button" value="홈으로" id="homeBtn" onclick="location.href='/'">
			
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>
	</div>
	<jsp:include page="myPageFooter.jsp"></jsp:include>
</body>
<jsp:include page="../../testFooter.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	
	function check(f){	// 빈칸 체크
		if(f.userpw.value==''){
			alert("비밀번호를 입력해주세요");
			return;
		}else if($("#userpw2").val()==''){
			alert("비밀번호를 확인해주세요");
			return;
		}
		
		var form1 = $("form").serialize();
		
		$.ajax({	
	      	type : 'post',
	     	url : 'modify',
	      	data: form1,
	      	dataType : 'text',
	     	success : function(result){ 
	     		alert(result);
	     		location.href='main';
	      	},
	      	error : function(result){
	      		alert("회원정보 수정에 실패했습니다.");
	      	}
		});
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