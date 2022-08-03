package com.SH.service;

import com.SH.domain.UserDTO;

public interface UserService {
	int checkId(String user_id);
	
	int checkEmail(String user_email);
	
	int checkPhone(String user_phone);
	
	int join(UserDTO user);
	
	int login(UserDTO user);

	
}
