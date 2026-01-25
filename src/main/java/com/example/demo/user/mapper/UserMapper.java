package com.example.demo.user.mapper;



import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.example.demo.user.domain.User;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    List<User> findAll();
    int insertUser(User user);
    int existEmail(@Param("email") String email);
    int existUserName(@Param("username") String username);
    User findByEmail(@Param("email") String email);
}