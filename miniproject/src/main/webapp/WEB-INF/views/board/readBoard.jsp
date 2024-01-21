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


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5PtkFExj5u9bOyDDn5a+3pu8L+I2LZ"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
        crossorigin="anonymous"></script>
        <script>
        function goBack(){
        	
        	window.history.back();
        }
        </script>
</body>
</html>