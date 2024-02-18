<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardlist information</title>
    <!-- Bootstrap CSS -->
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
			.boardlisttabletop{
				display: flex;
    			text-align: center;
				width:1500px;
				padding:10px;
			}
			.boardlisttable{
    			padding: 10px;
    			text-align: center;
    			margin: 0 auto;
				max-height:1000px;
    			overflow-y: scroll;
			}
			#brdtable{
				table-layout:fixed;
  				text-align: center;
  				border-spacing: 20px 20px;
				width: 100%
			}
			.boardlistsubject{
				width:500px;
				
			}
			td{
				word-wrap:break-word;
			}
          </style>
</head>
<body>
	
	<div>
	<button onclick="location.href='listboard'">홈화면으로 돌아가기</button>
	</div>
	
	<div class="boardlisttabletop">
		<div class="boardlisttable">
			<table id="brdtable">
				<thead>
					<tr>
						<th>게시판 일련번호</th>
						<th>게시판 이름</th>
						<th>게시판 등록일자</th>
						<th>게시판 생성아이디</th>
						<th>게시판에 대한 설명</th>
					</tr>
					<tbody id="boardlisttablebody">
					<c:forEach var="boardlist" items="${boardlistset}">
						<tr>
							<td>${boardlist.boardnum}</td>
							<td class="boardlistname">${boardlist.boardname}</td>
							<td>${boardlist.regdate}</td>
							<td>${boardlist.reguserid}</td>
							<td class="boardlistsubject">${boardlist.boardsubject}</td>
						</tr>
					</c:forEach>
					</tbody>
				</thead>
			</table>
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
	
	
});

</script>
</body>
</html>