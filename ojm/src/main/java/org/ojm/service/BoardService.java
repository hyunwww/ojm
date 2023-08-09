package org.ojm.service;

import java.util.List;

import org.ojm.domain.BoardImgVO;
import org.ojm.domain.BoardVO;
import org.ojm.domain.Criteria;

public interface BoardService {
	public List<BoardVO> getList(Criteria cri);
	public void register(BoardVO vo);
	public BoardVO get(int bno);
	public boolean remove(int bno);
	public boolean modify(BoardVO vo);
	public int getTotal();
	public List<BoardImgVO> getImgList(int bno);
	public int updateBlike(int bno);	// 좋아요
}
