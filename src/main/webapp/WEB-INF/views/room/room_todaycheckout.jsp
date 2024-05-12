<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link href="/lodsing/resources/img/titlelog.png" rel="shortcut icon"
	type="image/x-icon">

<script type="text/javascript"
	src="/lodsing/resources/js/httpRequest.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/lodsing/resources/js2/jquery-3.6.0.min.js"></script>
<script src="/lodsing/resources/js2/jquery-scrollbar.js"></script>
<link rel="stylesheet" href="/lodsing/resources/css2/swiper.css"
	type="text/css">
<link rel="stylesheet" href="/lodsing/resources/css2/swiper.min.css"
	type="text/css">
<script src="/lodsing/resources/js2/swiper.min.js"></script>
<script src="/lodsing/resources/js2/main.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=35d71e137b481a1c8d8befd339cf5e29&libraries=services"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<link rel="stylesheet" href="/lodsing/resources/css/style.css">
<link rel="stylesheet" href="/lodsing/resources/css/reservationList.css">
<link rel="stylesheet" href="/lodsing/resources/css/lee.css">

<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="/lodsing/resources/js/httpRequest.js"></script>
<style type="text/css">
th, td {
	font-size: 0.9em;
}

.btn {
	font-size: 0.9em;
	padding-top: 0;
	padding-bottom: 0;
}

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

#checkout:hover {
	color: white;
	background-color: #02647d;
}
#checkout{
	border : solid 1px #02647d;
	color : #02647d;
}
</style>
</head>
<body>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>

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
	<div class="row" style="margin: 50px auto; padding: 0 100px 0 100px;">

		<div class="col-sm-6" style="margin-top: 25px;">
			<h4 style="text-align: center;">퇴실 전</h4>
			<table class="table table-hover"
				style="margin-top: 30px; text-align: center;">
				<thead>
					<tr>
						<th>번호</th>
						<th>객실 이름</th>
						<th>체크인</th>
						<th>체크아웃</th>
						<th>이름</th>
						<th>핸드폰번호</th>
						<th>예약상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="notchecout" items="${nocheckout}" varStatus="i">
						<tr>
							<td class="over-td">${notchecout.booknum }</td>
							<td class="over-td">${notchecout.roomname}</td>
							<td>${notchecout.bookcheckin}</td>
							<td>${notchecout.bookcheckout}</td>
							<td>${notchecout.memname}</td>
							<td>${notchecout.memtel}</td>
							<td><input type="button" id="checkout"
								class="update btn btn-outline-warning" value="체크아웃"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>

		<div class="col-sm-6" style="margin-top: 25px;">
			<h4 style="text-align: center;">퇴실완료</h4>
			<table class="table table-hover"
				style="margin-top: 30px; text-align: center;">
				<thead>
					<tr>
						<th>번호</th>
						<th>객실 이름</th>
						<th>체크인</th>
						<th>체크아웃</th>
						<th>이름</th>
						<th>핸드폰번호</th>
						<th>예약상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="checkoutok" items="${checkoutok}" varStatus="i">
						<tr>
							<td class="over-td">${checkoutok.booknum }</td>
							<td class="over-td">${checkoutok.roomname}</td>
							<td>${checkoutok.bookcheckin}</td>
							<td>${checkoutok.bookcheckout}</td>
							<td>${checkoutok.memname}</td>
							<td>${checkoutok.memtel}</td>
							<td>이용완료</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		// 버튼 클릭시 Row 값 가져오기
		$(".update").click(
				function() {
					const str = ""
					const tdArr = new Array(); // 배열 선언
					const checkBtn = $(this);
					// checkBtn.parent() : checkBtn의 부모는 <td>이다.
					// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
					const tr = checkBtn.parent().parent();
					const td = tr.children();
					//	테이블의 td에서 0번째위치한 td의 값 가져오기
					const no = td.eq(0).text();
					const result = confirm(no + '번의 예약상태를 변경하시겠습니까?')
					if (result) {
						location.href = "updateTodayCheckOut.do?booknum=" + no
								+ "&ownid=${business.ownid}";
					}
					console.log(no)
				})
	</script>
</body>
</html>