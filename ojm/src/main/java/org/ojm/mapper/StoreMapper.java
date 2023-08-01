package org.ojm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ojm.domain.StoreVO;

public interface StoreMapper {
	public int storeRegister(StoreVO store);
	public List<StoreVO> allStore();
	public List<StoreVO> searchStore(String input);
	public List<StoreVO> searchStoreByUno(int uno);
	public StoreVO storeInfo(int sno);
	public int updateRate(int sno);
	public int storePermit(int sno);
	public int deleteStore(int sno);
	public int updateStore(StoreVO store);
	public int storeLike(@Param("sno") int sno, @Param("amount") int amount);
	
}