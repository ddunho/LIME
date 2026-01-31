package com.example.demo.comment.service;

import java.util.List;
import java.util.Map;

public interface CommentService {
    
    // 댓글 등록
    Map<String, Object> insertComment(Map<String, Object> params);
    
    // 댓글 수정
    boolean updateComment(Map<String, Object> params);
    
    // 댓글 목록 조회
    List<Map<String, Object>> getCommentList(Map<String, Object> params);
    
    // 댓글 상세 조회
    Map<String, Object> getComment(Map<String, Object> params);
    
    boolean deleteComment(Long commentUid);
}
