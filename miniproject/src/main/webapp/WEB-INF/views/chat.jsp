<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chatting</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
          crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5PtkFExj5u9bOyDDn5a+3pu8L+I2LZ"
        crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyldQxFbSTFpCR78dt4vgLSF6g6yo"
        crossorigin="anonymous"></script>
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
       textarea{
			margin: 0;
			text-align: justify;
			font-size: 15px;
			resize: none;
		}
		.chatdiv{
			margin-top:20px;
			width: 800px;
			height: 800px;
    		border: 1px solid #ccc;
   			overflow-y: auto;
    		padding: 10px;
    		background-color: #f9f9f9;
		}
		.chatdiv .message{
    		background-color: #fff;
    		border-radius: 5px;
    		padding: 5px 10px;
   			margin-bottom: 10px;
		}
		.chatdiv .message:last-child{
    		margin-bottom: 0;
    	}
		.chatdiv .mymessage{
			text-align: right;
		}
		.chatdiv .othermessae{
			text-align: left;
		}
		.chatText{
			margin-top: 20px;
		}
    </style> 
</head>
<body>
	<button id="session_btn">close_btn</button>
	<div class="chatroom_title">
		<h3 id="chatroom_id">test title</h4>
	</div>
	<div class="chatdiv">
		<div></div>
	</div>
	<div class="chatText">
		<textarea id="msgcontent" rows="1" cols="80"></textarea>
		<button id="submitmsg">submit</button>
	</div>
</body>
	<script>  
	let websocket;
	$(document).ready(function(){
		var sessionclosebtn=$("#session_btn");
		function sessionconnect(){
			websocket=new WebSocket("ws://localhost:8080/requestsession");
            websocket.onopen = sessionconnectafter;
            websocket.onmessage = listenmessage;
		}
		sessionconnect();
		
	});
	
	$(document).on("click","#session_btn",function(){
		sessionclose();
		function sessionclose(){
			websocket.close();
			console.log("연결 세션 종료");
		}
	});
	
	$(document).on("click","#submitmsg",function(){
		var str="";
		var chatsender="나";
		var chatdiv=$(".chatdiv");
		var message=$("#msgcontent").val();
		sendmessage(message);
		$("#msgcontent").val("");
		str=str+'<div class="message mymessage">';
		str=str+'<h4>'+chatsender+'</h4>';
		str=str+'<p>'+message+'</p>';
		str=str+'</div>';
		chatdiv.append(str);
		
		
		function sendmessage(message){
            websocket.send(message);
		}
	});
	
	function sessionconnectafter(){
		
	}
	
	function listenmessage(event){
		
	}
	</script>
</html>