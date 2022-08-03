package com.SH.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.SH.domain.BoardDTO;
import com.SH.domain.SearchCriteria;
import com.SH.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements BoardService{
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	
	@Override
	public List<BoardDTO> getList(SearchCriteria scri) {
		List<BoardDTO> list = mapper.getList(scri);
		log.info(list);
		return list;
	}

	@Override
	public void regist(BoardDTO board) {
		mapper.insert_with_bonum(board);
	}

	@Override
	public BoardDTO read(Long board_num) {
		
		return mapper.read(board_num);
	}

	@Override
	public int update(BoardDTO board) {
		int result = mapper.update(board);
		
		return result;
	}

	@Override
	public int delete(Long board_num) {
		int result = mapper.delete(board_num);
		return result;
	}

	@Override
	public int getTotal(SearchCriteria scri) {
		int result = mapper.getTotal(scri);
		return result;
	}

}
