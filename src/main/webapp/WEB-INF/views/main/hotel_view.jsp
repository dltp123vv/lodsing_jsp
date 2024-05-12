<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link href="${rc.contextPath }/resources/main/img/titlelog.png" rel="shortcut icon" type="image/x-icon">

<script type="text/javascript" src="${rc.contextPath }/resources/js/httpRequest.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${rc.contextPath }/resources/js2/jquery-3.6.0.min.js"></script>
<script src="${rc.contextPath }/resources/js2/jquery-scrollbar.js"></script>
<link rel="stylesheet" href="${rc.contextPath }/resources/css2/swiper.css" type="text/css">
<link rel="stylesheet" href="${rc.contextPath }/resources/css2/swiper.min.css" type="text/css">
<script src="${rc.contextPath }/resources/js2/swiper.min.js"></script>
<script src="${rc.contextPath }/resources/js2/main.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=35d71e137b481a1c8d8befd339cf5e29&libraries=services"></script>

<link rel="stylesheet" href="${rc.contextPath }/resources/css/style.css">
<link rel="stylesheet" href="${rc.contextPath }/resources/css/reservationList.css">
<link rel="stylesheet" href="${rc.contextPath }/resources/css/lee.css">
<script type="text/javascript" src="${rc.contextPath }/resources/js/httpRequest.js"></script>
<style>
.btn-primary {
	background-color: #02647d;
	width: 350px;
	font-size: 27px;
}

#map {
	height: 200px;
	width: 500px;
	margin: 0 auto;
	z-index: 10;
}

a {
	text-decoration: none;
}

#myform fieldset {
	display: inline-block;
	direction: rtl;
	border: 0;
}

#myform fieldset legend {
	text-align: right;
}

#myform input[type=radio] {
	display: none;
}

#myform label {
	font-size: 3em;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
}

#myform label:hover {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#myform label:hover ~ label {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#myform input[type=radio]:checked ~ label {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#reviewContents {
	width: 100%;
	height: 150px;
	padding: 10px;
	box-sizing: border-box;
	border: solid 1.5px #D3D3D3;
	border-radius: 5px;
	font-size: 16px;
	resize: none;
}

.starr {
	font-size: 1.5em;
	color: orange;
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
.jbTitle {
	border-bottom: 3px solid rgb(3, 101, 125);
}
</style>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyADOAQd1B0vWgDmwkVmzwn-0k24H4sSZZg&callback=initMap&region=kr"></script>
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
						aria-label="Bootstrap" src="${rc.contextPath }/resources/img/main/logo.png">

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

	<section>
		<div class="default_width">
			<div class="top row" style="padding-top: 25px;">

				<!-- 숙소 사진 목록 -->
				<div id="demo" class="carousel col-sm-6" data-bs-ride="carousel">


					<div class="carousel-inner rounded-5"
						style="width: 500px; margin-top: 20px">
						<img src="${rc.contextPath }/resources/upload/${bu.filename}"
							style="width: 100%;">
					</div>


				</div>
				<!-- 숙소 사진 목록 끝 -->

				<!-- 숙소 소개 -->
				<div class="col-sm-6">
					<b class="large_text"> <span class="badge"> ${bu.bucate }
					</span> ${bu.buname}
					</b>

					<div class="row">

						<!-- 별점, 리뷰, 주소 -->
						<div class="col-sm-8">
							<div class="mt-1 mb-1 bu_review_box">
								<li><span class="bu_review_star">⭐</span> <span
									class="bu_review_avg"> 평균 별점 3.5</span> <span
									class="bu_review_avg_sub">/5</span></li>
								<li><span class="bu_review_count">후기 <span
										style="color: red; font-size: 19px; font-weight: bold;">리뷰개수</span>
										13개
								</span></li>
							</div>

							<p class="gray_text" style="margin-bottom: 10px;">
								<img
									src="https://cdn4.iconfinder.com/data/icons/music-ui-solid-24px/24/location_map_marker_pin-2-512.png"
									style="width: 20px;"> ${bu.buaddr}
							</p>
						</div>

						<!-- 찜하기 -->

					</div>


					<div class="event-bg text-white rounded">
						<ul>
							<li>대표 이름 : ${bu.ownname}</li>
							<li>대표 전화번호 : ${bu.owntel}</li>
						</ul>
					</div>
					<!-- 지도 -->

					<div id="map"></div>
				</div>
				<!-- 숙소 소개 끝 -->

				<!-- 탭 -->
				<div class="container mt-5">
					<ul class="nav nav-tabs nav-justified row">
						<li class="nav-item"><a class="nav-link active"
							data-bs-toggle="tab" style="color: black;" href="#room-list">객실안내/예약</a>
						</li>
						<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
							style="color: black;" href="#review">리뷰</a></li>
					</ul>
					<!-- 탭  끝 -->

					<div class="tab-content" style="margin-top: 10px;">

						<!-- 방 목록 -->
						<div class="tab-pane active container" id="room-list">
							<!-- 체크인 체크아웃 설정 -->
							<form action="/reservation/overLap" name="f" method="get">
								<div class="row"
									style="text-align: center; margin-bottom: -12px; border: none;">
									<input type="hidden" name="roomcount"> <input
										type="hidden" name="ownid" value="${bu.ownid}">
									<div class="col-sm-5" style="">
										<input type='date' id="checkin" min="${today }"
											value="${bookcheckin }" class="detail_checkin_1"
											name="bookcheckin" required>
									</div>
									<div class="col-sm-5" style="border-left:">
										<input type='date' id="checkout" min="${tomorrow }"
											value="${bookcheckout }" class="detail_checkin_1"
											name="bookcheckout" style="border: none;" required>
									</div>
									<div class="col-sm-2" style="padding: 0 0 0 0 !important;">
										<input type="submit" class="default_btn" value="날짜 변경">
									</div>
								</div>
							</form>

							<!-- 체크인 체크아웃 설정 끝 -->
							<div>
								<c:forEach var="room" items="${room}">
									<form action="/reservation" method="get">
										<input type="hidden" name="buname" value="${bu.buname}">
										<input type="hidden" name="roomcount"
											value="${room.roomcount}"> <input type="hidden"
											name="bookcheckin" value="${bookcheckin}"> <input
											type="hidden" name="bookcheckout" value="${bookcheckout}">
										<input type="hidden" name="roomname" value="${room.roomname}">
										<input type="hidden" name="bookprice"
											value="${room.roomprice}"> <input type="hidden"
											name="filename" value="${room.filename}">

										<c:set var="roomnum" value="${room.roomnum}" />
										<input type="hidden" name="roomnum" value="${roomnum}">
										<input type="hidden" name="memid" value="${user.memid }">


										<div class="reserve_room">
											<p class="reserve_pic_view">
												<img src="${rc.contextPath }/resources/upload/${room.filename}"
													class="rounded"
													style="width: 376px; height: 226px; object-fit: cover;">
											</p>
											<span class="reserve_room_title large_text">${room.roomname}</span>
											<div class="gray_subtext right_text">
												<span>최대 ${room.roomcount}인</span> <br> <span>입실
													: ${room.roomcheckin} / </span> <span> 퇴실 :
													${room.roomcheckout}</span>
											</div>

											<div class="reserve_room_price row">
												<div class="col-sm-6">
													<strong class="medium_text">가격</strong>
												</div>
												<div class="col-sm-6 right_text">
													<span>1박 기준 &nbsp;</span> <b class="large_text"><fmt:formatNumber
															value="${room.roomprice}" pattern="#,###,###" />원</b>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6">
													<button type="button"
														class="reserve_room_btn default_btn medium_text"
														onclick="roomDetail('${room.roomnum}', '${bu.ownid}')">방
														정보</button>
												</div>
												<div class="col-sm-6">
													<input type="submit"
														class="reserve_room_btn default_btn medium_text"
														<c:if test="${room.overlap != 0}">disabled value="예약된 방"</c:if>
														<c:if test="${room.overlap == 0}">value="예약"</c:if>>
												</div>
											</div>
										</div>
									</form>
								</c:forEach>
							</div>
						</div>
					</div>
					<!-- 방 목록 끝 -->

					<div class="tab-pane fade" id="review">



						<div class="tab-content">
							<div class="tab-pane active container " id="review">

								<div class="row" style="margin-bottom: 10px;">
									<form class="col" action="/review/form"
										method="get" style="text-align: center;">
										<input type="hidden" name="buname" value="${bu.buname }">
										<input type="hidden" name="ownid" value="${bu.ownid }">
										<input style="margin: 20px auto;" type="submit"
											class=" btn btn-secondary btn-sm " value="리뷰작성"
											style="cusor: pointer">
									</form>



									<div class="list-group">
										<c:forEach var="vo" items="${list}">
											<div
												class="list-group-item list-group-item-action d-flex gap-3 py-3"
												aria-current="true">

												<c:if test="${vo.depth ne 1  }">
													<div>
														<img src="${rc.contextPath }/resources/img/main/customer.png"
															style="height: 39px">
														<h5 style="width: 80px;">${vo.memid}</h5>
													</div>
												</c:if>
												<c:if test="${vo.depth ne 0  }">
													<div>
														<img src="${rc.contextPath }/resources/img/main/admin.png"
															style="height: 39px">
														<h5 style="width: 80px;">${vo.ownid}</h5>
													</div>
												</c:if>
												<p style="width: 30%">
													<a
														href="/review/${vo.idx}?buname=${bu.buname}&ownid=${bu.ownid}"
														style="color: black;"> ${vo.buname}</a>
												</p>

												<!-- 댓글일경우 제목을 들여쓰기한다 -->
												<c:forEach begin="1" end="${vo.depth }">&nbsp;</c:forEach>

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
															href="/review/${vo.idx}?buname=${bu.buname}&ownid=${bu.ownid}"
															style="color: black;"> <c:if
																test="${vo.filename ne 'no_file'}">
																<img src="${rc.contextPath }/resources/upload/${vo.filename}"
																	class="card-img-top"
																	style="width: 300px; margin-top: 10px">
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
							</div>

						</div>
					</div>
				</div>
				<script>
					//지도 스크립트
					//상세조건의 값을 가져옵니다
					//지도를 생성합니다    
					const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
						level : 4
					// 지도의 확대 레벨
					};

					//지도를 생성합니다    
					const map = new kakao.maps.Map(mapContainer, mapOption);
					const address = '${bu.buaddr}';
					//주소-좌표 변환 객체를 생성합니다
					const geocoder = new kakao.maps.services.Geocoder();
					//주소로 좌표를 검색합니다
					geocoder
							.addressSearch(
									address,
									function(result, status) {

										// 정상적으로 검색이 완료됐으면 
										if (status === kakao.maps.services.Status.OK) {

											const coords = new kakao.maps.LatLng(
													result[0].y, result[0].x);

											// 결과값으로 받은 위치를 마커로 표시합니다
											const marker = new kakao.maps.Marker(
													{
														map : map,
														position : coords
													});

											// 인포윈도우로 장소에 대한 설명을 표시합니다
											const infowindow = new kakao.maps.InfoWindow(
													{
														content : '<div style="width:150px;text-align:center;padding:6px 0;">${bu.buname}</div>'
													});
											// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
											map.setCenter(coords);
											infowindow.open(map, marker);
										}
									});

					function roomDetail(roomnum, buownid) {
						const url = '/room/detail/' + roomnum
						console.log(url + ', ' + roomnum)
						const op = 'width=550, height=1000, location=no, toolbar=no'

						open(url, '방 정보', op)
					}
				</script>


				<script
					src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>