package com.example.demo.controller;

import com.example.demo.domain.User;
import com.example.demo.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import com.example.demo.dto.EmailCheckRequest;
import com.example.demo.dto.UserNameCheckRequest;





@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    //회원가입
    @PostMapping("/signup")
    public ResponseEntity<String> signup(@RequestBody User user) {
        userService.register(user);
        return ResponseEntity.ok("signup success");
    }
    
    //이메일 중복 체크
    @PostMapping("/check-email")
    public ResponseEntity<Boolean> checkEmail(
            @RequestBody EmailCheckRequest emailCheckRequest) {

        boolean exists = userService.existEmail(emailCheckRequest.getEmail());

        return ResponseEntity.ok(exists);
    }
    
    
  //아이디 중복 체크
    @PostMapping("/check-userName")
    public ResponseEntity<Boolean> checkUserName(
            @RequestBody UserNameCheckRequest userNameCheckRequest) {

        boolean exists = userService.existEmail(userNameCheckRequest.getUserName());

        return ResponseEntity.ok(exists);
    }
}
