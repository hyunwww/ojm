package org.ojm.service;

import java.util.List;

import org.ojm.domain.StoreImgVO;
import org.ojm.domain.StoreVO;

public interface StoreService {
	
	public List<StoreVO> allStores();
	public List<StoreVO> searchStore(String input);
	public List<StoreVO> searchStoreByUno(int uno);
	public StoreVO storeInfo(int sno);
	public int storeRegister(StoreVO store);
	public List<StoreImgVO> getStoreImgs(int sno);
	public int storePermit(int sno);
	public int updateRate(int sno);
	public int deleteStore(int sno);
	public int updateStore(StoreVO store);
	
	
	
	
	//storeimg 관련
	public int removeImg(int sino);
	
}
