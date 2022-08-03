package com.SH.controller;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		{"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Log4j
@WebAppConfiguration // servlet-context를 이용하기 위해 달아주는 어노테이션. 웹사이트처럼 돌아가게 해줌
public class BoardControllerTest {

	
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext wac;
	
	// 가짜 mvc
	// 마치 브라우저에서 사용하는 것처럼 만들어서 Controller를 실행해 볼 수 있다.
	private MockMvc mvc;
	
	// org.junit.Before
	// 선언된 메소드를 테스트 전에 매번 한번씩 실행한다.
	@Before
	public void setup() {
		mvc = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
	@Ignore
//	@Test
	public void listTest()throws Exception {
		// mvc.perform(요청) : 해당 요청대로 mockmvc가 수행
		//  MockMvcRequestBuilders.get("/board/list") -> GET방식으로 /board/list 요청한다는 뜻
		// .andReturn() -> 반환된 결과(응답, 뷰, 모델, .. 포함)
		// .getModelAndView() --> 응답에서 모델과 뷰를 포함하고 있는 타입의 객체 받기
		ModelAndView mav = mvc.perform(MockMvcRequestBuilders.get("/board/list")).andReturn().getModelAndView();

		log.info("응답 결과 : " + mav.getModelMap()); // 응답 결과
		log.info("경로 이름 : " + mav.getViewName()); // 경로 이름
	}
	
	@Ignore
//	@Test
	public void getTest()throws Exception{

		ModelAndView mav = mvc.perform(MockMvcRequestBuilders.get("/board/get")
				.param("pagenum", "2")
				.param("amount", "10")
				.param("boardnum", "1")
				
		).andReturn().getModelAndView();
		
		log.info("응답 결과 : " + mav.getModelMap());
		log.info("경로 이름 : " + mav.getViewName());
	}
	
//	@Ignore
	@Test
	public void modifyTest()throws Exception{
		MvcResult result = mvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("board_num", "1")
				.param("board_title", "수정된 게시글 제목")
				.param("board_contents", "수정된 게시글 내용")
				.param("board_writer", "a")
				.param("user_id", "a")
				.param("pagenum", "3")
				.param("amount", "10")
				
		).andReturn();
		
		ModelAndView mav = result.getModelAndView();
		
		// ModelMap은 Flash 영역은 나오지 않는다.
		log.info("응답 결과 : " + mav.getModelMap());
		log.info("응답 결과(Flash) : " +result.getFlashMap());
		log.info("경로 이름 : " + mav.getViewName());
	}
	
}









