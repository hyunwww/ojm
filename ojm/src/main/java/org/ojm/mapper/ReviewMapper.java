package org.ojm.mapper;

import java.util.List;

import org.ojm.domain.ReviewVO;

public interface ReviewMapper {

	public int addrv(ReviewVO vo);
	public List<ReviewVO> storeReviewList(int sno);
//	public long getrrvno();
//	public int getTotalCount();
//	public List<ReviewVO> getListWithPaging(Criteria cri);
}
