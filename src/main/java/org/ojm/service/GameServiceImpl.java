package org.ojm.service;

import java.util.List;

import org.ojm.domain.GameVO;
import org.ojm.mapper.GameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GameServiceImpl implements GameService{

	@Autowired
	private GameMapper mapper;
	
	@Override
	public List<GameVO> randomgame() {
		return mapper.randomgame();
	}

}
