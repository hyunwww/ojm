package org.ojm.service;

import lombok.extern.log4j.Log4j;

import java.util.List;

import org.ojm.domain.BoardReplyVO;
import org.ojm.mapper.BoardMapper;
import org.ojm.mapper.BoardReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Log4j
@Service
public class BoardReplyServiceImpl implements BoardReplyService{

	@Autowired
	private BoardReplyMapper mapper;
	
	@Autowired
	private BoardMapper bMapper;
	
	@Transactional
	@Override
	public int register(BoardReplyVO vo) {
		int bno = vo.getBno();
		int result = mapper.insert(vo);
		bMapper.updateReplyCnt(bno, 1);
		return result;
	}

	@Override
	public List<BoardReplyVO> getList(int bno) {
		return mapper.getList(bno);
	}

	@Transactional
	@Override
	public int remove(int brno, int bno) {
		int result = mapper.delete(brno, bno);
		bMapper.updateReplyCnt(bno, -1);
		return result;
	}

}
