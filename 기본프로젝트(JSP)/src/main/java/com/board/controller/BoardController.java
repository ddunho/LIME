package com.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.board.service.BoardServcie;
import com.board.service.impl.BoardServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@Transactional
public class BoardController {

    private final BoardServiceImpl boardServiceImpl;
	
	@Value("${upload.path}")
	private String uploadPath;
	
	@Autowired
	BoardServcie boardService;

    BoardController(BoardServiceImpl boardServiceImpl) {
        this.boardServiceImpl = boardServiceImpl;
    }

	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 게시판메인 이동
	 */
	@RequestMapping("/")
	public ModelAndView board(ModelAndView mv, @RequestParam(defaultValue = "1", value = "pageCnt", required = false) int pageCnt, HttpServletRequest request) {
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		int boardCnt = boardService.selectBoardCnt();
		System.out.println("pageCnt ---> " + pageCnt );
		resultList = boardService.selectBoardList(pageCnt);
		
		System.out.println("boardCnt ---> " + boardCnt );
		System.out.println("resultList ---> " + resultList );

		mv.addObject("resultList", resultList);
		mv.addObject("page", paging(pageCnt, boardCnt, 10));
		mv.setViewName("board/boardMain");
		return mv;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 게시판작성 이동
	 */
	@RequestMapping("/boardWrite")
	public ModelAndView boardWrite(ModelAndView mv, HttpSession session, HttpServletRequest request) {
		mv.setViewName("board/boardWrite");
		return mv;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 게시판 등록
	 */
	@ResponseBody
	@PostMapping("/insertBoard")
	public Map<String, Object> insertBoard(@RequestParam Map<String, Object> boardInfo, HttpSession session, MultipartHttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> user = new HashMap<>(); 
				
		user = (Map<String, Object>) session.getAttribute("user");
		boardInfo.put("userNo", user.get("userNo"));
		System.out.println("test ---> " + user );
		System.out.println("test ---> " + user.get("userNo") );
		System.out.println("boardInfo ---> " + boardInfo );

        boolean result = boardService.insertBoard(boardInfo);
        
        if(result) {
        	List<MultipartFile> fileList = request.getFiles("upLoadFile");
        	int postsNo = boardService.selectPostsNo(boardInfo); 

			for (int i = 0; i < fileList.size(); i++) {
				fileSave(fileList.get(i), postsNo);
			}
			resultMap.put("result", result);
		} else {
			resultMap.put("result", result);
		}

		return resultMap;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 게시판 상세 조회
	 */
	@RequestMapping(value = { "/boardDetail"})
	public ModelAndView boardDetail(ModelAndView mv, @RequestParam(value = "postsNo", required = true) int postsNo, HttpSession session, HttpServletRequest request) {
		
		System.out.println("boardDetail ------------ ");
		
		List<Map<String, Object>> fileList = new ArrayList<>();
		List<Map<String, Object>> commentList = new ArrayList<>();
		Map<String, Object> resultMap = new HashMap<>();

		fileList    = boardService.selectFileList(postsNo);
		commentList = boardService.selectCommentList(postsNo);
		resultMap   = boardService.selectBoardDetail(postsNo);

		mv.addObject("resultList", resultMap);
		mv.addObject("fileList", fileList);
		mv.addObject("commentList", commentList);
		mv.setViewName("board/boardDetail");
		
		return mv;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 게시판 상제 조회(수정)
	 */
	@RequestMapping(value = { "/boardUpdate"})
	public ModelAndView boardUpdate(ModelAndView mv, @RequestParam(value = "postsNo", required = true) int postsNo, HttpSession session, HttpServletRequest request) {
		
		System.out.println("boardUpdate ------------ ");
		
		List<Map<String, Object>> fileList = new ArrayList<>();
		Map<String, Object> resultMap = new HashMap<>();

		fileList    = boardService.selectFileList(postsNo);
		resultMap   = boardService.selectBoardDetail(postsNo);

		mv.addObject("resultList", resultMap);
		mv.addObject("fileList", fileList);
		mv.setViewName("board/boardUpdate");
		
		return mv;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 게시판 상세 수정 
	 */
	@ResponseBody
	@PostMapping("/updatePosts")
	public Map<String, Object> updatePosts(@RequestParam Map<String, Object> postsInfo, HttpSession session, MultipartHttpServletRequest request){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> user = new HashMap<String, Object>();
		
		user = (Map<String, Object>) session.getAttribute("user");
		postsInfo.put("userNo", user.get("userNo"));

		boolean result = boardService.updatePosts(postsInfo);
        
		int postsNo = Integer.parseInt(postsInfo.get("postsNo").toString());
		
        if(result) {
        	List<MultipartFile> fileList = request.getFiles("upLoadFile");

			for (int i = 0; i < fileList.size(); i++) {
				if (i == 0) {
					boardService.deleteFile(postsInfo);
				}
				fileSave(fileList.get(i), postsNo);
			}
			resultMap.put("result", result);
		} else {
			resultMap.put("result", result);
		}
        
        resultMap.put("postsNo", postsNo);
		return resultMap;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 게시판 상세 삭제
	 */
	@ResponseBody
	@PostMapping("/boardDelete")
	public Map<String, Object> deleteBoard(@RequestParam int postsNo, HttpSession session, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		boolean result = boardService.deleteBoard(postsNo);
		
		resultMap.put("result", result);
		return resultMap;
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 댓글 등록
	 */
	@ResponseBody
	@PostMapping("/commentWrite")
	public Map<String, Object> commentWrite(@RequestParam Map<String, Object> commentInfo , HttpSession session) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, Object>> commentList = new ArrayList<>();

		Map<String, Object> user = new HashMap<>(); 
		user = (Map<String, Object>) session.getAttribute("user");
		commentInfo.put("userNo", user.get("userNo"));
		
		System.out.println("파라미터 확인 commentInfo ----> " + commentInfo);
		
		String parentNo = (String) commentInfo.get("parentNo");
		if (parentNo == null || parentNo.trim().isEmpty()) {
		    commentInfo.put("parentNo", null);
		} else {
		    commentInfo.put("parentNo", Integer.parseInt(parentNo));
		}

		boolean result = boardService.insertComment(commentInfo);
		
		int postsNo =  Integer.parseInt(commentInfo.get("postsNo").toString());
		commentList = boardService.selectCommentList(postsNo);
		
		for(Map<String, Object> comment : commentList) {
			String ssUser = user.get("userNo").toString(); 
			String userNo = comment.get("USER_NO").toString();
			
			if( userNo != null && ssUser.equals(userNo)) {
				comment.put("userCheck", "Y");
			} else {
				comment.put("userCheck", "N");
			}
		}
		
		System.out.println("데이터 확인 commentList"  + commentList );
		
		resultMap.put("result", result);
		resultMap.put("commentList", commentList);

		return resultMap;
	}

	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 댓글 수정
	 */
	@ResponseBody
	@PostMapping("/commentUpdate")
	public Map<String, Object> commentUpdate(@RequestParam Map<String, Object> commentInfo , HttpSession session) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, Object>> commentList = new ArrayList<>();

		Map<String, Object> user = new HashMap<>(); 
		user = (Map<String, Object>) session.getAttribute("user");
		
		boolean result = boardService.updateComment(commentInfo);
		
		int postsNo =  Integer.parseInt(commentInfo.get("postsNo").toString());
		commentList = boardService.selectCommentList(postsNo);
		
		for(Map<String, Object> comment : commentList) {
			String ssUser = user.get("userNo").toString(); 
			String userNo = comment.get("USER_NO").toString();
			
			if( userNo != null && ssUser.equals(userNo)) {
				comment.put("userCheck", "Y");
			} else {
				comment.put("userCheck", "N");
			}
		}
		
		resultMap.put("result", result);
		resultMap.put("commentList", commentList);

		return resultMap;
	}

	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 댓글 삭제
	 */
	@ResponseBody
	@PostMapping("/commentDelete")
	public Map<String, Object> commentDelete(@RequestParam(value = "commentsNo", required = true) int commentsNo, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		boolean result = boardService.deleteComment(commentsNo);
		resultMap.put("result", result);
		resultMap.put("commentsNo", commentsNo);
		return resultMap;
	}


	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 파일 다운로드
	 */
	@ResponseBody
	@RequestMapping("/fileDownload")
	public void fileDownload(@RequestParam("fileName") String fileName, HttpServletResponse response) {
		
			System.out.println("fileName ----> " + fileName);
			
	    try {
	        File file = new File(uploadPath, fileName);
	        if (!file.exists()) {
	            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	            return;
	        }
	
	        String encodedFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	
	        response.setContentType("application/octet-stream");
	        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
	        response.setContentLengthLong(file.length());
	
	        try (InputStream in = new FileInputStream(file);
	             OutputStream out = response.getOutputStream()) {
	             FileCopyUtils.copy(in, out);
	        }
	
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
		
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 파일 저장
	 */
	private void fileSave(MultipartFile file, int postsNo) {

		Map<String, Object> fileMap = new HashMap<>();

		long time = System.currentTimeMillis();
		String originFileName = file.getOriginalFilename(); // 원본 파일 명
		String saveFileName = String.format("%d_%s", time, originFileName);	// 실제 저장 파일 명

		try {
			// 파일생성
			file.transferTo(new File(uploadPath, saveFileName));
			fileMap.put("postsNo", postsNo);
			fileMap.put("fileName", saveFileName);

			boardService.saveFile(fileMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @author 김정수
	 * @since 2025-05-12
	 * @description 페이징 관련 처리
	 */
	private Map<String, Object> paging(int cnt, int totalCnt, int size) {

		Map<String, Object> page = new HashMap<String, Object>();
		// 현재 페이지 번호
		int pageCnt = cnt;
		// 전체 게시글 수
		int boardCnt = totalCnt;

		// 페이지당 게시글 수
		int pageSize = size; // 한 페이지에 표시할 게시글 수

		// 전체 페이지 수 계산
		int totalPages = (int) Math.ceil((double) boardCnt / pageSize);

		// 시작 페이지와 끝 페이지 계산
		int startPage = Math.max(1, pageCnt / 5 * 5 + 1); // 시작 페이지는 현재 페이지 기준 앞쪽 5페이지
		if (pageCnt % 5 == 0) {
			// startPage = startPage - 5(페이징의 개수)
			startPage -= 5;
		}
		int endPage = Math.min(totalPages, startPage + 4); // 끝 페이지는 현재 페이지 기준 뒷쪽 5페이지
		// 이전 페이지와 다음 페이지 설정
		int prevPage = Math.max(1, pageCnt - 1); // 이전 페이지
		int nextPage = Math.min(totalPages, pageCnt + 1); // 다음 페이지

		page.put("pageCnt", pageCnt);
		page.put("boardCnt", boardCnt);
		page.put("pageSize", pageSize);
		page.put("totalPages", totalPages);
		page.put("startPage", startPage);
		page.put("endPage", endPage);
		page.put("prevPage", prevPage);
		page.put("nextPage", nextPage);

		return page;
	}
}


