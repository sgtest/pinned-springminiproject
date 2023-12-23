package org.webservice.mapper;

import java.util.List;

import org.webservice.domain.attachfile;

public interface filemapper {
	
	public int insertfile(attachfile file);
	public int deletefile(String uuid);
	public int deleteallfile(Long bno);
	public List<attachfile> getlistfile(Long bno);
	
	//db상의 파일과 실제 소유한 파일을 비교해서 db 정보를 업데이트 한다
	public List<attachfile> getoldfile();
}
