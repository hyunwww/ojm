package org.ojm.mapper;

import java.util.List;

import org.ojm.domain.Criteria;
import org.ojm.domain.JobVO;
import org.ojm.domain.QboardVO;

public interface JobMapper {
	public List<JobVO> getJlistWithPaging(Criteria cri);
	public int getJtotalCount();
	public int jInsert(JobVO jvo);
	public JobVO jRead(int jno);
	public int updateJview(int jno);
	public int jUpdate(JobVO jvo);
	public int jDelete(int jno);
}
