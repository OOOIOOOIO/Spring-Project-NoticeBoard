package com.SH.service;

import java.util.List;

import com.SH.domain.ReplyDTO;
import com.SH.domain.ReplyPageDTO;
import com.SH.domain.SearchCriteria;

public interface ReplyService {
	int regist(ReplyDTO reply);
	
	ReplyPageDTO getList(SearchCriteria scri, Long board_num);

	int remove(Long reply_num);
	
	int update(ReplyDTO reply);
}
