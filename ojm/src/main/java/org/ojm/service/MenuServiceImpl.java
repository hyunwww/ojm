package org.ojm.service;

import java.util.List;

import org.ojm.domain.MenuVO;
import org.ojm.mapper.MenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;


@Log4j
@Service
public class MenuServiceImpl implements MenuService{
	
	@Autowired
	private MenuMapper mMapper;
	
	@Override
	public int addMenu(MenuVO menu) {
		
		
		return mMapper.addMenu(menu);
	}
	@Override
	public int nextSno() {
		
		return mMapper.nextSno();
	}
	@Override
	public List<MenuVO> getMenu(int sno) {
		
		
		return mMapper.getMenu(sno);
	}
}
