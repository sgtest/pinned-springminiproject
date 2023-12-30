package org.webservice.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class boardlist {
	private String boardname;
	private String boardsubject;
	private Date regdate;
	private String regid;
	private List<String> manageridlist;
}
