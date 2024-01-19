<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>this is world board</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
          crossorigin="anonymous">
          
     <style>
        .boardlist {
            margin-top: 20px;
        }

        .default_board_top {
            text-align: center;
        }

        .board_table {
            width: 100%;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .page-item {
            margin: 0 5px;
        }
    </style>
          
</head>
<body>
	<h2>이것은 게시판이다</h2>
	
	<div class="boardlist">
	<div class=default_board_top align="center">
		<table boarder="1" class="board_table">
			<thead>
			<tr>
				<th>#게시물 번호</th>
				<th>게시판 이름</th>				
				<th>게시물 제목</th>
				<th>작성자</th>
				<th>등록 날짜</th>
				<th>수정 날짜</th>
				<th>댓글 숫자</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="board" items="${boardList}">
				<tr>
					<td>${board.bno}</td>					
					<td>${board.boardname}</td>
					<td><a href="readBoard/${board.bno}"> ${board.title}</a></td>
					<td>${board.writer}</td>
					<td><fmt:formatDate value="${board.regdate}" pattern="yyyy/MM/dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${board.udate}" pattern="yyyy/MM/dd HH:mm:ss" /></td>
					<td>${board.replyCnt}</td>					
				</tr>
			</c:forEach>
			</tbody>
		</table>		
	</div>
	</div>
	
	<div class="pagination">
    <c:if test="${page.prev}">
        <li class="page-item previous">
            <a href="${page.startPage-1}">Prev </a>
        </li>
    </c:if>
    
    <c:forEach var="num" begin="${page.startPage}" end="${page.endPage}">
        <li class="page-item btn">
            <a href="${num}">${num}</a>
        </li>
    </c:forEach>
    
    <c:if test="${page.next}">
        <li class="page-item next">
            <a href="${page.endPage+1}"> Next</a>
        </li>
    </c:if>
</div>

<form id='boardmove' method='get'>
    <input type='hidden' name='pageNum' value='${page.srh.pageNum}'>
    <input type='hidden' name='amount' value='${page.srh.amount}'>
</form>

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
    $(document).ready(function(){
        let boardmove = $("#boardmove");
        $(".page-item a").on("click", function(e){
        	e.preventDefault();
        	console.log("page click");
        	boardmove.find("input[name='pageNum']").val($(this).attr("href"));
        	boardmove.attr("action","listboard");
        	boardmove.submit();
        });
    });
</script>
</body>
</html>