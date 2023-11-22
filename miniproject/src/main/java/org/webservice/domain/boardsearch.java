package org.webservice.domain;

public class boardsearch {
	private int pageNum;
	private int amount;

	private String type;
	private String keyword;
	
	public boardsearch() {
		this.pageNum=1;
		this.amount=10;
	}
	public boardsearch(int pagenum,int amount) {
		this.pageNum=pagenum;
		this.amount=amount;
	}
}
