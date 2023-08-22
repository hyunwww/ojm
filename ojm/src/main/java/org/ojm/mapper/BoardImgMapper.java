package org.ojm.mapper;

import java.util.List;

import org.ojm.domain.BoardImgVO;

public interface BoardImgMapper {
	public void insert(BoardImgVO vo);
	public void delete(String uuid);
	public List<BoardImgVO> findByBno(int bno);
	public void deleteAll(int bno);
}
