package org.webservice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.webservice.domain.member;
import org.webservice.mapper.membermapper;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class securitycontroller {

	//@Autowired
	//private customUserDetailService csuser;
	private membermapper mmapper;
@GetMapping("/loginboard")
public String loginview() {
	return "loginboard";
}
@PostMapping("/loginaction")
public String loginaction() {
	//member mem=mmapper.readmember(id);
	//secmemberdetail ud=(secmemberdetail) csuser.loadUserByUsername(id);
	//m.setUserid(id);
	//m.setUserpw(passwd);
    //Authentication authentication = new UsernamePasswordAuthenticationToken();
    
	return "redirect:/board/listboard";
}
@GetMapping("/loginerror")
public void loginerror() {
	
}

@PostMapping("/logoutaction")
public String logoutaction() {
	return null;
}

@GetMapping("/boardjoin")
public void boardjoin() {
	
}
@PostMapping("/boardjoinaction")
public void boardjoinaction() {
	
}

}
