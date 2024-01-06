package org.webservice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class filecontroller {
	
	@PostMapping("/upload")
	public void uploadfile() {
		
	}

}
