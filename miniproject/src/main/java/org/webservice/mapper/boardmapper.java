package org.webservice.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.webservice.domain.attachfile;
import org.webservice.domain.auth;
import org.webservice.domain.banuser;
import org.webservice.domain.board;
import org.webservice.domain.boardlist;
import org.webservice.domain.boardsearch;

public interface boardmapper {
	public int banusers(banuser user);
	public int banuserrealease(String userid);
	public int banselect(String userid);
	
	public List<boardlist> selectboardlistset();
	public List<String> selectboardlist();
	public void createboard(boardlist brdlist);
	public int deleteaouthboard(auth ath);
	public int aouthboard(auth ath);
	public String select_boardaouth(String boardname);
	public int board_delete(String boardname);
	
	public board readboard(Long bno);
	public int deleteboard(Long bno);
	public int deleteboardbyname(String boardname);
	public int updateboard(board bd);
	public void insertboard(board bd);
	public List<board> getlistboard();
	public List<board> getlistsearchboard(boardsearch search);
	public List<board> getlistboardbyid(String userid);
	public int getcntbyid(String userid);
	
	public void updatecmtcnt(@Param("bno") Long bno, @Param("amount") int amount);
	public int gettotalcntboard(boardsearch search);
	public List<attachfile> findfilebybno(Long bno);
}
