<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>여행 할때 lodging</title>
<link href="/lodsing/resources/img/titlelog.png" rel="shortcut icon"
	type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet" href="/lodsing/resources/css2/main.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/lodsing/resources/js2/jquery-3.6.0.min.js"></script>
<script src="/lodsing/resources/js2/jquery-scrollbar.js"></script>
<script src="/lodsing/resources/css2/index.css"></script>
<link rel="stylesheet" href="/lodsing/resources/css2/swiper.css"
	type="text/css">
<link rel="stylesheet" href="/lodsing/resources/js2/swiper.min.css"
	type="text/css">
<script src="/lodsing/resources/js2/swiper.js"></script>
<script src="/lodsing/resources/js2/swiper.min.js"></script>
<script src="/lodsing/resources/js2/main.js"></script>
<link rel="stylesheet" href="/lodsing/resources/css2/custom.css"
	type="text/css">
<script type="text/javascript"
	src="/lodsing/resources/js/httpRequest.js"></script>
<style>
.nav-link {
	display: block;
	padding: 0.5rem 1rem;
	color: #0d6efd;
	text-decoration: none;
	transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out,
		border-color 0.15s ease-in-out;
}

@media ( prefers-reduced-motion : reduce) {
	.nav-link {
		transition: none;
	}
}

.nav-link:hover, .nav-link:focus {
	color: #0a58ca;
}

.business_menu ul {
	background-color: whitesmoke;
	padding-top: 10px;
	text-align: center;
	color: black;
}

.business_menu li {
	display: inline;
	margin-left: 20px;
}

.business_menu a:link, a:visited, a:active {
	color: black;
	text-decoration: none;
}

body {
	background-color: white;
}
</style>

</head>
<body>
	<header class="jbTitle">
		<div class="px-3 py-2 bg-white text-white  navbar-light bg-light">
			<div class="container container-fluid" class="box1"
				style="padding: 20px;">
				<div
					class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
					<a href="business_main.do?ownid=${business.ownid }"
						class="d-flex align-items-center my-2 my-lg-0 me-lg-auto text-white text-decoration-none">
						<img class="bi me-2" width="120" height="32"
						aria-label="Bootstrap" src="/lodsing/resources/img/main/logo.png">

					</a>


					<c:if test="${ !empty business }">
						<div class="user_name">${business.ownname}님환영합니다.</div>
					</c:if>






					<ul id="main_menu"
						class="nav col-12 col-lg-auto my-2 justify-content-center my-md-0 text-small">

						<li><a href="#" class="nav-link text-black"> 내주변 </a></li>

						<li>
							<div class="btn-group">
								<button class="btn  dropdown-toggle text-black" type="button"
									id="dropdownMenuButton" data-bs-toggle="dropdown"
									aria-expanded="false">더보기</button>
								<ul class="dropdown-menu text-black"
									aria-labelledby="dropdownMenuButton">
									<li><a class="dropdown-item" href="#">공지사항</a></li>
									<li><a class="dropdown-item" href="#">자주묻는 질문</a></li>
									<li><a class="dropdown-item" href="#">약관 및 정책</a></li>
								</ul>
							</div>

						</li>
						<li><c:if test="${ empty business }">
								<a href="login_form.do" class="nav-link text-black"> 로그인 </a>
							</c:if> <c:if test="${ !empty business }">
								<a href="business_logout.do" class="nav-link text-black">
									로그아웃 </a>
							</c:if></li>
					</ul>

				</div>
			</div>
		</div>
	</header>

	<div class="container">
		<section class="col-8 container bg-white"
			style="padding: 20px; margin-top: 2%;"background-color:whitesmoke;">
			<div class="justify-content-center"
				style="background-color: whitesmoke; height: 50px; padding-top: 12px;">
				<div>
					<ul class="business_menu">
						<li><a href="room_insert_form.do">객실 등록</a></li>
						<li>|</li>
						<li><a href="#">객실 정보</a></li>
						<li>|</li>
						<li><a href="#">매출</a></li>
						<li>|</li>
						<li><a href="reserve_list.do?ownid=${business.ownid }">예약
								확인</a></li>
						<li>|</li>
						<li><a href="todayCheckin.do?ownid=${business.ownid }">체크인</a></li>
						<li>|</li>
						<li><a href="todayCheckout.do?ownid=${business.ownid }">체크아웃</a></li>
						<li>|</li>
						<li><a href="reviewlist.do?ownid=${business.ownid}">리뷰</a></li>

					</ul>
				</div>
			</div>
		</section>
	</div>

	<div class="container" style="margin-top: 100px">
		<div class="container" style="margin-top: 50px;">
			<h2 style="text-align: center;">예약 내역</h2>
			<div style="margin-bottom: 100px;">
				<form style="margin: 30px 0px auto; float: right;">
					<select name="searchName" id="searchName">
						<option value="ro_name"
							${searchName == 'ro_name' ? 'selected' : '' }>방이름</option>
						<option value="name" ${searchName == 'name' ? 'selected' : '' }>예약자이름</option>
						<option value="checkin"
							${searchName == 'checkin' ? 'selected' : '' }>체크인</option>
						<option value="checkout"
							${searchName == 'checkout' ? 'selected' : '' }>체크아웃</option>
						<option value="status"
							${searchName == 'status' ? 'selected' : '' }>예약상태</option>
					</select> <input type="text" id="search" name="search"
						${searchName == 'status' ? 'placeholder ="예약완료, 결제취소, 이용완료 , 입실완료 입력하세요"' : '' }
						style="width: 450px;"> <input type="submit" value="검색">
				</form>
			</div>
			<table class="table table-hover"
				style="margin-top: 30px; text-align: center;">
				<thead>
					<tr>
						<th>객실 이름</th>

						<th>체크인</th>
						<th>체크아웃</th>
						<th>예약자이름</th>
						<th>핸드폰번호</th>
						<th>아이디</th>
						<th>예약상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="bookingvo" items="${bookingvo}" varStatus="i">
						<tr>
							<td>${bookingvo.roomname}</td>

							<td>${bookingvo.bookcheckin}</td>
							<td>${bookingvo.bookcheckout}</td>
							<td>${bookingvo.memname}</td>
							<td>${bookingvo.memtel}</td>
							<td>${bookingvo.memid}</td>
							<td><c:choose>
									<c:when test="${bookingvo.bookstatus == '1'}">예약 완료</c:when>
									<c:when test="${bookingvo.bookstatus == '2'}">결제 취소</c:when>
									<c:when test="${bookingvo.bookstatus == '3'}">이용 완료</c:when>
									<c:when test="${bookingvo.bookstatus == '4'}">입실 완료</c:when>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="container">
			<ul class="pagination justify-content-center">
				<li>${ pageMenu }</li>
			</ul>
		</div>
		<script type="text/javascript">
			$(document).ready(function() {
				var inputTag = document.querySelector('#search'); // id가 search인 태그를 선택
				$('#searchName').change(function() {
					var searchName = $('#searchName').val(); //id가 searchName인 select box의 값 추출하여 저장
					if (searchName == 'status') { // searchName의 값이 status면 
						// inputTag의 placeholder값을 변경
						inputTag.placeholder = "예약완료, 결제취소, 이용완료 , 입실완료 입력하세요";
					} else {
						// searchName의 값이 status가 아니면 공백으로 변경
						inputTag.placeholder = "";
					}
				});
			});
		</script>
	</div>
</body>
</html>