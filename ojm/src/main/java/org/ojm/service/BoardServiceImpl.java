package org.ojm.service;

import java.util.List;

import org.ojm.domain.BoardImgVO;
import org.ojm.domain.BoardVO;
import org.ojm.domain.Criteria;
import org.ojm.mapper.BoardImgMapper;
import org.ojm.mapper.BoardMapper;
import org.ojm.mapper.BoardReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private BoardReplyMapper brMapper;
	
	@Autowired
	private BoardImgMapper imgMapper;
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList...");
		return mapper.getListWithPaging(cri);
	}

	@Override
	@Transactional
	public void register(BoardVO vo) {
		log.info("register...");
		mapper.insert(vo);
		if (vo.getImgList() != null && vo.getImgList().size() > 0) {
			int bno = mapper.getMaxBno();
			for(BoardImgVO ivo : vo.getImgList()) {
				ivo.setBno(bno);
				imgMapper.insert(ivo);
			}
		}
	}

	@Override
	public BoardVO get(int bno) {
		log.info("get...");
		mapper.updateBview(bno);
		return mapper.read(bno);
	}

	@Override
	public boolean remove(int bno) {
		log.info("remove...");
		imgMapper.deleteAll(bno);
		brMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public boolean modify(BoardVO vo) {
		log.info("modify..." + vo);
		return mapper.update(vo) == 1;
	}

	@Override
	public int getTotal() {
		log.info("getTotal...");
		return mapper.getTotalCount();
	}

	@Override
	public List<BoardImgVO> getImgList(int bno) {
		log.info("getImgList..." + bno);
		return imgMapper.findByBno(bno);
	}

	@Override
	public int updateBlike(int bno) {
		log.info("updateBlike...");		
		return mapper.updateBlike(bno);
	}
}
