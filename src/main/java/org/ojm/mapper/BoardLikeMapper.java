package org.ojm.mapper;

import org.ojm.domain.BoardLikeVO;

public interface BoardLikeMapper {
	public int bCountLike(int bno, int uno);
	public int bLikeUp(int bno, int uno);
	public int bLikeDown(int bno, int uno);
}