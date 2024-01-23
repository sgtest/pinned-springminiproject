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
	textarea{
		margin: 0;
		text-align: justify;
		font-size: 15px;
		resize: none;
	}
	</style>
</head>
<body>
<a href="#" onclick="goBack()">이전 페이지로 되돌아가기</a>

<div class="readcontent_top">

	<h4>제목</h4>
	<p>${board.title}</p>

	<h4>게시판 종류</h4>
	<p>${board.boardname}</p>

	<h4>게시글 내용</h4>
	<div class="board_content">
	<textarea name="content" rows="40" cols="140" readonly="readonly" >
		<c:out value="${board.content}"/>
	</textarea>
	</div>
	
	<h4>작성자</h4>
	<p>${board.writer}</p>

	<h4>수정 날짜</h4>
	<p><fmt:formatDate value="${board.udate}" pattern="yyyy/MM/dd HH:mm:ss" /></p>

	<h4>작성 날짜</h4>
	<p><fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd HH:mm:ss" /></p>

</div>

<br><br>

<div class="comment_class top">
	<div class="comment_class class">
	<h4>댓글 목록</h4>
		<!-- 여기에는 댓글 페이지를 움직일시 다른 댓글을 보여주는 알고리즘 구현 board 페이지를 이용하면 될듯 -->
		<div class="comment_list">
			
		</div>
	</div>
	<div class="comment_class page">
	
	</div>
	
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5PtkFExj5u9bOyDDn5a+3pu8L+I2LZ"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
        crossorigin="anonymous"></script>
        <script>
        $(document).ready(function(){
        	var bnoValue = '<c:out value="${board.bno}"/>';

        	loadComments();
        	loadCommentspage();
        	
        	function loadComments(){
        		
        		$.ajax({
        			type: 'get',
        			url: '/comment/readcommentlist',
        			data: {pagenum: 1, bno: bnoValue},
        			dataType:'JSON',
        			success: function(cmtpage) {
						displaycomments(cmtpage);
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
        		str = str + '<div>' + '<p>' + comment.writer + '</p>';
            	str = str + '<p>' + comment.comments + '</p>';
            	str = str + '<p>' +  formatDateToCustomString(comment.regdate) + '</p>';
            	str = str + '</div><br>';
            	console.log(comment.comments);
            	console.log(str);
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

        	function loadCommentspage(){
        		var commentspageform=$('.comment_class page');
        		
        		
        	}
        	
        	//댓글 등록과 업데이트 코드
        });

        function goBack(){
        	
        	window.history.back();
        }
        </script>
</body>
</html>