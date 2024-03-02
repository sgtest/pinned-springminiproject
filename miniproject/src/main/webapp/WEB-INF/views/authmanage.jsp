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
<title>관리자 페이지</title>
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
	.memberlist{
			margin-top:30px;
    		background-color: #f0f0f0;
    		padding: 10px; 
    		border: 1px solid #ccc; 
   			margin-bottom: 10px; 
   			margin-left:20px;
            margin-top: 20px;
            width: 70%;
	}
	.memberlist_content{
			max-height:1000px;
    		overflow-y: scroll;
            text-align: center;
	}
	.memberlist_table{
            width: 100%;
	}
	.table_element{
  			border: 1px solid #fff;
  			border-radius: 5px;
			margin-top: 50px;
	}
	</style>
</head>
<body>
	<button onclick="location.href='/board/listboard'">게시판에 글쓰기</button><br>
	
	<div class="memberlist">
		<div class="memberlist_content" align="center">
			<table boarder="1" class="memberlist_table">
				<thead>
					<tr>
						<th>회원의 아이디</th>
						<th>회원의 닉네임</th>
						<th>회원의 가입날짜</th>
						<th>회원의 수정날짜</th>
						<th>회원 허용여부</th>
						<th>회원의 휴대폰 번호</th>
						<th>회원의 권한 리스트</th>
						<th>회원의 권한 수정</th>
						<th>회원 차단</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="member" items="${userlist}">
						<tr class="table_element">
							<td>${member.userid}</td>
							<td>${member.username}</td>
							<td>${member.regdate}</td>
							<td>${member.udate}</td>
							<td>${member.enabled}</td>
							<td>${member.phone}</td>
							<td>
								<div class="authlist" data-userid="${member.userid}">
									<c:forEach var="auth" items="${member.authlist}">
										<p>${auth.auth}</p>
									</c:forEach>
								</div>
							</td>
							<td><button class="authbtn" data-userid="${member.userid}">권한수정</button></td>
							<td><button class="banbtn" data-userid="${member.userid}">차단 및 차단해제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>


<div class="modal fade" id="authmodal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="authmodalcontent">
			<div class="authmodalheader">
			</div>
			<div class="authmodalbody">
			</div>
			<div class="authmodalfooter">
			<div class="authbtnset">
			</div>
			</div>
		</div>
	</div>
</div>		


<div class="modal fade" id="banmodal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="banmodalcontent">
			<div class="banmodalheader">
			</div>
			<div class="banmodalbody">
			</div>
			<div class="banmodalfooter">
			<div class="banbtnset">
			</div>
			</div>
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
	var aubtn=$('.authbtn');
	var banbtn=$('.banbtn');
	
	aubtn.on("click",function(e){
		
	});
	banbtn.on("click",function(e){
		
	});
	
});
</script>
</body>
</html>