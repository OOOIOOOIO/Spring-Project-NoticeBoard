package com.SH.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class SearchCriteria {
	private int pagenum;
	private int amount;
	private String type;
	private String keyword;
	
	public SearchCriteria() {
		this(1, 10);
	}
	
	public SearchCriteria(int pagenum, int amount) {
		this.pagenum = pagenum;
		this.amount = amount;
	}
	
	
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pagenum", this.pagenum)
				.queryParam("amount", this.amount)
				.queryParam("type", this.keyword)
				.queryParam("keyword", this.keyword);
		
		return builder.toUriString();
	}
	
	
	public String[] getTypeArr() {
		
		return type == null ? new String[] {} : type.split("");
	}
	
	
}
