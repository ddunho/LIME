package com.example.demo.post.controller;

import com.example.demo.post.service.PostService;
import com.example.demo.user.domain.User;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class PostController {

    private final PostService postService;

    public PostController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping("/")
    public String list(
            @RequestParam(defaultValue = "1") int page,
            Model model
    ) {
        int totalPages = postService.getTotalPages();

        model.addAttribute("posts", postService.findPage(page));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "tables";
    }

    @PostMapping("/write")
    @ResponseBody
    public Map<String, Object> write(
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFiles,
            HttpSession session
    ) {
        
        System.out.println("========== Controller 시작 ==========");
        
        Map<String, Object> result = new HashMap<>();

        try {
            User loginUser = (User) session.getAttribute("LOGIN_USER");

            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            Long userUid = loginUser.getUserUid();

            List<MultipartFile> fileList = null;
            if (uploadFiles != null && uploadFiles.length > 0) {
                fileList = new ArrayList<>(Arrays.asList(uploadFiles));
            }
            
            System.out.println("=== 파일 업로드 디버깅 ===");
            System.out.println("uploadFiles is null? " + (uploadFiles == null));
            if (uploadFiles != null) {
                System.out.println("uploadFiles length: " + uploadFiles.length);
            }
            
            System.out.println(">>> Service 호출 직전");
            postService.write(title, content, fileList, userUid);
            System.out.println(">>> Service 호출 완료");

            result.put("success", true);
            result.put("message", "게시글이 작성되었습니다.");
            
        } catch (Exception e) {
            System.out.println("========== 에러 발생 ==========");
            System.out.println("에러 메시지: " + e.getMessage());
            e.printStackTrace();
            
            result.put("success", false);
            result.put("message", "에러: " + e.getMessage());
        }
        
        System.out.println("========== Controller 끝 ==========");
        return result;
    }

}