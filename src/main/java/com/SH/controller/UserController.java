package com.SH.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.SH.domain.UserDTO;
import com.SH.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value = "/user/*")
@Log4j
public class UserController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService service;
	
	// 회원가입 메인 페이지
	@RequestMapping(value="/join", method= {RequestMethod.GET, RequestMethod.POST})
	public String join() {
		
		return "/join/join_main";
	}
	
	
	// ajax
	@PostMapping("/checkId")
	@ResponseBody
	public int checkId(@RequestBody String user_id) {
		
		// 유효성 검사 하는 곳
		// 유효성 검사를 js에서 다 할 수 있구나 굳이 java단까지 안가고
		// db관련만 java에 들리면 되겠구나, 중복검사 같은거
		// 파라미터로 dto 타입 받는거 모르겟따아아아아
		int result = 0;
		result = service.checkId(user_id);
		log.info("==============id controller : " +result + user_id);
		return result;
	}
	
	// ajax
	@PostMapping("/checkEmail")
	@ResponseBody
	public int checkEamil(@RequestBody String user_email) {
		
		int result = service.checkEmail(user_email);
		log.info("==============email controller : " +result + user_email);
		return result;
		
	}
	
	// ajax
	@PostMapping("/checkPhone")
	@ResponseBody
	public int checkPhone(@RequestBody String user_phone) {
		
		int result = service.checkPhone(user_phone);
		log.info("==============phone controller : " +result + user_phone);
		return result;
		
	}
	
	//ajax
	@PostMapping("/doJoin")
	@ResponseBody
	public int doJoin(@RequestBody UserDTO user) {
		
		int result = service.join(user);
		
		return result;
	}
	
	//=======================================================
	
	
	@RequestMapping(value="/login", method= {RequestMethod.GET, RequestMethod.POST})
	public String login() {
		
		return "/login/login_main";
	}
	
	// Ajax
	@PostMapping("/checkLogin")
	@ResponseBody
	public int checkLogin(@RequestBody UserDTO user, HttpServletRequest req, HttpSession session) {
		
		int result = service.login(user);
		
		// login 성공하였으면 session 생성해주기
		// jsp 에서는 el문으로 ${sessionId} 이렇게 사용하면 되고
		// java에서는 HttpServletRequest import 해서  getSession()으로 가져오면 된다.
		if(result > 0) {
			session.setAttribute("user_id", user.getUser_id());
		}
		
		return result;
	}
	
	
	@RequestMapping(value="/findPw")
	public String findPw() {
		
		return "/login/findPw";
	}
	
	
	@GetMapping(value = "/logout") // a태그로 로그아웃 만들자 
	public String logout(HttpServletRequest session) {
		
		// 세션 삭제해주기
		session.removeAttribute("user_id");
		
		return "/login/login_main";
	}

}
