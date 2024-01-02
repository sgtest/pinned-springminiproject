package org.webservice.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
public class boardcontroller {

	
	@GetMapping("/readBoard")
	public void readboardLink() {
		
	}
	
	@PreAuthorize("authenticated()")
	@PostMapping("/createBoardlist")
	public String createboardlist() {
		
		return "redirect:/board/list";
	}
	
	@PreAuthorize("authenticated()")
	@PostMapping("/createBoard")
	public String createboardLink() {
		
		return "redirect:/board/list";
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/updateBoard")
	public String updateboardLink(){
		
		return "redirect:/board/list";
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/removeBoard")
	public String deleteboard() {
		return "redirect:/board/list";
	}
	
	
}
