package org.webservice.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.webservice.domain.attachfile;
import org.webservice.domain.board;
import org.webservice.domain.boardlist;
import org.webservice.domain.boardpage;
import org.webservice.domain.boardsearch;
import org.webservice.domain.memberfile;
import org.webservice.mapper.membermapper;
import org.webservice.service_1.boardservice;
import org.webservice.service_1.commentservice;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
public class boardcontroller {

	public boardservice bservice;
	@Autowired
	public membermapper mmapper;
	@GetMapping("/readBoard")
	public void readBoard(@RequestParam("bno") Long bno,@ModelAttribute("search") boardsearch search, Model model) {
		
		board board=bservice.readBoard(bno);
		List<attachfile> attachlist=bservice.getfilelist(bno);
		
		model.addAttribute("attachlist", attachlist);
		model.addAttribute("board", board);
		model.addAttribute("search",search);
	}
	
	@GetMapping("/listboard")
	public void listboard(boardsearch search, Model model) {
		
		List<board> boardList=bservice.getList(search);
		List<String> username=new ArrayList<String>();
		for(int i=0;i<boardList.size();i++) {
			String userid=boardList.get(i).getWriter();
			String realname=mmapper.readmembername(userid);
			username.add(realname);
		}
		boardpage page=new boardpage(search, bservice.getlisttotal(search));
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("realnamelist", username);
		model.addAttribute("page", page);
		
	}
	
	@PreAuthorize("authenticated()")
	@PostMapping("/saveBoard")
	public String saveBoard(board brd, boardsearch search, RedirectAttributes rttr) {
		if(brd.getAttachlist()!=null) {
		for(int i=0;i<brd.getAttachlist().size();i++) {
			log.info("this is files: "+brd.getAttachlist().get(i).getFileName());
		}
		}
		bservice.insertboard(brd);
		rttr.addFlashAttribute("result","success");
		return "redirect:/board/listboard"+search.getListLink();
	}	
	@PreAuthorize("authenticated()")
	@GetMapping("/createBoard")
	public void createBoard(boardsearch search, Model model) {
		List<String> boardname=bservice.select_boardlist();
		model.addAttribute("boardlist", boardname);
		model.addAttribute("searchcondition", "type: "+search.getType()+", keyword: "+search.getKeyword());
	}
	
	@PostMapping("/uploadTest")
	public void uploadTest(MultipartFile[] uploadFile, Model model) {
		for(MultipartFile multipartFile:uploadFile) {
			log.info(multipartFile.getOriginalFilename());
			log.info(multipartFile.getSize());
			log.info(multipartFile.getName());
		}
	}

	@PreAuthorize("hasAuthority('master')")
	@GetMapping("removeBoardlist")	
	public void removeBoardlist(Model model) {
		List<boardlist> brdlist=bservice.select_boardlistset();
		model.addAttribute("boardlistset", brdlist);
	}
	
	@PreAuthorize("hasAuthority('master')")
	@PostMapping("removeBoardlistaction")
	public Map<String, Object> removeBoardlistaction(String brdname) {
		Map<String, Object> response=new HashMap<String, Object>();
	if(bservice.board_delete(brdname)) {
		response.put("result", "success");
	}else {
		response.put("result", "failure");
	}
		return response;
	}

	@PreAuthorize("hasAuthority('admin')")
	@PostMapping("createBoardlistaction")
	public String createBoardlistaction(boardlist brdli, boardsearch search, RedirectAttributes rttr) {
		
		List<String> ex_brdlist=bservice.select_boardlist();
		
		for(String brdlist:ex_brdlist) {			
			if(brdli.getBoardname().equals(brdlist)) {
				rttr.addAttribute("result", "error");
				return "redirect:/board/listboard"+search.getListLink();
			}
		}
		bservice.board_register(brdli.getBoardname(), brdli.getReguserid(), brdli.getBoardsubject());
		rttr.addAttribute("result", "success");
		return "redirect:/board/listboard"+search.getListLink();
	}
	
	@PreAuthorize("hasAuthority('admin')")
	@GetMapping("createBoardlist")
	public void createBoardlist(Model model) {
		
	}

	@GetMapping("/selectBoardlist")
	public void getlistboard(Model model) {
		List<boardlist> brdlist=bservice.select_boardlistset();
		model.addAttribute("boardlistset", brdlist);
	}
	
	//@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/updatesaveBoard")
	public String updatesaveBoard(board brd, boardsearch search,RedirectAttributes rttr) {
		log.info(brd.getBno()+"  "+brd.getTitle()+"  "+brd.getContent()+"  "+brd.getUdate());
		if(bservice.updateboard(brd))
			rttr.addFlashAttribute("result", "success");
		
		return "redirect:/board/listboard"+search.getListLink();
	}
	
	//@PreAuthorize("principal.username == #board.writer")
	@GetMapping("/updateBoard")
	public void updateBoard(Long bno, boardsearch search, Model model){
		board brd=bservice.readBoard(bno);
		List<String> boardname=bservice.select_boardlist();
		model.addAttribute("boardlist", boardname);
		model.addAttribute("board", brd);
	}
	
	//@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/removeBoard")
	public String removeBoard(@RequestParam final Long bno, boardsearch search, RedirectAttributes rttr) {
		log.info(bno);
		Filedelete(bservice.getfilelist(bno));
		log.info(bservice.getfilelist(bno).size());
		bservice.deletefilelist(bno);
		bservice.deleteboard(bno);
		rttr.addFlashAttribute("result", "success");
		
		return "redirect:/board/listboard"+search.getListLink();
	}
	
	@PostMapping("/directremoveBoard")
	@ResponseBody
	public Map<String,Object> directremoveBoard(Long bno) {
		Map<String, Object> response=new HashMap<String, Object>();
		Filedelete(bservice.getfilelist(bno));
		bservice.deletefilelist(bno);
		
		if(bservice.deleteboard(bno)) {
			response.put("result", "success");
		}
		
		return response;
	}	
	
	private void Filedelete(List<attachfile> filelist) {
		String firstfilelink="D:\\server\\temp\\";
		Path fpath,sumfpath;
		if(filelist==null||filelist.size()==0) {
			return;
		}
		
		for(attachfile rmfile:filelist) {
			fpath=Paths.get(firstfilelink+rmfile.getUploadPath()+"\\"+rmfile.getUuid()+"_"+rmfile.getFileName());
			log.info(fpath.toString());
			try {
				Files.deleteIfExists(fpath);
			} catch (IOException e) {
				log.info("삭제하려는 파일이 없거나 실패하였습니다.");
			}
			if(rmfile.isImage()) {
				sumfpath=Paths.get(firstfilelink+rmfile.getUploadPath()+"\\"+"th_"+rmfile.getUuid()+"_"+rmfile.getFileName());
				try {
					Files.delete(sumfpath);
				} catch (IOException e) {
					log.info("삭제하려는 썸네일이 없거나 실패하였습니다.");
				}
				
			}
		}
	}
	
	@GetMapping("/fileload")
	@ResponseBody
	public Map<String,Object> fileload(Long bno){
		Map<String, Object> response=new HashMap<String, Object>();
		List<attachfile> Filelist=new ArrayList<attachfile>();	
		Filelist=bservice.getfilelist(bno);
		
		if(Filelist.size()>0) {
		response.put("attachlist", Filelist);
		response.put("result","exist");
		}
		else {
		response.put("result", "none");	
		}
		return response;
	}
	
}
