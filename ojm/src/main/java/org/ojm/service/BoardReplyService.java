package org.ojm.service;

import java.util.List;

import org.ojm.domain.BoardReplyVO;

public interface BoardReplyService {
	public int register(BoardReplyVO rvo);
	public List<BoardReplyVO> getList(int bno);
	public int remove(int brno, int bno);
}
