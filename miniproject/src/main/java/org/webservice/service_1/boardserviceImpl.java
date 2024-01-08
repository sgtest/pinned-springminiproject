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
	public void board_register(String boardname,String reguserid, String boardsub) {
		log.info("create boardname: "+boardname+", boardsubject: "+boardsub);
		mapper.createboard(boardname, reguserid, boardsub);
		mapper.aouthboard(reguserid,boardname);
		
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
		
		log.info(bno+"_board read");
		return mapper.readboard(bno);
	}

	@Transactional
	@Override
	public void insertboard(board bd) {
		mapper.insertboard(bd);
		if(bd.getAttachlist()==null||bd.getAttachlist().size()<=0) {
			log.info(bd.getBoardname()+"_"+bd.getBno()+"_"+bd.getTitle()+"_"+bd.getContent()+"_"+bd.getWriter());
			return;
		}
		for(attachfile file:bd.getAttachlist()) {
			file.setBno(bd.getBno());
			fmapper.insertfile(file);
		}
		log.info(bd.getBoardname()+"_"+bd.getBno()+"_"+bd.getTitle()+"_"+bd.getContent()+"_"+bd.getWriter());
	}

	@Transactional
	@Override
	public boolean deleteboard(Long bno) {
		fmapper.deleteallfile(bno);
		if(mapper.deleteboard(bno)==1)
			log.info(mapper.readboard(bno).getBoardname()+"_"+bno+"_board delete");
		return mapper.deleteboard(bno)==1;
	}

	@Transactional
	@Override
	public boolean updateboard(board bd) {
		fmapper.deleteallfile(bd.getBno());
		boolean result=mapper.updateboard(bd)==1;
		if(bd.getAttachlist()!=null||result) {
			for(attachfile file:bd.getAttachlist()) {
				file.setBno(bd.getBno());
				fmapper.insertfile(file);
			}
			log.info(bd.getBoardname()+"_"+bd.getBno()+"_"+"board update");
			return result;
		}
		log.info(bd.getBoardname()+"_"+bd.getBno()+"_"+"board update");
		return result;
	}

	@Override
	public int getlisttotal(boardsearch search) {
		
		log.info(search.getKeyword()+" has "+mapper.gettotalcntboard(search)+" number ");
		return mapper.gettotalcntboard(search);
	}

	@Override
	public List<board> getList(boardsearch search) {
		
		log.info(search.getKeyword()+" has "+mapper.getlistsearchboard(search).size()+" number");
		return mapper.getlistsearchboard(search);
	}

	@Override
	public List<attachfile> getfilelist(Long bno) {
		board bd=mapper.readboard(bno);
		log.info(bd.getBoardname()+"_"+bno+"_board is "+fmapper.getlistfile(bno).size()+" file is existed");
		return fmapper.getlistfile(bno);
	}

	@Override
	public void deletefilelist(Long bno) {
		board bd=mapper.readboard(bno);
		log.info(bd.getBoardname()+"_"+bno+"_board is "+fmapper.getlistfile(bno).size()+" file is deleted");
		fmapper.deleteallfile(bno);
	}

	@Transactional
	@Override
	public boolean board_delete(String boardname) {
		// TODO Auto-generated method stub
		if(mapper.deleteaouthboard(boardname, mapper.select_boardaouth(boardname))==1)
			if(mapper.board_delete(boardname)==1)
			{	
				log.info(boardname+" is delete");
				return mapper.board_delete(boardname)==1;
			}
		return false;
	}

}
