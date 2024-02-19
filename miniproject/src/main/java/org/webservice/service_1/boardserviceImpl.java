package org.webservice.service_1;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.webservice.domain.attachfile;
import org.webservice.domain.auth;
import org.webservice.domain.banuser;
import org.webservice.domain.board;
import org.webservice.domain.boardlist;
import org.webservice.domain.boardsearch;
import org.webservice.domain.memberfile;
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
		
		LocalDate currentDate = LocalDate.now();
		LocalDate endDate=currentDate.plusDays(periods);
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd");
		String startformattedDate=currentDate.format(formatter);
		String endformattedDate=endDate.format(formatter);
		
		banuser ban=new banuser();
		ban.setUserid(userid);
		ban.setBanreason(reason);
		ban.setStartdate(startformattedDate);
		ban.setEnddate(endformattedDate);
		
		return mapper.banusers(ban)==1;
	}
	
	public boolean userbanrelease(String userid) {
		log.info("userban release: "+userid);
		return mapper.banuserrealease(userid)==1;
	}

	@Override
	public void board_register(String boardname,String reguserid, String boardsub) {
		log.info("create boardname: "+boardname+", boardsubject: "+boardsub);
		boardlist brdlist=new boardlist();
		List<String> mgrlist=new ArrayList<String>(); 
		auth ath=new auth();
		
		mgrlist.add(reguserid);
		
		brdlist.setBoardname(boardname);
		brdlist.setBoardsubject(boardsub);
		brdlist.setReguserid(reguserid);
		brdlist.setManageridlist(mgrlist);
		mapper.createboard(brdlist);
		
		ath.setUserid(reguserid);
		ath.setAuth(boardname);
		mapper.aouthboard(ath);
		
	}

	@Override
	public boolean board_aouth(String boardname, String userid) {
		String olduserid=mapper.select_boardaouth(boardname);
		auth ath=new auth();
		ath.setUserid(olduserid);
		ath.setAuth(boardname);
		if(1==mapper.deleteaouthboard(ath)) 
		{
			log.info("new "+boardname+" board manager"+userid);
			ath.setUserid(userid);
			return (1==mapper.aouthboard(ath));
		}
		return false;
	}

	@Override
	public board readBoard(Long bno) {
		
		log.info(bno+"_board read");
		return mapper.readboard(bno);
	}

	@Transactional
	@Override
	public void insertboard(board bd) {
		mapper.insertboard(bd);
		Authentication auth=SecurityContextHolder.getContext().getAuthentication();
		String userid=auth.getName();
		String pro_mem_file_code;
		if(bd.getAttachlist()==null||bd.getAttachlist().size()<=0) {
			log.info(bd.getBoardname()+"_"+bd.getBno()+"_"+bd.getTitle()+"_"+bd.getContent()+"_"+bd.getWriter());
			return;
		}
		
		for(attachfile file:bd.getAttachlist()) {
			file.setBno(bd.getBno());
			if(file.isImage()) {
				 pro_mem_file_code=userid+"_"+file.getUploadPath()+"_"+file.getUuid()+"_"+file.getFileName()+"_"+"1";
			}else {
				 pro_mem_file_code=userid+"_"+file.getUploadPath()+"_"+file.getUuid()+"_"+file.getFileName()+"_"+"0";
			}
			memberfile mfile=fmapper.getmemberfilebycode(pro_mem_file_code);
			mfile.setBno(bd.getBno());
			fmapper.updatememfile(mfile);			
			fmapper.insertfile(file);
		}
		log.info(bd.getBoardname()+"_"+bd.getBno()+"_"+bd.getTitle()+"_"+bd.getContent()+"_"+bd.getWriter());
	}

	@Transactional
	@Override
	public boolean deleteboard(Long bno) {
		fmapper.deleteallfile(bno);
		fmapper.deletememfilebybno(bno);
		return mapper.deleteboard(bno)==1;
	}

	@Transactional
	@Override
	public boolean updateboard(board bd) {
		fmapper.deleteallfile(bd.getBno());
		Authentication auth=SecurityContextHolder.getContext().getAuthentication();
		String userid=auth.getName();
		String pro_mem_file_code;
		
		boolean result=mapper.updateboard(bd)==1;
		if(bd.getAttachlist()==null&& result) {
			log.info(bd.getBoardname()+"_"+bd.getBno()+"_"+"board update");
			return result;
		}
		for(attachfile file:bd.getAttachlist()) {
			file.setBno(bd.getBno());
			if(file.isImage()) {
				 pro_mem_file_code=userid+"_"+file.getUploadPath()+"_"+file.getUuid()+"_"+file.getFileName()+"_"+"1";
			}else {
				 pro_mem_file_code=userid+"_"+file.getUploadPath()+"_"+file.getUuid()+"_"+file.getFileName()+"_"+"0";
			}
			memberfile mfile=fmapper.getmemberfilebycode(pro_mem_file_code);
			mfile.setBno(bd.getBno());
			fmapper.updatememfile(mfile);
			fmapper.insertfile(file);
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
	public int getlisttotalbyid(String userid) {
		return mapper.getcntbyid(userid);
	}
	
	@Override
	public List<board> getList(boardsearch search) {
		
		log.info(search.getKeyword()+" has "+mapper.getlistsearchboard(search).size()+" number");
		return mapper.getlistsearchboard(search);
	}

	@Override
	public List<board> getListbyid(String userid) {
		return mapper.getlistboardbyid(userid);
	}
	
	@Override
	public List<attachfile> getfilelist(Long bno) {
		board bd=mapper.readboard(bno);
		//log.info(bd.getBoardname()+"_"+bno+"_board is "+fmapper.getlistfile(bno).size()+" file is existed");
		return fmapper.getlistfile(bno);
	}
	@Transactional
	@Override
	public void deletefilelist(Long bno) {
		board bd=mapper.readboard(bno);
		//log.info(bd.getBoardname()+"_"+bno+"_board is "+fmapper.getlistfile(bno).size()+" file is deleted");
		fmapper.deleteallfile(bno);
	}

	@Transactional
	@Override
	public boolean board_delete(String boardname) {
		// TODO Auto-generated method stub
		auth ath=new auth();
		ath.setAuth(boardname);
		ath.setUserid(mapper.select_boardaouth(boardname));
		if(mapper.deleteaouthboard(ath)==1) {
			if(mapper.board_delete(boardname)==1)
			{	
				log.info(boardname+" is delete");
				return mapper.deleteboardbyname(boardname)==1;
			}
		}
		return false;
	}
	
	@Override
	public List<boardlist> select_boardlistset(){
		List<boardlist> brdset=mapper.selectboardlistset();
		return brdset;
	}
	@Override
	public List<String> select_boardlist() {
		List<String> boardlist=mapper.selectboardlist();
		return boardlist;
	}

	@Transactional
	@Override
	public void insertMemfile(memberfile memberfile) {
		fmapper.insertmemfile(memberfile);
	}
	@Transactional
	@Override
	public boolean deleteMemfile(String pro_mem_file_code) {
		return fmapper.deletememfile(pro_mem_file_code)==1;
	}
	@Transactional
	@Override
	public void deleteMemfileall(String userid) {
		fmapper.deletememfileall(userid);
	}
	@Transactional
	@Override
	public List<memberfile> getMemberfilebyuserid(String userid) {
		return fmapper.getmemberfilelist(userid);
	}
	@Transactional
	@Override
	public List<memberfile> getMemberfilebybno(Long bno) {
		return fmapper.getmemberfilebybno(bno);
	}
	@Transactional
	@Override
	public memberfile getMemberfilebycode(String pro_mem_file_code) {
		return fmapper.getmemberfilebycode(pro_mem_file_code);
	}

	@Override
	public void deletefileone(String uuid) {
		fmapper.deletefile(uuid);
		
	}

}
