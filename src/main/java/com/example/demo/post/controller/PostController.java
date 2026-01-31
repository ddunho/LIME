package com.example.demo.post.controller;

import com.example.demo.post.service.PostService;
import com.example.demo.comment.mapper.CommentMapper;
import com.example.demo.user.domain.User;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class PostController {

    private final PostService postService;
    
    @Autowired
    private CommentMapper commentMapper;
    
    // 파일 개수 제한 상수
    private static final int MAX_FILE_COUNT = 5;

    public PostController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping("/")
    public String list(
            @RequestParam(defaultValue = "1") int page,
            Model model
    ) {
        // 게시글 목록 조회
        List<Map<String, Object>> posts = postService.findPage(page);
        
        // 게시글이 있을 때만 댓글 수 조회
        if (posts != null && !posts.isEmpty()) {
            try {
                // 게시글 UID 목록 추출
                List<Long> postUids = posts.stream()
                    .map(post -> {
                        Object postUidObj = post.get("POSTUID");
                        if (postUidObj instanceof Number) {
                            return ((Number) postUidObj).longValue();
                        }
                        return Long.parseLong(postUidObj.toString());
                    })
                    .collect(Collectors.toList());
                
                // 댓글 수 일괄 조회
                List<Map<String, Object>> commentCounts = 
                    commentMapper.selectCommentCountByPostUids(postUids);
                
                // Map으로 변환 (postUid -> commentCount)
                Map<Long, Integer> commentCountMap = commentCounts.stream()
                    .collect(Collectors.toMap(
                        m -> {
                            Object postUidObj = m.get("POST_UID");
                            if (postUidObj instanceof Number) {
                                return ((Number) postUidObj).longValue();
                            }
                            return Long.parseLong(postUidObj.toString());
                        },
                        m -> {
                            Object countObj = m.get("COMMENT_COUNT");
                            if (countObj instanceof Number) {
                                return ((Number) countObj).intValue();
                            }
                            return Integer.parseInt(countObj.toString());
                        }
                    ));
                
                // 각 게시글에 댓글 수 추가
                posts.forEach(post -> {
                    Object postUidObj = post.get("POSTUID");
                    Long postUid;
                    if (postUidObj instanceof Number) {
                        postUid = ((Number) postUidObj).longValue();
                    } else {
                        postUid = Long.parseLong(postUidObj.toString());
                    }
                    post.put("COMMENT_COUNT", commentCountMap.getOrDefault(postUid, 0));
                });
                
            } catch (Exception e) {
                // 댓글 수 조회 실패 시 0으로 설정
                e.printStackTrace();
                posts.forEach(post -> post.put("COMMENT_COUNT", 0));
            }
        }
        
        int totalPages = postService.getTotalPages();

        model.addAttribute("posts", posts);
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

            // 파일 개수 제한 검증
            if (uploadFiles != null && uploadFiles.length > MAX_FILE_COUNT) {
                result.put("success", false);
                result.put("message", "파일은 최대 " + MAX_FILE_COUNT + "개까지만 첨부할 수 있습니다.");
                return result;
            }

            Long userUid = loginUser.getUserUid();

            List<MultipartFile> fileList = null;
            if (uploadFiles != null && uploadFiles.length > 0) {
                // 빈 파일 필터링
                fileList = Arrays.stream(uploadFiles)
                    .filter(file -> file != null && 
                            !file.isEmpty() && 
                            file.getOriginalFilename() != null && 
                            !file.getOriginalFilename().trim().isEmpty())
                    .collect(Collectors.toList());
                
                // 필터링 후 개수 재검증
                if (fileList.size() > MAX_FILE_COUNT) {
                    result.put("success", false);
                    result.put("message", "파일은 최대 " + MAX_FILE_COUNT + "개까지만 첨부할 수 있습니다.");
                    return result;
                }
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
    
    /**
     * 게시글 삭제 (인증 추가)
     */
    @PostMapping("/post/delete")
    @ResponseBody
    public Map<String, Object> deletePost(
            @RequestParam Long postUid,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        try {
            // 1. 로그인 체크
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            // 2. 게시글 조회
            Map<String, Object> post = postService.findById(postUid);
            if (post == null) {
                result.put("success", false);
                result.put("message", "존재하지 않는 게시글입니다.");
                return result;
            }

            // 3. 작성자 본인 확인
            String postUsername = (String) post.get("USERNAME");
            if (postUsername == null) {
                postUsername = (String) post.get("username");
            }
            
            if (!loginUser.getUsername().equals(postUsername)) {
                result.put("success", false);
                result.put("message", "본인이 작성한 게시글만 삭제할 수 있습니다.");
                return result;
            }

            // 4. 삭제 처리
            postService.deletePost(postUid);
            result.put("success", true);
            result.put("message", "게시글이 삭제되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "게시글 삭제 실패: " + e.getMessage());
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

        String encodedFileName = URLEncoder.encode(originalName, "UTF-8")
                .replaceAll("\\+", "%20");

        response.setHeader(
            "Content-Disposition",
            "attachment; filename*=UTF-8''" + encodedFileName
        );

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
    
    /**
     * 게시글 수정 페이지 (인증 추가)
     */
    @GetMapping("/modify")
    public String modifyPage(
            @RequestParam("postUid") Long postUid, 
            Model model,
            HttpSession session) {
        
        // 1. 로그인 체크
        User loginUser = (User) session.getAttribute("LOGIN_USER");
        if (loginUser == null) {
            model.addAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        // 2. 게시글 조회
        Map<String, Object> data = postService.getPostForModify(postUid);
        Map<String, Object> post = (Map<String, Object>) data.get("post");
        
        if (post == null) {
            model.addAttribute("errorMessage", "존재하지 않는 게시글입니다.");
            return "redirect:/";
        }

        // 3. 작성자 본인 확인
        String postUsername = (String) post.get("USERNAME");
        if (postUsername == null) {
            postUsername = (String) post.get("username");
        }
        
        if (!loginUser.getUsername().equals(postUsername)) {
            model.addAttribute("errorMessage", "본인이 작성한 게시글만 수정할 수 있습니다.");
            return "redirect:/detail?postUid=" + postUid;
        }
        
        // 4. 수정 페이지로 이동
        model.addAttribute("post", post);
        model.addAttribute("fileList", data.get("fileList"));
        
        return "modify"; // modify.jsp
    }

    /**
     * 게시글 수정 처리 (인증 추가)
     */
    @PostMapping("/modify")
    @ResponseBody
    public Map<String, Object> modifyPost(
            @RequestParam("postUid") Long postUid,
            @RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile,
            HttpSession session) {
        
        System.out.println("게시글 수정 요청 - postUid: " + postUid + ", title: " + title);
        
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 1. 로그인 체크
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            // 2. 게시글 조회
            Map<String, Object> post = postService.findById(postUid);
            if (post == null) {
                result.put("success", false);
                result.put("message", "존재하지 않는 게시글입니다.");
                return result;
            }

            // 3. 작성자 본인 확인
            String postUsername = (String) post.get("USERNAME");
            if (postUsername == null) {
                postUsername = (String) post.get("username");
            }
            
            if (!loginUser.getUsername().equals(postUsername)) {
                result.put("success", false);
                result.put("message", "본인이 작성한 게시글만 수정할 수 있습니다.");
                return result;
            }

            // 4. 파일 개수 제한 검증
            if (uploadFile != null && uploadFile.length > MAX_FILE_COUNT) {
                result.put("success", false);
                result.put("message", "파일은 최대 " + MAX_FILE_COUNT + "개까지만 첨부할 수 있습니다.");
                return result;
            }
            
            // 5. 빈 파일 필터링 및 재검증
            if (uploadFile != null) {
                long validFileCount = Arrays.stream(uploadFile)
                    .filter(file -> file != null && 
                            !file.isEmpty() && 
                            file.getOriginalFilename() != null && 
                            !file.getOriginalFilename().trim().isEmpty())
                    .count();
                
                if (validFileCount > MAX_FILE_COUNT) {
                    result.put("success", false);
                    result.put("message", "파일은 최대 " + MAX_FILE_COUNT + "개까지만 첨부할 수 있습니다.");
                    return result;
                }
            }
            
            // 6. 수정 처리
            return postService.modifyPost(postUid, title, content, uploadFile);
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "게시글 수정 중 오류가 발생했습니다: " + e.getMessage());
            return result;
        }
    }
}