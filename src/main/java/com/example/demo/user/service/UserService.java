package com.example.demo.user.service;

import com.example.demo.user.domain.User;
import jakarta.servlet.http.HttpSession;

public interface UserService {

    boolean register(User user);

    boolean existEmail(String email);

    boolean existUserName(String userName);
    
    User findByEmail(String email);
    
    User login(String email, String password);
    
    void logout(HttpSession session);
}
