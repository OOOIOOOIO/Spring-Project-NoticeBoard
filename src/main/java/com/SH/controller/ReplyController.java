package com.SH.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.SH.domain.ReplyDTO;
import com.SH.domain.ReplyPageDTO;
import com.SH.domain.SearchCriteria;
import com.SH.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/reply/*")
public class ReplyController {
	@Setter(onMethod_ = @Autowired)
	private ReplyService service;

	
	@PostMapping(value="/regist", consumes="application/json")
	public ResponseEntity<String> regist(@RequestBody ReplyDTO reply) {
		boolean check = service.regist(reply) == 1;
		
		return check ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@GetMapping(value="/pages/{board_num}/{pagenum}",
			produces={
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
			}
	)
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("board_num") Long board_num, @PathVariable("pagenum") int pagenum) {
		SearchCriteria scri = new SearchCriteria(pagenum, 5);
		
		return new ResponseEntity<ReplyPageDTO>(service.getList(scri, board_num), HttpStatus.OK);
	}
	
   	
	@DeleteMapping(value="/{reply_num}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("reply_num") Long reply_num) {
		boolean check = service.remove(reply_num) == 1;
		// ResponseEntity는 result로  앞에 있는 success와 상태코드가 날아간다!
		return (check ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR));
		
	}
	
	
	
	@RequestMapping(value="/{reply_num}",
			method={RequestMethod.PUT, RequestMethod.PATCH},
			consumes="application/json",
			produces=MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody ReplyDTO reply) {
		if(service.update(reply) == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
}









 
