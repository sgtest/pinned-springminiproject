package org.webservice.security;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.webservice.domain.member;
import org.webservice.mapper.membermapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class customUserDetailService implements UserDetailsService{

	@Setter(onMethod_= {@Autowired})
	private membermapper mmapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		member mem=mmapper.readmember(username);
		if(mem==null) {
			throw new UsernameNotFoundException("계정을 찾는것을 실패하였습니다.");
		}
		System.out.println("성공적으로 로드함");
		log.warn(username);
		return new userdetail(mem);
		
	}

}
