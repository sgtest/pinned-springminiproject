<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글을 수정합니다.</title>
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
	.update_attachfileform{
		margin-left: 10px;
		display: flex;
		flex-direction: row;
		justify-content: flex-start;
	}
	#update_imgfile_modal,#update_cmnfile_modal{
		width: 1500px;
		hight: 1200px;
	}
	
	.imgfile_view{
  		display: flex;
 	    flex-direction: row;
  		overflow-x: scroll;
    	height:1200px;	
	}
	.cmnfile_view{
  		display: flex;
  		flex-direction: column;
  		overflow-y: scroll;
    	height:1200px;	
	}
</style>
</head>
<body>

<h1>게시물 수정 페이지</h1>
<button onclick="goBack()">이전페이지로 돌아가기</button><br><br>
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
	<div class="update_attachfileform">
		<div class="imgmodalbtnform">
		<p class="imgfilenumber"></p>
		<input type="button" class="imgfile_modal_btn"  data-bs-toggle="modal" data-bs-target="#update_imgfile_modal" value="해당 이미지들 보기"/><br><br>
		</div>
		
		<div class="commodalbtnform">
		<p class="comfilenumber"></p>
		<input type="button" class="comfile_modal_btn" data-bs-toggle="modal" data-bs-target="#update_cmnfile_modal" value="일반 첨부 파일 목록 보기" /><br><br>
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

	<div id="update_imgfile_modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">		
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="imgfile_content" >
			<button id="update_imgfile_modal_close_btn" data-dismiss="modal">닫기</button>
			<div id="imgupdate">
			
			<div id="imgdragupdate">
			
			</div>
			</div>
			<div class="updateimgfile_view" id="imgfile_view">
			<!-- 현재 업로드된 사진들을 보여주고 아래에 삭제버튼으로 삭제를 가능하게 한다-->
			<ul class="upimgfile_layout">
			
			</ul>
			</div>
			</div>
		</div>
	</div>

	<div id="update_cmnfile_modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">		
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="cmnfile_content">
			<button id="update_cmnfile_modal_close_btn" data-dismiss="modal">닫기</button>
			<div id="cmnupdate">
			
			<div id="cmndragupdate">
			
			</div>
			</div>
			<div class="updatecmnfile_view" id="cmnfile_view">
			<!-- 현재 업로드된 일반 파일의 이름을 목차별로 보여주고 삭제도 가능하게 한다. -->
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
	var bno=${board.bno};
	var imgumodal=$('#update_imgfile_modal');
	var cmnumodal=$('#update_cmnfile_modal');
	var imgview=$('.upimgfile_layout');
	var cmnview=$('.updatecmnfile_view');
	var imgmodalbtn=$('.imgfile_modal_btn');
	var cmnmodalbtn=$('.comfile_modal_btn');
	var imgmodalclbtn=$('#update_imgfile_modal_close_btn');
	var cmnmodalclbtn=$('#update_cmnfile_modal_close_btn');
	
	
	loadattachfile(bno);
	
	function loadattachfile(bno){
		var vbno=bno;
	$.ajax({
			type:'get',
			url:'fileload',
			data:{bno: vbno},
			dataType:'json',
			success: function(response){
				if(response['result']==='exist'){
					achfilelist=response['attachlist'];
					dispalyfileview(achfilelist);
				}else{
					console.log('파일이 존재하지 않습니다.');
				}
			},
			error: function(){
				console.error('파일을 불러오는 것을 실패하였다');
			}
		});
	}
	
	function dispalyfileview(achfilelist){
		var vachfilelist=achfilelist;
		var str="";
		var vstr="";
		for(var i=0;i<vachfilelist.length;i++){
			var file=vachfilelist[i];
			if(file.image===true){
				//<div><p></p><img></img><button></button></div>
				//파일의 이름과 uuid, 'th_', 경로를 조합해서 썸네일 이미지 정보를 가져옴
				var orguri=file.uploadPath;
				var thuri=encodeURIComponent(file.uploadPath+"/th_"+file.uuid+"_"+file.fileName);
				str=str+'<div class="upimg_obj"><p>'+file.fileName+'</p>';
				str=str+'<img src="/display?fileuri='+thuri+'"></img>';
				str=str+'<button></button>';
				str=str+'</div>';
			}
			else{
				//<div><p></p><button></button></div>
				//파일의 이름만 보여준다.
				vstr=vstr+'<div class="upcmn_obj"><p>'+file.fileName+'</p>';
				vstr=vstr+'<button></button>';
				vstr=vstr+'</div>';
			}
		}
		imgview.append(str);
		cmnview.append(vstr);		
	}
	
	imgmodalbtn.on("click",function(){
		imgumodal.modal('show');
	});
	cmnmodalbtn.on("click",function(){
		cmnumodal.modal('show');
	});
	imgmodalclbtn.on("click",function(e){
		imgumodal.modal('hide'); 
        //$("#update_imgfile_modal_close_btn").attr("data-dismiss", "modal");
	});
	cmnmodalclbtn.on("click",function(e){
		cmnumodal.modal('hide');
        //$("#update_cmnfile_modal_close_btn").attr("data-dismiss", "modal");
	});
});
	
	function goBack(){
		//window.location.href="readBoard?bno="+${board.bno};
    	window.history.back();
	}
</script>
</body>
</html>