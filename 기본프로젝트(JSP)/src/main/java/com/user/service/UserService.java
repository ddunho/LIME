package com.user.service;

import java.util.Map;


public interface UserService{
	
	/**
	 * 회원가입
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */
	boolean createUser(Map<String, Object> userInfo);
	
	/**
	 * 중복 이메일 체크
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */
	boolean checkEmail(Map<String, Object> userEmail);

	/**
	 * 로그인 체크 
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */
	Map<String, Object> checkLogin(Map<String, Object> userInfo);
	
	/**
	 * 중복 닉네임 체크 
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */
	int checkUser(Map<String, Object> userInfo);
	
}
