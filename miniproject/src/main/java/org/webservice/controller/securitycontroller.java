package org.webservice.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.naming.spi.DirStateFactory.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.webservice.domain.auth;
import org.webservice.domain.board;
import org.webservice.domain.boardpage;
import org.webservice.domain.boardsearch;
import org.webservice.domain.comment;
import org.webservice.domain.member;
import org.webservice.domain.memberfile;
import org.webservice.mapper.filemapper;
import org.webservice.mapper.membermapper;
import org.webservice.service_1.boardservice;
import org.webservice.service_1.commentservice;


import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class securitycontroller {

	//@Autowired
	//private customUserDetailService csuser;
	@Setter(onMethod_ = @Autowired)
	private membermapper mmapper;
	@Setter(onMethod_ = @Autowired)
	private filemapper fmapper;
	@Setter(onMethod_ = @Autowired)
	private boardservice bservice;
	@Setter(onMethod_ = @Autowired)
	private commentservice cmtservice;
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pencoder;
	
	//비밀번호 정규식
	private static final String pass_regex = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$";
	//휴대폰 정규식
	private static final String phone_regex = "^\\d{10,11}$";

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

@PreAuthorize("authenticated()")
@GetMapping("/myPage")
public void myPage(Model model) {
	//마이페이지,작성 글과 댓글 기록, 업로드 파일 기록, 회원정보
	//메일 과 1:1 채팅기능(추후 구현 가능성)
	Authentication auth=SecurityContextHolder.getContext().getAuthentication();
	String userid=auth.getName();
	member minfo=mmapper.readmember(userid);
	List<board> mbrdlist=bservice.getListbyid(userid);
	List<comment> mcmtlist=cmtservice.getcmtlistbyid(userid);
	List<memberfile> mfilelistList=bservice.getMemberfilebyuserid(userid);
	
	model.addAttribute("memberinfo", minfo);
	model.addAttribute("boardrecordsize", mbrdlist.size());
	model.addAttribute("boardrecord", mbrdlist);
	model.addAttribute("commentrecordsize", mcmtlist.size());
	model.addAttribute("commentrecord", mcmtlist);
	model.addAttribute("filerecordsize", mfilelistList.size());
	model.addAttribute("filerecord", mfilelistList);
}



@GetMapping("/boardjoin")
public void boardjoin() {
	
}

@PostMapping("/boardjoinaction")
public String boardjoinaction(String id, String passwd, String username, String phone) {
	
	List<auth> aulist=new ArrayList<auth>();
	auth au=new auth();
	String userid=id;
	String userpw=passwd;
	String usname=username;
	String pne=phone;
	String enpw=pencoder.encode(passwd);
	if(mmapper.readmember(userid)!=null) {
		return  "redirect:/loginboard";
	}
	member joinmem=new member();
	
	au.setUserid(userid);
	au.setAuth("common");
	aulist.add(au);
	
	joinmem.setAuthlist(aulist);
	joinmem.setUserid(userid);
	joinmem.setUserpw(enpw);
	joinmem.setUsername(username);
	joinmem.setPhone(phone);
	
	mmapper.insertmember(joinmem);
	
	return "redirect:/loginboard";
}

@PostMapping("/idcheckaction")
@ResponseBody
public Map<String, Object> idcheckaction(String id){
	Map<String, Object> response=new HashMap<String, Object>();
	
	if(mmapper.readmember(id)!=null) {
		response.put("result", "failure");
	}else {
		response.put("result", "success");
	}
	
	return response;
}

@PostMapping("/etcdatacheckaction")
@ResponseBody
public Map<String, Object> etcdatacheckaction(String passwd, String username, String phonenumber)
{
	Map<String, Object> response=new HashMap<String, Object>();
	Pattern pwptn=Pattern.compile(pass_regex);
	Pattern phptn=Pattern.compile(phone_regex);
	
	Matcher pwmach=pwptn.matcher(passwd);
	Matcher phmach=phptn.matcher(phonenumber);
	
	if(!pwmach.matches()||!phmach.matches()||username.length()<3) {
		response.put("result", "failure");
	}
	else {
		response.put("result", "success");
	}
	return response;
}

@GetMapping("/boardout")
public void boardout() {
	
}

@PostMapping("/boardoutaction")
public String boardoutaction() {
	
	return "redirect:/loginboard";
}

}
