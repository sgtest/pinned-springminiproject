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
    		padding: 10px;
		}
		.show{
    		display: block;
		}
		.boardrecordcontent,.commentrecordcontent{
    		padding: 10px;
    		text-align: center;
		}
		#memberinfocontent{
            width: 80%;
		}
		.board-record,.comment-record{
            width: 80%;
		}
		.boardrecord-title,.commentrecord-cmt {
			width: 300px;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
		
</style>
</head>
<body>

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
								<h4>${memberinfo.userid}</h4>
							</div>
							
							<div>							
								<h4>${memberinfo.username}</h4>
							</div>
							
							<div>
								<h4>${memberinfo.regDate}</h4>						
							</div>
							
							<div>
								<h4>${memberinfo.phone}</h4>
							</div>
							
							<div>
								<h4>${memberinfo.udate}</h4>							
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
										<td><button data-href="board/directdeleteboard">삭제하기</button></td>									
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
									</tr>
								</thead>
								<tbody>
									<c:forEach var="comment" items="${commentrecord}">
										<tr>
											<td>${comment.rno}</td>
											<td>${comment.bno}</td>
											<td><div class="commentrecord-cmt">${comment.comments}</div></td>
											<td>${comment.regdate}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

					<div class="infomypage-tabcontent" data-tabid="filerecordtab">
						<p class="filerecordsize">지금 까지 업로드한 파일의 총 개수는 ${filerecordsize} 개 입니다.</p>
						<div>
							<table>
								<thead>
									<tr>
										<th>파일 코드</th>
										<th>파일의 uuid</th>
										<th>파일의 이름</th>
										<th>이미지 여부</th>
										<th>게시물 번호</th>
										<th>등록 일자</th>
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
											<td><button>삭제하기</button></td>
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
	var toptablist=$('.toppagetab');
	var cmtabbtn=$('#commoninfo-btn');
	var etctabbtn=$('#etcinfo-btn');
	
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
	
	homebt.on("click",function(e){
		window.location.href=homebt.data("href")	
	});
	
	function loadbrdrepage(){
		
	}
	function loadboardrecordpage(pagenum,amount,totalcnt){
		
	}

	function loadcmtrepage(){
		
	}
	function loadcommentrecordpage(pagenum,amount,totalcnt){
		
	}
	
	function loadfilrepage(){
		
	}
	function loadfilerecordpage(pagenum,amount,totalcnt){
		
	}
});
</script>
</body>
</html>