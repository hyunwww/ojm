package org.ojm.service;

import java.util.List;

import org.ojm.domain.Criteria;
import org.ojm.domain.ReportVO;

public interface ReportService {
	public List<ReportVO> getRpList(Criteria cri);
	public int getRpTotal();
	public ReportVO rpGet(int rpno);
	public ReportVO getRpReply(int rpno);
	public int rpReplyRegister(ReportVO rpvo);
}
