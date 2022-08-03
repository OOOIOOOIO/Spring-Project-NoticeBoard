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
		// 1페이지 10개 게시물을 처음 들어왔을 때 띄우겠다는 의미.
		// this는 밑에 있는 생성자를 뜻한다.
		this(1, 10);
	}
	
	public SearchCriteria(int pagenum, int amount) {
		this.pagenum = pagenum;
		this.amount = amount;
	}
	
	
	// 페이지 이동할 때 GET 뒤에 쿼리스트링 붙여주는 메서드, getter 형식
	// 현재 객체가 가지고 있는 pagenum, amount, .. 파라미터로 쿼리스트링을 만들어서 리턴하는 메소드
	// 사용하는 곳에서는 다 getter로 가져오기 때문에 이름을 이렇게 써야한다.	
	public String getListLink() {
		
		// URI를 만들 수 있는, 쿼리스트링을 만들어주는 아이.
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pagenum", this.pagenum)
				.queryParam("amount", this.amount)
				.queryParam("type", this.keyword)
				.queryParam("keyword", this.keyword);
		
		// b?pagenum=3&amount=10&.... 이걸(쿼리 스트링) 만드는 것이다.	
		return builder.toUriString(); // 빌더가 가지고 있는 설정대로 문자열 만들기
	}
	
	
	// 검색조건 넘겨주는 메서드, getter 형식
	public String[] getTypeArr() {
		
		return type == null ? new String[] {} : type.split("");
	}
	
	
}
