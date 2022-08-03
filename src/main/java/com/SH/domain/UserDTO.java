package com.SH.domain;

import lombok.Data;

@Data
public class UserDTO {
	private String user_name;
	private String user_id;
	private String user_pw;
	private String user_email;
	private String user_phone;
	private String zipcode;
	private String addr;
	private String addr_detail;
	private String addr_ete;
}
