package org.webservice.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.webservice.domain.attachfile;
import org.webservice.domain.file;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class filecontroller {

	// 결국 attachlist로 값을 반환해야할듯
	@PostMapping(value="/uploadFile",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String,Object> uploadfile(MultipartFile[] uploadFile) {
		
		Map<String, Object> response=new HashMap<String, Object>();
	
		List<file> filelist=new ArrayList<file>();
		List<File> thumbnaillist=new ArrayList<>();
		String result="upload_fail";
		
		String topuploadfolder="D:\\server\\temp";
		Date datevalue=new Date();
		String uploaddate=new SimpleDateFormat("yyyy-MM-dd-HH-mm").format(datevalue);
		String uploadfolder=uploaddate.replace("-",File.separator);
		File upload=new File(topuploadfolder,uploadfolder);
		if(upload.exists()==false)
		{
			upload.mkdirs();
		}
		
		for(MultipartFile multipartFile:uploadFile) {
			log.info("this is for loop");
			file achfile=new file();
			String fileorgname=multipartFile.getOriginalFilename();
			fileorgname=fileorgname.substring(fileorgname.lastIndexOf("//")+1);
			log.info("fileorgname:   "+fileorgname);
			achfile.setFileName(fileorgname);
			
			UUID uuid=UUID.randomUUID();
			String filerename=uuid+"_"+fileorgname;
			achfile.setUuid(uuid.toString());
			
			File saveFile=new File(upload,filerename);
			log.info(saveFile.getAbsolutePath());
			achfile.setUploadPath(uploadfolder);
			try {
				if(!checkFile(saveFile)) {
					log.info("this file is reject");
					filelist=null;
					thumbnaillist=null;
					break;
				}
				result="upload_success";
				log.info("test"+saveFile.getAbsolutePath());
				multipartFile.transferTo(saveFile);
				
				if(checkImg(saveFile)) 
				{
					achfile.setImage(true);
					File thimgfile=new File(upload,"th_"+filerename);
					FileOutputStream thumboutfile=new FileOutputStream(thimgfile);
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumboutfile, 100, 100);
					
					log.info("thumnailfile info: "+thimgfile.getName()+",  "+thimgfile.getAbsolutePath());
					thumbnaillist.add(thimgfile);
					thumboutfile.close();
				}
				else 
				{
					achfile.setImage(false);
				}
				
				
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			log.info("file class info: "+achfile.getFileName()+",  "+achfile.getUploadPath()+",  "+achfile.getUuid());
			filelist.add(achfile);
			
		}
		log.info("for loop end");
		response.put("attachfilelist", filelist);
		response.put("thumbnaillist", thumbnaillist);
		response.put("result",result);
		
		return response;
	}
	
	public boolean checkFile(File achfile) {
		String filefullname = achfile.getName();
		int filesize=(int)achfile.length();
		boolean checksecurity=true;
		int lastposition = filefullname.lastIndexOf(".");
		String fileextend = filefullname.substring(lastposition + 1);
		String[] dangerextend= {"exe","js","zip","sh","alz","Ink"};
		
		for(String extend:dangerextend) {
			if(fileextend.contains(extend)) {
				checksecurity=false;
			}else if(filesize>524288000){
				checksecurity=false;
			}
		}
		
		return checksecurity;
	}
	public boolean checkImg(File achfile) {
		String filefullname = achfile.getName();
		boolean isImg = false;
		int lastposition = filefullname.lastIndexOf(".");
		String fileextend = filefullname.substring(lastposition + 1);
		String[] imgextend = { "jpg", "jpeg", "png", "gif", "bmp" };

		for (String extend : imgextend) {
			if (fileextend.contains(extend)) {
				isImg = true;
				break;
			}
		}
		return isImg;
	}

}
