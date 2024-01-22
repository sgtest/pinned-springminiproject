package org.webservice.controller;

import java.util.List;

import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.webservice.domain.boardsearch;
import org.webservice.domain.comment;
import org.webservice.domain.commentpage;
import org.webservice.service_1.boardservice;
import org.webservice.service_1.commentservice;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/comment/*")
@Log4j
public class commentcontroller {
	
	
	boardservice bservice;
	
	commentservice cservice;
	
	//@PreAuthorize("authenticated()")
	@PostMapping("/insertcomment")
	public void insertcomment(comment cmt, RedirectAttributes rttr) {
		cservice.registercomment(cmt);
		rttr.addFlashAttribute("result", "success");
	}
	
	//@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/deletecomment")
	public void deletecomment(Long rno, RedirectAttributes rttr) {
		if(cservice.deletecomment(rno)==1) {
			rttr.addFlashAttribute("result", "success");
		}
		
	}
	
	@PostMapping("/updatecomment")
	public void updatecomment(comment cmt, RedirectAttributes rttr) {
		if(cservice.updatecomment(cmt)==1) {
			rttr.addFlashAttribute("result", "success");
		}
		
	}
	
	@GetMapping("/readcommentlist")
	@ResponseBody
	public commentpage readcommentlist(@RequestParam Long bno, @RequestParam int pagenum) {
		boardsearch search=new boardsearch(pagenum,10);
		List<comment> cmtlist=cservice.getcmtlist(search, bno);
		commentpage cmtpage=new commentpage(cmtlist.size(), cmtlist);
		
		return cmtpage;
	}
	
}
