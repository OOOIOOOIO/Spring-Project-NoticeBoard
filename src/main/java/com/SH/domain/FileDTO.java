package com.SH.domain;

import lombok.Data;

@Data
public class FileDTO {
	private String system_name; // 수정을 통해 올린 파일 이름
	private String orig_name; // 수정을 통해 올린 파일의 원래 이름
	private Long board_num;
	private String regi_date;
	// file을 db에 넣지는 않으니까 contents는 필요없다.
}
