package org.webservice.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class boardsearch {
	private int pagenum;
	private int amount;

	private String boardname;
	private String type;
	private String keyword;
	
	//처음 접속시 실행
	public boardsearch() {
		this.pagenum=1;
		this.amount=10;
	}
	
	
	public boardsearch(String boardname,int pagenum,int amount) {
		this.boardname=boardname;
		this.pagenum=pagenum;
		this.amount=amount;
	}
	
	//이동시 실행
	public boardsearch(String boardname, int pagenum, int amount, String type, String keyword) {
		this.boardname=boardname;
		this.pagenum=pagenum;
		this.amount=amount;
		this.type=type;
		this.keyword=keyword;
	}
	public String[] getTypeArr() {

		return type == null ? new String[] {} : type.split("");
	}
	
	public String getListLink() {

		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("boardname", this.getBoardname())
				.queryParam("pageNum", this.pagenum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());

		return builder.toUriString();

	}
}
