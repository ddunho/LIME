package com.example.demo.post.controller;

import com.example.demo.post.service.PostService;
import com.example.demo.user.domain.User;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
            @RequestParam(value = "uploadFile", required = false) List<MultipartFile> uploadFiles,
            HttpSession session
    ) throws Exception {

        Map<String, Object> result = new HashMap<>();

        User loginUser = (User) session.getAttribute("LOGIN_USER");

        if (loginUser == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            result.put("redirectUrl", "/login");
            return result;
        }

        Long userUid = loginUser.getUserUid();

        postService.write(title, content, uploadFiles, userUid);

        result.put("success", true);
        result.put("message", "게시글이 작성되었습니다.");
        return result;
    }

}