package org.webservice.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class websockethandler extends TextWebSocketHandler{
	
	//세션 아이디, 웹소켓 연결 객체를 저장하는 리스트
	Map<String, WebSocketSession> sessionmap = new HashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionmap.put(session.getId(), session);
		super.afterConnectionEstablished(session);
		System.out.println("세션 아이디: "+session.getId());
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println(session.getId()+" 연결 세션 종료");
		sessionmap.remove(session.getId());
		
		super.afterConnectionClosed(session, status);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg=message.getPayload();
		System.out.println("전송된 메시지: "+msg);
		super.handleTextMessage(session,message);
	}
	
}
