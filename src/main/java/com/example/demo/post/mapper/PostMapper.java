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
     
     Map<String, Object> findById(Long postUid);

     List<Map<String, Object>> findFilesByPostUid(Long postUid);
     
     Map<String, Object> findFileByUid(Long fileUid);
     
     void updatePost(Map<String, Object> param);
     void deleteFilesByPostUid(Long postUid);
     


}
