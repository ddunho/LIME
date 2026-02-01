package com.example.demo.post.service;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface PostService {
	
	/**
	 @author : 최재혁
	 @since : 2026-02-01
	 @detail : dto없이 페이징처리된 게시글 조회
	 */
	List<Map<String, Object>> findPage(int page);
	int getTotalPages();
	Long write(String title, String content, List<MultipartFile> uploadFiles, Long userUid) throws Exception;
	Map<String, Object> findById(Long postUid);
	List<Map<String, Object>> findFilesByPostUid(Long postUid);
	Map<String, Object> findFileByUid(Long fileUid);
    void modify(Map<String, Object> param, List<MultipartFile> files);
    Map<String, Object> modifyPost(Long postUid, String title, String content, MultipartFile[] uploadFile);
    Map<String, Object> getPostForModify(Long postUid);
    void deletePost(Long postUid);


}
