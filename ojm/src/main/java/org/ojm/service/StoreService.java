package org.ojm.service;

import java.util.List;
import java.util.Map;

import org.ojm.domain.BookVO;
import org.ojm.domain.ReportVO;
import org.ojm.domain.StoreImgVO;
import org.ojm.domain.StoreVO;
import org.ojm.domain.UserVO;

public interface StoreService {
	
	public List<StoreVO> allStores(int start, int end);
	public List<StoreVO> searchStore(String input);
	public List<StoreVO> searchStoreByUno(int uno);
	public List<StoreVO> searchStoreWithFilter(Map<String, List<String>> map);
	public List<StoreVO> rank();
	public StoreVO storeInfo(int sno);
	public int storeRegister(StoreVO store);
	public List<StoreImgVO> getStoreImgs(int sno);
	public int storePermit(int sno);
	public int updateRate(int sno);
	public int deleteStore(int sno);
	public int updateStore(StoreVO store);
	public int reportSubmit(ReportVO rvo);
	public int storeLike(int sno, int amount);
	
	
	//user관련 (임시 테스트용)
	public UserVO getUserById(String id);
	
	//storeimg 관련
	public int removeImg(int sino);
	
	// 푸쉬용
	//book 예약 관련 	
	public void addBook(BookVO vo);
}
