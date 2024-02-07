package org.webservice.controller;

import java.util.HashMap;
import java.util.Map;

import javax.naming.spi.DirStateFactory.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.webservice.domain.member;
import org.webservice.mapper.membermapper;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class securitycontroller {

	//@Autowired
	//private customUserDetailService csuser;
	@Autowired
	private membermapper mmapper;
@GetMapping("/loginboard")
public String loginview() {
	return "loginboard";
}
@PostMapping("/loginaction")
public String loginaction() {
	return "redirect:/board/listboard";
}

@PostMapping("/getuserinfo")
@ResponseBody
public Map<String, Object> getuserinfo(String userid){
	//log.info(userid);
	member minfo=mmapper.readmember(userid);
	Map<String,Object> result=new HashMap<String, Object>();
	
	result.put("userinformation", minfo);
	return result;
}

@PostMapping("/getuserinfoname")
@ResponseBody
public Map<String, Object> getuserinfoname(String userid){
	//log.info(userid);
	member minfo=mmapper.readmember(userid);
	String realname=minfo.getUsername();
	Map<String,Object> result=new HashMap<String, Object>();
	
	result.put("userrealname", realname);
	return result;
}

@GetMapping("/loginerror")
public void loginerror() {
	
}

@PostMapping("/logoutaction")
public String logoutaction() {
	return "redirect:/board/listboard";
}

@GetMapping("/boardjoin")
public void boardjoin() {
	
}
@PostMapping("/boardjoinaction")
public void boardjoinaction() {
	
}

}
