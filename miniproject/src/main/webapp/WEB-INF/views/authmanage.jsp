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
	#authmodal,#banmodal{
		width: 500px;
		height: 800px;
    	left: 50%;
    	top: 50%;
    	transform: translate(-50%,-50%);
    	position: fixed;
    	display: none;
    	margin: 0;
  		justify-content: center;
  		align-items: center;
  		background-color: rgba(160, 160, 160, 1);
    	overflow-y: scroll;
	}
	.bansituation,.bansubmitbody{
		margin-top: 60px;
		margin-bottom: 60px;
	}
	.authlist{
		margin-top: 60px;
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
										<input class="authinput" type="hidden" value="${auth.auth}">
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
			<button id="authmodalclose">close</button>
				<h2>권한 설정 창</h2>
			</div>
			<div class="authmodalbody">
				<h3>사용자 아이디</h3>
				<div class="authmodaluserid">
					
				</div>
				<ul class="authlistview">
				</ul>
				<h4>권한 추가</h4>
				<div>
				
				<input type="text" class="inputauth">
				</div>
			</div>
			<div class="authmodalfooter">
			
			<div class="authbtnset">
				<button class="authsubmit">적용하기</button>
			</div>
			</div>
		</div>
	</div>
</div>		


<div class="modal fade" id="banmodal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="banmodalcontent">
			<div class="banmodalheader">
			<button id="banmodalclose">close</button>
				<h3>차단 설정 창</h3>
			</div>
			<div class="banmodalbody">
				<h3>사용자 아이디</h3>
				<div class="banmodaluserid">
					
				</div>
				<div class="bansituation">
					<h4>차단 상태</h4>
					<h4>차단 사유</h4>
					<h4>차단 적용 일자</h4>
					<h4>차단 해제 일자</h4>
				</div>
				<div class="bansubmitbody">
					<div class="bantime">
						<h4>차단 기간</h4>
						<input type="text" class="inputbantime">
					</div>
					<div class="banreason">
						<h4>차단 사유</h4>
						<input type="text" class="inputbanreason">
					</div>
				</div>
			</div>
			<div class="banmodalfooter">
				
			<div class="banbtnset">
				<div class="bancanclediv">
					<button class="bancancle">차단해제 하기</button>
				</div>
				<div class="bansubmitdiv">
					<button class="bansubmit">차단하기</button>
				</div>
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
	var authclose=$('#authmodalclose');
	var banclose=$('#banmodalclose');
	var authui=$('.authlistview');
	var authmodal=$('#authmodal');
	var authmodaluserid=$('.authmodaluserid');
	var banmodal=$('#banmodal');
	var banmodaluserid=$('.banmodaluserid');
	var authsubmitbtn=$('.authsubmit');
	
	aubtn.on("click",function(e){
		var userinfo=$(this).closest('tr');
		var userid=userinfo.find('td:first').text();
	    var authlist=userinfo.find('.authlist p').map(function() {
            return $(this).text().trim();
        }).get();
		
		var str="";
		var idstr=""
		authui.empty();
		authmodaluserid.empty();
		
		idstr=idstr+"<h3>"+userid+"</h3>"
        $.each(authlist, function(index, value) {
            str += "<div class='authelement'>";
            str += "<p>" + value + "</p>";
            str += "<button class='authelementdelete' data-userid='"+userid+"'>권한 삭제</button>";
            str += "</div>";
        });
		authmodaluserid.append(idstr);
		authui.append(str);
		authmodal.css("display","block");
	});
	banbtn.on("click",function(e){
		var userinfo=$(this).closest('tr');
		var userid=userinfo.find('td:first').text();
		var idstr=""

		banmodaluserid.empty();
		idstr=idstr+"<h3>"+userid+"</h3>"
		banmodaluserid.append(idstr);
		
		//ajax 실행으로 차단 현황을 가져온다.
		banmodal.css("display","block");
	});
	authclose.on("click",function(e){
		authmodal.css("display","none");
	});
	banclose.on("click",function(e){
		banmodal.css("display","none");
	});
	
	var bansubtn=$('.bansubmitdiv');
	var bandebtn=$('.bancanclediv');
	authui.on("click","button",function(e){
		var authvalue=$(this).closest('.authelement').find('p').text();
		var authid=$(this).data('userid');
		console.log(authid);
		console.log(authvalue);
		//ajax로 권한 삭제 메소드 수행
	});
	var authbtndiv=$('.authbtnset');
	authbtndiv.on("click","button","button",function(e){
		var authValue=$('.inputauth').val();
		var userid=$('.authmodaluserid').find('h3').text();
		console.log(authValue);
		console.log(userid);
		//ajax로 권한 추가 메소드 수행
	});
	bansubtn.on("click","button",function(e){
		var bantime=$('.inputbantime').val();
		var banreason=$('.inputbanreason').val();
		var userid=$('.banmodaluserid').find('h3').text();
		console.log(bantime);
		console.log(banreason);
		console.log(userid);
		//ajax로 차단 메소드 수행
	});
	bandebtn.on("click","button",function(e){
		var userid=$('.banmodaluserid').find('h3').text();
		console.log(userid);
		//ajax로 차단 해제 메소드 수행
	});
});
</script>
</body>
</html>