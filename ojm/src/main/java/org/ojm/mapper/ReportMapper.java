package org.ojm.mapper;

import java.util.List;

import org.ojm.domain.Criteria;
import org.ojm.domain.ReportVO;

public interface ReportMapper {
	public List<ReportVO> getRpListWithPaging(Criteria cri);
	public int getRpTotalCount();
	public ReportVO RpRead(int rpno);
	public ReportVO getRpReply(int rpno);
	public int rpReplyRegister(ReportVO rpvo);
}
