package org.webservice.service_1;

import java.util.List;

import org.webservice.domain.boardsearch;
import org.webservice.domain.comment;
import org.webservice.domain.commentpage;

public interface commentservice {
	
	public int registercomment(comment cmt);
	public comment getcomment(Long rno);
	public int updatecomment(comment cmt);
	public int deletecomment(Long rno);
	
	public List<comment> getcmtlist(boardsearch search, Long bno);
	public commentpage getcmtlistpage(boardsearch search, Long bno);
}
