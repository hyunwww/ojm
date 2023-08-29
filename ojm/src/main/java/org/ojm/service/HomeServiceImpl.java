package org.ojm.service;

import lombok.extern.log4j.Log4j;

import java.util.List;

import org.ojm.domain.StoreVO;
import org.ojm.mapper.HomeMapper;
import org.ojm.mapper.StoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Log4j
@Service
public class HomeServiceImpl implements HomeService{

	@Autowired
	private HomeMapper hm;
	@Autowired
	private StoreMapper sm;
	
	
	@Override
	public List<StoreVO> allStore() {
		log.warn(hm.allStore());
		return hm.allStore();
	}

}
