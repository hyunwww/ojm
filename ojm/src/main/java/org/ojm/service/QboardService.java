package org.ojm.service;

import java.util.List;

import org.ojm.domain.Criteria;
import org.ojm.domain.QboardVO;

public interface QboardService {
	public List<QboardVO> getQlist(Criteria cri);
	public int getQtotal();
	public void qRegister(QboardVO qvo);
	public QboardVO qGet(int qno);
	public boolean qModify(QboardVO vo);
	public boolean qRemove(int qno);
}
