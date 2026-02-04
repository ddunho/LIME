package com.example.demo.post.service;

import com.example.demo.post.mapper.PostMapper;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;

@Service
public class PostServiceImpl implements PostService {

    private final PostMapper postMapper;
    private static final int PAGE_SIZE = 10;
    private static final String UPLOAD_DIR = System.getProperty("user.dir") + "/uploads/board_file";

    public PostServiceImpl(PostMapper postMapper) {
        this.postMapper = postMapper;
    }
    
    // 페이징 처리
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
    public Long write(String title,
                      String content,
                      List<MultipartFile> uploadFiles,
                      Long userUid) throws Exception {

        // 게시글 저장
        Map<String, Object> postParam = new HashMap<>();
        postParam.put("title", title);
        postParam.put("content", content);
        postParam.put("userUid", userUid);
        
        // 파일 저장
        postMapper.insertPost(postParam);

        Object postUidObj = postParam.get("postUid");
        if (postUidObj == null) {
            throw new Exception("postUid가 null입니다!");
        }

        Long postUid = ((Number) postUidObj).longValue();

        // 파일 저장 (여러 개)
        if (uploadFiles != null && !uploadFiles.isEmpty()) {
            for (MultipartFile uploadFile : uploadFiles) {

                if (uploadFile.getOriginalFilename() == null ||
                    uploadFile.getOriginalFilename().trim().isEmpty() ||
                    uploadFile.getSize() == 0) {
                    continue;
                }

                String originalName = uploadFile.getOriginalFilename();
                String storedName = UUID.randomUUID() + "_" + originalName;
                String filePath = UPLOAD_DIR;

                File dir = new File(filePath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

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

        return postUid;
    }
    
    
    // ID로 유저 정보 조회
    @Override
    public Map<String, Object> findById(Long postUid) {
        return postMapper.findById(postUid);
    }
    
    // 게시글 ID로 파일 정보 조회
    @Override
    public List<Map<String, Object>> findFilesByPostUid(Long postUid) {
        return postMapper.findFilesByPostUid(postUid);
    }
    
    // 파일 ID로 파일 정보 조회
    @Override
    public Map<String, Object> findFileByUid(Long fileUid) {
        return postMapper.findFileByUid(fileUid);
    }
    
    // 수정을 위한 게시글 정보 찾기
    @Override
    public Map<String, Object> getPostForModify(Long postUid) {
        Map<String, Object> result = new HashMap<>();
        
        // 게시글 정보
        Map<String, Object> post = postMapper.findById(postUid);
        
        // 파일 목록
        List<Map<String, Object>> fileList = postMapper.findFilesByPostUid(postUid);
        
        result.put("post", post);
        result.put("fileList", fileList);
        
        return result;
    }

    // 게시글 수정
    @Override
    @Transactional
    public Map<String, Object> modifyPost(Long postUid, String title, String content, MultipartFile[] uploadFile) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Map<String, Object> param = new HashMap<>();
            param.put("postUid", postUid);
            param.put("title", title);
            param.put("content", content);
            
            //게시글 수정
            postMapper.updatePost(param);
            
            // 파일이 새로 선택된 경우
            if (uploadFile != null && uploadFile.length > 0 && !uploadFile[0].isEmpty()) {
                
                // 기존 파일 삭제 (실제 파일 + DB)
                List<Map<String, Object>> oldFiles = postMapper.findFilesByPostUid(postUid);
                for (Map<String, Object> oldFile : oldFiles) {
                    String storedName = (String) oldFile.get("storedName");
                    if (storedName == null) {
                        storedName = (String) oldFile.get("STOREDNAME");
                    }
                    deletePhysicalFile(UPLOAD_DIR, storedName);
                }
                postMapper.deleteFilesByPostUid(postUid);
                
                // 새 파일 저장
                for (MultipartFile file : uploadFile) {
                    if (!file.isEmpty()) {
                        saveFile(file, postUid);
                    }
                }
            }
            // 파일을 선택하지 않은 경우 기존 파일 유지
            
            result.put("success", true);
            result.put("message", "게시글이 수정되었습니다.");
            
        } catch (Exception e) {
            System.err.println("게시글 수정 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "게시글 수정 중 오류가 발생했습니다.");
            throw new RuntimeException(e);
        }
        
        return result;
    }

    /**
     * 게시글 삭제
     * 1. 댓글 소프트 삭제
     * 2. 파일 물리적 삭제
     * 3. 파일 DB 하드 삭제
     * 4. 게시글 소프트 삭제
     */
    @Transactional
    @Override
    public void deletePost(Long postUid) {

        // 게시글의 모든 댓글 소프트 삭제
        try {
            int commentDeleted = postMapper.updateCommentDeleteYnByPostUid(postUid);
            
        } catch (Exception e) {
            System.err.println("댓글 소프트 삭제 실패 (comment_tb에 deleteyn 컬럼이 없을 수 있음): " + e.getMessage());
            // 댓글 삭제 실패해도 게시글 삭제는 진행
        }

        // 첨부파일 조회
        List<Map<String, Object>> files = postMapper.selectFilesByPostUid(postUid);

        // 실제 파일 물리적 삭제
        for (Map<String, Object> file : files) {
            // 대소문자 구분 없이 값 가져오기
            String filepath = getMapValue(file, "FILEPATH", "filePath");
            String storedname = getMapValue(file, "STOREDNAME", "storedName");
            
            if (filepath != null && storedname != null) {
                File f = new File(filepath, storedname);
                if (f.exists()) {
                    boolean deleted = f.delete();
                    System.out.println("파일 삭제: " + f.getAbsolutePath() + " - " + (deleted ? "성공" : "실패"));
                } else {
                    System.out.println("파일이 존재하지 않음: " + f.getAbsolutePath());
                }
            }
        }

        // 4. 파일 DB 하드 삭제
        int fileDeleted = postMapper.deleteFilesByPostUid(postUid);
        System.out.println("파일 DB 삭제 완료: " + fileDeleted + "개");

        // 5. 게시글 소프트 삭제
        int postDeleted = postMapper.updatePostDeleteYn(postUid);
        if (postDeleted == 0) {
            throw new RuntimeException("게시글 삭제에 실패했습니다. (이미 삭제되었거나 존재하지 않는 게시글)");
        }
        System.out.println("게시글 소프트 삭제 완료: postUid=" + postUid);
    }

    
    // Map에서 대소문자 구분 없이 값 가져오기
    private String getMapValue(Map<String, Object> map, String upperKey, String lowerKey) {
        Object value = map.get(upperKey);
        if (value == null) {
            value = map.get(lowerKey);
        }
        return value != null ? value.toString() : null;
    }

    
    // 파일 저장
    private void saveFile(MultipartFile file, Long postUid) throws Exception {
        String originalName = file.getOriginalFilename();
        String storedName = UUID.randomUUID() + "_" + originalName;
        
        // 디렉토리 생성
        File dir = new File(UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        
        // 파일 저장
        File saveFile = new File(UPLOAD_DIR, storedName);
        file.transferTo(saveFile);
        
        // DB 저장
        Map<String, Object> fileParam = new HashMap<>();
        fileParam.put("originalName", originalName);
        fileParam.put("storedName", storedName);
        fileParam.put("filePath", UPLOAD_DIR);
        fileParam.put("fileType", file.getContentType());
        fileParam.put("postUid", postUid);
        
        postMapper.insertPostFile(fileParam);
    }
    
    
    // 실제 파일 삭제
    private void deletePhysicalFile(String filePath, String storedName) {
        try {
            File file = new File(filePath, storedName);
            if (file.exists()) {
                boolean deleted = file.delete();
                if (deleted) {
                    System.out.println("파일 삭제 완료: " + file.getAbsolutePath());
                } else {
                    System.out.println("파일 삭제 실패: " + file.getAbsolutePath());
                }
            }
        } catch (Exception e) {
            System.err.println("파일 삭제 실패: " + filePath + "/" + storedName);
            e.printStackTrace();
        }
    }
}