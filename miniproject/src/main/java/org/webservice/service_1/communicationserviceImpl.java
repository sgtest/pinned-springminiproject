package org.webservice.service_1;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.webservice.domain.friend;
import org.webservice.mapper.friendmapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class communicationserviceImpl implements communicationservice{


	@Setter(onMethod_ = @Autowired)
	private friendmapper frdmapper;
	
	@Override
	public List<friend> getlistfriend(String userid) {

		Authentication auth=SecurityContextHolder.getContext().getAuthentication();
		String exuserid=auth.getName();
		if(exuserid.compareTo(userid)!=0) {
			return null;
		}else {
			List<friend> frdlist=frdmapper.listfriend(userid);
			return frdlist;
		}
		
	}

	@Override
	public void insert_friend(String userid, String fuserid) {
		
		Authentication auth=SecurityContextHolder.getContext().getAuthentication();
		String exuserid=auth.getName();
		if(exuserid.compareTo(userid)!=0) {
			return;
		}
		else {
			friend frd=new friend();
			String frd_code="~Friend~"+userid+"~"+fuserid;
			frd.setFirend_code(frd_code);
			frd.setFuserid(fuserid);
			frd.setUserid(userid);
			frdmapper.insertfriend(frd);
		}
		
	}

	@Override
	public void delete_friend(String userid, String fuserid) {
		
		Authentication auth=SecurityContextHolder.getContext().getAuthentication();
		String exuserid=auth.getName();
		if(exuserid.compareTo(userid)!=0) {
			return;
		}
		else {
			friend frd=new friend();
			String frd_code="~Friend~"+userid+"~"+fuserid;
			frd.setFirend_code(frd_code);
			frd.setFuserid(fuserid);
			frd.setUserid(userid);
			frdmapper.deletefriend(frd);
			
		}
	}

	

}
