package org.webservice.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class board {
	private Long bno;
	private String boardname;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;

	private int replyCnt;
	private List<attachfile> attachlist;
}
