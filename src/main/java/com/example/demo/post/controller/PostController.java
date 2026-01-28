package com.example.demo.post.controller;

import com.example.demo.post.service.PostService;
import com.example.demo.user.domain.User;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
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
                fileList = Arrays.asList(uploadFiles);
            }

            Long postUid = postService.write(title, content, fileList, userUid);

            result.put("success", true);
            result.put("message", "게시글이 작성되었습니다.");
            result.put("postUid", postUid);

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "에러: " + e.getMessage());
        }

        return result;
    }
    
    @GetMapping("/detail")
    public String detail(
            @RequestParam Long postUid,
            Model model
    ) {

        Map<String, Object> post = postService.findById(postUid);
        List<Map<String, Object>> files = postService.findFilesByPostUid(postUid);

        model.addAttribute("post", post);
        model.addAttribute("files", files);

        return "detail";
    }
    
    
    @GetMapping("/download")
    public void downloadFile(
            @RequestParam Long fileUid,
            HttpServletResponse response
    ) throws Exception {
        
        Map<String, Object> fileInfo = postService.findFileByUid(fileUid);

        if (fileInfo == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        System.out.println("=== fileInfo keys ===");
        fileInfo.keySet().forEach(key -> {
            System.out.println(key + " = " + fileInfo.get(key));
        });
        
        String filePath = (String) fileInfo.get("FILEPATH");
        String storedName = (String) fileInfo.get("STOREDNAME");
        String originalName = (String) fileInfo.get("ORIGINALNAME");

        File file = new File(filePath, storedName);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + originalName + "\"");
        response.setContentLengthLong(file.length());

        // 파일 전송
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            
            byte[] buffer = new byte[8192];
            int bytesRead;
            
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            
            os.flush();
        }
    }
    



}