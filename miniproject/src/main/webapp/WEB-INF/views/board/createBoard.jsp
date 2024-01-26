<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성 페이지(테스트 단계)</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
          crossorigin="anonymous">
	<style>
	#fileUploadModal {
    top: 50%;
    transform: translateY(-50%);
    width: 600px;
    height: 600px;
    position: absolute;
    display: none;
    left: 40%;
    margin: 0;
  	justify-content: center;
  	align-items: center;
  	background: rgba(0, 0, 0, 0.5);
	}
	#filemodalbody{
    width: 600px;
    height: 500px;
	}
	#filemodalbtn{
	
	}
	</style>
</head>
<body>

<div class="insert_top">
	<h1><a href="listboard">메인 홈페이지로</a></h1>
	<h2>게시물 작성</h2>
	
	<form action="/board/saveBoard" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<h4>게시판 선택</h4>
		<div class="insert_group">
			<!-- 여기에는 현재 존재하는 게시판 중 하나를 선택할 수 있게 한다 -->
			<select name="boardname">
				<c:forEach var="boardname" items="${boardlist}">
					<option value="${boardname}">${boardname}</option>
				</c:forEach>
			</select>
		</div>
	<h4>제목</h4>
		<div class="insert_group">
			<textarea id="title" name="title" rows="1" cols="100" required></textarea><br><br>
		</div>
		
	<h4>내용</h4>
		<div class="insert_group">
			<textarea id="content" name="content" rows="80" cols="140" required></textarea><br>
		</div>
	
	<h4>작성자의 이름</h4>
		<div class="insert_group">
			<input type="text" id="writer" name="writer" required><br>
		</div>		
		
		<button type="submit" class="btn_boardinsert">작성완료</button>
	</form>
	
	<h4>첨부파일</h4>
		<div class="file_upload">
			<div class="file_upload_attach">
				<button type="button" id="fileupload_btn" data-bs-toggle="modal" data-bs-target="#fileUploadModal">파일 업로드</button>
				<input type="file" id="inputfile" name="upload" multiple>
			</div>
			<div class="file_upload_result">
			
			</div>
		</div>	
</div>


<!-- 파일등록 모달창 -->
<div class="modal fade" id="fileUploadModal" tabindex="-1" role="dialog" aria-labelledby="fileUploadModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="file-modal-content">
			<div class="file-modal-header">
			<h5 class="file-modal-title" id="fileUploadModalLabel">파일 업로드</h5>
			</div>
			<div id="filemodalbody" class="file-modal-body">
			<!-- 파일 업로드 영역 -->
			
			
			<div id="filemodalbtn" class="fileupload_btn_set">
				<button>File reset</button>
				<button>File temp register</button>
				<button id="fileupload_close" data-dismiss="modal">exit</button>
			</div>
			</div>
		</div>
	</div>
</div>		
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5PtkFExj5u9bOyDDn5a+3pu8L+I2LZ"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>        
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
        crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	var inputFile=$('#inputfile')
	var filemodalbtn=$('#fileupload_btn');
	var filemodal=$('#fileUploadModal');
	var filemodalclose=$('#fileupload_close');
	
	filemodalbtn.click(function(){
		filemodal.modal('show');
	});
	
	filemodalclose.click(function(){
		
		filemodal.modal('hide');
		deletefile();
	});
	
	inputFile.change(function(){
		var formData = new FormData();
		var files = $('#inputfile')[0].files;
		$.ajax({
			type: 'post',
			url:'/upload',
			data: formData,
            contentType: false,
            processData: false,
			success: function(response){
				var resultfilelist=response['attachfilelist'];
				displayfilelist(resultfilelist);
			},
			error: function(error){
				console.error('파일 업로드 에러!!');
			}
		});
	});
	function deletefile(){
		
		
	}
	
	function displayfilelist(resultfilelist){
		
	}
});

</script>
</body>
</html>