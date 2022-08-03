package com.SH.domain;

import lombok.Data;

@Data
public class ReplyDTO {
	private Long reply_num;
	private String reply_id;
	private String reply_contents;
	private String regi_date;
	private String update_date;
	private Long board_num;
}
