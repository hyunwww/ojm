package org.ojm.mapper;

import java.util.List;

import org.ojm.domain.StoreImgVO;

public interface StoreImgMapper {
	public int addImg(StoreImgVO ivo);
	public int removeImg(int sino);
	public List<StoreImgVO> getImg(int sno);
}
