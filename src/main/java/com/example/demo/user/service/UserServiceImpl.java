package com.example.demo.user.service;

import com.example.demo.user.domain.User;
import com.example.demo.user.mapper.UserMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.demo.user.service.UserService;



@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserMapper userMapper,
                           PasswordEncoder passwordEncoder) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public boolean register(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userMapper.insertUser(user) > 0;
    }

    @Override
    public boolean existEmail(String email) {
        return userMapper.existEmail(email) > 0;
    }

    @Override
    public boolean existUserName(String userName) {
        return userMapper.existUserName(userName) > 0;
    }
    
    @Override
    public User findByEmail(String email) {
        return userMapper.findByEmail(email);
    }
}
