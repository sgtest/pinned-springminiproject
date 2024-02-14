<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>
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
</style>
</head>
<body>

<div class="topbtnset">
<button id="backloginbtn" data-href="/loginboard">로그인 화면으로 돌아가기</button>
</div>
<form action="/boardjoinaction" method="post" role="form">
	<input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<div>
<h3>비밀번호는 숫자,영문자, 특수문자를 포함하고 8자 이상이여야 하고,<br>휴대폰 번호는 11자여야 하고, 이름은 3자 이상이어야 합니다.</h3>
</div>
<div class="joinset" id="joinidset">
<h4>아이디</h4>
	<input type="text" id="id" name="id" required>
	<input type="checkbox" id="isidchk" name="isidchk" disabled>
	<button id="idcheck">아이디 존재여부 확인</button>
	<br>
</div>

<div class="joinset">
<h4>비밀번호</h4>
	<input type="text" id="passwd" name="passwd" required><br>
</div>

<div class="joinset">
<h4>사용자의 이름</h4>
	<input type="text" id="username" name="username" required><br>
</div>

<div class="joinset">
<h4>휴대폰 번호</h4>
	<input type="text" id="phone" name="phone" required><br>
</div>

<div class="joinset">
<h4>자동등록방지 숫자</h4>
	
</div>

<button id="joinbtn">회원가입 완료</button>

</form>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(document).ready(function(){
	var idset=$('#joinidset');
	var submitbtn=$('#joinbtn');
	var idckbtn=$('#idcheck');
	var idckbox=$('#isidchk');
	var submitform=$("form");
	
	idckbtn.on("click",function(e){
		var inputid=$('#id').val();
		var csrfToken = $("#_csrf").val();
		
		if(inputid === ''||inputid.length === 0){
			alert('아이디를 입력해주세요')
		}
		else if(inputid.length<4){
			alert('충분한 길이의 아이디를 입력해주세요');
		}
		else{
			//ajax를 이용해서 아이디 중복여부 확인
			$.ajax({
				type:'post',
				url:'/idcheckaction',
				data:{ id:inputid},
				dataType:'json',
			    beforeSend: function(xhr) {
			         xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			    },
				success: function(response){
					if(response['result']==="success"){
						idckbox.prop('checked', true);
						idckbtn.prop('disabled', true);
					}else{
						alert("이미 아이디가 존재합니다.");
					}
				},
				error: function(error){
					console.error("아이디 확인 실패");
				}
			});
		}
	});
	
	submitbtn.on("click",function(e){
		var inputpw=$('#passwd').val();
		var inputname=$('#username').val();
		var inputphone=$('#phone').val();
		var csrfToken = $("#_csrf").val();
		if(!idckbox.prop('checked')){
			alert("아이디를 다시 확인해주세요");
			e.preventDefault();
			
		}
		else if(inputpw.length===0||inputname.length===0||inputphone.length===0){

			alert("작성 정보들을 다시 확인해주세요");
			e.preventDefault();	
			
		}
		else{
			//console.log(inputpw);
			//console.log(inputname);
			//console.log(inputphone);
			$.ajax({
				type:'post',
				url:'/etcdatacheckaction',
				data:{passwd:inputpw, username:inputname, phonenumber:inputphone},
				dataType:'json',
			    beforeSend: function(xhr) {
			         xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			    },
				success: function(response){

					console.log(inputpw);
					console.log(inputname);
					console.log(inputphone);
					console.log(response['result']);
					if(response['result']==='failure'){
						alert("작성 정보들을 다시 확인해주세요");
					}else{
						alert("회원가입이 완료되었습니다");
						submitform.submit();
					}
				},
				error: function(error){
					console.error("기타 데이터 확인 실패");
					alert("작성 정보들을 다시 확인해주세요");
				}
			});

		}
	});

	
	var bkloginbtn=$('#backloginbtn');
	bkloginbtn.on("click",function(e){
		var loginhref=bkloginbtn.data("href");
		window.location.href=loginhref;
	});
	
});
</script>
</body>
</html>