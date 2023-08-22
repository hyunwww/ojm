package org.ojm.service;

import java.util.List;

import org.ojm.domain.Criteria;
import org.ojm.domain.JobVO;

public interface JobService {
	public List<JobVO> getJlist(Criteria cri);
	public int getJtotal();
	public void jRegister(JobVO jvo);
	public JobVO jGet(int jvo);
}
