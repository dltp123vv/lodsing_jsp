<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script src="${rc.contextPath }/resources/js/bootstrap.js"></script>
<script src="${rc.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${rc.contextPath }/resources/css/bootstrap.css">
<link rel="stylesheet" href="${rc.contextPath }/resources/css/custom.css">

<script type="text/javascript" src="${rc.contextPath }/resources/js/httpRequest.js"></script>
<script type="text/javascript">


/* function auth(f) {
   
   var phone = f.memtel.value.trim();
   var check2 = false;
   var url = "phoneAuth.do";
   var param = "memtel=" + phone;
   sendRequest(url, param, resultFunc1, "post");

} */

/* function resultFunc1() {

   if (xhr.readyState == 4 && xhr.status == 200) {
      //컨트롤러에서 삭제후 return해준 데이터를 받는다. 
      var data = xhr.responseText;

      if (data == "error") {
         alert("유효한 번호를 입력해주세요");

      }else if ( data == "yes_tel"){
         
         alert("중복된 전화번호 입니다.")

            return;
            
         } else {
             alert("인증번호를 전송했습니다.");
         }
     
         const btn = document.querySelector('#code_btn')
         btn.disabled = false;
         
         document.getElementById('input_tel').readOnly = true;
         
         code2 = data;
      }
   } */
 
//휴대폰 인증번호 대조

/* function codenumcheck(f) {
      
   let codenum = f.code.value.trim();
   
   
   if(codenum == code2){
      
      alert("일치하는 인증번호 입니다."); 
      check2 = true;
      
   }else{
      alert("인증번호가 일치하지 않습니다.")
      check2 = false;
   }
}  */
/* function idCheck(f) {
   var memid = f.memid.value.trim();
   var check = false;

   var url = "memidcheck.do";
   var param = "memid=" + memid;
   sendRequest(url, param, resultFunc, "post");

} */
/* function resultFunc() {

   if (xhr.readyState == 4 && xhr.status == 200) {
      //컨트롤러에서 삭제후 return해준 데이터를 받는다. 
      var data = xhr.responseText;

      if (data == 'yes_id') {
         alert("중복되는 아이디 입니다.");
         check = false;
      } else if (data == 'no_id') {
         alert("가입 가능한 아이디입니다.");
         check = true;
      }
   }
}  */

// 게시글 업로드
function insert(f) {
   var memid = f.memid.value.trim();
   var memname = f.memname.value.trim();
   var mempwd = f.mempwd.value.trim();
   var mempwd2 = f.mempwd2.value.trim();
   var memgender = f.memgender.value.trim();
   var mememail = f.mememail.value.trim();
   var membirth = f.membirth.value.trim();
   var memtel = f.memtel.value.trim();
   /* var code = f.code.value.trim(); */
    
   
   if (memid == "") {
      alert("아이디를 입력하세요.");
      f.memid.focus();
      return;
   }
   if (memname == "") {
      alert("이름 입력하세요.");
      f.memname.focus();
      return;
   }
   if (mempwd == "") {
      alert("비밀번호를 입력하세요.");
      f.mempwd.focus();
      return;
   }
   if (mempwd != mempwd2) {
      alert("비밀번호를 확인해주세요.");
      f.mempwd2.focus();
      return;
   }

   if (memgender == "") {
      alert("성별을 입력하세요.");
      f.memgender.focus();
      return;
   }
   if (mememail == "") {
      alert("이메일을 입력하세요.");
      f.mememail.focus();
      return;
   }
   if (membirth == "") {
      alert("생년월일을 입력하세요.");
      f.membirth.focus();
      return;
   }

   
/*    if (code == "") {
       alert("인증번호를 입력하세요.");
       f.code.focus();
       return;
    } */
    if (check == false){
      alert("아이디 중복체크를 하세요");
      return;
   }
 

   f.action = "/member/form";
   f.method = "post";
   f.submit();
}

   function passwordCheckFunction() {
      var userPassword1 = $('#userPassword1').val();
      var userPassword2 = $('#userPassword2').val();
      if (userPassword1 != userPassword2) {
         $('#passwordCheckMessage').html('비밀번호가 일치하지 않습니다.').css("color", "red");
      } else {
         $('#passwordCheckMessage').html('비밀번호가 일치합니다.').css("color", "green");
      }
   }
</script type="text/javascript">
<script>
$(function(){
	var $memid = $("form").find('input[name=memid]');
		
	
	$("#checkId").click(function(){
		if ($memid.val() == "") {
			alert("아이디를 입력하세요.");
			$memid.focus();
			return false;
		}
		
		$.ajax({
			type: "get",
			url: "${urlPrefix}checkId?memid=" + $memid.val(),
			success: function(data){
				if (data == 'yes_id') {
			         alert("중복되는 아이디 입니다.");
			         check = false;
			      } else if (data == 'no_id') {
			         alert("가입 가능한 아이디입니다.");
			         check = true;
			      }
				},
			dataType: "text"
		});
	});
	
	
	
	
	
//휴대폰 번호 인증

});
</script>
</head>
<body>


   <div class="container" style="margin-top: 5%;">
      <div class="seongi">
         <a class="seongi" href="main.do"><img src="${rc.contextPath }/resources/img/business/logo.png"></a>
      </div>
      <form method="post" enctype="multipart/form-data">
         <table class="table table-bordered table-hover"
            style="text-align: center;">
            <thead>
               <tr>
                  <th colspan="3"><h4>회원 가입</h4></th>

               </tr>
            </thead>
            <tbody>
                <tr>
                  <td style="width: 110px;"><h5>아이디</h5></td>
                  <td>
                  	<input class="form-control" type="text" id="memid" name="memid" maxLength="20" placeholder="아이디를 입력해주세요.">
                  </td>
                  <td style="width: 110px;">
                  	<!-- <button class="btn btn-primary" type="button" onclick="idCheck(this.form);">중복체크</button> -->
                  	<button class="btn btn-primary" type="button" id="checkId">중복체크</button>
                  </td>
               </tr>
               <tr>
                  <td style="width: 110px;"><h5>비밀번호</h5></td>
                  <td colspan="2"><input class="form-control" type="password"
                     onkeyup="passwordCheckFunction();" id="userPassword1"
                     name="mempwd" maxLength="20" placeholder="비밀번호를 입력해주세요."></td>
               </tr>
               <tr>
                  <td style="width: 110px;"><h5>비밀번호 확인</h5></td>
                  <td colspan="2"><input class="form-control " type="password"
                     onkeyup="passwordCheckFunction();" id="userPassword2"
                     name="mempwd2" maxLength="20" placeholder="비밀번호를 확인해주세요."></td>
               </tr>
               <tr>
                  <td style="width: 110px;"><h5>이름</h5></td>
                  <td colspan="2"><input class="form-control" type="text"
                     id="userName" name="memname" maxLength="20"
                     placeholder="이름을 입력해주세요."></td>
               </tr>

               <tr>
                  <td style="width: 110px;"><h5>성별</h5></td>
                  <td colspan="2"><select name="memgender"
                     class=" form-control " aria-label="Default select example">
                        <option selected>성별을 선택해주세요</option>
                        <option value="남자">남자</option>
                        <option value="여자">여자</option>
                  </select></td>
               </tr>

               <tr>
                  <td style="width: 110px;"><h5>휴대전화</h5></td>
                  <td colspan="2">
                     <!-- <input type="text" name="rand" id="rand"> 인증번호 확인용 -->
                     <div class="row mt-5">
                        <div class="col-sm-8">
                           <input type="tel" name="memtel" 
                            class="form-control form-control-lg" id="tel" placeholder="전화번호(- 빼고 작성해주세요)" pattern="[0-9]{11}" required>
                        </div>
                       <!--  <div class="col-sm-4">
                           <button type="button" id="tel_btn" class="default_btn rounded"
                              style="height: 48px;" onclick="auth(this.form)">인증코드
                              전송</button>
                        </div> -->
                     </div>
                     
                     <!-- <div class="row mt-3">
                        <div class="col-sm-8">
                           <input type="text" name="code" id="input_code"
                              class="form-control form-control-lg" placeholder="전송받은 코드"
                              pattern="[0-9]{6}" required>
                        </div>
                        <div class="col-sm-4">
                           <input type="button" id="code_btn" class="default_btn rounded"
                              style="height: 48px;" onclick="codenumcheck(this.form)" value="코드 확인" disabled>
                              
                           <input type="hidden" id="phoneDoubleChk" /> 
                           
                        </div>
                     </div> -->

                  </td>
               </tr>

               <tr>
                  <td style="width: 110px;"><h5>이메일</h5></td>
                  <td colspan="2"><input class="form-control" type="email"
                     id="userEmail" name="mememail" maxLength="20"
                     placeholder="이메일을 입력해주세요."></td>
               </tr>

               <tr>
                  <td style="width: 110px;"><h5>생년 월일</h5></td>
                  <td colspan="2"><input class="form-control" type="text"
                     id="userEmail" name="membirth" maxLength="20"
                     placeholder="생년월일을 입력해주세요. ( ex : 19960515 )"></td>
               </tr>

               <tr>
                  <td style="text-align: left" colspan="3">
                     <h5 id="passwordCheckMessage"></h5> 
                     <input class="btn btn-primary pull-right" type="button" value="회원가입" onclick="insert(this.form);">



                  </td>
               </tr>

            </tbody>
         </table>
      </form>
   </div>

   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>