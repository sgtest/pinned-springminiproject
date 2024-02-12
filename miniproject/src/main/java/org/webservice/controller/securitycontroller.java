package org.webservice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.spi.DirStateFactory.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
public void boardjoinaction() {
	
}

}
