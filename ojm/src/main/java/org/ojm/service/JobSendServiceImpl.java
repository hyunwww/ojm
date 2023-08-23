package org.ojm.service;

import org.ojm.domain.JobSendVO;
import org.ojm.mapper.JobSendMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class JobSendServiceImpl implements JobSendService{
	
	@Autowired
	private JobSendMapper jsMapper;
	
	@Override
	public void jsRegister(JobSendVO jsvo) {
		jsMapper.jsInsert(jsvo);
	}
	
}
