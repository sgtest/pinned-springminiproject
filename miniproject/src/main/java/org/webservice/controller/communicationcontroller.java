package org.webservice.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.webservice.domain.friend;
import org.webservice.service_1.communicationservice;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class communicationcontroller {

	@Setter(onMethod_=@Autowired)
	private communicationservice communicateservice;
	
	@PreAuthorize("authenticated()")
	@GetMapping("chat")
	public void chatting(String userid, String frienduserid, Model model) {
		
	}
	
	@PreAuthorize("authenticated()")
	@PostMapping("/deletefriend")
	@ResponseBody
	public Map<String,Object> deletefriend(String userid, String fuserid){

		Map<String, Object> response=new HashMap<String, Object>();
		Authentication auth=SecurityContextHolder.getContext().getAuthentication();
		String exuserid=auth.getName();
		if(exuserid.compareTo(userid)!=0){
			response.put("result", "failure");
		}else {
			communicateservice.delete_friend(exuserid, fuserid);
			response.put("result", "success");
		}	
		return response;
	}
	
	@PreAuthorize("authenticated()")
	@PostMapping("/insertfriend")
	@ResponseBody
	public Map<String,Object> insertfriend(String userid, String fuserid){

		Map<String, Object> response=new HashMap<String, Object>();
		Authentication auth=SecurityContextHolder.getContext().getAuthentication();
		String exuserid=auth.getName();
		if(exuserid.compareTo(userid)!=0){
			response.put("result", "failure");
		}else {
			communicateservice.insert_friend(userid, fuserid);
			response.put("result", "success");
		}	
		return response;
	}
	
}
