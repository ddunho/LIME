package com.example.demo.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;

import com.example.demo.user.domain.User;
import com.example.demo.user.dto.EmailCheckRequest;
import com.example.demo.user.dto.UserNameCheckRequest;
import com.example.demo.user.service.UserService;





@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    
  //회원가입
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
    
    //이메일 중복 체크
    @PostMapping("/check-email")
    @ResponseBody
    public Boolean checkEmail(
            @RequestBody EmailCheckRequest emailCheckRequest) {

        boolean exists = userService.existEmail(emailCheckRequest.getEmail());

        return exists;
    }
    
    
  //아이디 중복 체크
    @PostMapping("/check-userName")
    @ResponseBody
    public Boolean checkUserName(
            @RequestBody UserNameCheckRequest userNameCheckRequest) {

        boolean exists = userService.existUserName(userNameCheckRequest.getUserName());

        return exists;
    }
}
