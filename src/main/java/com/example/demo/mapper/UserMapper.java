package com.example.demo.mapper;



import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.example.demo.domain.User;

@Mapper
public interface UserMapper {
    List<User> findAll();
    int insertUser(User user);
    int existEmail(String email);
    int existUserName(String username);
}