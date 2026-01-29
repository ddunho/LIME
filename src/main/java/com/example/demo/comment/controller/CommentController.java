package com.example.demo.comment.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.comment.service.CommentService;
import com.example.demo.user.domain.User;  // User 클래스 import 추가


@Controller
@RequestMapping("/comment")
public class CommentController {
    
    @Autowired
    private CommentService commentService;
    
    //댓글 목록 조회
    @GetMapping("/list")
    @ResponseBody
    public Map<String, Object> getCommentList(@RequestParam Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            List<Map<String, Object>> commentList = commentService.getCommentList(params);
            result.put("success", true);
            result.put("data", commentList);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "댓글 목록 조회에 실패했습니다.");
        }
        
        return result;
    }
    
    //댓글 작성
    @PostMapping("/insert")
    @ResponseBody
    public Map<String, Object> insertComment(@RequestParam Map<String, Object> params, 
                                             HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 세션에서 User 객체로 가져오기
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            
            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            // User 객체에서 userUid 추출
            params.put("user_uid", loginUser.getUserUid());
            
            // 필수 파라미터 검증
            if (params.get("content") == null || params.get("content").toString().trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "댓글 내용을 입력해주세요.");
                return result;
            }
            
            if (params.get("post_uid") == null) {
                result.put("success", false);
                result.put("message", "게시글 정보가 없습니다.");
                return result;
            }
            
            result = commentService.insertComment(params);
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "댓글 등록 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    //댓글 수정
    @PostMapping("/update")
    @ResponseBody
    public Map<String, Object> updateComment(@RequestParam Map<String, Object> params, 
                                             HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 세션에서 User 객체로 가져오기
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            
            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            // User 객체에서 userUid 추출
            params.put("user_uid", loginUser.getUserUid());
            
            // 필수 파라미터 검증
            if (params.get("comment_uid") == null) {
                result.put("success", false);
                result.put("message", "댓글 정보가 없습니다.");
                return result;
            }
            
            if (params.get("content") == null || params.get("content").toString().trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "댓글 내용을 입력해주세요.");
                return result;
            }
            
            boolean updateResult = commentService.updateComment(params);
            
            if (updateResult) {
                result.put("success", true);
                result.put("message", "댓글이 수정되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "댓글 수정에 실패했습니다. 권한을 확인해주세요.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "댓글 수정 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 댓글 삭제
     */
    @PostMapping("/delete")
    @ResponseBody
    public Map<String, Object> deleteComment(@RequestParam Map<String, Object> params, 
                                             HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 세션에서 User 객체로 가져오기
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            
            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            // User 객체에서 userUid 추출
            params.put("user_uid", loginUser.getUserUid());
            
            // 필수 파라미터 검증
            if (params.get("comment_uid") == null) {
                result.put("success", false);
                result.put("message", "댓글 정보가 없습니다.");
                return result;
            }
            
            boolean deleteResult = commentService.deleteComment(params);
            
            if (deleteResult) {
                result.put("success", true);
                result.put("message", "댓글이 삭제되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "댓글 삭제에 실패했습니다. 권한을 확인해주세요.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "댓글 삭제 중 오류가 발생했습니다.");
        }
        
        return result;
    }
}