package org.ojm.service;

import java.util.List;

import org.ojm.domain.Criteria;
import org.ojm.domain.QboardVO;
import org.ojm.mapper.QboardMapper;
import org.ojm.mapper.QboardReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class QboardServiceImpl implements QboardService{
	
	@Autowired
	private QboardMapper qmapper;

	@Autowired
	private QboardReplyMapper qrmapper;
	
	@Override
	public List<QboardVO> getQlist(Criteria cri) {
		return qmapper.getQlistWithPaging(cri);
	}

	@Override
	public int getQtotal() {
		return qmapper.getQtotalCount();
	}

	@Override
	public void qRegister(QboardVO qvo) {
		qmapper.qInsert(qvo);
	}

	@Override
	public QboardVO qGet(int qno) {
		qmapper.updateQview(qno);
		return qmapper.qRead(qno);
	}

	@Override
	public boolean qModify(QboardVO qvo) {
		return qmapper.qUpdate(qvo) == 1;
	}

	@Override
	public boolean qRemove(int qno) {
		qrmapper.qDeleteAll(qno);
		return qmapper.qDelete(qno) == 1;
	}
}
