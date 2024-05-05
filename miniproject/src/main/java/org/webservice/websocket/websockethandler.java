package org.webservice.websocket;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class websockethandler extends TextWebSocketHandler{
	
	//세션 아이디, 웹소켓 연결 객체를 저장하는 리스트
	//List<HashMap<String, Object>> sessionlist=new ArrayList<>();
	List<WebSocketSession> sessionlist=new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//HashMap<String, Object> sessionmap = new HashMap<String, Object>();
		System.out.println(session.getUri());
		//sessionmap.put(session.getId(), session);
		//sessionlist.add(sessionmap);
		sessionlist.add(session);
		super.afterConnectionEstablished(session);
		System.out.println("새로 생성된 세션 아이디: "+session.getId());
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		/*
		for(int i=0;i<sessionlist.size();i++) {
			sessionlist.get(i).remove(session.getId());
		}
		*/
		sessionlist.remove(session);
		System.out.println(session.getId()+" 연결 세션 종료");
		super.afterConnectionClosed(session, status);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg=message.getPayload();
		
		SimpleDateFormat stf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strday=stf.format(new Date());
		String sendmsg=msg+"|"+strday;
		/*for(HashMap<String, Object> sessionmap: sessionlist) {
			WebSocketSession exsession=(WebSocketSession) sessionmap.get(session.getId());
			exsession.sendMessage(new TextMessage(sendmsg));
			
			System.out.println(exsession.getId()+" 세션에서 전송된 메시지: "+sendmsg);
		}*/
		for(WebSocketSession s: sessionlist) {
			if(!s.getId().equals(session.getId())) {
				s.sendMessage(new TextMessage(sendmsg));
				System.out.println(s.getId()+" 세션에서 전송된 메시지: "+sendmsg);
			}
		}
		super.handleTextMessage(session,message);
	}
	
}
