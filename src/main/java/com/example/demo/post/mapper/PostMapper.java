package com.example.demo.post.mapper;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface PostMapper {

    List<Map<String, Object>> findAll();
}
