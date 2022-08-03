package com.SH.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor // 저절로 생성자가 만들어진다.
public class ReplyPageDTO {
	private int replyCnt;
	private List<ReplyDTO> list;
}
