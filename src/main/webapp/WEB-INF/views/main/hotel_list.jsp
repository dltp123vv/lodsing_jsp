<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="urlPrefix" value="${rc.contextPath}/acc/"/>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>여행 할때 lodging</title>
<link href="${rc.contextPath}/resources/img/titlelog.png" rel="shortcut icon" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${rc.contextPath}/resources/css2/main.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${rc.contextPath}/resources/js2/jquery-3.6.0.min.js"></script>
<script src="${rc.contextPath}/resources/js2/jquery-scrollbar.js"></script>
<link rel="stylesheet" href="${rc.contextPath}/resources/css2/swiper.css" type="text/css">
<link rel="stylesheet" href="${rc.contextPath}/resources/js2/swiper.min.css" type="text/css">
<script src="${rc.contextPath}/resources/js2/swiper.js"></script>
<script src="${rc.contextPath}/resources/js2/swiper.min.js"></script>
<script src="${rc.contextPath}/resources/js2/main.js"></script>
<link rel="stylesheet" href="${rc.contextPath}/resources/css2/custom.css" type="text/css">
<link rel="stylesheet" href="${rc.contextPath}/resources/css2/index.css">
<style>
.btn-primary {
	background-color: #02647d;
	width: 350px;
	font-size: 27px;
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
					<a href="main.do"
						class="d-flex align-items-center my-2 my-lg-0 me-lg-auto text-white text-decoration-none">
						<img class="bi me-2" width="120" height="32"
						aria-label="Bootstrap" src="${rc.contextPath}/resources/img/main/logo.png">

					</a>


					<c:if test="${ !empty user }">
						<div class="user_name">${user.memname}님환영합니다.</div>
					</c:if>

					<c:if test="${ user.verify == admin }">
						<div class="user_name">${user.memname}님환영합니다.</div>
					</c:if>




					<ul id="main_menu"
						class="nav col-12 col-lg-auto my-2 justify-content-center my-md-0 text-small">

						<li><a href="#" class="nav-link text-black"> 내주변 </a></li>
						<li><c:if test="${ !empty user }"><a href="reservationlist.do" class="nav-link text-black"> 예약내역 </a></c:if></li>
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
						<li><c:if test="${ empty user }">
								<a href="/login" class="nav-link text-black"> 로그인 </a>
							</c:if> <c:if test="${ !empty user }">
								<a href="/member/logout" class="nav-link text-black"> 로그아웃 </a>
							</c:if></li>
					</ul>
					<c:if test="${user.verify =='관리자'}">
						<li><a href="admin.do" class="nav-link text-black"> 관리자
								페이지 </a></li>
					</c:if>
				</div>
			</div>
		</div>
	</header>
	<main class="container">
		<div style="border-bottom: 1px black solid; margin-bottom: 10px;">
			<h4 class="text-gray" style="text-align: center;">
				<a href="hotel.do" style="text-decoration: none; color: black;">호텔</a>
			</h4>
		</div>
		<c:forEach var="vo" items="${m_list }">
			<form>
				<div class="row d-flex justify-content-center"
					style="margin: 50px auto;">
					<div
						class="row  col-9 g-0 border rounded overflow-hidden flex-md-row mb- shadow-sm h-md-250 position-relative">
						<div class="col-auto d-none d-lg-block text-white"
							style="margin-right: 10px;">

							<img class="bd-placeholder-img" width="400" height="250"
								src="${rc.contextPath}/resources/upload/${vo.filename}"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
							<title>Placeholder</title>
							<rect width="100%" height="100%" fill="#55595c"></rect>
							<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
							</img>

						</div>
						<div class="col p-4 d-flex flex-column position-static">
							<h1 class="mb-0 text-black" style="font-size: 40px;">
								<span class="lee" style="font-size: 35px; margin-left: 0px;">${vo.bucate }</span>
								${vo.buname }
							</h1>
							<br>

							<p class="card-text mb-auto">${vo.buaddr }</p>

							<div class="d-grid gap-2 col-8 mx-auto">

								<input class="btn btn-primary" type="button" value="방 상세보기"
									onclick="location.href='/acc/hotelView?ownid=${vo.ownid}'">

							</div>

						</div>
					</div>
				</div>
			</form>
		</c:forEach>
	</main>
</body>

</html>
