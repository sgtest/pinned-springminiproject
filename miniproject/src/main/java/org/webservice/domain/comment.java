package org.webservice.domain;

import java.util.Date;

import lombok.Data;

@Data
public class comment {
	  private Long rno;
	  private Long bno;

	  private String reply;
	  private String replyer;
	  private Date regdate;
}
