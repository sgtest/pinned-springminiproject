<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글을 수정합니다.</title>
</head>
<body>

<h1>게시물 수정 페이지</h1>
<a href="#" onclick="goBack()">이전 페이지로 되돌아가기</a><br><br>
<div>

<form action="updatesaveBoard" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<input type="hidden" name="bno" value="${board.bno}">
	
<h4>게시판 종류 수정</h4>
<div class="old_boardname">
	<p>${board.boardname}</p>
</div>
<div class="update_group">
	<select name="boardname">
		<c:forEach var="boardname" items="${boardlist}">
			<option value="${boardname}">${boardname}</option>
		</c:forEach>
	</select>
</div>

<h4>게시글 제목 수정</h4>
<div class="update_group">
	<textarea id="title" name="title" rows="1" cols="100" required>${board.title}</textarea>
</div>

<h4>게시글 내용 수정</h4>
<div class="update_group">
	<textarea id="content" name="content" rows="80" cols="140" required>${board.content}</textarea><br>
</div>

<h4>게시글 작성자</h4>
<div class="update_group">
	<input type="text" id="writer" name="writer" value="${board.writer}" required><br>
</div>

<h4>게시글 첨부파일 수정</h4>
<div class="update_group">
	<div class="file_upload">
		<div class="orginal_filelist">
			
		</div>
		<div class="file_upload_attach">
			<input type="file" name="uploadFile" multiple>
		</div>
		<div class="file_upload_result">
		
		</div>
	</div>
</div>

<h4> 게시글 작성일자</h4>
<div class="update_group">
	<p><fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd HH:mm:ss" /></p>
</div>

<div>
</div>

<button type="submit" class="btn_boardupdate">수정완료</button>

</form>
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
function goBack(){
	
	window.history.back();
}
</script>
</body>
</html>