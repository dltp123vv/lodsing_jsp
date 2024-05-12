<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>여행 할때 lodging</title>
<link
	href="${pageContext.request.contextPath}/resources/img/titlelog.png"
	rel="shortcut icon" type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/index.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script>
	function send(f) {

		f.action = "/review";
		f.method = "post";
		f.submit();

	}
</script>
<style>
#rating {
	display: inline-block;
	direction: rtl;
	border: 0;
}

#rating input[type=radio] {
	display: none;
}

#rating label {
	font-size: 3em;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
}

#rating label:hover {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#rating label:hover ~ label {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

#rating input[type=radio]:checked ~ label {
	text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
</style>
</head>
<body>
	<jsp:include page="check_login.jsp" />
	<div class="container">
		<form method="post" class="row" enctype="multipart/form-data">
			<input type="hidden" name="memid" value="${user.memid}"> 
			<input type="hidden" name="buname" value="${buname}">
			<input type="hidden" name="ownid" value="${ownid}">
			
			<table class=" table" align="center">
				<tr>
					<th>Title</th>
					<td><input class="form-control form-control-sm"
						id="formFileSm" name="subject" style="width: 300px"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${user.memid}</td>
				</tr>
				<tr>
					<th>호텔이름</th>
					<td>${buname}</td>
				</tr>

				<tr>
					<th>사진첨부</th>
					<td><input class="form-control form-control-sm"
						id="formFileSm" type="file" name="photo"></td>
				</tr>
				<tr>



					<th>별점</th>

					<td>
						<fieldset id="rating">
							<input type="radio" name="rating" value="5" id="rate1"> <label
								for="rate1">★</label> <input type="radio" name="rating"
								value="4" id="rate2"> <label for="rate2">★</label> <input
								type="radio" name="rating" value="3" id="rate3"> <label
								for="rate3">★</label> <input type="radio" name="rating"
								value="2" id="rate4"> <label for="rate4">★</label> <input
								type="radio" name="rating" value="1" id="rate5"> <label
								for="rate5">★</label>
						</fieldset>
					</td>
				</tr>

				<tr>
					<th>내용</th>
					<td><textarea class="form-control"
							id="exampleFormControlTextarea1" name="content" rows="10"
							cols="70"></textarea></td>
				</tr>


				<tr>
					<td colspan="2" align="right"><input
						class="btn btn-secondary btn-sm" type="button" value="등록"
						onclick="send(this.form);"> <input
						class="btn btn-secondary btn-sm" type="button" value="취소"
						onclick="history.back(-1);"></td>
				</tr>
			</table>
		</form>

	</div>
</body>
</html>