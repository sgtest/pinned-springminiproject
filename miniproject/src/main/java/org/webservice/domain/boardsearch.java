package org.webservice.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class boardsearch {
	private int pageNum;
	private int amount;

	private String type;
	private String keyword;
	private String boardname;
	
	//처음 접속시 실행
	public boardsearch() {
		this.boardname="main";
		this.pageNum=1;
		this.amount=10;
	}
	
	//처음 갤러리 접속시 실행
	public boardsearch(String brdname) {
		this.boardname=brdname;
		this.pageNum=1;
		this.amount=10;
	}
	
	public boardsearch(int pagenum,int amount) {
		this.boardname="mainboard";
		this.pageNum=pagenum;
		this.amount=amount;
	}
	
	//이동시 실행
	public boardsearch(String brdname, int pagenum,int amount) {
		this.boardname=brdname;
		this.pageNum=pagenum;
		this.amount=amount;
	}
	public String[] getTypeArr() {

		return type == null ? new String[] {} : type.split("");
	}
	
	public String getListLink() {

		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("boardname", this.boardname)
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());

		return builder.toUriString();

	}
}
