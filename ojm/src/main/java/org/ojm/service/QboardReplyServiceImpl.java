package org.ojm.service;

import java.util.List;

import org.ojm.domain.QboardReplyVO;
import org.ojm.mapper.QboardMapper;
import org.ojm.mapper.QboardReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class QboardReplyServiceImpl implements QboardReplyService{
	
	@Autowired
	private QboardReplyMapper qrMapper;
	
	@Autowired
	private QboardMapper qMapper;
	
	@Transactional
	@Override
	public int qRegister(QboardReplyVO qvo) {
		int qno = qvo.getQno();
		int result = qrMapper.qInsert(qvo);
		qMapper.updateQreplyCnt(qno, 1);
		return result;
	}

	@Override
	public List<QboardReplyVO> getQlist(int qno) {
		return qrMapper.getQlist(qno);
	}

	@Override
	public int qRemove(int qrno, int qno) {
		int result = qrMapper.qDelete(qrno, qno);
		qMapper.updateQreplyCnt(qno, -1);
		return result;
	}
	
}
