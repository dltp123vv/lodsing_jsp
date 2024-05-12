<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="urlPrefix" value="${rc.contextPath}/member/"/>
<c:set var="urlPrefixOwn" value="${rc.contextPath}/business/"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${rc.contextPath }/resources/css/bootstrap.css">
<link rel="stylesheet" href="${rc.contextPath }/resources/css/custom.css">
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="${rc.contextPath }/resources/js/httpRequest.js"></script>
<script src="${rc.contextPath }/resources/js2/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	/* function send(f) {
		let url = "${rc.contextPath}/member/login";
		let param = "memid=" + f.memid.value + "&mempwd=" + f.mempwd.value;
		sendRequest(url, param, resultFn1, "POST");
	}
	function resultFn1() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			//no_id, no_pwd, clear중 하나를 받는다
			let data = xhr.responseText;
			if (data == 'no_memid') {
				alert("아이디가 없습니다.");
			} else if (data == 'no_mempwd') {
				alert("비밀번호 불일치");
			} else {
				location.href = "/";
			}
		}
	} */
	$(function(){
	var $memid = $("form").find('input[name=memid]');
	var $mempwd = $("form").find('input[name=mempwd]');
	var $ownid = $("form").find('input[name=ownid]');
	var $ownpwd = $("form").find('input[name=ownpwd]');
	
	$("#login-button").click(function(){
		if ($memid.val() == "") {
			alert("아이디를 입력하세요.");
			$memid.focus();
			return false;
		}
		if ($mempwd.val()=="") {
			alert("비밀번호를 입력하세요");
			$mempwd.focus();
			return false;
		}

		
		$.ajax({
			type: "post",
			url: "${urlPrefix}login?memid=" + $memid.val()+"&mempwd="+$mempwd.val(),
			success: function(data){
				if (data=='no_memid') {
					alert("아이디가 없습니다."); 
				}
				else if (data =='no_mempwd'){
					alert("비밀번호 불일치"); 
				}
				else{
					location.href = "/";
				}
			},
			dataType: "text"
		});
	});
	
	$("input[name=chkBubtn]").click(function(){
		if ($ownid.val() == "") {
			alert("아이디를 입력하세요.");
			$ownid.focus();
			return false;
		}
		if ($ownpwd.val()=="") {
			alert("비밀번호를 입력하세요");
			$ownpwd.focus();
			return false;
		}

		
		$.ajax({
			type: "post",
			url: "${urlPrefixOwn}login?ownid=" + $ownid.val()+"&ownpwd="+$ownpwd.val(),
			success: function(data){
				if (data == "no_ownid") {
					alert("아이디가 없습니다."); 
				}
				else if (data =='no_ownpwd'){
					alert("비밀번호 불일치"); 
				}
				else if(data == 'no_approval'){
					alert("승인이 되지 않았습니다.");
				}
				else{
					/* location.href = "/room/"+ $ownid; */
					location.href = "/room/"+$ownid.val();
				}
			},
			dataType: "text"
		});
	});
	});
	

/* 	function businesssend(f) {
		let url = "/business/login";
		var ownid = f.ownid.value;

		let param = "ownid=" + ownid + "&ownpwd=" + f.ownpwd.value;
		sendRequest(url, param, resultFn, "POST");
	}
	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			//no_id, no_pwd, clear중 하나를 받는다
			var data = xhr.responseText;

			var json = eval(data);
			//json ---> [{'res':'clear'}, {'id':'aaa'}]
			//json[0].res == 'clear'
			//json[1].id

			if (json[0].res == 'no_ownid') {
				alert("아이디가 없습니다.");
			} else if (json[0].res == 'no_ownpwd') {
				alert("비밀번호 불일치");

			} else if (json[0].res == 'no_approval') {
				alert("승인 대기중입니다.");
			} else {
				location.href = "business_main.do?ownid=" + json[1].id;
			}
		}
	} */

	Kakao.init('7c7fc9be5a5c5e37975ce524e7a39cf2');
	console.log(Kakao.isInitialized());
	function loginWithKakao() {
		Kakao.Auth
				.login({
					success : function(authObj) {
						/* alert(JSON.stringify(authObj)) */

						Kakao.API
								.request({
									url : '/v2/user/me',
									success : function(res) {
										/* alert(JSON.stringify(res)) */
										const mememail = res.id
										const name = res.properties.name
										location.href = 'kakaoLogin.do?mememail='
												+ mememail + '&memname=' + name
									},
									fail : function(error) {
										alert('login success, but failed to request user information: '
												+ JSON.stringify(error))
									},
								})

					},
					fail : function(err) {
						alert(JSON.stringify(err))
					},
				})
	}
</script>
</head>


<body>

	<div class="seongi" style="margin-top: 50px;">
		<a class="seongi" href="main.do"><img
			src="${rc.contextPath }/resources/img/main/logo.png"></a>
	</div>
	<div class="tabs" style="margin-top: 10px;">
		<input id="all" type="radio" name="tab_item" checked> <label
			class="tab_item" for="all">고객 로그인</label> <input id="programming"
			type="radio" name="tab_item"> <label class="tab_item"
			for="programming">사업자 로그인</label>



		<!-- 고객 로그인 폼 -->
		<div class="tab_content" id="all_content">

			<form>
				<div>

					<input id="ID_check" class="form-control" name="memid" placeholder="아이디를 입력해주세요."> 
					<input id="ID_check2" class="form-control" type="password" name="mempwd" placeholder="비밀번호를 입력해주세요."> 
					<input id="login-button" class="form-control" type="button" value="로그인" >
<!-- 					<input id="login-button" class="form-control" type="button" value="로그인" onclick="send(this.form)"> -->
				</div>
				<!-- 카카오톡 로그인 -->
				<%-- <div class="seongi" style="margin-top: 50px;">
					<a id="custom-login-btn" href="javascript:loginWithKakao()">
						<button type="button" class="default_btn rounded mt-1"
							style="background: rgb(252, 229, 30);">
							<span class="small_text"> <img alt="logo"
								src="${rc.contextPath }/resources/img/main/kakaotalk.png"> 카카오톡으로
								로그인
							</span>
						</button>
					</a>
				</div> --%>
			</form>

			<ul style="margin-top: 10px;">
				<li><a href="${urlPrefix}form" class="nav-link text-black"
					style="color: black;">회원가입</a></li>
				<li><a href="#" class="nav-link text-black"
					style="color: black;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀번호 재설정</a></li>
			</ul>
		</div>



		<!-- 사업자 로그인 폼 -->

		<div class="tab_content" id="programming_content">
			<form>

				<input id="ID_check" class="form-control" name="ownid" placeholder="사업자 아이디를 입력해주세요."> 
				<input id="ID_check2" class="form-control" type="password" name="ownpwd" placeholder="비밀번호를 입력해주세요."> 
				<input id="login-button" name="chkBubtn" class="form-control" type="button" value="로그인" >
				<!-- <input id="login-button" class="form-control" type="button" value="로그인" onclick="businesssend(this.form)"> -->
			</form>
			<ul style="margin-top: 10px;">
				<li><a href="/business/form"
					class="nav-link text-black" style="color: black;">회원가입</a></li>

				<li><a href="#" class="nav-link text-black"
					style="color: black;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀번호
						재설정</a></li>
			</ul>
		</div>

	</div>
</body>
</html>