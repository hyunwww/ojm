package org.ojm.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.ojm.domain.BookVO;
import org.ojm.domain.ReportVO;
import org.ojm.domain.StoreVO;

public interface StoreMapper {
	public int storeRegister(StoreVO store);
	public List<StoreVO> allStore(@Param("start") int start, @Param("end") int end);
	public List<StoreVO> searchStore(String input);
	public List<StoreVO> searchStoreByUno(int uno);
	public List<StoreVO> searchStoreByCate(Map<String, List<String>> map);
	public List<StoreVO> rank();
	public StoreVO storeInfo(int sno);
	public int updateRate(int sno);
	public int storePermit(int sno);
	public int reportSubmit(ReportVO rvo);
	public int deleteStore(int sno);
	public int updateStore(StoreVO store);
	public int storeLike(@Param("sno") int sno, @Param("amount") int amount);
	public int addbook(BookVO vo);	
	public int countStore();
	
}
