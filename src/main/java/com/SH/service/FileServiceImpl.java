package com.SH.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.SH.domain.FileDTO;

@Service
public class FileServiceImpl implements FileService {

	@Override
	public List<FileDTO> getFile(Long board_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int upload(FileDTO file) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(FileDTO file) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String system_name) {
		// TODO Auto-generated method stub
		return 0;
	}

}
