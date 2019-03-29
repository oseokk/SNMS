<%@page import="java.util.Random"%>
<%@page import="seok.yun.na.dtos.BookingDto"%>
<%@page import="seok.yun.na.dtos.CinemaDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<%
   response.setContentType("text/html; charset=UTF-8");
%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<%
   List<CinemaDto> clists = (List<CinemaDto>) request.getAttribute("clists");
   List<BookingDto> lists = (List<BookingDto>) request.getAttribute("lists");
%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>KOKOA</title>
<link href="css/singlePageTemplate.css" rel="stylesheet" type="text/css">
<script>var __adobewebfontsappname__="dreamweaver"</script>
<script src="http://use.edgefonts.net/source-sans-pro:n2:default.js"
   type="text/javascript"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
   
<script type="text/javascript">

function itemSum() { // -------------금액계싼------------------------------------------안됨
   var sum = 0;
   var obj = document.getElementsByName("seat_cd");
      for(var i = 0; i<obj.length; i++){
         if(obj[i].checked){
            sum++;
         }else if(obj[i].unchecked){
            sum--;
         }
      }
      document.getElementById("total_sum").value=(sum*10000).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   }

// $(function(){
//    var cin_cd = $("#cin_cd").val();
//    $.ajax({
//       method : "get", // 서버에 전송하는 방식
//       url : "./getMoviecdAjax.do",
//       data : "cin_cd=" + cin_cd,
//       async : true, //비동기식(기본:비동식, 동기식 false)
//       success : function(data) { // 서버통신 성공했을때 
//          // alert("성공");
//          var a = data.lists;
//          // alert(a[0].play_date);
//          $("#getinfo").empty();
//          $("#gettime").empty();
//          $("#getseat").empty();
//             for (var i = 0; i < a.length; i++) {
//                var str = a[i];
//                $("#getinfo").append("<input type='text' id='moviecd' name='moviecd' value='"+str.moviecd+"'></input>");
//             }
//       }, // success가 실패 했을때
//       error : function() {
//          alert("서버통신에 실패함");
//       }
//    }); // ajax 
// }
// });

function tstest(val){ // -------------상영날짜띄우기------------------------------------------------완료
   var moviecd =  document.getElementsByName("moviecd")[val].value;
//    alert(moviecd);
   document.getElementById("moivecd_obj").value = moviecd;
//    var moviecd = document.getElementById("moviecd")[val].value;
   var cin_cd = $("#cin_cd").val();
    $.ajax({
      method : "get", // 서버에 전송하는 방식
      url : "./book_playAjax.do",
      data : "cin_cd=" + cin_cd + "&" + "moviecd=" + moviecd,
      async : true, //비동기식(기본:비동식, 동기식 false)
      success : function(data) { // 서버통신 성공했을때 
         // alert("성공");
         var a = data.lists;
         // alert(a[0].play_date);
         $("#getinfo").empty();
         $("#gettime").empty();
         $("#getseat").empty();
            for (var i = 0; i < a.length; i++) {
               var str = a[i];
               $("#getinfo").append("<li id='play_date' class='click' onclick='tdtest(this.value)''>" + str.play_date + "</li>");
               $("#getinfo").append("<input type='hidden' id='playhall_cd' name='playhall_cd' value='"+str.playhall_cd+"'></input>");
            }
      }, // success가 실패 했을때
      error : function() {
         alert("서버통신에 실패함");
      }
   }); // ajax 
}


function tdtest(val){ // -------------시간띄우기------------------------------------------------완료
      var moviecd =  document.getElementsByName("moviecd")[val].value;
      var cin_cd = $("#cin_cd").val();
       $.ajax({
            method : "get", // 서버에 전송하는 방식
                 url:"./book_playAjax.do",
                data :  "cin_cd="+cin_cd+"&"+"moviecd="+moviecd,
            async : true, //비동기식(기본:비동식, 동기식 false)
            success : function(data){ // 서버통신 성공했을때 
//                alert("성공");
            var a = data.lists;
//                alert(a[0].play_date);
               $("#gettime").empty();
               $("#getseat").empty();
                  for(var i=0; i<a.length;i++){
                     var str=a[i];
                     $("#gettime").append("<li id='start_time' class='click' onclick='tftest(this.value)''>"+str.start_time+"</li>");
                     $("#gettime").append("<input type='hidden' id='play_cd' name='play_cd' value='"+str.play_cd+"'></input>");
//                      $("#gettime").append("<input type='text' id='moviecd' name='moviecd' value='"+str.moviecd+"'></input>");
                  }
                  }, // success가 실패 했을때
                  error : function(){
                     alert("서버통신에 실패함");
                  }
            }); // ajax
      };

function tftest(val){ // --------------좌석띄우기-----------------------------------------------완료
      var playhall_cd =  document.getElementsByName("playhall_cd")[val].value;
//       alert(playhall_cd);
      var cin_cd = $("#cin_cd").val();
       $.ajax({
            method : "get", // 서버에 전송하는 방식
                 url:"./book_seatAjax.do",
                data :  "cin_cd="+cin_cd+"&"+"playhall_cd="+playhall_cd, //"cin_cd="+
            async : true, //비동기식(기본:비동식, 동기식 false)
            success : function(data){ // 서버통신 성공했을때 
            var a = data.lists;
            $("#getseat").empty();
            for(var i=0; i<a.length;i++){
               var str=a[i];
//                $("#getseat").append("<li id='seat' name='chk' style='width:20px; margin-left:40px; text-align: center;' onClick='itemSum()'>"+str.seatrow+str.seatcol+"</li>")
               $("#getseat").append("<input type='checkbox'  id='seat_cd' name='seat_cd' style='width:15px; margin-left:40px; text-align: center;' value='"+str.seat_cd+"' onClick='itemSum()'>"+str.seatrow+str.seatcol+"</input>")
                  if(((i+1)%6)==0){
                     $("#getseat").append("<br/>");
                  }//if
               }
                  }, // success가 실패 했을때
                  error : function(){
                     alert("서버통신에 실패함");
                  }
            }); // ajax
      };

$(function(){  // --------------체크박스 제한----------------------------------------안됨
       $("input[name=chk]:checkbox").change(function() {
           var cnt = 6;
           if( cnt==$("input[name=chk]:checkbox:checked").length ) {
               $(":checkbox:not(:checked)").attr();
           } else {
               $("input[name=chk]:checkbox").removeAttr();
           }
       });
});

// function change1(obj){ 
//     obj.style.background = '#4eaeaa';
//     obj.style.color = 'white';
// }

// function bookinggg(){
//    var seat=document.reservation.chk.value;
//    if(seat == ""){
//                 alert('예매정보를 모두 선택해 주세요.');
//                 return false;      
//       }
//       action="./bookinsert.do";
//       document.reservation.submit();
//    }

function bookinggg(){ // --------------예매하기2 // 입력된값 확인하기---------------------------------------
//    var seat_cd = document.getElementsByName("seat_cd");
   var mem_id = $("#mem_id").val();
   var moviecd = $("#moviecd").val();
   var play_cd = $("#play_cd").val();
   var playhall_cd = $("#playhall_cd").val();
//    var seat_cd =  $("#seat_cd").val();
//    alert(mem_id);alert(moviecd);alert(play_cd);alert(playhall_cd);alert(seat_cd);
   var sh="";
   var obj = document.getElementsByName("seat_cd");
   
   for(var a=0; a < obj.length ; a++){
      if(obj[a].checked){
         alert(obj[a].value);
         sh += obj[a].value+":";
      }
   }
   alert(sh); 
}

</script>   

<!-- Main Container -->
<div class="container">
   <!-- Navigation -->
   <%@include file="Header.jsp"%>
   <div class="maincontents">
      <div class="title_box_bk">
         <div class="booking_title">
            <p>예매하기</p>
         </div>
      </div>
      <form action="./bookinsert.do" method="post" onsubmit="ggg()">
      <div class="booking_contents_box">
         <input type="hidden" readonly="readonly" id="cin_cd"   value="${cin_cd}">
         <input type="hidden" readonly="readonly" id="mem_id" name="mem_id" value="${lDto.mem_id}">
         <div class="list_box list_box_w" >
            <div class="bkng_list_title">영화선택</div>
            <ul class="bkng_list_con">
            <%
               for (int n = 0; n<lists.size() ; n++) {
                  BookingDto dto = lists.get(n);
//                   Random r = new Random(); 
//                   int i = r.nextInt(20); 
            %>
               <li id="title" class="click"  value=<%=n%> onclick="tstest(this.value)">
                     <%=dto.getTitle()%>
                     <input  type="hidden" readonly="readonly" id="moviecd" name="moviecd"  value="<%=dto.getMoviecd()%>">
<%--                   <input type="hidden" readonly="readonly" id="playhall_cd"  name="playhall_cd" value="<%=dto.getPlayhall_cd()%>" > --%>
               </li>
               <%}%>
            </ul>
         </div>
         <div class="list_box list_box_w">
            <div class="bkng_list_title">날짜선택</div>
            <ul class="bkng_list_con" id="getinfo" >

            </ul>
         </div>
         <div class="list_box list_box_w">
            <div class="bkng_list_title">시간선택</div>
            <ul class="bkng_list_con" id="gettime">

            </ul>
         </div>
      </div>
      <div class="booking_contents_box">
         <div class="list_box" id="left">
            <div class="bkng_list_title">좌석선택</div>
               <img src="images/seat.png" >
            <div class="bkng_img"  id="getseat" >
<!--                <ul class="bkng_img"  id="getseat" > -->
               
<!--                </ul> -->
            </div>
         </div>
         <div class="list_box" id="right">
            <div class="bkng_list_title">결제금액</div>
            <div class="bkng_info">
               <div class="num"><input type="text"  id="total_sum" readonly="readonly" ></div>
               <div class="num" id="won">원</div>
            </div>
            <div class="bkng_btn">
               <input type="hidden" name="moivecd_obj" id="moivecd_obj" value="">
               <input type="submit"  value="예매하기" class="btn" >
<!--             <input type="button"  value="예매하기2" class="btn" onclick="bookinggg()" > -->
            </div>
         </div>
      </div>
      </form>
   </div>
   <!-- Copyrights Section -->
   <%@include file="Footer.jsp"%>
</div>
<!-- Main Container Ends -->