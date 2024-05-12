<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

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
	type="text/css"> -->

<script type="text/javascript"
	src="/lodsing/resources/js/httpRequest.js"></script>
<link rel="stylesheet" href="/lodsing/resources/css2/index.css"
	type="text/css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.rhda {
	color: rgb(56, 56, 56);
	font-weight: bold;
}
.red {
	color: rgb(3, 101, 125);
	font-weight: bold;
}
.starr {
	font-size: 1.5em;
	color: orange;
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
a{
text-decoration:none;}
</style>
<body>

	<header class="jbTitle"
		style="border-bottom: 3px solid rgb(3, 101, 125);">
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

	<section class=" container bg-light">
		<div class="row justify-content-center">
			<div
				class="col-2 d-flex flex-column flex-shrink-0 p-3 text-black bg-white side_menu"
				>
				<ul class="nav nav-pills flex-column mb-auto">
					<li class="nav-item "><a href="reservationlist.do"
						class="nav-link  rhda "> 예약내역 </a></li>
					<li class="nav-item link-dark"><a href="memberinfo.do"
						class="nav-link  rhda ">내정보관리 </a></li>
					<li class="nav-item link-dark" ><a
						href="#" class="nav-link red" ><span class="red">
							내가 작성한 리뷰</span> </a></li>
					<li class="nav-item "><a
						href="${pageContext.request.contextPath}/member/myWish"
						class="nav-link text-black  rhda"> 찜한 숙소 </a></li>

				</ul>
			</div>

			<div class=" col-8 list-group bg-white" style="margin: 80px 0 0 40px;">

				<c:forEach var="vo" items="${mlist}">
					<div
						class="list-group-item list-group-item-action d-flex gap-3 py-3"
						aria-current="true">

						<c:if test="${vo.depth ne 1  }">
							<div>
								<img src="/lodsing/resources/img/main/customer.png"
									style="height: 39px">
								<h5 style="width: 10%">${vo.memid}</h5>
							</div>
						</c:if>
						<c:if test="${vo.depth ne 0  }">
							<div>
								<img src="/lodsing/resources/img/main/admin.png"
									style="height: 39px">
								<h5 style="width: 10%">${vo.ownid}</h5>
							</div>
						</c:if>
						<p style="width: 30%">${vo.buname}</p>

						<!-- 댓글일경우 제목을 들여쓰기한다
					<c:forEach begin="1" end="${vo.depth }"></c:forEach> -->

						<!-- 댓글기호 -->
						<c:if test="${vo.depth ne 0  }">
							<div class="col-2" style="color: gray;">::관리자 댓글::</div>
						</c:if>
						<c:if test="${vo.rating == '0'}">
							<div class="starr col-2">☆☆☆☆☆</div>
						</c:if>
						<c:if test="${vo.rating == '1'}">
							<div class="starr col-2">★☆☆☆☆</div>
						</c:if>
						<c:if test="${vo.rating == '2'}">
							<div class="starr col-2">★★☆☆☆</div>
						</c:if>
						<c:if test="${vo.rating == '3'}">
							<div class="starr col-2">★★★☆☆</div>
						</c:if>
						<c:if test="${vo.rating == '4'}">
							<div class="starr col-2">★★★★☆</div>
						</c:if>
						<c:if test="${vo.rating == '5'}">
							<div class="starr col-2">★★★★★</div>
						</c:if>
						<div class="d-flex gap-2 w-100 justify-content-between">
							<div style="width: 40%;">
								<a
									href="reviewview.do?idx=${vo.idx}&buname=${bu.buname}&ownid=${bu.ownid}"
									style="color: black;"> <c:if
										test="${vo.filename ne 'no_file'}">
										<img src="/lodsing/resources/upload/${vo.filename}"
											class="card-img-top" style="width: 300px; margin-top: 10px">
									</c:if> <span style="font-size: 20px; text-align: center;"><pre
											style="margin-top: 20px;">${vo.content}</pre></span>
								</a>
							</div>

						</div>

						<small class="opacity-50 text-nowrap">${fn:split(vo.regdate, ' ')[0]}</small>
					</div>
				</c:forEach>
			</div>



		</div>
	</section>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>