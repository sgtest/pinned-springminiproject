package org.webservice.service_1;

import java.util.List;

import org.webservice.domain.attachfile;
import org.webservice.domain.board;
import org.webservice.domain.boardsearch;

public interface boardservice {
	
	
	//차단
	public boolean userban(String userid, String reason);
	
	//게시판 생성
	public void board_register(String boardname, String boardsub);
	
	//관리자 양도
	public void board_aouth(String boardname,String userid);
	
	//게시판의 게시글 관련 서비스
	public board readboard(Long bno);
	public void insertboard(board bd);
	public boolean deleteboard(Long bno);
	public void updateboard(board bd);
	public int getlisttotal(boardsearch search);
	public List<board> getList(boardsearch search);
	public List<attachfile> getfilelist(Long bno);
	public void deletefilelist(Long bno);
}
