package com.user.repository;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
	/**
	 * 회원가입 관련 DB 처리
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */
	int insertUser(Map<String, Object> userInfo);
	
	/**
	 * 중복 이메일 체크
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */
	int checkEmail(Map<String, Object> userEmail);

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
