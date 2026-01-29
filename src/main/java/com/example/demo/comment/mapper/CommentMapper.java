package com.example.demo.comment.mapper;

import java.util.List;
import java.util.Map;

public interface CommentMapper {
    
    // 댓글 등록
    int insertComment(Map<String, Object> params);
    
    // 댓글 수정
    int updateComment(Map<String, Object> params);
    
    // 댓글 삭제 (논리적 삭제)
    int deleteComment(Map<String, Object> params);
    
    // 특정 게시글의 댓글 목록 조회
    List<Map<String, Object>> selectCommentList(Map<String, Object> params);
    
    // 특정 댓글 조회
    Map<String, Object> selectComment(Map<String, Object> params);
    
    // 대댓글 개수 조회
    int selectReplyCount(Map<String, Object> params);
    
    // 특정 게시글의 댓글 수 조회
    int selectCommentCountByPostUid(Long postUid);
    
    // 여러 게시글의 댓글 수 일괄 조회
    List<Map<String, Object>> selectCommentCountByPostUids(List<Long> postUids);
}
