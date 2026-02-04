package com.board.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {
	/**
	 * 파일 저장 관련 DB 처리
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */
	void saveFile(Map<String, Object> fileMap);
	
	/**
	 * 게시판 등록 관련 DB 처리
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */
	boolean insertBoard(Map<String, Object> boardInfo);

	/**
	 * 게시판번호 조회
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */	
	int selectPostsNo(Map<String, Object> boardInfo);

	/**
	 * 게시판 개수 조회
	 * 
	 * @author 김정수
	 * @since 2025-05-12
	 */
	int selectBoardCnt();
	
	/**
	 * 게시판 전체 조회
	 * 
	 * @author 김정수
	 * @param pageCnt 
	 * @since 2025-05-12
	 */
	List<Map<String, Object>> selectBoardList(int pageCnt);

	/**
	 * 게시판 상세 조회
	 * 
	 * @author 김정수
	 * @param postsNo 
	 * @since 2025-05-12
	 */
	Map<String, Object> selectBoardDetail(int postsNo);
	
	/**
	 * 파일 조회
	 * 
	 * @author 김정수
	 * @param postsNo 
	 * @since 2025-05-12
	 */
	List<Map<String, Object>> selectFileList(int postsNo);

	/**
	 * 게시판 댓글 조회
	 * 
	 * @author 김정수
	 * @param postsNo 
	 * @since 2025-05-12
	 */
	List<Map<String, Object>> selectCommentList(int postsNo);
	
	/**
	 * 게시판 글 삭제
	 * 
	 * @author 김정수
	 * @param postsNo 
	 * @since 2025-05-12
	 */
	boolean deleteBoard(int postsNo);
	
	/**
	 * 댓글 등록
	 * 
	 * @author 김정수
	 * @param postsNo 
	 * @since 2025-05-12
	 */
	boolean insertComment(Map<String, Object> commentInfo);
	
	/**
	 * 댓글 수정
	 * 
	 * @author 김정수
	 * @param postsNo 
	 * @since 2025-05-12
	 */
	boolean updateComment(Map<String, Object> commentInfo);
	
	/**
	 * 댓글 삭제
	 * 
	 * @author 김정수
	 * @param postsNo 
	 * @since 2025-05-12
	 */
	boolean deleteComment(int commentsNo);
	
	/**
	 * 파일 삭제
	 * 
	 * @author 김정수
	 * @param postsNo 
	 * @since 2025-05-12
	 */
	void deleteFile(Map<String, Object> postsInfo);
	
	/**
	 * 게시판 수정
	 * 
	 * @author 김정수
	 * @param postsNo 
	 * @since 2025-05-12
	 */
	boolean updatePosts(Map<String, Object> postsInfo);


}
