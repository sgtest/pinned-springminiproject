package org.webservice.service_1;

import java.util.List;

import org.webservice.domain.boardsearch;
import org.webservice.domain.comment;
import org.webservice.domain.commentpage;

public class commentserviceImpl implements commentservice{

	@Override
	public int registercomment(comment cmt) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public comment getcomment(Long rno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updatecomment(comment cmt) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deletecomment(Long rno) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<comment> getcmtlist(boardsearch search, Long bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public commentpage getcmtlistpage(boardsearch search, Long bno) {
		// TODO Auto-generated method stub
		return null;
	}

}
