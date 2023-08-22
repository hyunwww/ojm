package org.ojm.mapper;

import java.util.List;

import org.ojm.domain.MenuVO;

public interface MenuMapper {
	public int addMenu(MenuVO menu);
	public List<MenuVO> getMenu(int sno);
	public int nextSno();
	public int deleteMenu(int sno);
}
