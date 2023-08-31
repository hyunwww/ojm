package org.ojm.service;

import java.util.List;

import org.ojm.domain.ReviewAttachVO;
import org.ojm.domain.ReviewVO;
import org.ojm.mapper.ReviewAttachMapper;
import org.ojm.mapper.ReviewMapper;
import org.ojm.mapper.StoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewMapper mapper;
	@Autowired
	private StoreMapper sMapper;
	
	@Autowired
	private ReviewAttachMapper attachMapper;
	
	@Override
	@Transactional
	public void addrv(ReviewVO vo) {
		
		if (mapper.addrv(vo) > 0) {
			sMapper.updateRate((int)vo.getSno());
		}else {
		}
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
