package com.SH.service;

import java.util.List;

import com.SH.domain.BoardDTO;
import com.SH.domain.SearchCriteria;

public interface BoardService {
	List<BoardDTO> getList(SearchCriteria scri); // 게시물 하나하나를 다 가져와서 쭈루룩 보여줘야하기 때문에 리스트에 담는다.
	
	void regist(BoardDTO board);
	
	BoardDTO read(Long board_num);
	
	int update(BoardDTO board); // 삽입은 1 리턴, 실패하면 0 리턴

	int delete(Long board_num); // 삭제는 1 리턴, 실패하면 0 리턴
	
	int getTotal(SearchCriteria scri); // 게시물의 총 개수
}
