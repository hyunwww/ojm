package org.ojm.service;

import java.util.List;

import org.ojm.domain.Criteria;
import org.ojm.domain.ReportVO;
import org.ojm.mapper.ReportMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	private ReportMapper rpMapper;

	@Override
	public List<ReportVO> getRpList(Criteria cri) {
		return rpMapper.getRpListWithPaging(cri);
	}

	@Override
	public int getRpTotal() {
		return rpMapper.getRpTotalCount();
	}

	@Override
	public ReportVO rpGet(int rpno) {
		return rpMapper.RpRead(rpno);
	}

	@Override
	public ReportVO getRpReply(int rpno) {
		return rpMapper.getRpReply(rpno);
	}

	@Override
	public int rpReplyRegister(ReportVO rpvo) {
		System.out.println(rpvo);
		System.out.println(rpMapper.rpReplyRegister(rpvo));
		int result = rpMapper.rpReplyRegister(rpvo);
		return result;
	}
}
