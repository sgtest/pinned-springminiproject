package org.webservice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class filecontroller {
	
	@PostMapping("/upload")
	public void uploadfile(MultipartFile[] uploadFile, Model model) {
		for(MultipartFile multipartFile:uploadFile) {
			log.info(multipartFile.getOriginalFilename());
			log.info(multipartFile.getSize());
			log.info(multipartFile.getName());
		}
	}

	
}
