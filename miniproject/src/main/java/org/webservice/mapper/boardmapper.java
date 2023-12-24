package org.webservice.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.webservice.domain.attachfile;
import org.webservice.domain.board;
import org.webservice.domain.boardsearch;

public interface boardmapper {
	public int banuser(String userid,String reason,int periods);
	public int banuserrealease(String userid);
	public int banselect(String userid);
	
	public int createboard(String boardname, String boardsubject);
	public int deleteaouthboard(String boardname,String userid);
	public int aouthboard(String boardname, String userid);
	public int board_delete(String boardname);
	
	public board readboard(Long bno);
	public int deleteboard(Long bno);
	public int updateboard(board bd);
	public void insertboard(board bd);
	public List<board> getlistboard();
	public List<board> getlistsearchboard(boardsearch search);
	
	
	public void updatecmtcnt(@Param("bno") Long bno, @Param("amount") int amount);
	public int gettotalcntboard(boardsearch search);
	public List<attachfile> findfilebybno(Long bno);
}
