<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이 페이지</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
          crossorigin="anonymous">
<style>
		button, input[type="button"]{
  			background-color: #000;
  			color: #fff;
  			padding: 10px 20px;
  			border: 1px solid #fff;
  			border-radius: 5px;
  			cursor: pointer;
		}
		input[type="button"]:hover,button:hover {
  			background-color: #e5e5e5;
  			color: #000;
		}
		.mypagerecordtab,.totalmypage{
			list-style-type: none;
		}
		.mypage-tab{
    		display: inline-block;
  			background-color: #000;
  			color: #fff;
  			cursor: pointer;
		}
		.select{
  			background-color: #e5e5e5;
  			color: #000;
		}
		.mypage-tabcontent{
   			display: none;
    		padding: 10px;
		}
		.show{
    		display: block;
		}
</style>
</head>
<body>

	<div class="mypagetotal">

		<div class="mypagetop">
			<button id="homebtn" data-href="board/listboard">홈으로 돌아가기</button>
		</div>

		<div class="mypageinfo">

			<ul class="totalmypage">
			<li class="mypagecommon">
			<div class="mypageinfobody">
				<ul class="mypagerecordtab">
					<li class="mypage-tab select" id="memberinfotab">
						나의 회원정보
					</li>

					<li class="mypage-tab" id="boardrecordtab">
						작성글 기록
					</li>

					<li class="mypage-tab" id="commentrecordtab">
						작성 댓글 기록
					</li>

					<li class="mypage-tab" id="filerecordtab">
						업로드 파일 기록
					</li>
				</ul>

				<div class="mypagerecordcontent">
					<div class="mypage-tabcontent show" data-tabid="memberinfotab">
						<p>테스트 1번</p>
					</div>

					<div class="mypage-tabcontent" data-tabid="boardrecordtab">
						<p>테스트 2번</p>
					</div>

					<div class="mypage-tabcontent" data-tabid="commentrecordtab">
						<p>테스트 3번</p>
					</div>

					<div class="mypage-tabcontent" data-tabid="filerecordtab">
						<p>테스트 4번</p>
					</div>
				</div>
			</div>
			</li>
			
			<li class="mypageetc">
			
			</li>
			</ul>
			
		</div>

	<div class="mypagebottom">
		<div class="mbtnset">
			<button>회원정보 수정하기</button>
		</div>
	</div>

</div>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5PtkFExj5u9bOyDDn5a+3pu8L+I2LZ"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
        crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	var tablist=$('.mypage-tab');
	var tabcontentlist=$('.mypage-tabcontent');
	var homebt=$('#homebtn');
	
	tablist.on("click",function(e){
		var tabid=$(this).attr('id');
		var tabobj=$('#'+tabid);
		var tabcontentobj=tabcontentlist.filter('[data-tabid="' + tabid + '"]');
		
		for(var i=0;i<tablist.length;i++){
			$(tablist[i]).removeClass('select');
			$(tabcontentlist[i]).removeClass('show');
		}
		
		tabobj.addClass('select');
		tabcontentobj.addClass('show');
	});
	
	homebt.on("click",function(e){
		window.location.href=homebt.data("href")	
	});
	
});
</script>
</body>
</html>