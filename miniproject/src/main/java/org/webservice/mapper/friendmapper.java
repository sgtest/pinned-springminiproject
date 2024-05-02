package org.webservice.mapper;

import java.util.List;

import org.webservice.domain.friend;

public interface friendmapper {
	public List<friend> listfriend(String userid);
	public void insertfriend(friend frd);
	public void deletefriend(friend frd);
}
