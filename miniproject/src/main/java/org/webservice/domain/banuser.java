package org.webservice.domain;

import java.util.Date;

import lombok.Data;
@Data
public class banuser {
	private int bannum;
	private String userid;
	private String boardname;
	private String banreason;
	private Date startdate;
	private Date enddate;
	
}
