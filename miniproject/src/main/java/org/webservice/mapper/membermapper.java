package org.webservice.mapper;

import java.util.List;

import org.webservice.domain.auth;
import org.webservice.domain.member;

public interface membermapper {
	public member readmember(String userid);
	public int insertmember(member member);
	public int updatemember(member member);
	public int deletemember(member member);
	public List<auth> readauth(String userid);
	public List<member> memberlist();
}
