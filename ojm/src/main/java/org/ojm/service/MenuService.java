package org.ojm.service;

import java.util.List;

import org.ojm.domain.MenuVO;

public interface MenuService {
	public int addMenu(MenuVO menu);
	public List<MenuVO> getMenu(int sno);
	public int nextSno();
	
}
