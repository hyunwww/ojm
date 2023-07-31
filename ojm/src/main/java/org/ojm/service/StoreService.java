package org.ojm.service;

import java.util.List;

import org.ojm.domain.StoreImgVO;
import org.ojm.domain.StoreVO;

public interface StoreService {
	
	public List<StoreVO> allStores();
	public List<StoreVO> searchStore(String input);
	public StoreVO storeInfo(int sno);
	public int storeRegister(StoreVO store);
	public List<StoreImgVO> getStoreImgs(int sno);
	public int storePermit(int sno);
	public int updateRate(int sno);
	
	
}
