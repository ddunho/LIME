package com.example.demo.post.controller;

import com.example.demo.post.service.PostService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;

@Controller
public class PostController {

    private final PostService postService;

    public PostController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping("/")
    public String main(Model model) {
        List<Map<String, Object>> postList = postService.getPostList();
        model.addAttribute("postList", postList);
        return "tables";
    }
}