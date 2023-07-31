package org.ojm.mapper;

import java.util.List;

import org.ojm.domain.BoardReplyVO;

public interface BoardReplyMapper {
	public int insert(BoardReplyVO vo);				// 댓글 삽입
	public List<BoardReplyVO> getList(int bno);		// 댓글 목록
}
