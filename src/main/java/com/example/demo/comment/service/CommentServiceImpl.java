package com.example.demo.comment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.comment.mapper.CommentMapper;

@Service
public class CommentServiceImpl implements CommentService {
    
    @Autowired
    private CommentMapper commentMapper;
    
    /**
     * 댓글 등록 (depth는 LEVEL로 자동 계산)
     */
    @Override
    @Transactional
    public Map<String, Object> insertComment(Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Object parentCommentUid = params.get("parent_comment_uid");
            
            // 답글인 경우 부모 댓글 존재 확인
            if (parentCommentUid != null && !parentCommentUid.toString().isEmpty()) {
                Map<String, Object> parentParams = new HashMap<>();
                parentParams.put("comment_uid", parentCommentUid);
                Map<String, Object> parentComment = commentMapper.selectComment(parentParams);
                
                if (parentComment == null) {
                    result.put("success", false);
                    result.put("message", "존재하지 않는 댓글입니다.");
                    return result;
                }
            } else {
                // 원댓글인 경우
                params.put("parent_comment_uid", null);
            }
            
            // 댓글 등록 (depth는 쿼리의 LEVEL로 자동 계산됨)
            int insertResult = commentMapper.insertComment(params);
            
            if (insertResult > 0) {
                result.put("success", true);
                result.put("message", "댓글이 등록되었습니다.");
                result.put("comment_uid", params.get("comment_uid"));
            } else {
                result.put("success", false);
                result.put("message", "댓글 등록에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 댓글 수정
     */
    @Override
    @Transactional
    public boolean updateComment(Map<String, Object> params) {
        try {
            int result = commentMapper.updateComment(params);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 댓글 삭제 (소프트 삭제)
     */
    @Override
    @Transactional
    public boolean deleteComment(Long commentUid) {
        int result = commentMapper.updateCommentDeleteYn(commentUid);
        return result > 0;
    }
    
    /**
     * 댓글 목록 조회
     */
    @Override
    public List<Map<String, Object>> getCommentList(Map<String, Object> params) {
        return commentMapper.selectCommentList(params);
    }
    
    /**
     * 댓글 상세 조회
     */
    @Override
    public Map<String, Object> getComment(Map<String, Object> params) {
        return commentMapper.selectComment(params);
    }
}