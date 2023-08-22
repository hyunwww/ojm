package org.ojm.mapper;

import java.util.List;

import org.ojm.domain.BoardReplyVO;

public interface BoardReplyMapper {
	public int insert(BoardReplyVO rvo);				// 댓글 삽입
	public List<BoardReplyVO> getList(int bno);			// 댓글 목록
	public int delete(int brno, int bno);				// 댓글 삭제
	public int deleteAll(int bno);						// 댓글 전체 삭제
}
