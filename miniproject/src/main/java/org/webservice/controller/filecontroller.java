package org.webservice.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.webservice.domain.attachfile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class filecontroller {
	
	
	//결국 attachlist로 값을 반환해야할듯
	@PostMapping("/uploadFile")
	@ResponseBody
	public Map<String,List<attachfile>> uploadfile(MultipartFile[] uploadFile, Model model) {
		
		Map<String, List<attachfile>> response=new HashMap<String, List<attachfile>>();
		
		List<attachfile> filelist=new ArrayList<attachfile>();
		String topuploadfolder="D:\\server\\temp";
		Date datevalue=new Date();
		String uploaddate=new SimpleDateFormat("yyyy-MM-dd-HH-mm").format(datevalue);
		String uploadfolder=uploaddate.replace("-",File.separator);
		
		File upload=new File(topuploadfolder,uploadfolder);
		for(MultipartFile multipartFile:uploadFile) {
			attachfile achfile=new attachfile();
			String fileorgname=multipartFile.getOriginalFilename();
			
			//File saveFile=new File();
			filelist.add(achfile);
			
		}
		response.put("attachfilelist", filelist);
		return response;
	}

	
}
