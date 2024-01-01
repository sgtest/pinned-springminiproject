package org.webservice.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
public class boardcontroller {

	
	@RequestMapping(value="/readBoard/",method=RequestMethod.GET)
	public void readboardLink() {
		
	}
	
	@PreAuthorize("authenticated()")
	@RequestMapping(value="/createBoard/",method=RequestMethod.POST)
	public String createboardLink() {
		
		return "redirect:/board/list";
	}
	
	@PreAuthorize("authenticated()")
	@RequestMapping(value="/updateBoard/",method=RequestMethod.POST)
	public String updateboardLink(){
		
		return "redirect:/board/list";
	}
}
