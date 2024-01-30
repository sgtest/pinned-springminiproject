<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><c:out value="${board.title}"/></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
          crossorigin="anonymous">
	<style>
	.board_content{
    	border: 2px solid #000;
		width: 1200px;
		height: 600px;
	}
	textarea{
		margin: 0;
		text-align: justify;
		font-size: 15px;
		resize: none;
	}
	.comment_insert,.comment_obj {
    	background-color: #f0f0f0;
    	padding: 10px; 
    	border: 1px solid #ccc; 
   		margin-bottom: 10px; 
	}
	.comment_obj{
		margin-top: -5px;
	}
	.comment_class_page{
        display: flex;
        justify-content: center;
        margin-top: 20px;
        margin-bottom: 20px;
	}
	.commentpage{
            margin: 0 5px;
	}
	</style>
</head>
<body>
<a href="#" onclick="goBack()">이전 페이지로 되돌아가기</a><br>
<a href="updateBoard?bno=${board.bno}">게시물 수정하기</a>
<div class="readcontent_top">

	<h4>제목</h4>
	<p>${board.title}</p>

	<h4>게시판 종류</h4>
	<p>${board.boardname}</p>

	<h4>게시글 내용</h4>
	<div class="board_content">
	<p><c:out value="${board.content}"/></p>
	</div>
	
	<h4>첨부 이미지 목록<h4>
	<div>
	<p class="imgfilenumber"></p>
	<button>해당 이미지들 보기</button>
	<!--  -->
	</div>
	
	<h4>첨부파일 목록</h4>
	<div>
	<!-- 각각의 파일명들을 a 링크 형태로 다운받을수 있게 한다.-->
	</div>
	
	<h4>작성자</h4>
	<p>${board.writer}</p>

	<h4>수정 날짜</h4>
	<p><fmt:formatDate value="${board.udate}" pattern="yyyy/MM/dd HH:mm:ss" /></p>

	<h4>작성 날짜</h4>
	<p><fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd HH:mm:ss" /></p>
	
</div>

<br>
<div class="comment_insert">
	<div class="comment_form">
		<form action="/comment/insertcomment" method="post">
			<input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			
			<input type="hidden" id="bno" name="bno" value="${board.bno}"/>
			<h5>댓글 작성자</h5>
		        <div class="comment_insert_group">
			    	<input type="text" id="writer" name="writer" required><br>
			    </div>
			
			<h5>댓글 내용</h5>
				<div class="comment_insert_group">
					<textarea id="comments" name="comments" rows="1" cols="100"></textarea>
				</div>
			<button class="commment_insert_btn" type="submit">댓글 입력하기</button>
		</form>
	</div>
</div>
<br>

<div class="comment_class top">
	<div class="comment_class class">
	<h4>댓글 목록</h4>
	<input type="button" value="댓글 다시 불러오기" onclick="loadComments(1)"><br><br>
		<!-- 여기에는 댓글 페이지를 움직일시 다른 댓글을 보여주는 알고리즘 구현 board 페이지를 이용하면 될듯 -->
		<div class="comment_list">
			
		</div>
	</div>
	
	<div class="comment_class_page">
	
	</div>
	
</div>

<div class="commentedit_modal" id="comment_edit" tabindex="-1" role="dialog" aria-labelledby="commenteditmodal" aria-hidden="true" style="display: none;">
	<div class="commentedit_dialog" id="comment_edit_form" role="document">
		<div class="commentedit_content">
			<div class="commentedit_header">
				<h5 class="commentedit_modal_title" id="commenteditmodal">댓글 수정</h5>
			</div>
			<div class="commentedit_body">
				<form action="/comment/updatecomment" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<input type="hidden" id="bno" name="bno" value=""/>
					<input type="hidden" id="rno" name="rno" value=""/>
				<h5>댓글 작성자</h5>
		        	<div class="comment_update_group">
			    		<input type="text" id="writer_obj" name="writer" value="" required>
			    	</div>
			
				<h5>댓글 내용</h5>
					<div class="comment_update_group">
						<textarea id="comments_obj" name="comments" rows="1" cols="100" value=""></textarea>
					</div>
				
					<button type="submit">댓글 수정완료</button>
				<button type="button" id="modal_close_btn" class="commentedit_close_btn" data-dismiss="modal"  data-bs-target="#comment_edit" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				</form>
			</div>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5PtkFExj5u9bOyDDn5a+3pu8L+I2LZ"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>        
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
        crossorigin="anonymous"></script>
        <script>
        $(document).ready(function(){
        	//최초로 게시글 읽기 실행시 댓글 1페이지 화면을 보여준다.
        	
			var pageNumValue = 1;
        	loadComments(pageNumValue);
        	var attachlist= '<c:out value="${attachlist}"/>';

        	//var attachlist=${attachlist};
			var imgcount=0;
			
        	loadattachfile(attachlist);
        	loadimgcount(attachlist);
        	$(".commentedit_close_btn").on("click",function(e){
            	e.preventDefault();
            	console.log("cmtmodal_close_click");
        		const cmtmodal=document.getElementById("comment_edit");
        		cmtmodal.style.display="none";
        		
        	});       	
        	function loadimgcount(attachlist){
        		var imgnumber=$('.imgfilenumber');
    			console.log(attachlist);
    			var length=attachlist.length;
				console.log(length);
    			if(length>0){
    				for(var i=0;i<length;i++){
    					const achfile=attachlist[i];					
    					if(achfile.image===true){
    						imgcount=imgcount+1;
    					}					
    				}
    			}
    			imgnumber.text('현재 이미지가 총 ' + imgcount + ' 개 있습니다.');
    		}
        	
        });
        
		
		
		function loadattachfile(attachlist){
			var str="";
			if(attachlist.length>0){
				for(var i=0;i<attachlist.length;i++){
					const achfile=attachlist[i];
					
					if(achfile.image===true){
						
					}
					else{
						
					}
					
				}
				
			}
			else{
				
			}
			
		}
		
    	function loadComments(pageNumValue){
        	var bnoValue = '<c:out value="${board.bno}"/>';
    		$.ajax({
    			type: 'get',
    			url: '/comment/readcommentlist',
    			data: {pagenum: pageNumValue, bno: bnoValue},
    			dataType:'JSON',
    			success: function(resultMap) {
    				var cmtpage=resultMap['cmtpage'];
    				var cmtcnt=resultMap['cmtcnt'];
    				var cmtamount=10;
					displaycomments(cmtpage);
					loadCommentspage(pageNumValue,cmtcnt,cmtamount);
				},
    			error: function(){
    				console.error('댓글 불러오기 실패');
    			}
    		});
    	}
    
    	function displaycomments(cmtpage){
    		var commentContainer=$('.comment_list');
    		commentContainer.empty();
    		var str="";
    		if(cmtpage==null||cmtpage.replyCnt==0){
    			return;
    		}
    		
    		
    		$.each(cmtpage.list, function(index, comment) {
    		str = str + '<div class="comment_obj">' + '<p>' + comment.writer + '</p>';
        	str = str + '<p>' + comment.comments + '</p>';
        	str = str + '<p>' +  formatDateToCustomString(comment.regdate) + '</p>';
        	str = str + '<input type="button" value="댓글 삭제하기" onclick="removeComment('+ comment.rno +')">'
        	str = str + '<input type="button" value="댓글 수정하기" onclick="readCmt('+ comment.rno +', '+ comment.bno+')">'
        	str = str + '</div><br>';
   		 	});

        	commentContainer.append(str);
    	}

    	function formatDateToCustomString(date) {
    	    const options = {
    	        year: 'numeric',
    	        month: '2-digit',
    	        day: '2-digit',
    	        hour: '2-digit',
    	        minute: '2-digit',
    	        second: '2-digit',
    	        hour12: false, // 24-hour format
    	    };

    	    const formattedDate = new Intl.DateTimeFormat('en-US', options).format(date);
    	    return formattedDate.replace(/(\d+)\/(\d+)\/(\d+), (\d+):(\d+):(\d+)/, '$3/$1/$2 $4:$5:$6');
    	}

    	function loadCommentspage(pageNumValue, cmtcnt, cmtamount){
    		var commentspageform=$('.comment_class_page');
    		console.log(cmtcnt);
    		
    		var endpage=Math.ceil(pageNumValue/cmtamount)*10;
    		var startpage=endpage-9;
    		var realendpage=Math.ceil(cmtcnt/cmtamount);
    		if(realendpage <= endpage){
    			endpage=realendpage
    		}

    		var prev=startpage>1;
    		var next=endpage<realendpage;
    		
    		//여기에서는 페이지 번호들을 생성을 한다 페이지 번호를 클릭시 게시물 번호와 해당 댓글 페이지 번호 정보를 이용해서 댓글 창을 출력한다	
    		var str = "";
    		commentspageform.empty();
    		if (prev) {
    		    str += '<li class="commentpage prev"><a href="#" onclick="loadComments(' + (startpage - 1) + ');"> prev </a></li>';
    		}
    		for (var num = startpage; num <= endpage; num++) {
    		    str += '<li class="commentpage btn"><a href="#" onclick="loadComments(' + num + ');">' + num + '</a></li>';
    		}
    		if (next) {
    		    str += '<li class="commentpage next"><a href="#" onclick="loadComments(' + (startpage + 1) + ');"> next </a></li>';
    		}
    		commentspageform.append(str);
    		
    	}
    	
    	function removeComment(rno){
    		var csrfToken = $("#_csrf").val();
    		$.ajax({
    			type: 'post',
    			url: '/comment/deletecomment',
    			data: {rno: rno},
    			dataType:'JSON',
    	        beforeSend: function(xhr) {
    	            xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
    	        },
    			success: function(response){
    				
    				console.log('댓글 삭제 결과: '+response['result']);
    				loadComments(1);
    			},
    			error: function(error){
    				console.error('댓글 삭제 실패');
    			}
    		});
    	}
    	
    	//댓글 등록과 업데이트 코드
        function readCmt(rno, bno){
        		$.ajax({
        			type: 'get',
        			url: '/comment/readComment',
        			data: {rno: rno},
        			dataType:'JSON',
        			success: function(resultMap) {
        				//댓글을 rno를 통해서 읽어오는 것을 성공할 시 해당 결과값을 이용해서 modal 창을 출력
    					showupdatemodal(resultMap['comment'], bno);
    				},
        			error: function(){
        				console.error('댓글 항목 불러오기 실패');
        			}
        		});
        		
        	}
        function showupdatemodal(comment, bno){
        		//댓글 수정을 위한 모달창을 띄우고 모달창에서 저장버튼 누를시 바로 수정적용
        		const cmtmodal=document.getElementById("comment_edit");

        	    cmtmodal.querySelector('#writer_obj').value=comment.writer;
        	    cmtmodal.querySelector('#comments_obj').value=comment.comments;
        	    cmtmodal.querySelector('#rno').value=comment.rno;
        	    cmtmodal.querySelector('#bno').value=bno;
        		
        		cmtmodal.style.display="block";
        		
        	}
    	
        function goBack(){
        	
        	window.history.back();
        }
        </script>
        
</body>
</html>