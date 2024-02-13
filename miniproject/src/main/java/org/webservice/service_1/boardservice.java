package org.webservice.service_1;

import java.util.List;

import org.webservice.domain.attachfile;
import org.webservice.domain.board;
import org.webservice.domain.boardlist;
import org.webservice.domain.boardsearch;
import org.webservice.domain.memberfile;

public interface boardservice {
	
	
	//차단 및 차단 해제
	public boolean userban(String userid, String reason,int periods);
	public boolean userbanrelease(String userid);
	
	//게시판 생성 및 삭제
	public void board_register(String boardname,String reguserid, String boardsub);
	public boolean board_delete(String boardname);
	public List<String> select_boardlist();
	
	//관리자 양도
	public boolean board_aouth(String boardname,String userid);
	
	//게시판의 게시글 관련 서비스
	public board readBoard(Long bno);
	public void insertboard(board bd);
	public boolean deleteboard(Long bno);
	public boolean updateboard(board bd);
	public int getlisttotal(boardsearch search);
	public int getlisttotalbyid(String userid);
	public List<board> getList(boardsearch search);
	public List<board> getListbyid(String userid);
	public List<attachfile> getfilelist(Long bno);
	public void deletefilelist(Long bno);
	public void deletefileone(String uuid);
	
	//회원별 파일 관련 서비스
	/* 파일 임시 등록시 pro_member_file에 insert를 해야한다.(파일 컨트롤러 상의 uploadfile 메소드에 포함), 
	 * 임시 등록된 파일 삭제시 pro_member_file에서 해당 파일을 delete 해야한다.(파일 컨트롤러 상의 serverdeletefile 메소드에 포함),
	 * 마이 페이지에서 등록했던 파일을 pro_member_file에서 select 해서 보여줘야한다(보안 컨트롤러 상세서 myPage 메소드에 포함),
	 * 마이 페이지에서도 등록했던 파일을 삭제 가능하도록 함
	 */
	public void insertMemfile(memberfile memberfile);
	public boolean deleteMemfile(String pro_mem_file_code);
	public void deleteMemfileall(String userid);
	public memberfile getMemberfilebycode(String pro_mem_file_code);
	public List<memberfile> getMemberfilebyuserid(String userid);
	public List<memberfile> getMemberfilebybno(Long bno);
}
