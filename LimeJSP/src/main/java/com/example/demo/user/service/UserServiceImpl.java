package com.example.demo.user.service;

import com.example.demo.user.domain.User;
import com.example.demo.user.mapper.UserMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.demo.user.service.UserService;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;
import jakarta.servlet.http.HttpSession;





@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserMapper userMapper,
                           PasswordEncoder passwordEncoder) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
    }
    
    // 회원가입
    @Override
    @Transactional
    public boolean register(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userMapper.insertUser(user) > 0;
    }

    // email로 이메일 중복여부 확인
    @Override
    public boolean existEmail(String email) {
        return userMapper.existEmail(email) > 0;
    }
    
    // userName으로 아이디 중복여부 확인
    @Override
    public boolean existUserName(String userName) {
        return userMapper.existUserName(userName) > 0;
    }
    
    
    // 로그인
    @Override
    public User login(String email, String password) {
        User user = userMapper.findByEmail(email);
        
        if (user == null) {
            return null;
        }
        
        if (!passwordEncoder.matches(password, user.getPassword())) {
            return null;
        }
        
        user.setPassword(null);
        return user;
    }
    
    // 로그아웃
    @Override
    public void logout(HttpSession session) {
        session.invalidate();
    }
    
    /**이메일로 유저정보 찾기
	    @Override
	    public User findByEmail(String email) {
	        return userMapper.findByEmail(email);
	    }
    */
}
