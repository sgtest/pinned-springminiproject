User
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
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
		.chatdiv .particate{
			text-align: center;
		}
		.chatdiv .exit{
			text-align: center;
		}
		.chatText{
			margin-top: 20px;
		}
    </style> 
</head>
<body>
	<button id="session_btn">close_btn</button>
	<div class="chatroom_title">
		<h3 id="chatroomcode">${chatroomcode}</h3>
		<h3 id="chatowner">${myid}</h3>
		<h3 id="chatroom_id">${chatroomtitle}</h4>
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
	let jssocket;
	let jsstomp;
	$(document).ready(function(){
		var sessionclosebtn=$("#session_btn");
		var chtrmcode="${chatroomcode}";
		
			jssocket=new SockJS("http://localhost:8080/requestsession");
			jsstomp=Stomp.over(jssocket);
			jsstomp.connect({}, function(frame) {
				console.log('Connected: ' + frame);
				
				jsstomp.subscribe("/sub/pub/"+chtrmcode,function(chat){
			        var msg=JSON.parse(chat.body);
			        var msgtype=msg.type;
			        var msgcontent=msg.content;
			        var msgwritter=msg.userid;
			        var msgdate=msg.regdate;

			        var str="";
			        if(msgtype === "nomal"){
			            str=str+'<div class="message othermessae">';
			            str=str+'<h4>'+msgwritter+'</h4>';
			            str=str+'<p>'+msgcontent+'</p>';
			            str=str+'<p>'+msgdate+'</p>';
			            str=str+'</div>';
			        }
			        else if(msgtype === "particate"){
			            str=str+'<div class="message particate">';
			            str=str+'<h4>'+msgwritter+'</h4>';
			            str=str+'<p>'+msgcontent+'</p>';
			            str=str+'<p>'+msgdate+'</p>';
			            str=str+'</div>';
			        }
			        else{
			            str=str+'<div class="message exit">';
			            str=str+'<h4>'+msgwritter+'</h4>';
			            str=str+'<p>'+msgcontent+'</p>';
			            str=str+'<p>'+msgdate+'</p>';
			            str=str+'</div>';
			        }
			        $('.chatdiv').append(str);
			        scrollToBottom();
			    });
				
				var particater=$("#chatowner").text();
	            var date=new Date();
	        	var strday = getTime();
	    		var strday = '   TIME: ' + strday;
	    		var partication="채팅에 참여하였습니다.";

	    		var chatdiv=$(".chatdiv");
	            var str="";
	    		str=str+'<div class="message particate">';
	    		str=str+'<h4>'+particater+'</h4>';
	    		str=str+'<p>'+partication+'</p>';
	    		str=str+'<p>'+strday+'</p>';
	    		str=str+'</div>';
	    		chatdiv.append(str);
	    		//var particatemsg=particater+"|"+partication;
	    		//json 형태로 전송?
	    		var particatemsg={
	    				"roomcode": chtrmcode,
	    				"userid": particater,
	    				"content": particater+" 님이 "+partication,
	    				"type": "particate",
	    				"regdate": date
	    		}
	    		jsstomp.send("/pub/chat/message?code="+chtrmcode,{},JSON.stringify(particatemsg));
				scrollToBottom();
				
			});	
    		
			
		
		
	});
	
	$(document).on("click","#session_btn",function(){
		sessionclose();
		function sessionclose(){
			
			console.log("연결 세션 종료");
		}
	});
	
	$(document).on("click","#submitmsg",function(){
		var str="";
		var chatsender="나";
		var chatsenderid=$("#chatowner").text();
		var chatdiv=$(".chatdiv");
		var message=$("#msgcontent").val();
		var chtrmcode="${chatroomcode}";
		
		var current = new Date();
		var strday = getTime();
		var strday = '   TIME: ' + strday;
		
		$("#msgcontent").val("");
		str=str+'<div class="message mymessage">';
		str=str+'<h4>'+chatsender+'</h4>';
		str=str+'<p>'+message+'</p>';
		str=str+'<p>'+strday+'</p>';
		str=str+'</div>';
		chatdiv.append(str);

		//json 형태로 전송?
		var particatemsg={
    			"roomcode": chtrmcode,
    			"userid": chatsender,
    			"content": message,
    			"type": "nomal",
    			"regdate": current
    	}
    	jsstomp.send("/pub/chat/message?code="+chtrmcode,{},JSON.stringify(particatemsg));				
		
		scrollToBottom();
		
	});
	
	function getTime(){
		var currentDate = new Date();
		var year = currentDate.getFullYear();
		var month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
		var day = ('0' + currentDate.getDate()).slice(-2);
		var hours = ('0' + currentDate.getHours()).slice(-2);
		var minutes = ('0' + currentDate.getMinutes()).slice(-2);
		var seconds = ('0' + currentDate.getSeconds()).slice(-2);
		var strday = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;	
		return strday;
	}
	function scrollToBottom() {
	    var chatdiv = $('.chatdiv');
	    chatdiv.scrollTop(chatdiv.prop("scrollHeight"));
	}
	</script>
</html>