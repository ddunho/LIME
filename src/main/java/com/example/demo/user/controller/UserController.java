package com.example.demo.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;

import com.example.demo.user.domain.User;
import com.example.demo.user.dto.EmailCheckRequest;
import com.example.demo.user.dto.LoginRequest;
import com.example.demo.user.dto.UserNameCheckRequest;
import com.example.demo.user.service.UserService;

import jakarta.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;






@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService,
	            PasswordEncoder passwordEncoder) {
	this.userService = userService;
	this.passwordEncoder = passwordEncoder;
	}

    
  // 회원가입
    @PostMapping("/signup")
    @ResponseBody
    public Map<String, Object> signup(@RequestBody User user) {
    	Map<String, Object> resultMap = new HashMap<>();
    	boolean result = userService.register(user);
    	
    	if(result) {
    		resultMap.put("msg", "회원가입에 성공했습니다.");
    	} else {
    		resultMap.put("msg", "회원가입에 실패했습니다. 관리자에게 문의바랍니다.");
    	}
    	resultMap.put("result", result);
        return resultMap;
    }
    
    // 이메일 중복 체크
    @PostMapping("/check-email")
    @ResponseBody
    public Boolean checkEmail(
            @RequestBody EmailCheckRequest emailCheckRequest) {

        boolean exists = userService.existEmail(emailCheckRequest.getEmail());

        return exists;
    }
    
    
    // 아이디 중복 체크
    @PostMapping("/check-userName")
    @ResponseBody
    public Boolean checkUserName(
            @RequestBody UserNameCheckRequest userNameCheckRequest) {

        boolean exists = userService.existUserName(userNameCheckRequest.getUserName());

        return exists;
    }
    
    // 로그인
    @PostMapping("/login")
    @ResponseBody
    public boolean login(
            @RequestBody LoginRequest request,
            HttpSession session) {

        User loginUser = userService.login(
            request.getEmail(),
            request.getPassword()
        );

        if (loginUser != null) {
            session.setAttribute("LOGIN_USER", loginUser);
            return true;
        }
        
        return false;
    }
    
    // 로그아웃
    @GetMapping("/logout")
    @ResponseBody
    public void logout(HttpSession session) {
        userService.logout(session);
    }


}
