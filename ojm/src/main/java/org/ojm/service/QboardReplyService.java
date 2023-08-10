package org.ojm.service;

import java.util.List;

import org.ojm.domain.QboardReplyVO;

public interface QboardReplyService {
	public int qRegister(QboardReplyVO qvo);
	public List<QboardReplyVO> getQlist(int qno);
	public int qRemove(int qrno, int qno);
}
