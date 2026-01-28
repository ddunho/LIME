package com.example.demo.post.service;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface PostService {

	List<Map<String, Object>> findPage(int page);
	int getTotalPages();
	Long write(String title, String content, List<MultipartFile> uploadFiles, Long userUid) throws Exception;
	Map<String, Object> findById(Long postUid);
	List<Map<String, Object>> findFilesByPostUid(Long postUid);
	Map<String, Object> findFileByUid(Long fileUid);


}
