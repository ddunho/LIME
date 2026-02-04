package com.user.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.exception.UserRegistrationException;
import com.user.repository.UserMapper;
import com.user.service.UserService;

import lombok.RequiredArgsConstructor;

@Service
public class UserServiceimpl implements UserService {
	
	private final PasswordEncoder encoder;
    private final UserMapper userMapper;
    
    public UserServiceimpl(PasswordEncoder encoder, UserMapper userMapper) {
        this.encoder = encoder;
        this.userMapper = userMapper;
    }
    

	@Override
	public boolean createUser(Map<String, Object> userInfo) {

		try {
			String rawPw = String.valueOf(userInfo.get("userPw"));
			String encodedPw = encoder.encode(rawPw);
		
			userInfo.put("userPw", encodedPw);
			return userMapper.insertUser(userInfo) > 0 ? true : false;
			
		} catch (Exception e) {
			throw new UserRegistrationException("회원가입 중 오류가 발생했습니다.", e);
		}
	}

	@Override
	public boolean checkEmail(Map<String, Object> userEmail) {
		
		try {
			return userMapper.checkEmail(userEmail) > 0 ? false : true; 
		} catch (Exception e) {
			throw new UserRegistrationException("중복 이메일 체크 중 오류가 발생했습니다.", e);
		}
	}

	@Override
	public Map<String, Object> checkLogin(Map<String, Object> userInfo) {
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			
			resultMap = userMapper.checkLogin(userInfo);
			
			String reqPw = String.valueOf(userInfo.get("userPw"));		// 입력한 비밀번호
			String resPw = String.valueOf(resultMap.get("USER_PW"));	// DB에 저장되어있는 비밀번호(암호화)

			// 비밀번호 비교
			if(encoder.matches(reqPw, resPw)) {
				resultMap.put("result", "Y");
			} else { 
				resultMap.put("result", "N");
			}
			
			return resultMap;
			
		} catch (Exception e) {
			throw new UserRegistrationException("로그인 체크 중 오류가 발생했습니다.", e);
		}
	}

	@Override
	public int checkUser(Map<String, Object> userInfo) {
		return userMapper.checkUser(userInfo);
	}
	
}
