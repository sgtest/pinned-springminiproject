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
	.thumgrid {
  		display: grid;
  		grid-template-columns: repeat(8, 1fr);
  		grid-template-rows: repeat(5, 1fr);
    	overflow-y: scroll;
    	height:0px;
	}
	.filelist{
    	overflow-y: scroll;
    	height:0px;
	}
	.modal_img_file{
  		display: flex;
  		flex-direction: column;  
  		align-items: center; 
		margin-left: 20px;
	    width: 100%;
  		height: 100%;
	}
	.modal_file_btn{
		margin-top: 20px;
	}
	.modal_thumimg{
		margin-top: 10px;
		max-width: 100px;
		max-height: 100px;
	}
	#fileresult_thumb{
  		display: grid;
  		grid-template-columns: repeat(10, 1fr);
  		grid-template-rows: repeat(5, 1fr);
    	overflow-y: scroll;
    	height:0px;
	}
	#fileUploadModal {
    	top: 50%;
    	transform: translateY(-50%);
    	width: 1000px;
    	height: 1300px;
    	position: absolute;
    	display: none;
    	left: 30%;
    	margin: 0;
  		justify-content: center;
  		align-items: center;
  		background-color: rgba(160, 160, 160, 1);
	}
	#fileUploadModal_box {
	
	}
	#filemodalbody{
		margin-left: 50px;
		margin-right: 50px;
   		width: 900px;
    	height: 600px;
    	border: 2px solid #000;
    	overflow-y: auto;
	}
	#filemodalbtn{
		margin-top: 80px;
		margin-bottom: 0px;
		margin-left: 250px;
		margin-right: 250px;
	}
	#fileupload_reset,#fileupload_tupload,#fileupload_close{
		align-items:center; 
		text-align: center;
		margin-left:10px;
		width: 150px;
		height: 50px;
		padding: 10px 5px;	
  		cursor: pointer;
	}
	</style>
</head>
<body>

<div class="insert_top">
	<h1><a href="listboard">메인 홈페이지로</a></h1>
	<h2>게시물 작성</h2>
	
	<form action="/board/saveBoard" method="post">
	<input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
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
	
	<h4>첨부파일 (다시 업로드 버튼을 누르면 기존의 파일 목록이 초기화됩니다!!)</h4>
		<div class="file_upload">
			<div class="file_upload_attach">
				<button type="button" id="fileupload_btn" data-bs-toggle="modal" data-bs-target="#fileUploadModal">파일 업로드</button>
				<input type="file" id="inputfile" name="upload" multiple>
			</div>
			<div class="file_upload_result">
				<ul class="thumgrid" id="fileresult_thumb">
				
				</ul>
				<ul class="filelist" id="fileresult_common">
				
				</ul>
			</div>
		</div>	
</div>

<!-- 파일 재등록 여부 확인 모달창 -->
<!-- 
<div class="modal fade" id="fileminimodal" tabindex="-1" role="dialog" aria-hidden="true">
	<div role="document">
		<div>
			<div>
			<h5>파일 등록 창을 엽니다.(파일을 이미 등록한 경우, 기존에 등록된 파일이 초기화 됩니다!!!!)</h5>
			</div>
			<div>
			<button></button>
			<button></button>
			</div>
		</div>
	</div>
</div>
-->
 
<!-- 파일등록 모달창 -->
<div class="modal fade" id="fileUploadModal" tabindex="-1" role="dialog" aria-labelledby="fileUploadModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" id="fileUploadModal_box" role="document">
		<div class="file-modal-content">
			<div class="file-modal-header">
			<h5 class="file-modal-title" id="fileUploadModalLabel">파일을 드래그해서 업로드 해주세요</h5>
			</div>
			<div id="filemodalbody" class="file-modal-body">
			<!-- 파일 업로드 영역 -->
			
			</div>
			<h5 class="file-modal-title">파일을 드래그해서 업로드 해주세요</h5>
			<h5 id="fileuplaodrule">zip, js, exe, sh, alz 형태의 확장자를 가진 파일은 업로드가 제한됩니다!!!<br>이미지 파일은 따로 이미지 파일끼리 업로드 해주세요!!!</h5>
			<div id="filemodalresult">
			<!-- 파일 업로드 리스트 영역 -->
				<ul class="thumgrid" id="filemodalresult_thumb">
				
				</ul>
				<ul class="filelist" id="filemodalresult_common">
				
				</ul>
			</div>
			<div id="filemodalfooter">
			<div id="filemodalbtn" class="fileupload_btn_set">
				<button id="fileupload_reset">File Reset</button>
				<button id="fileupload_tupload">File Temp Register</button>
				<button id="fileupload_close" data-dismiss="modal">Exit</button>
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
	var filemodalreset=$('#fileupload_reset');
	var filemodalregister=$('#fileupload_tupload');
	var filemodaltopresult=$('#filemodalresult');
	var filemodalresult=$('#filemodalresult_common');
	var imgfilemodalresult=$('#filemodalresult_thumb');
	var fileresult=$('#fileresult_commen');
	var imgfileresult=$('#fileresult_thumb');
	
	filemodaltopresult.on("click", "button",function(e){
		var objfile= $(this).data("path");
		var objtype= $(this).data("image");
		
		var objui=$(this).closest("li");
		var csrfToken = $("#_csrf").val();
		
		$.ajax({
			type:'post',
			url:'/deletefile',
			data:{fileuri: objfile, filetype: objtype},
			dataType:'JSON',
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	        },
			success: function(response){
				alert(response['result']);
				objui.remove();
			},
			error: function(error){
				console.error('파일삭제 오류');
			}
		});	
	});
	
	
	filemodalbtn.click(function(){
		deleteshowfile();
		filemodal.modal('show');
	});
	
	filemodalreset.click(function(){
		deletefile();
	});
	filemodalclose.click(function(){
		
		deletefile();
		filemodal.modal('hide');
	});
	filemodalregister.click(function(){
		
		
	})
	
	const modal_file_drag=$('#filemodalbody');
	modal_file_drag.on("dragover",function(e){
	    console.log("파일 드래그 감지");
	    e.preventDefault();
	});
	
	modal_file_drag.on("drop",function(e){
		console.log("파일 드롭 완료");
	    e.preventDefault();
		var csrfToken = $("#_csrf").val();
		
		var formData = new FormData();
	    var files = e.originalEvent.dataTransfer.files;
	    for(var i=0;i<files.length;i++){
		    console.log(files[i].name);	
		    console.log(files[i].size);
		    formData.append("uploadFile",files[i]);
	    }
	    $.ajax({
	    	type: 'post',
			url:'/uploadFile',
			data: formData,
			dataType:'JSON',
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	        },
            contentType: false,
            processData: false,
            success: function(response){
            	var resultresponse=response['result'];
				var resultfilelist=response['attachfilelist'];
				var thumbnailefilelist=response['thumbnaillist'];
				displayfilelist(resultresponse,resultfilelist,thumbnailefilelist);
            },
            error: function(error){
            	console.error('파일 업로드 에러!!');
            }
	    });
	    //여기서 드롭을 할때, 실제로 서버에 업로드 아래 result 화면에 순서대로 나열된 리스트 형식으로 보여주면 될듯(이미지+파일이름)
	    
	});
	
	
	function deletefile(){
		
		//버튼 클릭을 감지하고 모달창에서 해당 파일만 삭제
		filemodalresult.css("height","0px");
		imgfilemodalresult.css("height","0px");
		filemodalresult.empty();
		imgfilemodalresult.empty();
	}
	
	
	function deleteshowfile(){
		
		//버튼 클릭을 감지하고 게시물 입력창에서 해당 파일만 삭제
		filemodalresult.css("height","0px");
		imgfilemodalresult.css("height","0px");
		filemodalresult.empty();
		imgfilemodalresult.empty();
		
	}
	
	
	function deletelistfile(){
		
		//모달창에서 파일 삭제
		filemodalresult.css("height","0px");
		imgfilemodalresult.css("height","0px");
		filemodalresult.empty();
		imgfilemodalresult.empty();
	}
	
	function deleteshowlistfile(){
		
		//게시물 입력창에서 파일 삭제
		filemodalresult.css("height","0px");
		imgfilemodalresult.css("height","0px");
		filemodalresult.empty();
		imgfilemodalresult.empty();
		
	}
	
	function displayfilelist(resultresponse,resultfilelist,thumbnailefilelist){
		//hidden input에 필요한 값들을 넣으면 될듯
		var str="";

		if(resultresponse === 'upload_fail' || resultfilelist === null)
		{
			console.log('지원하지 않는 파일');
			str=str+'<div><p>업로드에 실패하였습니다. 다시 시도해주세요</p></div>';	
			filemodalresult.append(str);
		}
		//모든 파일은 기본적으로 x버튼을 추가해서 추후에 해당 버튼을 클릭시 삭제를 수행하도록한다.
		else if(resultfilelist[0].image===true)
		{
			//이미지 파일 리스트인 경우	
			//썸네일 파일을 생성해서 모달창 아래쪽에 최대 5*4인 격자무늬로 보여줌
			//이미지 경로를 받아서 섬네일을 보여주는 컨트롤러 메소드 필요
			imgfilemodalresult.css("height","300px");
			for(var i=0;i<resultfilelist.length;i++){
				var imgfile=resultfilelist[i];
				var thumbfileuri=encodeURIComponent(imgfile.uploadPath+"/th_"+imgfile.uuid+"_"+imgfile.fileName);
				var imgfileuri=encodeURIComponent(imgfile.uploadPath+"/"+imgfile.uuid+"_"+imgfile.fileName);
				console.log(thumbfileuri);
				
				//파일의 이미지 여부, 파일의 경로정보, 파일의 이름, 파일의 uuid 등을 따로 저장해야(나중에 파일 등록버튼 누를시 필요)
				
				str=str+"<li class='modal_img_file'>"+"<span>"+imgfile.fileName+"</span>";
				str=str+"<img class='modal_thumimg' src='/display?fileuri="+thumbfileuri+"'>";
				str=str+"<button class='modal_file_btn' type='button' data-path="+imgfileuri+" data-name="+imgfile.fileName+" data-uuid="+imgfile.uuid+" data-image="+imgfile.image+">delete</burron>";
				str=str+"</li>";
				
				
			}
			imgfilemodalresult.append(str);
		}
		else
		{
			//이미지 파일 리스트가 아닌 경우	
			//파일명 그대로 순서대로 모달창 아래쪽에 목록으로 보여줌
			filemodalresult.css("height","300px");
			for(var i=0;i<resultfilelist.length;i++){
				var normalfile=resultfilelist[i];
				var normalfileuri=encodeURIComponent(normalfile.uploadPath+"/"+normalfile.uuid+"_"+normalfile.fileName);
				var normalfilelink=normalfileuri
				
				console.log(normalfileuri);
				
				//파일의 이미지 여부, 파일의 경로정보, 파일의 이름, 파일의 uuid 등을 따로 저장해야(나중에 파일 등록버튼 누를시 필요)
				
				str=str+"<li class='modal_file'>";
				str=str+"<p class='filename'>"+normalfile.fileName+"</p>";
				str=str+"<button class='modal_file_btn' type='button' data-path=\'"+normalfileuri+"\' data-name="+normalfile.fileName+" data-uuid="+normalfile.uuid+" data-image="+normalfile.image+">delete</burron>";
				str=str+"</li>";
				
			}
			filemodalresult.append(str);
		}
		
	}
	
	
});

</script>
</body>
</html>