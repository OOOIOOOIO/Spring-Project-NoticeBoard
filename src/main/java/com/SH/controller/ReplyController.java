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

	
	// 댓글 등록하기
	// ResponseEntity<데이터타입>(데이터, 상태코드)  : 서버의 상태코드, 응답 메세지, 데이터 등을 담을 수 있는 타입
	// consumes : 이 메소드가 호출될 때 소비할 데이터의 타입(넘겨지는 body의 데이터 타입)
	@PostMapping(value="/regist", consumes="application/json")
	public ResponseEntity<String> regist(@RequestBody ReplyDTO reply) {
		boolean check = service.regist(reply) == 1;
		
		return check ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	// 댓글 목록 띄워주기
	// REST 방식!!
	// /pages/something/something2 : /뒤에 something이 있다면 여기로 들어온다.
	// @PathVariable("something") : something에 있는 것을 저기에 넣어줘~ 라는 뜻
	// produce : 이 메소드의 호출된 결과로 생산해낼 데이터 타입(돌려주는 body의 데이터 타입) 지정, return해주는 데이터. json데이터를 반환해준다.
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
	
   	
	// 댓글 삭제하기
	// REST 방식 이용시 삭제 요청을 보낼 때 사용하는 맵핑!
	// produces : return을 할 때 그냥 평범한 text 타입을 넘길 것이다~
	@DeleteMapping(value="/{reply_num}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("reply_num") Long reply_num) {
		boolean check = service.remove(reply_num) == 1;
		// ResponseEntity는 result로  앞에 있는 success와 상태코드가 날아간다!
		return (check ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR));
		
	}
	
	
	
	// 댓글 수정하기
	// PUT or PATCH
	// PUT : 모든 데이터들을 다 전달해야 한다. 자원의 전체 수정, 자원 내의 모든 필드를 전달해야하고 전달되지 않은 필드는 모두 초기화 처리된다.
	// PATCH : 자원의 일부 수정, 수정할 필드만 전송
	// 여기서 regi_date, update_date를 넘겨주지 않고 DB에서 채워주기 때문에
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









 
