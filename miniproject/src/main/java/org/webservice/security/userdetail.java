
package org.webservice.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.webservice.domain.auth;
import org.webservice.domain.member;

public class userdetail implements UserDetails{

	private member mem;
	private String ID;
	private String PASSWORD;
	private String NAME;
	private String AUTHORITY;
	private boolean ENABLED;
	
	public userdetail(member m) {
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
