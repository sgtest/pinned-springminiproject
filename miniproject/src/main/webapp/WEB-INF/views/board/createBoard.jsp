<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성 페이지(테스트 단계)</title>
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
	
	.result_img_file{
  		display: flex;
  		flex-direction: column;  
  		align-items: center; 
		margin-left: 20px;
	    width: 100%;
  		height: 100%;
	}
	.result_img{
		margin-top: 10px;
		margin-width: 500px;
		margin-height:500px;
	}
	.file_btn{
		margin-top: 20px;
	}
	.file-modal-content{
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
    	overflow-y: scroll;
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
		margin-left: 230px;
		margin-right: 230px;
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
	#fileresult_common{
		
	}
	
	</style>
</head>
<body style="overflow: auto">
	<input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<sec:authentication property="principal" var="userinfo"/>
	
<div class="insert_top">
	<h1><a href="listboard">메인 홈페이지로</a></h1>
	<h2>게시물 작성</h2>
	
	<form role="form" action="/board/saveBoard" method="post">
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
			<input type="text" id="writer" name="writer" value="${userinfo.username}" readonly><br>
		</div>		
		
		<button type="submit" class="btn_boardinsert" data-beforeunloads="false">작성완료</button>
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
			<h5 class="file-modal-title" id="fileUploadModalLabel">파일을 드래그하거나 직접 업로드 버튼을 눌러서 업로드 해주세요</h5>
			</div>
			<div id="filemodalbody" class="file-modal-body">
			<!-- 파일 업로드 영역 -->
			
			</div>
			<input type="file" id="filemodaldirect" name="upload" multiple>
			<h5 class="file-modal-title">파일을 드래그하거나 직접 업로드 버튼을 눌러서 업로드 해주세요</h5>
			<h5 id="fileuplaodrule">zip, js, exe, sh, alz 형태의 확장자를 가진 파일은 업로드가 제한됩니다!!!<br>이미지 파일은 이미지 파일끼리 따로 업로드 해주세요!!!</h5>
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
	
	var filetopresult=$('.file_upload_result')
	var fileresult=$('#fileresult_common');
	var imgfileresult=$('#fileresult_thumb');
	
	var submitform=$("form[role='form']");
	
	
	$("button[type='submit']").on("click", function(e){

	    e.preventDefault();
		const dataPath=[];
		const dataUuid=[];
		const dataName=[];
		const dataType=[];
		const commondataPath=[];
		const commondataUuid=[];
		const commondataName=[];
		const commondataType=[];
		const showfilelist=document.querySelectorAll(".result_img_file");
		const showcommonfilelist=document.querySelectorAll(".result_file");

	    var str = "";
		var i=0;
		if(showfilelist.length>0){
			for(i=0;i<showfilelist.length;i++){
				const button=showfilelist[i].querySelector(".file_btn");
				const name=showfilelist[i].querySelector("span").textContent;
				dataPath.push(button.dataset.path);
				dataUuid.push(button.dataset.uuid);
				dataName.push(name);
				dataType.push(button.dataset.image);
			}
			for(i=0;i<showfilelist.length;i++){
				var dataname=dataName[i];
				var datapath=dataPath[i];
				var datauuid=dataUuid[i];
				var datatype=dataType[i];
				
				str = str + "<input type='hidden' name='attachlist["+i+"].fileName' value='"+dataname+"'>";
			    str = str + "<input type='hidden' name='attachlist["+i+"].uuid' value='"+datauuid+"'>";
			    str = str + "<input type='hidden' name='attachlist["+i+"].uploadPath' value='"+datapath+"'>";
			    str = str + "<input type='hidden' name='attachlist["+i+"].image' value='"+datatype+"'>";
			}
		}
		var j=0;
		if(showcommonfilelist.length>0){
			for(j=i;j<showcommonfilelist.length+i;j++){
				const button=showcommonfilelist[j-i].querySelector(".file_btn");
				const name=showcommonfilelist[j-i].querySelector("span").textContent;
				commondataPath.push(button.dataset.path);
				commondataUuid.push(button.dataset.uuid);
				commondataName.push(name);
				commondataType.push(button.dataset.image);
			}
			
			for(j=i;j<showcommonfilelist.length+i;j++){
				var commondataname=commondataName[j-i];
				var commondatapath=commondataPath[j-i];
				var commondatauuid=commondataUuid[j-i];
				var commondatatype=commondataType[j-i];
				
				str = str + "<input type='hidden' name='attachlist["+j+"].fileName' value='"+commondataname+"'>";
			    str = str + "<input type='hidden' name='attachlist["+j+"].uuid' value='"+commondatauuid+"'>";
			    str = str + "<input type='hidden' name='attachlist["+j+"].uploadPath' value='"+commondatapath+"'>";
			    str = str + "<input type='hidden' name='attachlist["+j+"].image' value='"+commondatatype+"'>";
			}
		}
		
		if(showfilelist.length===0 && showcommonfilelist.length===0){
			
		}
		submitform.append(str);
		submitform.submit();		
	});
	
	
	filemodaltopresult.on("click", "button",function(e){
		var orgobjfile= $(this).data("path");
		var objtype= $(this).data("image");
		var objuuid= $(this).data("uuid");
		var objui=$(this).closest("li");
		var objname = objui.find("span").text();
		
		var objfile=encodeURIComponent(orgobjfile+"/"+objuuid+"_"+objname);
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

				const filelist=document.querySelectorAll(".modal_img_file");
				const commonfilelist=document.querySelectorAll(".modal_file");
				if(filelist.length===0){
					imgfilemodalresult.css("height","0px");
					imgfilemodalresult.empty();
				}
				if(commonfilelist.length===0){
					filemodalresult.css("height","0px");
					filemodalresult.empty();
				}
			},
			error: function(error){
				console.error('파일삭제 오류');
			}
		});	
	});
	filetopresult.on("click", "button",function(e){
		var orgobjfile= $(this).data("path");
		var objtype= $(this).data("image");
		var objuuid= $(this).data("uuid");
		var objui=$(this).closest("li");
		var objname = objui.find("span").text();
		var objfile=encodeURIComponent(orgobjfile+"/"+objuuid+"_"+objname);
		
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
				const showfilelist=document.querySelectorAll(".result_img_file");
				const showcommonfilelist=document.querySelectorAll(".result_file");
				if(showfilelist.length===0){
					imgfileresult.css("height","0px");
					imgfileresult.empty();
				}
				if(showcommonfilelist.length===0){
					fileresult.css("height","0px");
					fileresult.empty();
				}
			},
			error: function(error){
				console.error('파일삭제 오류');
			}
		});	
		
	});
	
	filemodalbtn.click(function(){
		filemodalresult.css("height","0px");
		imgfilemodalresult.css("height","0px");
		filemodalresult.empty();
		imgfilemodalresult.empty();
		filemodal.modal('show');
	});
	
	//새로고침과 뒤로가기 버튼을 누르거나 링크 이동시에만 파일 삭제해야 게시물 등록때는 작동을 안해야한다
	/*window.addEventListener('beforeunload', function(e) {
		
	//var target = event.target || event.srcElement;
	//(event.returnValue && event.returnValue.includes(' 새로고침'))
	    e.preventDefault(); 
		if (e.target?.classList?.contains('btn_boardinsert')) {
	        return;
	    }
	    else{
			console.log('동작중입니다');
	      // 임시 파일 삭제
	      fileclear();
	      return;
	    }
	    
	  });*/

	function fileclear(){
		//모달창이 열린상태이면
		var filemodalobj=$('#fileUploadModal');
		var filemodalopen=filemodalobj.css('display') === 'block';
		if(filemodalopen){
			modalfiledelete();
			resultfiledelete();
		}
		else{
			//모달창이 숨겨진 상태이면
			resultfiledelete();	
		}
	}
	filemodalreset.click(function(){
		modalfiledelete();
	});
	filemodalclose.click(function(){
		modalfiledelete();
		filemodal.modal('hide');
	});
	function modalfiledelete(){
		const dataPath=[];
		const dataName=[];
		const dataUuid=[];
		const dataType=[];
		const commondataPath=[];
		const commondataType=[];
		const commondataName=[];
		const commondataUuid=[];
		
		const filelist=document.querySelectorAll(".modal_img_file");
		const commonfilelist=document.querySelectorAll(".modal_file");
		
		if(filelist.length>0){
		for (let i = 0; i < filelist.length; i++) {
			const button=filelist[i].querySelector(".modal_file_btn");
			const name=filelist[i].querySelector("span").textContent;
			dataPath.push(button.dataset.path);
		    dataType.push(button.dataset.image);
		    dataUuid.push(button.dataset.uuid);
		    dataName.push(name);
		}
		deletefilelist(dataPath,dataType,dataUuid,dataName);
		for(let i=0;i<filelist.length;i++){
			filelist[i].remove();
		}

		imgfilemodalresult.css("height","0px");
		imgfilemodalresult.empty();
		}
		if(commonfilelist.length>0){
			for (let i = 0; i < commonfilelist.length; i++) {
			const button=commonfilelist[i].querySelector(".modal_file_btn");
			const name=commonfilelist[i].querySelector("span").textContent;
			commondataPath.push(button.dataset.path);
		    commondataType.push(button.dataset.image);
	    	commondataUuid.push(button.dataset.uuid)
	    	commondataName.push(name);
		}
		deletefilelist(commondataPath,commondataType,commondataUuid,commondataName);
		for(let i=0;i<commonfilelist.length;i++){
			commonfilelist[i].remove();
		}

		filemodalresult.css("height","0px");
		filemodalresult.empty();
				
		}
		if(commonfilelist.length === 0 && filelist.length === 0){			
			alert('파일이 없습니다');
		}
	}
	function resultfiledelete(){
		const dataPath=[];
		const dataName=[];
		const dataUuid=[];
		const dataType=[];
		const commondataPath=[];
		const commondataType=[];
		const commondataName=[];
		const commondataUuid=[];
		
		const showfilelist=document.querySelectorAll(".result_img_file");
		const showcommonfilelist=document.querySelectorAll(".result_file");
		
		if(showfilelist.length>0){
			for (let i = 0; i < showfilelist.length; i++) {
				const button=showfilelist[i].querySelector(".file_btn");
				const name=showfilelist[i].querySelector("span").textContent;
				dataPath.push(button.dataset.path);
			    dataType.push(button.dataset.image);
			    dataUuid.push(button.dataset.uuid);
			    dataName.push(name);
			}
			deletefilelist(dataPath,dataType,dataUuid,dataName);
			for(let i=0;i<showfilelist.length;i++){
				showfilelist[i].remove();
			}

			imgfileresult.css("height","0px");
			imgfileresult.empty();
			}
			if(showcommonfilelist.length>0){
				for (let i = 0; i < showcommonfilelist.length; i++) {
				const button=showcommonfilelist[i].querySelector(".file_btn");
				const name=showcommonfilelist[i].querySelector("span").textContent;
				commondataPath.push(button.dataset.path);
			    commondataType.push(button.dataset.image);
		    	commondataUuid.push(button.dataset.uuid)
		    	commondataName.push(name);
			}
			deletefilelist(commondataPath,commondataType,commondataUuid,commondataName);
			for(let i=0;i<showcommonfilelist.length;i++){
				showcommonfilelist[i].remove();
			}

			fileresult.css("height","0px");
			fileresult.empty();
					
			}
			if(showcommonfilelist.length === 0 && showfilelist.length === 0){			
				alert('파일이 없습니다');
			}
			
	}
	
	function deletefilelist(dataPath,dataType,dataUuid,dataName){
		 for (let i = 0; i < dataPath.length; i++){
			 const orgfileuri=dataPath[i];
			 const img=dataType[i];
			 const fileuuid=dataUuid[i];
			 const filename=dataName[i]
			 
			 const fileuri=encodeURIComponent(orgfileuri+"/"+fileuuid+"_"+filename);
			 var csrfToken = $("#_csrf").val();
			 
			 $.ajax({
					type:'post',
					url:'/deletefile',
					data:{fileuri: fileuri, filetype: img},
					dataType:'JSON',
			        beforeSend: function(xhr) {
			            xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			        },
					success: function(response){
						alert(response['result']);
					},
					error: function(error){
						console.error('파일삭제 오류');
					}
				});	
			 
		 }		
	}
	
	filemodalregister.click(function(){
		//각종 필요한 리스트 요소(4가지)를 이용해서 같은 방식으로 실제 등록화면에 반영
		const dataPath=[];
		const dataUuid=[];
		const dataName=[];
		const dataType=[];
		const commondataPath=[];
		const commondataUuid=[];
		const commondataName=[];
		const commondataType=[];
		const filelist=document.querySelectorAll(".modal_img_file");
		const commonfilelist=document.querySelectorAll(".modal_file");
		
		
		
		var str="";
		
		if(filelist.length>0){
			imgfileresult.css("height","1000px");
			for(var i=0;i<filelist.length;i++){
				const button=filelist[i].querySelector(".modal_file_btn");
				const name=filelist[i].querySelector("span").textContent;
				dataPath.push(button.dataset.path);
				dataUuid.push(button.dataset.uuid);
				dataName.push(name);
				dataType.push(button.dataset.image);
			}
			for(var i=0;i<filelist.length;i++){
			var dataname=dataName[i];
			var datapath=dataPath[i];
			var datauuid=dataUuid[i];
			var datatype=dataType[i];
			var imgfileuri=encodeURIComponent(datapath+"/"+datauuid+"_"+dataname);
			
			str=str+"<li class='result_img_file'>"+"<span>"+dataname+"</span>";
			str=str+"<img class='reuslt_img' src='/display?fileuri="+imgfileuri+"'>";
			str=str+"<button class='file_btn' type='button' data-path="+datapath+" data-name="+dataname+" data-uuid="+datauuid+" data-image="+datatype+">delete</button>";
			str=str+"</li>";
			}
			imgfileresult.append(str);
		}
		str="";
		if(commonfilelist.length>0){
			fileresult.css("height","500px");
			for(var i=0;i<commonfilelist.length;i++){
				const button=commonfilelist[i].querySelector(".modal_file_btn");
				const name=commonfilelist[i].querySelector("span").textContent;
				
				commondataPath.push(button.dataset.path);
				commondataUuid.push(button.dataset.uuid);
				commondataName.push(name);
				commondataType.push(button.dataset.image);
			}
			for(var i=0;i<commonfilelist.length;i++){
			var commondataname=commondataName[i];
			var commondatapath=commondataPath[i];
			var commondatauuid=commondataUuid[i];
			var commondatatype=commondataType[i];
				
			str=str+"<li class='result_file'>";
			str=str+"<span class='filename'>"+commondataname+"</span>";
			str=str+"<button class='file_btn' type='button' data-path=\'"+commondatapath+"\' data-name="+commondataname+" data-uuid="+commondatauuid+" data-image="+commondatatype+">delete</button>";
			str=str+"</li>";
			}
			fileresult.append(str);
		}
		
		if(filelist.length === 0 && commonfilelist.length === 0){
			alert('파일이 없습니다')
		}
		
		filemodal.modal('hide');
	})
	
	const modal_file_drag=$('#filemodalbody');
	modal_file_drag.on("dragover",function(e){
	    console.log("파일 드래그 감지");
	    e.preventDefault();
	});
	
	const modal_file_direct=$('#filemodaldirect');
	modal_file_direct.on("change",function(e){
		console.log("파일 직접 등록 완료");
	    e.preventDefault();
	    
		var csrfToken = $("#_csrf").val();
		var formData = new FormData();
	    var files =this.files;
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
		
		for(var i=0;i<resultfilelist.length;i++){
		if(resultfilelist[i].image===true)
		{
			//이미지 파일 리스트인 경우	
			//썸네일 파일을 생성해서 모달창 아래쪽에 최대 5*4인 격자무늬로 보여줌
			//이미지 경로를 받아서 섬네일을 보여주는 컨트롤러 메소드 필요
			imgfilemodalresult.css("height","300px");
				var imgfile=resultfilelist[i];
				var thumbfileuri=encodeURIComponent(imgfile.uploadPath+"/th_"+imgfile.uuid+"_"+imgfile.fileName);
				var imgfileuri=encodeURIComponent(imgfile.uploadPath+"/"+imgfile.uuid+"_"+imgfile.fileName);
				console.log(thumbfileuri);
				
				//파일의 이미지 여부, 파일의 경로정보, 파일의 이름, 파일의 uuid 등을 따로 저장해야(나중에 파일 등록버튼 누를시 필요)
				
				str=str+"<li class='modal_img_file'>"+"<span>"+imgfile.fileName+"</span>";
				str=str+"<img class='modal_thumimg' src='/display?fileuri="+thumbfileuri+"'>";
				str=str+"<button class='modal_file_btn' type='button' data-path="+imgfile.uploadPath+" data-name="+imgfile.fileName+" data-uuid="+imgfile.uuid+" data-image="+imgfile.image+">delete</burron>";
				str=str+"</li>";
				
				
			
			imgfilemodalresult.append(str);
		}
		if(resultfilelist[i].image===false)
		{
			//이미지 파일 리스트가 아닌 경우	
			//파일명 그대로 순서대로 모달창 아래쪽에 목록으로 보여줌
			str="";
			filemodalresult.css("height","300px");
				var normalfile=resultfilelist[i];
				var normalfileuri=encodeURIComponent(normalfile.uploadPath+"/"+normalfile.uuid+"_"+normalfile.fileName);
				var normalfilelink=normalfileuri
				
				console.log(normalfileuri);
				
				//파일의 이미지 여부, 파일의 경로정보, 파일의 이름, 파일의 uuid 등을 따로 저장해야(나중에 파일 등록버튼 누를시 필요)
				
				str=str+"<li class='modal_file'>";
				str=str+"<span class='filename'>"+normalfile.fileName+"</span>";
				str=str+"<button class='modal_file_btn' type='button' data-path=\'"+normalfile.uploadPath+"\' data-name="+normalfile.fileName+" data-uuid="+normalfile.uuid+" data-image="+normalfile.image+">delete</burron>";
				str=str+"</li>";
				
			filemodalresult.append(str);
		}
		}
	}
	
	
});
</script>
</body>
</html>