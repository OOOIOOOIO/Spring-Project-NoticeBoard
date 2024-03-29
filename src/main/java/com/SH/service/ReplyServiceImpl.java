package com.SH.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.SH.domain.ReplyDTO; 	
import com.SH.domain.ReplyPageDTO;
import com.SH.domain.SearchCriteria;
import com.SH.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int regist(ReplyDTO reply) {
		
		return mapper.insert(reply);
	}



	@Override
	public ReplyPageDTO getList(SearchCriteria scri, Long board_num) {
		
		return new ReplyPageDTO(mapper.getTotal(board_num), mapper.getList(scri, board_num));
	}



	@Override
	public int remove(Long reply_num) {
		
		return mapper.remove(reply_num);
	}



	@Override
	public int update(ReplyDTO reply) {
		
		return mapper.update(reply);
	}

}
