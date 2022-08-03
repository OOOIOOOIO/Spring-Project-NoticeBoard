package com.SH.domain;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage;
	private int endPage;
	private int realEndPage;
	private boolean prevBtn, nextBtn;
	private int total;
	private SearchCriteria scri;
	
	public PageDTO(int total, SearchCriteria scri){
		this.total = total;
		this.scri = scri;
		// Math.ceil : 올림
		//pagenum이 13일 경우		 2	= 	 2.0 ( 1.3 )  20
		this.endPage = (int)Math.ceil(scri.getPagenum() / 10.0) * 10;
		this.startPage = endPage - 9;
		//total이 173일 경우		18		18.0	173.0	17.3
		this.realEndPage = (int)Math.ceil(((total*1.0) / 10));
		
		if(endPage > realEndPage) {
			endPage = realEndPage;
		}
		
		this.prevBtn = this.startPage > 1;
		this.nextBtn = this.endPage < this.realEndPage;
		
		
	}
}
