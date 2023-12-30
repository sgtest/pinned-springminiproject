package org.webservice.service_1;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.webservice.domain.attachfile;
import org.webservice.domain.board;
import org.webservice.domain.boardsearch;
import org.webservice.mapper.boardmapper;
import org.webservice.mapper.filemapper;
import org.webservice.mapper.boardmapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class boardserviceImpl implements boardservice{

	@Setter(onMethod_ = @Autowired)
	private boardmapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private filemapper fmapper;
	
	@Override
	public boolean userban(String userid, String reason, int periods) {
		log.info("userid: "+userid+" ban, reason: "+reason+", period: "+periods);
		return mapper.banuser(userid, reason, periods)==1;
	}
	
	public boolean userbanrelease(String userid) {
		log.info("userban release: "+userid);
		return mapper.banuserrealease(userid)==1;
	}

	@Override
	public void board_register(String boardname,String boardsub) {
		log.info("create boardname: "+boardname+", boardsubject: "+boardsub);
		mapper.createboard(boardname, boardsub);
		
	}

	@Override
	public boolean board_aouth(String boardname, String userid) {
		String olduserid=mapper.select_boardaouth(boardname);
		if(1==mapper.deleteaouthboard(boardname, olduserid)) 
		{
		log.info("new "+boardname+" board manager"+userid);
		return (1==mapper.aouthboard(boardname, userid));
		}
		return false;
	}

	@Override
	public board readboard(Long bno) {
		
		return mapper.readboard(bno);
	}

	@Transactional
	@Override
	public void insertboard(board bd) {
		mapper.insertboard(bd);
		if(bd.getAttachlist()==null||bd.getAttachlist().size()<=0) {
			return;
		}
		for(attachfile file:bd.getAttachlist()) {
			file.setBno(bd.getBno());
			fmapper.insertfile(file);
		}
	}

	@Transactional
	@Override
	public boolean deleteboard(Long bno) {
		fmapper.deleteallfile(bno);
		return mapper.deleteboard(bno)==1;
	}

	@Transactional
	@Override
	public void updateboard(board bd) {
		fmapper.deleteallfile(bd.getBno());
		
		if(bd.getAttachlist()!=null||mapper.updateboard(bd)==1) {
			for(attachfile file:bd.getAttachlist()) {
				file.setBno(bd.getBno());
				fmapper.insertfile(file);
			}
		}
		
	}

	@Override
	public int getlisttotal(boardsearch search) {
		
		return mapper.gettotalcntboard(search);
	}

	@Override
	public List<board> getList(boardsearch search) {
		
		return mapper.getlistsearchboard(search);
	}

	@Override
	public List<attachfile> getfilelist(Long bno) {
		return fmapper.getlistfile(bno);
	}

	@Override
	public void deletefilelist(Long bno) {
		
		fmapper.deleteallfile(bno);
	}

	@Override
	public boolean board_delete(String boardname) {
		// TODO Auto-generated method stub
		if(mapper.deleteaouthboard(boardname, mapper.select_boardaouth(boardname))==1)
		return mapper.board_delete(boardname)==1;
		
		return false;
	}

}
