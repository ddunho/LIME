package com.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.user.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {

	@Autowired
	UserService userService;

	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 로그인 페이지 이동
	 */
	@RequestMapping("/login")
	public String login() {
		return "user/login";
	}

	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 회원가입 페이지 이동
	 */
	@RequestMapping("/membership")
	public String membership() {
		return "user/membership";
	}

	/**
	 * 회원가입
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 회원가입
	 */
	@ResponseBody
	@PostMapping("/createUser")
	public Map<String, Object> createUser(@RequestParam Map<String, Object> userInfo, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
		
		System.out.println("데이터확인 ---> "+ userInfo);

		boolean result = userService.createUser(userInfo);
		resultMap.put("result", result);

		return resultMap;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 중복이메일 체크
	 */
	@ResponseBody
	@PostMapping("/checkEmail")
	public Map<String, Object> checkEmail(@RequestParam Map<String, Object> userEmail, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
		
		System.out.println("데이터확인 ---> "+ userEmail);

		boolean result = userService.checkEmail(userEmail);
		resultMap.put("result", result);

		return resultMap;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 로그인
	 */
	@ResponseBody
	@PostMapping("/login")
	public Map<String, Object> login(@RequestParam Map<String, Object> userInfo, HttpSession session, HttpServletRequest request) {
		Map<String, Object> resultMap  = new HashMap<String, Object>();
		Map<String, Object> resultUser = new HashMap<String, Object>();

		System.out.println("데이터확인(login)---> "+ userInfo);
		
		resultUser = userService.checkLogin(userInfo);
		
		if("Y".equals(resultUser.get("result"))) {
			Map<String, Object> userSession = new HashMap<>();
			
			userSession.put("userNo", resultUser.get("USER_NO"));
			userSession.put("userNm", resultUser.get("USER_NM"));
			
			session.setAttribute("user", userSession);
			
			resultMap.put("result", true);
		} else {
			resultMap.put("result", false);
		}
		
		return resultMap;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 로그아웃
	 */
	@ResponseBody
	@PostMapping("/logoutCheck")
	public Map<String, Object> logout(HttpSession session, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		session.removeAttribute("user");
		
		System.out.println("로그아웃 테스트 @@@@@@@@@@@@");
		
		if(session.getAttribute("user") == null) {
			resultMap.put("result", true);
		} else {
			resultMap.put("result", false);
		}

		return resultMap;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 중복 닉네임 체크
	 */
	@ResponseBody
	@PostMapping("/checkUser")
	public Map<String, Object> checkUser(@RequestParam Map<String, Object> userInfo, HttpSession session, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = userService.checkUser(userInfo);
		
		System.out.println("오긴함?? userInfo -_> " + userInfo);
		
		if(result > 0) {
			resultMap.put("result", false);
		} else {
			resultMap.put("result", true);
		}
		
		resultMap.put("target", userInfo.get("target"));
		
		return resultMap;
	}
	
	
}
