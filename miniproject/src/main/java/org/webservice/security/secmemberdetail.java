package org.webservice.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.webservice.domain.auth;
import org.webservice.domain.member;

public class secmemberdetail implements UserDetails{

	private final member mem;
	
	public secmemberdetail(member m) {
		this.mem=m;
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		ArrayList<GrantedAuthority> auths=new ArrayList<>();
		
		for(auth au:mem.getAuthlist()) {
			String role=au.getAuth();
			auths.add(new SimpleGrantedAuthority(role));
		}
		return auths;
	}

	@Override
	public String getPassword() {
		return mem.getUserpw();
	}

	@Override
	public String getUsername() {
		return mem.getUserid();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return false;
	}

	@Override
	public boolean isEnabled() {
		return false;
	}

}
