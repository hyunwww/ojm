<%@page import="org.ojm.security.domain.CustomUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%
   Authentication auth = SecurityContextHolder.getContext().getAuthentication();
      Object principal = auth.getPrincipal();
      
      try{
         pageContext.setAttribute("uvo", ((CustomUser)principal).getUvo()); 
      }catch(Exception e){
         pageContext.setAttribute("uvo", null);
      }
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript">
			var currentUno = "${uvo.uno}";
			if (currentUno == 0) {
				alert("로그인이 필요한 서비스입니다.");
				location.href='/';
			}
		</script>
	</head>
	<body>
		<h1>게시글 등록</h1>
		<hr>
		
		<form action="/board/register" method="post" role="form">
			<table>
				<tr>
					<td>제목</td>
					<td><input name="btitle" id="btitle"></td>
				</tr>
				<tr>
					<td>말머리</td>
					<td>
						<select name="bcate" id="bcate">
							<option value="none" selected disabled hidden>말머리 선택</option>
							<sec:authorize access="hasRole('ROLE_admin')">
								<option value="공지사항">공지사항</option>
							</sec:authorize>
							<option value="추천">추천</option>
							<option value="정보">정보</option>
							<option value="자유">자유</option>
							<option value="기타">기타</option>
						</select>							
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input name="bwriter" id="bwriter" value="${uvo.username }" readonly="readonly" style="background-color: #ccc"></td>
				</tr>
				<tr>  
					<td>내용</td>
					<td>
						<textarea rows="15" cols="100" name="bcontent" id="bcontent"></textarea>
					</td>
				</tr>
				<tr>
					<!-- 파일 첨부 -->
					<td>파일 첨부</td>
					<td class="uploadDiv">
						<input type="file" name="filename" multiple="multiple">
					</td>
					<td class = 'uploadResult'>
						<ul></ul>
					</td>
				</tr>
			</table>
			<hr>
			
			<button type="submit" data-oper="register">등록</button>
			<button type="reset" data-oper="reset">취소</button>
			<button type="submit" data-oper="list">목록</button>
			<input type="hidden" name="pageNum" value="${cri.pageNum }">
			<input type="hidden" name="amount" value="${cri.amount }">
			<input type="hidden" name="total" value="${total }">
			<input type="hidden" name="uno" value="${uvo.uno }">
		</form>

	</body>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		$(function(){
		var formObj = $("form");
		
		$("button").on('click', function(e){
			e.preventDefault();		// 동작 중단
			
			var operation = $(this).data("oper");
			
			if (operation === 'register') {
				if (document.getElementById("btitle").value=="") {
					alert("제목을 입력하세요.");
					return;
				}else if (document.getElementById("bcate").value=="none") {
					alert("카테고리를 선택하세요.")
					return;
				}else if (document.getElementById("bcontent").value=="") {
					alert("내용을 입력하세요.");
					return;
				}
				
				formObj.attr("action", '/board/register');
				
				var str = '';
				
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					
					// showUploadFile function의 li data~ 들
					str += '<input type="hidden" name="imgList['+i+'].filename" value="'+jobj.data('filename')+'"/>';
					str += '<input type="hidden" name="imgList['+i+'].uuid" value="'+jobj.data('uuid')+'"/>';
					str += '<input type="hidden" name="imgList['+i+'].uploadpath" value="'+jobj.data('path')+'"/>';
				});
				
				formObj.append(str);
				
				formObj.submit();
				
			}else if (operation === 'list') {
				formObj.attr("action", '/board/list');
				formObj.attr("method", 'get');
				
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var totalTag = $("input[name='total']").clone();
				
				formObj.empty();	// 해당 요소 내부 초기화
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(totalTag);
				formObj.submit();
			}else if(operation === 'reset'){
				formObj[0].reset();
				return;
			}
		});
	});
	</script>
	
	<!-- 파일 업로드 스크립트 -->
	<script type="text/javascript">
		$(function(){
			// input = file 변경시 fileInputChange() 함수 실행
			$("input[type='file']").on('change', function(){
				fileInputChange();
			});
			
			var regex = new RegExp("(.*?)\.(jpg|JSP|png|PNG|bmp|BMP|tiff|TIFF)$");	// 확장자 정규식
			var maxSize = 5242880;	// 5MB
			
			var cloneObj = $(".uploadDiv").clone();
			
			function checkExtension(filename, fileSize){
				if (fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				if (regex.test(filename) == false) {
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			}
			
			function fileInputChange(){
				$(".uploadResult ul").empty();
				var formData = new FormData();
				var inputFile = $("input[type='file']");
				var files = inputFile[0].files;
				
				for (var i = 0; i < files.length; i++) {
					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append('uploadFile', files[i]);
				}
				$.ajax({
					type : 'post',
					url : '/uploadAjaxAction',
					data : formData,
					contentType : false,
					processData : false,
					dataType : 'json',
					success : function(result){
						console.log(result);
						showUploadFile(result);
					}
				});
			}
			
			var uploadResult = $(".uploadResult ul");
			function showUploadFile(uploadResultArr){
				var str = '';
				
				for (var i = 0; i < uploadResultArr.length; i++) {
					
					// 인코딩
					var fileCallPath = encodeURIComponent(uploadResultArr[i].uploadpath + "/" + uploadResultArr[i].uuid + "_" + uploadResultArr[i].filename);
					
					str += '<li data-path="' + uploadResultArr[i].uploadpath + '" data-uuid="' + uploadResultArr[i].uuid + '" data-filename="' + uploadResultArr[i].filename + '">';
					str += '<div>';
					str += '<img alt="' + uploadResultArr[i].filename + '" src="/ojm/' + uploadResultArr[i].uploadpath + '/' + uploadResultArr[i].uuid + '_' + uploadResultArr[i].filename + '">';
					str += '<button type="button" data-file="' + fileCallPath + '" data-type="file" >삭제</button><br>';
					str += '</div>';
					str += '</li>';
				}
				uploadResult.html(str);
			}
			
			$("input[type='file']").on('click', function(){
		         // 다시 첨부 시 업로드 폴더에서 파일들 삭제하기  
		         // 임시 폴더 만들어서 글 작성 버튼 클릭 시 업로드, 임시폴더 삭제하는 로직으로다시 짜는 게 나을듯함.
		         $.each($(".uploadResult ul li"), function(i, li){
		            targetFile = $(this).find("button").data("file");
		         
		            $.ajax({
						type : 'post',
						url : '/deleteFile',
						data: {filename : targetFile},
						dataType : 'text',
		            });
		         });
		      });
			
			// 파일 삭제 버튼 클릭 이벤트
			// 위 button(X)에 클릭 이벤트 걸기
			// var targetFile = 눌려진 객체의 fileCallPath 값 갑져오기
			uploadResult.on('click', 'button', function(){
				var targetFile = $(this).data('file');
				var targetLi = $(this).closest("li");
				
				$.ajax({
					type : 'post',
					url : '/deleteFile',
					data : {filename : targetFile},	// key : value
					dataType : 'text',
					success : function(result){
						targetLi.remove();	// 리스트 삭제
					}
				});
			});
		});
		
	</script>
	
</html>