package org.webservice.service_1;

import java.util.List;

import org.webservice.domain.attachfile;
import org.webservice.domain.board;
import org.webservice.domain.boardsearch;

public class boardserviceImpl implements boardservice{

	@Override
	public boolean userban() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void board_register(String boardname) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void board_aouth(String boardname, String userid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public board readboard(Long bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertboard(board bd) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean deleteboard(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void updateboard(board bd) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int getlisttotal(boardsearch search) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<board> getList(boardsearch search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<attachfile> getfilelist(Long bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deletefilelist(Long bno) {
		// TODO Auto-generated method stub
		
	}

}
