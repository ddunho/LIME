package com.example.demo.post.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface PostMapper {

	List<Map<String, Object>> findPage(
		    @Param("start") int offset,
		    @Param("end") int limit
		);
	
	 int countAll();
	 
	 void insertPost(Map<String, Object> param);

     void insertPostFile(Map<String, Object> param);


}
