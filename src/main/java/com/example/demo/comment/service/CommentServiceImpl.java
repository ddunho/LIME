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
    
   // 댓글 등록
    @Override
    @Transactional
    public Map<String, Object> insertComment(Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // depth 계산
            Object parentCommentUid = params.get("parent_comment_uid");
            int depth = 0;
            
            if (parentCommentUid != null && !parentCommentUid.toString().isEmpty()) {
                // 부모 댓글 조회
                Map<String, Object> parentParams = new HashMap<>();
                parentParams.put("comment_uid", parentCommentUid);
                Map<String, Object> parentComment = commentMapper.selectComment(parentParams);
                
                if (parentComment != null) {
                    depth = Integer.parseInt(parentComment.get("DEPTH").toString()) + 1;
                } else {
                    result.put("success", false);
                    result.put("message", "존재하지 않는 댓글입니다.");
                    return result;
                }
            } else {
                params.put("parent_comment_uid", null);
            }
            
            params.put("depth", depth);
            
            // 댓글 등록
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
    
    // 댓글 수정
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
    
    
    // 댓글 삭제
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
