<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<style>
.lee{
    background-color: #02647d;
    color: white;
    font-family: Arial, Helvetica, sans-serif ;
}

.list{
    background-color: rgb(236, 231, 231);
    color: rgb(0, 0, 0);
    width: 180px;
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
						aria-label="Bootstrap" src="/lodsing/resources/img/main/logo.png">

					</a>

					<ul id="main_menu"
						class="nav col-12 col-lg-auto my-2 justify-content-center my-md-0 text-small">
						<li><a href="#" class="nav-link text-black"> 내주변 </a></li>
						<li><a href="#" class="nav-link text-black"> 예약내역 </a></li>
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
						<li><a href="login_form.do" class="nav-link text-black">
								로그인 </a></li>
						<li><a href="#" class="nav-link text-black"> 회원가입 </a></li>
					</ul>
				</div>
			</div>
		</div>
	</header>

	<main class="container">
		<div style="border-bottom: 1px black solid; margin-bottom: 10px;">
			<h4 class="text-gray" style="text-align: center;">
				<a href="motel.do" style="text-decoration:none ;color:black;">모텔</a>
			</h4>
		</div>
		<c:forEach var="vo" items="${m_list }">
			<div class="row d-flex justify-content-center"
				style="margin: 50px auto;">
				<div
					class="row  col-9 g-0 border rounded overflow-hidden flex-md-row mb- shadow-sm h-md-250 position-relative">
					<div class="col-auto d-none d-lg-block text-white"
						style="margin-right: 10px;">

						<img class="bd-placeholder-img" width="400" height="250"
							src="${rc.contextPath }/resources/upload/${vo.filename}"
							aria-label="Placeholder: Thumbnail"
							preserveAspectRatio="xMidYMid slice" focusable="false">
						<title>Placeholder</title>
						<rect width="100%" height="100%" fill="#55595c"></rect>
						<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
						</img>

					</div>
					<div class="col p-4 d-flex flex-column position-static">
						<h1 class="mb-0 text-black" style="font-size: 45px;">
							<span class="lee" style="font-size: 35px; margin-left: 0px;">${vo.bucate }</span>
							${vo.buname }
						</h1>
						<br>

						<p class="card-text mb-auto">${vo.buaddr }</p>
						
						<input class="btn btn-primary" type="button" value="방 상세보기">

					</div>
				</div>
			</div>
		</c:forEach>
	</main>
</body>

</html>
