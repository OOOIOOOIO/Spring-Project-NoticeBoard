package com.SH.service;

import java.util.List;


import com.SH.domain.FileDTO;

public interface FileService {
	List<FileDTO> getFile(Long board_num);
	int upload(FileDTO file);
	int update(FileDTO file);
	int delete(String system_name);
	
	
}
