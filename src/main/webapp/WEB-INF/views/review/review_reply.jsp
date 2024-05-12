<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>여행 할때 lodging</title>
	<link href="${pageContext.request.contextPath}/resources/img/titlelog.png" rel="shortcut icon" type="image/x-icon">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script>
	function send_check(f){
		//유효성 체크 했다고 하고
		
		
		f.submit();
		
	}
</script>
</head>
<body>
<form method="post" action="reply.do" enctype="multipart/form-data">
<input type="hidden" name="ownid" value="${ownid }">
<input type="hidden" name="buname" value="${buname }">
<input type="hidden" name="ref" value="${ref }">
<input type="hidden" name="idx" value="${idx }">

<table class="table" border="1" align="center" width="610">
	<tr>
		<th>제목</th>
		<td><input name="subject" style="width:300px"></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${ownid}</td>
	</tr>
	<tr>
		<th>호텔이름</th>
		<td>${buname}</td>
	</tr>
	
	<tr>
		<th>내용</th>
		<td><textarea name="content" rows="10" cols="70"></textarea></td>
	</tr>
	
	
	<tr>
	<td colspan="2" align="right">
	 <input type="button" value="등록" onclick="send_check(this.form);">
	 <input type="button" value="취소" onclick="location.href='hotel_view.do'">
	 
	</td>
	</tr>
</table>
</form>
</body>
</html>