package com.example.demo.service;

import com.example.demo.domain.User;
import com.example.demo.mapper.UserMapper;
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
    public void register(User user) {
    	user.setPassword(
                passwordEncoder.encode(user.getPassword())
            );
        userMapper.insertUser(user);
    }
    
    //이메일 중복 검사
    public boolean existEmail(String email) {
        return userMapper.existEmail(email) > 0;
    }
    
  //아이디 중복 검사
    public boolean existUserName(String userName) {
        return userMapper.existEmail(userName) > 0;
    }
}
