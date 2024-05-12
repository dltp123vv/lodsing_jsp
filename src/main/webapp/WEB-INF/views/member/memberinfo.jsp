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
<link href="/lodsing/resources/img/main/titlelog.png" rel="shortcut icon"
	type="image/x-icon">

<script type="text/javascript"
	src="/lodsing/resources/js/httpRequest.js"></script>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/lodsing/resources/js2/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/lodsing/resources/css2/main.css"
	type="text/css">
  <!-- <link rel="stylesheet" href="/lodsing/resources/css/style.css" 
	type="text/css">  --> 

<script type="text/javascript"
	src="/lodsing/resources/js/httpRequest.js"></script>
<link rel="stylesheet" href="/lodsing/resources/css2/index.css"
	type="text/css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="/lodsing/resources/js/httpRequest.js"></script>


<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<style type="text/css">
	a{text-decoration:none;}
	</style>
	</head>
<body class="bg-light">

	<header class="jbTitle">
		<div class="px-3 py-2 bg-white text-white  navbar-light bg-light">
			<div class="container container-fluid" class="box1"
				style="padding: 20px;">
				<div
					class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
					<a href="main.do"
						class="d-flex align-items-center my-2 my-lg-0 me-lg-auto text-white text-decoration-none">
						<img class="bi me-2" width="120" height="32"
						aria-label="Bootstrap" src="/lodsing/resources/img/main/logo.png">

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
						<li><c:if test="${ !empty user }">
								<a href="reservationlist.do" class="nav-link text-black">
									예약내역 </a>
							</c:if></li>
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
								<a href="login_form.do" class="nav-link text-black"> 로그인 </a>
							</c:if> <c:if test="${ !empty user }">
								<a href="logout.do" class="nav-link text-black"> 로그아웃 </a>
							</c:if></li>
					<c:if test="${user.verify =='관리자'}">
						<li><a href="admin.do" class="nav-link text-black"> 관리자
								페이지 </a></li>
					</c:if>
					</ul>
				</div>
			</div>
		</div>
	</header>


	<section class=" container ">
		<div class="row justify-content-center">
			<div
				class="col-2 d-flex flex-column flex-shrink-0 p-3 text-black bg-white side_menu"
				  style="margin-right:10px;">
				<ul class="nav nav-pills flex-column mb-auto">
					<li class="nav-item fw-bold"><a href="reservationlist.do"
						class="nav-link  rhda "> 예약내역 </a></li>
					<li class="nav-item link-dark"><a href="memberinfo.do"
						class="nav-link  rhda "><span class="red">내정보관리</span> </a></li>
					<li class="nav-item link-dark fw-bold" ><a
						href="myreview.do?memid=${user.memid}" class="nav-link rhda fw-bold" >
							내가 작성한 리뷰 </a></li>
					<li class="nav-item fw-bold"><a
						href="${pageContext.request.contextPath}/member/myWish"
						class="nav-link text-black  rhda"> 찜한 숙소 </a></li>

				</ul>
			</div>


			<div class="col-sm-8 card text-start d-flex bg-white " style="margin:50px 0px 0px 30px; padding:15px 20px 0px;">
				<p class="memberInfo_large_text ">
					<b>내 정보 관리</b>
				</p>
				<div class="mt-3">
					<p class="memberInfo_defalut_btn rounded text-start fw-bolder">이메일 </p>
					<p class="memberInfo_default_text text-start text-gray">${member.mememail}</p>
				</div>

				<div class="mt-3">
					<p class="memberInfo_defalut_btn rounded text-start fw-bolder">이름</p>
					<p class="memberInfo_default_text text-start">${member.memname }</p>
				</div>

				<div class="mt-3">
					<p class="memberInfo_defalut_btn rounded text-start fw-bolder">전화번호</p>
					<p class="memberInfo_default_text text-start">${member.memtel }</p>

				</div>

				<hr>
				<div id="memberinfo_bottom_text">
					<p class="memberInfo_small_text">
						Lodging을 이용하고 싶지 않으신가요?&nbsp;&nbsp; <a href="#" onclick="logout()">로그아웃</a>
						&nbsp;&nbsp;&nbsp;&nbsp; <a
							href="${pageContext.request.contextPath}/view/search/main.jsp">회원탈퇴</a>
				</div>

			</div>
		</div>
	
	</section>
</body>
</html>