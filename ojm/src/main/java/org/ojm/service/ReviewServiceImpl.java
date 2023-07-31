package org.ojm.service;

import java.util.List;

import org.ojm.domain.ReviewAttachVO;
import org.ojm.domain.ReviewVO;
import org.ojm.mapper.ReviewAttachMapper;
import org.ojm.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewMapper mapper;
	
	@Autowired
	private ReviewAttachMapper attachMapper;
	
	@Override
	public void addrv(ReviewVO vo) {
		mapper.addrv(vo);
	}
//	@Override
//	public int getTotal() {
//		log.info("getTotal...");
//		return mapper.getTotalCount();
//	}


//	@Override
//	public List<ReviewAttachVO> getAttachList(long rvno) {
//		// TODO Auto-generated method stub
//		return attachMapper.findByRvno(rvno);
//	}
}
