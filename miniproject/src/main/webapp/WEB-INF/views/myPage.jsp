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
		.totalmypage{
			
    		text-align: center;
		}
		.mypagerecordtab,.totalmypage{
			list-style-type: none;
		}
		.infomypage-tab{
    		display: inline-block;
  			background-color: #000;
  			color: #fff;
  			cursor: pointer;
		}
		.select{
  			background-color: #e5e5e5;
  			color: #000;
		}
		.infomypage-tabcontent,.toppagetab{
   			display: none;
   			width:1500px;
    		padding: 10px;
		}
		.show{
    		display: block;
		}
		.boardrecordcontent,.commentrecordcontent{
    		padding: 10px;
    		text-align: center;
			max-height:1000px;
    		overflow-y: scroll;
		}
		.recordtable{
			max-height:1000px;
    		overflow-y: scroll;
		}
		#memberinfocontent{
    		text-align: center;
            width: 80%;
		}
		
		.board-record,.comment-record{
			table-layout:fixed;
  			border-spacing: 20px 20px;
  				text-align: center;
            width: 100%;
		}
		.file-record{
			table-layout:fixed;
  			border-spacing: 20px 20px;
  			
  				text-align: center;
			width: 100%;
		}
		.userinfo{
		}
		
		/*.boardrecord-title,.commentrecord-cmt {
			width: 300px;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}*/
		
		td{
			word-wrap:break-word;
		}
</style>
</head>
<body>
	<input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

	<div class="mypagetotal">

		<div class="mypagetop">
			<button id="homebtn" data-href="board/listboard">홈으로 돌아가기</button>
		</div>

		<div class="mypageinfo">

			<div class="mypagebody-btnset">
			<button id="commoninfo-btn">기본정보 보기</button>
			<button id="etcinfo-btn">기타정보 보기</button>
			<button>회원정보 수정하기</button>
			</div>
			<ul class="totalmypage">
			<li class="toppagetab show" id="mypagecommon">
			<div class="mypageinfobody">
				<ul class="mypagerecordtab">
					<li class="infomypage-tab select" id="memberinfotab">
						나의 회원정보
					</li>

					<li class="infomypage-tab" id="boardrecordtab">
						작성글 기록
					</li>

					<li class="infomypage-tab" id="commentrecordtab">
						작성 댓글 기록
					</li>

					<li class="infomypage-tab" id="filerecordtab">
						업로드 파일 기록
					</li>
				</ul>

				<div class="infomypagerecordcontent">
					<div class="infomypage-tabcontent show" data-tabid="memberinfotab">
						<div id="memberinfocontent">
							<div>
								<h5>사용자의 아이디</h5><h3>${memberinfo.userid}</h3><br>
							</div>
							
							<div class="userinfo">							
								<h5>사용자의 이름</h5><h3>${memberinfo.username}</h3><br>
							</div>
							
							<div class="userinfo">
								<h5>사용자의 가입날짜</h5><h3>${memberinfo.regDate}</h3><br>						
							</div>
							
							<div class="userinfo">
								<h5>사용자의 휴대폰 번호</h5><h3>${memberinfo.phone}</h3><br>
							</div>
							
							<div class="userinfo">
								<h5>사용자의 정보 수정일자</h5><h3>${memberinfo.udate}</h3><br>							
							</div>
						</div>
					</div>

					<div class="infomypage-tabcontent" data-tabid="boardrecordtab">
						<p class="brdrecordsize">게시물의 총 개수는 ${boardrecordsize} 개 입니다.</p>
						<div class="boardrecordcontent">
						<table class="board-record">
							<thead>
								<tr>
									<th>게시물 번호</th>
									<th>게시판 이름</th>
									<th>게시물 제목</th>
									<th>게시물 작성일자</th>
									<th>게시물 수정일자</th>
									<th>삭제하기</th>
								</tr>
							</thead>
							
							<tbody>
								<c:forEach var="board" items="${boardrecord}">
									<tr>
										<td>${board.bno}</td>
										<td>${board.boardname}</td>
										<td><div class="boardrecord-title"><a href="board/readBoard?bno=${board.bno}">${board.title}</a></div></td>
										<td>${board.regdate}</td>
										<td>${board.udate}</td>	
										<td><button class="recordbrd-deletebtn" data-bno="${board.bno}" data-href="board/directdeleteboard">삭제하기</button></td>									
									</tr>
								</c:forEach>
							</tbody>
							
						</table>
						</div>						
					</div>

					<div class="infomypage-tabcontent" data-tabid="commentrecordtab">
						<p class="cmtrecordsize">댓글의 총 개수는 ${commentrecordsize} 개 입니다.</p>
						<div class="commentrecordcontent">
							<table class="comment-record">
								<thead>
									<tr>
										<th>댓글 번호</th>
										<th>게시물 번호</th>
										<th>댓글 내용</th>
										<th>등록 일자</th>
										<th>삭제하기</th>
									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="comment" items="${commentrecord}">
										<tr>
											<td>${comment.rno}</td>
											<td>${comment.bno}</td>
											<td><div class="commentrecord-cmt">${comment.comments}</div></td>
											<td>${comment.regdate}</td>
											<td><button class="recordcmt-deletebtn" data-rno="${comment.rno}">삭제하기</button></td>
										</tr>
									</c:forEach>
								</tbody>
								
							</table>
						</div>
					</div>

					<div class="infomypage-tabcontent" data-tabid="filerecordtab">
						<p class="filerecordsize">지금 까지 업로드한 파일의 총 개수는 ${filerecordsize} 개 입니다.</p>
						<div class="recordtable">
							<table class="file-record">
								<thead>
									<tr>
										<th>파일 코드</th>
										<th>파일의 uuid</th>
										<th>파일의 이름</th>
										<th>이미지 여부</th>
										<th>게시물 번호</th>
										<th>등록일자</th>
										<th>삭제하기</th>
									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="memberfile" items="${filerecord}">
										<tr>
											<td>${memberfile.pro_mem_file_code}</td>
											<td>${memberfile.uuid}</td>
											<td>${memberfile.fileName}</td>
											<td>${memberfile.image}</td>
											<td>${memberfile.bno}</td>
											<td>${memberfile.regDate}</td>
											<td><button class="recordfile-deletebtn" data-isimage="${memberfile.image}" data-uuid="${memberfile.uuid}" 
											data-filename="${memberfile.fileName}" data-uploadpath="${memberfile.uploadPath}">삭제하기</button></td>
										</tr>
									</c:forEach>
								</tbody>
								
							</table>
						</div>
						
					</div>
				</div>
			</div>
			</li>
			
			<li class="toppagetab" id="mypageetc">
				<div>
					<p>기본 정보를 제외한 기타 정보들</p>
				</div>
			</li>
			
			</ul>
			
		</div>

	<div class="mypagebottom">
		<div class="mbtnset">
			<button id="moutbtn">회원 탈퇴</button>
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
	var tablist=$('.infomypage-tab');
	var tabcontentlist=$('.infomypage-tabcontent');
	var homebt=$('#homebtn');
	var memberoutbtn=$('#moutbtn');
	var toptablist=$('.toppagetab');
	var cmtabbtn=$('#commoninfo-btn');
	var etctabbtn=$('#etcinfo-btn');
	var brdrecordbtn=$('.recordbrd-deletebtn');
	var cmtrecordbtn=$('.recordcmt-deletebtn');
	var filerecordbtn=$('.recordfile-deletebtn');
	
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
	
	cmtabbtn.on("click",function(e){
		var toptabobj=$('#mypagecommon');
		var toptablist=$('.toppagetab');
		
		for(var i=0;i<toptablist.length;i++){
			$(toptablist[i]).removeClass('show');
		}
		toptabobj.addClass('show');
	});
	etctabbtn.on("click",function(e){
		var toptabobj=$('#mypageetc');
		var toptablist=$('.toppagetab');
		
		for(var i=0;i<toptablist.length;i++){
			$(toptablist[i]).removeClass('show');
		}
		toptabobj.addClass('show');
	});
	
	brdrecordbtn.on("click",function(e){
		var brdobj=$(this).data("bno")
		var csrfToken = $("#_csrf").val();
		$.ajax({
			type:'post',
			url:'/board/directremoveBoard',
			data:{bno: brdobj},
			dataType:'json',
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			},
			success: function(response){
				console.log(response['result']);
				if(response['result']==="failure"){
					alert("해당 게시물 삭제에 실패하셨습니다");
				}
				else{
					alert(brdobj+" 번 게시물이 삭제되었습니다.");
				}
			},
			error: function(error){
				console.error(brdobj+" 번 게시물 삭제에 실패하였습니다.")
			}
		});
	});
	cmtrecordbtn.on("click",function(e){
		var cmtobj=$(this).data("rno")
		var csrfToken = $("#_csrf").val();
		$.ajax({
			type:'post',
			url:'/comment/deletecomment',
			data:{rno: cmtobj},
			dataType:'json',
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			},
			success: function(response){
				console.log(response['result']);
				alert(cmtobj+' 번 댓글이 삭제되었습니다.');
			},
			error: function(error){
				console.error(cmtobj+" 번 댓글 삭제에 실패하였습니다.")
			}
		});
	});
	filerecordbtn.on("click",function(e){
		var filename=$(this).data("filename");
		var fileuuid=$(this).data("uuid");
		var filepath=$(this).data("uploadpath");
		var fileobjtype=$(this).data('isimage');
		
		var fileobjuri=encodeURIComponent(filepath+"/"+fileuuid+"_"+filename);
		var csrfToken = $("#_csrf").val();
		$.ajax({
			type:'post',
			url:'/deletefile',
			data:{fileuri:fileobjuri, filetype:fileobjtype},
			dataType:'json',
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			},
			success: function(response){
				console.log(response['result']);
				alert("파일 기록 삭제가 정상적으로 되었습니다.");
			},
			error: function(error){
				console.error("파일 기록 삭제를 실패했습니다.");
			}
		});
	});
	
	homebt.on("click",function(e){
		window.location.href=homebt.data("href")	
	});
	memberoutbtn.on("click",function(e){
		window.location.href='/boardout';
	});
});
</script>
</body>
</html>