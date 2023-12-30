package org.webservice.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class commentpage {
	private int replyCnt;
	private List<comment> list;
}
