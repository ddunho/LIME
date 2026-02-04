package com.example.demo.comment.service;

import java.util.List;
import java.util.Map;

public interface CommentService {
    
	/**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 댓글 등록
	 */
    Map<String, Object> insertComment(Map<String, Object> params);
 
    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 댓글 수정
	 */
    boolean updateComment(Map<String, Object> params);
    

    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 댓글 목록 조회
	 */
    List<Map<String, Object>> getCommentList(Map<String, Object> params);
    


    
    /**
	 @author : 최재혁
	 @since : 2026-02-02
	 @detail : dto없이 댓글 삭제
	 */
    boolean deleteComment(Long commentUid);
}
