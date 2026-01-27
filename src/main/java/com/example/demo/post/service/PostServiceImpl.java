package com.example.demo.post.service;

import com.example.demo.post.mapper.PostMapper;
import java.util.UUID;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.util.HashMap;

@Service
public class PostServiceImpl implements PostService {

    private final PostMapper postMapper;
    private static final int PAGE_SIZE = 10;
    private static final String UPLOAD_DIR = "uploads/board_file";

    public PostServiceImpl(PostMapper postMapper) {
        this.postMapper = postMapper;
    }

    @Override
    public List<Map<String, Object>> findPage(int page) {
        int start = (page - 1) * PAGE_SIZE + 1;
        int end   = page * PAGE_SIZE;
        return postMapper.findPage(start, end);
    }

    @Override
    public int getTotalPages() {
        int totalCount = postMapper.countAll();
        return (int) Math.ceil((double) totalCount / PAGE_SIZE);
    }

    @Override
    public void write(String title, String content, List<MultipartFile> uploadFiles, Long userUid) throws Exception {

        /* 1. 게시글 저장 */
        Map<String, Object> postParam = new HashMap<>();
        postParam.put("title", title);
        postParam.put("content", content);
        postParam.put("userUid", userUid);

        postMapper.insertPost(postParam);

        Long postUid = ((Number) postParam.get("postUid")).longValue();

        /* 2. 파일 저장 (여러 개) */
        if (uploadFiles != null && !uploadFiles.isEmpty()) {
            
            for (MultipartFile uploadFile : uploadFiles) {
                
                if (uploadFile.isEmpty()) {
                    continue;
                }
                
                String originalName = uploadFile.getOriginalFilename();
                String storedName = UUID.randomUUID() + "_" + originalName;
                String filePath = UPLOAD_DIR;

                File dir = new File(filePath);
                if (!dir.exists()) dir.mkdirs();

                File saveFile = new File(filePath, storedName);
                uploadFile.transferTo(saveFile);

                /* 3. 파일 정보 DB 저장 */
                Map<String, Object> fileParam = new HashMap<>();
                fileParam.put("originalName", originalName);
                fileParam.put("storedName", storedName);
                fileParam.put("filePath", filePath);
                fileParam.put("fileType", uploadFile.getContentType());
                fileParam.put("postUid", postUid);

                postMapper.insertPostFile(fileParam);
            }
        }
    }
}
