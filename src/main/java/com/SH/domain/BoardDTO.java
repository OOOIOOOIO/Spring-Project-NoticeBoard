package com.SH.domain;

import lombok.Data;

@Data
public class BoardDTO {
	private Long board_num;
	private String board_title;
	private String board_contents;
	private String board_writer;
	private String regi_date;
	private String update_date;
	private String user_id;
}
