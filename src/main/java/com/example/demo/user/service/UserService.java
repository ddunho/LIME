package com.example.demo.user.service;

import com.example.demo.user.domain.User;
import com.example.demo.user.mapper.UserMapper;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import org.springframework.security.crypto.password.PasswordEncoder;

@Service
public class UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserMapper userMapper, PasswordEncoder passwordEncoder) {
		this.userMapper = userMapper;
		this.passwordEncoder = passwordEncoder;
	}
    
    
    //회원가입
    @Transactional
    public boolean register(User user) {
    	// 비밀번호 암호화
    	user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userMapper.insertUser(user) > 0 ? true : false;
    }
    
    //이메일 중복 검사
    public boolean existEmail(String email) {
        return userMapper.existEmail(email) > 0;
    }
    
  //아이디 중복 검사
    public boolean existUserName(String userName) {
        return userMapper.existUserName(userName) > 0;
    }
}
