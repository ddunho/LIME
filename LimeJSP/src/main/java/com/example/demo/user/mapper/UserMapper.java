package com.example.demo.user.mapper;



import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.example.demo.user.domain.User;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
	 
    // 회원가입
    int insertUser(User user);
    
    // Email 중복 여부
    int existEmail(@Param("email") String email);
    
    // 아이디 중복 여부
    int existUserName(@Param("username") String username);
    
    
    // 로그인 시 Email로 회원 정보 조회
    User findByEmail(@Param("email") String email);
    
    /** User 정보 조회
    List<User> findAll();
    */
}