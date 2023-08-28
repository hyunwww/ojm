<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>등록 요청</title>
		<style type="text/css">
			table {
				border: 1px solid black;
				border-collapse: collapse;
			}
			th, td{
				border: 1px solid black;
			}
			.banner {
				position: fixed;
				right: 10%;
				text-align: center;
			}
		</style>
	</head>
	<body>
		<h1>등록 요청 관리 페이지</h1>
		<hr>
		
		<div class="banner">
			<table>
				<tr><td><a href="/admin/reportList">신고 관리</a></td></tr>
				<tr><td><a href="/qboard/qlist">Q&A 관리</a></td></tr>
				<tr><td><a href="/admin/storeRegister">등록 요청 관리</a></td></tr>
			</table>
		</div>
	</body>
</html>