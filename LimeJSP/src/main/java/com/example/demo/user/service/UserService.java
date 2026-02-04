package com.example.demo.user.service;

import com.example.demo.user.domain.User;
import jakarta.servlet.http.HttpSession;

public interface UserService {
	
	/**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : UserDomain으로 회원가입
	 */
    boolean register(User user);
    
    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : EmailCheckRequest dto로 이메일 중복 여부 확인
	 */
    boolean existEmail(String email);
    
    
    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : UserNameCheckRequest dto로 아이디 중복 여부 확인
	 */
    boolean existUserName(String userName);
    
    
    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : LoginRequest dto로 로그인
	 */
    User login(String email, String password);
    
    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : session 초기화로 로그아웃
	 */
    void logout(HttpSession session);
    
    
    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : Email로 유저 정보 찾기(현재는 사용 x)
	User findByEmail(String email);
   */
}
