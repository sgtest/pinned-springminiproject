package org.webservice.controller;

import java.io.File;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.webservice.domain.attachfile;
import org.webservice.domain.boardsearch;
import org.webservice.service_1.boardservice;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
public class boardcontroller {

	public boardservice bservice;
	
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
	public String deleteboard(@RequestParam final Long bno, boardsearch search, RedirectAttributes rttr, String writer) {
		
		if(bservice.deleteboard(bno)) {
			//파일 직접 삭제 함수
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
	private void Filedelete(List<attachfile> filelist) {
		String filelink="";
		File file;
		for(attachfile rmfile:filelist) {
			
		}
	}

	private void Fileupload(attachfile file) {
		
	}
	
	private void oldFiledelete() {
		
	}
}
