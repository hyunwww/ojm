package org.ojm.service;

import org.ojm.domain.MenuVO;

public interface MenuService {
	public int addMenu(MenuVO menu);
	public int nextSno();
	
}
