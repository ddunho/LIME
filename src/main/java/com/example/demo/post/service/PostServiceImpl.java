package com.example.demo.post.service;

import com.example.demo.post.mapper.PostMapper;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.util.HashMap;

@Service
public class PostServiceImpl implements PostService {

    private final PostMapper postMapper;
    private static final int PAGE_SIZE = 10;
    private static final String UPLOAD_DIR = System.getProperty("user.dir") + "/uploads/board_file";

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
    @Transactional
    public void write(String title, String content, List<MultipartFile> uploadFiles, Long userUid) throws Exception {
        
        System.out.println("========== Service 시작 ==========");
        
        /* 1. 게시글 저장 */
        Map<String, Object> postParam = new HashMap<>();
        postParam.put("title", title);
        postParam.put("content", content);
        postParam.put("userUid", userUid);
        
        System.out.println(">>> insertPost 호출 전");
        postMapper.insertPost(postParam);
        System.out.println(">>> insertPost 호출 후");
        
        System.out.println(">>> postParam 내용: " + postParam);
        
        Object postUidObj = postParam.get("postUid");
        System.out.println(">>> postUidObj: " + postUidObj);
        System.out.println(">>> postUidObj type: " + (postUidObj != null ? postUidObj.getClass() : "null"));
        
        if (postUidObj == null) {
            throw new Exception("postUid가 null입니다!");
        }
        
        Long postUid = ((Number) postUidObj).longValue();
        System.out.println(">>> 생성된 postUid: " + postUid);
        
        // 실제 DB에서 확인
        System.out.println(">>> DB에서 post 조회 시도");
        
        /* 2. 파일 저장 (여러 개) */
        if (uploadFiles != null && !uploadFiles.isEmpty()) {
            
            System.out.println(">>> 업로드 파일 개수: " + uploadFiles.size());
            
            for (MultipartFile uploadFile : uploadFiles) {
                
                if (uploadFile.getOriginalFilename() == null || 
                    uploadFile.getOriginalFilename().trim().isEmpty() ||
                    uploadFile.getSize() == 0) {
                    System.out.println(">>> 빈 파일 스킵");
                    continue;
                }
                
                String originalName = uploadFile.getOriginalFilename();
                String storedName = UUID.randomUUID() + "_" + originalName;
                String filePath = UPLOAD_DIR;
                
                System.out.println(">>> originalName: " + originalName);
                System.out.println(">>> storedName: " + storedName);
                
                File dir = new File(filePath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                
                File saveFile = new File(filePath, storedName);
                uploadFile.transferTo(saveFile);
                System.out.println(">>> 파일 저장 완료");
                
                /* 3. 파일 정보 DB 저장 */
                Map<String, Object> fileParam = new HashMap<>();
                fileParam.put("originalName", originalName);
                fileParam.put("storedName", storedName);
                fileParam.put("filePath", filePath);
                fileParam.put("fileType", uploadFile.getContentType());
                fileParam.put("postUid", postUid);
                
                System.out.println(">>> insertPostFile에 전달할 postUid: " + postUid);
                System.out.println(">>> fileParam 내용: " + fileParam);
                
                postMapper.insertPostFile(fileParam);
                System.out.println(">>> DB 저장 완료");
            }
        }
        
        System.out.println("========== Service 완료 ==========");
    }
}
