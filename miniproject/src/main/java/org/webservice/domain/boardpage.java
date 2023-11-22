package org.webservice.domain;

public class boardpage {
	  private String boardname;
	  private int startPage;
	  private int endPage;
	  private boolean prev, next;

	  private int total;
	  private boardsearch srh;
	  
	  public boardpage(boardsearch srh,int total) {
		  this.srh=srh;
		  this.total=total;
		  
		  
	  }
}
