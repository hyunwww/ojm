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
		if (bMapper.updateReplyCnt(bno, 1) > 0) {
			System.out.println("success...");
		}else {
			System.out.println("fail...");
		}
		return result;
	}

	@Override
	public List<BoardReplyVO> getList(int bno) {
		return mapper.getList(bno);
	}

}
