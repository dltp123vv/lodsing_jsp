<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/lodsing/resources/img/titlelog.png" rel="shortcut icon"
	type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${rc.contextPath }/resources/js2/jquery-3.6.0.min.js"></script>
<script src="${rc.contextPath }/resources/js2/jquery-scrollbar.js"></script>
<link rel="stylesheet" href="${rc.contextPath }/resources/css2/swiper.css" type="text/css">
<link rel="stylesheet" href="${rc.contextPath }/resources/css2/swiper.min.css" type="text/css">
<script src="${rc.contextPath }/resources/js2/swiper.min.js"></script>
<script src="${rc.contextPath }/resources/js2/main.js"></script>
<link rel="stylesheet" href="${rc.contextPath }/resources/css2/index.css">
<script type="text/javascript" src="${rc.contextPath }/resources/js/httpRequest.js"></script>
<script type="text/javascript">
	
</script>
<style>
body {
	background-color: white;
}
</style>
</head>
<body>

	<!-- Carousel -->
	<div id="demo" class="carousel roominfo_div_box mt-3">
		<img src="${rc.contextPath }/resources/upload/${room.filename }">
	</div>

	<div class="roominfo_div_box">

		<div>
			<input type="hidden" name="pic_num" value="${room.filename}"> <input
				type="hidden" name="ro_num" value="${room.roomnum}">

			<div class="rounded mt-3" style="text-align: center;">
				<div
					style="width: 500px; border-top: 1px solid #c8c8c8; border-bottom: 1px solid #c8c8c8;">
					<strong class="large_text" style="color: black;">${room.roomname}</strong>
				</div>
			</div>
			<div class="rounded mt-3 mb-3"
				style="text-align: center; border: 1px solid #c8c8c8;">
				<div class="large_text mt-3 mb-3">
					<strong style="color: grey">객실기본정보</strong>
				</div>
				<table class="table table-borderless medium_text"
					style="text-align: center;">
					<tr>
						<td><strong>가격</strong></td>
						<td>${room.roomprice}원</td>
					</tr>
					<tr>
						<td><strong>체크인</strong></td>
						<td>${room.roomcheckin}</td>
					</tr>
					<tr>
						<td><strong>체크아웃</strong></td>
						<td>${room.roomcheckout}</td>
					</tr>
				</table>

				<hr>

				<div class="mt-3 mb-3 small_text">${info}</div>
			</div>
			<button class="default_btn rounded mt-1" onclick="window.close()">창
				닫기</button>
		</div>
	</div>
</body>
</html>