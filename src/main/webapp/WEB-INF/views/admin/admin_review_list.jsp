<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/lodsing/resources/js/bootstrap.js"></script>
<script src="/lodsing/resources/js/jquery-3.6.0.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="/lodsing/resources/css/bootstrap.css">
<link rel="stylesheet" href="/lodsing/resources/css/custom.css">

<script type="text/javascript"
   src="/lodsing/resources/js/httpRequest.js"></script>
<script>

// 신고된 리뷰 report 컬럼 유지로 변경

function send(f) {

   var url = "admin_review_modify.do";
   var param = "idx=" + f.idx.value;
   sendRequest(url, param, resultFunc, "post");

}

function resultFunc() {

   if (xhr.readyState == 4 && xhr.status == 200) {
      //컨트롤러에서 삭제후 return해준 데이터를 받는다. 
      var data = xhr.responseText;

      if (data == 'no') {
         alert("수정되지 않았습니다.");

      } else if (data == 'yes') {
         alert("수정 완료");
         location.href = "admin_review_list.do";
      }
   }
}




   /* 삭제버튼 클릭 */
   function del(f) {

      //Ajax를 통해 idx를 서버로 전송
      var url = "admin_review_delete.do";
      var param = "idx=" + f.idx
      .value;
      sendRequest(url, param, resultFunc1, "Post");

   }//del()

   /* 삭제결과를 확인할 콜백메서드 */
   function resultFunc1() {

      if (xhr.readyState == 4 && xhr.status == 200) {

         //컨트롤러에서 삭제 후 return해준 데이터를 받는다
         var data = xhr.responseText;

         if (data == 'no') {
            alert("삭제실패");
            return;
         } else {
            alert("삭제성공");
            location.href = "admin_review_list.do";
         }

      }

   }
</script>

<style>
th, td {
   text-align: center;
}
</style>

</head>
<body>

   <div class="seongi" style="margin-top: 50px;">
      <a class="aaa" href="main.do"><img
         src="/lodsing/resources/img/main/logo.png"></a>
   </div>

   <div class="business_table">

      <ul class="nav nav-tabs">
         <li class="nav-item"><a class="nav-link" aria-current="page"
            href="admin.do" style="font-weight: bold;">사업자 관리</a></li>
            
         <li class="nav-item"><a class="nav-link "
            href="admin_member_list.do" style="font-weight: bold;">회원 관리</a></li>
            
         <li class="nav-item"><a class="nav-link active" 
         href="admin_review_list.do" style="font-weight: bold;">리뷰 관리</a></li>


      </ul>

   </div>

      <div>
      <c:forEach var="vo" items="${m_list}">
      <form>
      <c:if test="${vo.report =='신고'}">
                                    
         <div id="review-box" style="padding: 20px 20px 20px 20px;     margin:0 auto; margin-top:20px;
            width:50%; border : 1.5px solid rgba(0, 0, 0, 0.1); border-radius: 5px;">
            <div style="color:black; font-size: 14px">
               <div class="row">
                  <div class="col-sm-6 review_star">
                     <c:choose>
                        <c:when test="${vo.rating == '1' }">⭐</c:when>
                        <c:when test="${vo.rating == '2' }">⭐ ⭐</c:when>
                        <c:when test="${vo.rating == '3' }">⭐ ⭐ ⭐</c:when>
                        <c:when test="${vo.rating == '4' }">⭐ ⭐ ⭐ ⭐</c:when>
                        <c:when test="${vo.rating == '5' }">⭐ ⭐ ⭐ ⭐ ⭐</c:when>
                     </c:choose>   
                  </div>
                  
                  <div class="col-sm-6 review_email" style="text-align: right;">
                     ${fn:substring(vo.regdate,0,4)} -
                     ${fn:substring(vo.regdate,5,7)} -
                     ${fn:substring(vo.regdate,8,10)}
                  </div>
               </div>
   
               <div class="review_email">
               <br>
                  <span>No : ${vo.idx}</span> <br> 
                  <span>작성자 : ${vo.memid}</span> <br> 
                  <span>업체명 : ${vo.subject}</span>
                  
               </div>
            </div>
            
            <hr style="color: rgba(0, 0, 0, 0.5);">
            
            <div class="review_content mt-1">
               <span>${vo.content}</span>
            </div>
            <br>
            <br>
            
            <div class="review_content mt-1">
               <span>${vo.filename}</span>
            </div>
            
            <hr style="color: rgba(0, 0, 0, 0.5);">
            <input type="hidden" name="idx" value="${vo.idx}">
            <input type="button" value="삭제" onclick="del(this.form);" class="btn btn-primary">
            <input type="button" value="유지" onclick="send(this.form);" class="btn btn-primary">
         </div>
         </c:if>
         <!-- 리뷰 끝 -->
         </form>
      </c:forEach>
   </div>

   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>