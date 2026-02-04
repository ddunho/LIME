package com.board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.repository.BoardMapper;
import com.board.service.BoardServcie;

@Service
public class BoardServiceImpl implements BoardServcie {
	
	@Autowired
	BoardMapper boardMapper;

	@Override
	public void saveFile(Map<String, Object> fileMap) {
		boardMapper.saveFile(fileMap);
	}

	@Override
	public boolean insertBoard(Map<String, Object> boardInfo) {
		return boardMapper.insertBoard(boardInfo);
	}

	@Override
	public int selectPostsNo(Map<String, Object> boardInfo) {
		return boardMapper.selectPostsNo(boardInfo);
	}

	@Override
	public int selectBoardCnt() {
		return boardMapper.selectBoardCnt();
	}

	@Override
	public List<Map<String, Object>> selectBoardList(int pageCnt) {
		return boardMapper.selectBoardList(pageCnt);
	}

	@Override
	public Map<String, Object> selectBoardDetail(int postsNo) {
		return boardMapper.selectBoardDetail(postsNo);
	}

	@Override
	public List<Map<String, Object>> selectFileList(int postsNo) {
		return boardMapper.selectFileList(postsNo);
	}

	@Override
	public List<Map<String, Object>> selectCommentList(int postsNo) {
		return boardMapper.selectCommentList(postsNo);
	}

	@Override
	public boolean deleteBoard(int postsNo) {
		return boardMapper.deleteBoard(postsNo);
	}

	@Override
	public boolean insertComment(Map<String, Object> commentInfo) {
		return boardMapper.insertComment(commentInfo);
	}

	@Override
	public boolean updateComment(Map<String, Object> commentInfo) {
		return boardMapper.updateComment(commentInfo);
	}

	@Override
	public boolean deleteComment(int commentsNo) {
		return boardMapper.deleteComment(commentsNo);
	}

	@Override
	public void deleteFile(Map<String, Object> postsInfo) {
		boardMapper.deleteFile(postsInfo);
	}

	@Override
	public boolean updatePosts(Map<String, Object> postsInfo) {
		return boardMapper.updatePosts(postsInfo);
	}


}
