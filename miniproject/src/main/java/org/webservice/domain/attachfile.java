package org.webservice.domain;

import java.util.Date;

import lombok.Data;

@Data
public class attachfile {
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
	private Long bno;
}
