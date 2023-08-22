package org.ojm.service;

import java.util.List;

import org.ojm.domain.Criteria;
import org.ojm.domain.JobVO;
import org.ojm.mapper.JobMapper;
import org.ojm.mapper.StoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class JobServiceImpl implements JobService{
	
	@Autowired
	private JobMapper jmapper;

	@Override
	public List<JobVO> getJlist(Criteria cri) {
		return jmapper.getJlistWithPaging(cri);
	}

	@Override
	public int getJtotal() {
		return jmapper.getJtotalCount();
	}

	@Override
	public void jRegister(JobVO jvo) {
		jmapper.jInsert(jvo);
	}

	@Override
	public JobVO jGet(int jvo) {
		jmapper.updateJview(jvo);
		return jmapper.jRead(jvo);
	}

	@Override
	public boolean jModify(JobVO jvo) {
		return jmapper.jUpdate(jvo) == 1;
	}

	@Override
	public boolean jRemove(int jno) {
		return jmapper.jDelete(jno) == 1;
	}
	
}
