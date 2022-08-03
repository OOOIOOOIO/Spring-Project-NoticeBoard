package com.SH.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.SH.domain.UserDTO;
import com.SH.mapper.UserMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserServiceImpl implements UserService{
	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;
	
	@Override
	public int checkId(String user_id) {
		int result = mapper.checkId(user_id);
		log.info("====================ServiceImpl=================" + result);
		return result;
	}

	@Override
	public int checkEmail(String user_email) {
		int result = mapper.checkEmail(user_email);		
		
		return result;
	}

	@Override
	public int checkPhone(String user_phone) {
		int result = mapper.checkPhone(user_phone);
		
		return result;
	}

	@Override
	public int join(UserDTO user) {
		int result = mapper.join(user);
		
		return result;
	}
	
	@Override
	public int login(UserDTO user) {
		int result = mapper.login(user);
		
		return result;
	}

}
