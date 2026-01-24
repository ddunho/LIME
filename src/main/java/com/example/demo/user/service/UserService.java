package com.example.demo.user.service;

import com.example.demo.user.domain.User;

public interface UserService {

    boolean register(User user);

    boolean existEmail(String email);

    boolean existUserName(String userName);
}
