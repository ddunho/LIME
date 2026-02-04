package com.example.demo.post.service;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface PostService {
	
	/**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 페이징처리된 게시글 조회
	 */
	List<Map<String, Object>> findPage(int page);
	
	/**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 총 페이지 수 조회
	 */
	int getTotalPages();
	
	/**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 게시글 저장
	 */
	Long write(String title, String content, List<MultipartFile> uploadFiles, Long userUid) throws Exception;
	
	/**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 ID로 유저 정보 조회
	 */
	Map<String, Object> findById(Long postUid);
	
	/**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 게시글 ID로 파일 정보 조회
	 */
	List<Map<String, Object>> findFilesByPostUid(Long postUid);
	
	/**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 파일 ID로 파일 정보 조회
	 */
	Map<String, Object> findFileByUid(Long fileUid);
	
	/**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 수정을 위한 게시글 정보 찾기
	 */
   Map<String, Object> getPostForModify(Long postUid);
    
    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 게시글 수정
	 */
    Map<String, Object> modifyPost(Long postUid, String title, String content, MultipartFile[] uploadFile);
    
   
    
    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 게시글 삭제
	 */
    void deletePost(Long postUid);


}
