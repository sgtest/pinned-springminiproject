package org.webservice.service_1;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import org.webservice.domain.member;
import org.webservice.domain.member_info_etc;
import org.webservice.domain.memberfile;
import org.webservice.mapper.boardmapper;
import org.webservice.mapper.commentmapper;
import org.webservice.mapper.filemapper;
import org.webservice.mapper.membermapper;
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
	
	@Setter(onMethod_ = @Autowired)
	private commentmapper cmapper;
	
	@Setter(onMethod_ = @Autowired)
	private membermapper mmapper;
	
	private static final String mailregix="\\w+@\\w+\\.\\w+(\\.\\w+)?";
	private static final String birthdayregix="^\\d{4}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])$";
	
	
	@Override
	public member getuser(String userid) {
		member user=mmapper.readmember(userid);
		return user;
	}
	@Override
	public List<auth> getauth(String userid){
		List<auth> aulist=mmapper.readauth(userid);
		return aulist;
	}
	
	@Override
	public List<member> getmlist(){
		return mmapper.memberlist();
	}
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
	public boardlist getboardlistbyname(String boardname) {
		return mapper.getboardlistbyname(boardname);
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
	public List<board> getListbyboardname(String boardname){
		return mapper.getlistboardbybrdname(boardname);
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

	@Override
	public List<String> select_Boardaouthbyname(String boardname){
		return mapper.select_boardaouthbyname(boardname);
	}
	@Transactional
	@Override
	public boolean board_delete(String boardname) {
		// TODO Auto-generated method stub
		List<auth> athlist=new ArrayList<auth>();
		List<String> brdathlist=new ArrayList<String>();
		int result=0;
		brdathlist=mapper.select_boardaouthbyname(boardname);
		for(String s:brdathlist) {
			auth ath=new auth();
			ath.setAuth(boardname);
			ath.setUserid(s);
			athlist.add(ath);
		}
		
		for(int i=0;i<athlist.size();i++) {
		mapper.deleteaouthboard(athlist.get(i));
		}
		//관련 파일이나 댓글도 삭제해야 한다.
		deleteboardbynameall(boardname);
		log.info(boardname+" is delete");
		mapper.deleteboardbyname(boardname);
		return mapper.board_delete(boardname)==1;			
		
	}
	
	
	
	@Transactional
	@Override
	public void boardlist_update(boardlist brd, String boardsubject) {
		boardlist brdlist=brd;
		brdlist.setBoardsubject(boardsubject);
		mapper.updateboardlist(brdlist);
	}
	
	@Override
	public void deleteboardbynameall(String boardname) {
		List<board> brdlist=new ArrayList<board>();
		brdlist=mapper.getlistboardbybrdname(boardname);
		
		if(brdlist!=null) {
			for(board brd:brdlist) {
				fmapper.deleteallfile(brd.getBno());
				fmapper.deletememfilebybno(brd.getBno()); 
				cmapper.deletecommentbybno(brd.getBno());
			}
		}
		
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
	
	@Override
	public boolean updatememberetc(member_info_etc etc) {
		if(!etcvalidation(etc)) {
			return false;
		}
		return mmapper.updatememberetc(etc)>0;
	}
	@Override
	public boolean deletememberetc(String userid) {
		boolean result=false;
		if(mmapper.deletememberetc(userid)>0) {
			result=true;
		}
		
		return result;
	}
	@Override
	public boolean insertmemberetc(member_info_etc etc) {
		//이미 기존에 등록된 값이 있는지 확인해야
		if(mmapper.readmemberetc(etc.getUserid())!=null) {
			return false;
		}
		else if(!etcvalidation(etc)) {
			return false;
		}
		
		return mmapper.insertmemberetc(etc)>0;
		
	}
	@Override
	public member_info_etc getmemberetc(String userid) {
		return mmapper.readmemberetc(userid);
	}
	
	public boolean etcvalidation(member_info_etc etc) {
		Pattern emptn=Pattern.compile(mailregix);
		Pattern birptn=Pattern.compile(birthdayregix);
		Matcher emmach=emptn.matcher(etc.getMail());
		Matcher birmach=birptn.matcher(etc.getBirth_date());
		if(!emmach.matches()||!birmach.matches()) {
			return false;
		}
		else {
			return true;
		}
	}
}
