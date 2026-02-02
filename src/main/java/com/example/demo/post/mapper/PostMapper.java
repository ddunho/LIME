package com.example.demo.post.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface PostMapper {
	
	// 페이징으로 게시글 조회
    List<Map<String, Object>> findPage( // List : 여러 행 Map<String, Object> : 한 행
        @Param("start") int offset,
        @Param("end") int limit
    );
    
    // 총 페이지 수 조회
    int countAll();
    
    // 게시글 저장
    void insertPost(Map<String, Object> param);
    
    // 파일 저장
    void insertPostFile(Map<String, Object> param);
    
    // 아이디로 게시글 정보 조회
    Map<String, Object> findById(Long postUid);
    
    // 게시글 ID로 파일 정보 조회
    List<Map<String, Object>> findFilesByPostUid(Long postUid);
    
    // 파일 ID로 파일 정보 조회
    Map<String, Object> findFileByUid(Long fileUid);
    
    // 게시글 수정
    void updatePost(Map<String, Object> param);
    
    // 게시글 소프트 삭제
    int updatePostDeleteYn(Long postUid);
    
    // 게시글의 모든 댓글 소프트 삭제
    int updateCommentDeleteYnByPostUid(Long postUid);
    
    // 게시글 첨부파일 조회
    List<Map<String, Object>> selectFilesByPostUid(Long postUid);
    
    // 게시글 첨부파일 DB 삭제 (하드)
    int deleteFilesByPostUid(Long postUid);
}