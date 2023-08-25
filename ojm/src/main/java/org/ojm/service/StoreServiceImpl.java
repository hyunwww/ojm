package org.ojm.service;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.ojm.domain.BookVO;
import org.ojm.domain.MenuVO;
import org.ojm.domain.ReportVO;
import org.ojm.domain.StoreImgVO;
import org.ojm.domain.StoreVO;
import org.ojm.domain.UserVO;
import org.ojm.mapper.MenuMapper;
import org.ojm.mapper.ReviewMapper;
import org.ojm.mapper.StoreImgMapper;
import org.ojm.mapper.StoreMapper;
import org.ojm.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class StoreServiceImpl implements StoreService{
	
	@Autowired
	private StoreMapper mapper;
	@Autowired
	private MenuMapper mMapper;
	@Autowired
	private StoreImgMapper iMapper;
	@Autowired
	private ReviewMapper rMapper;
	@Autowired
	private UserMapper uMapper;
	
	
	@Override
	public List<StoreVO> allStores(int start, int end) {
		if (end > mapper.countStore()) {
			return mapper.allStore(start, mapper.countStore());
		}else {
			return mapper.allStore(start, end);
		}
	}
	
	@Override
	@Transactional 
	public int storeRegister(StoreVO store) {
		log.info("addStore!");
		//매장 등록
		int result = mapper.storeRegister(store);
		if (result > 0) { // 메뉴 등록
			
			if (store.getMenuList() != null && !store.getMenuList().isEmpty()) {
				for (MenuVO menu : store.getMenuList()) {
					menu.setSno(mMapper.nextSno());
					mMapper.addMenu(menu);
				}
			}
			//이미지 db에 저장
			if (store.getImgList() != null && !store.getImgList().isEmpty()) {
				for (StoreImgVO img : store.getImgList()) {
					img.setSno(mMapper.nextSno());
					iMapper.addImg(img);
				}
			}
			
			
		}
		
		
		return result;
	}
	@Override
	public StoreVO storeInfo(int sno) {
		
		StoreVO info = mapper.storeInfo(sno);
		
		String result = "";
		
		// 데이터 >> 요일
		if (info.getDayOff() != null && !info.getDayOff().equals("")) {
			for (String day : info.getDayOff().split("")) {
				switch (day) {
				case "1":
					result += "월요일,";
					break;
				case "2":
					result += "화요일,";
					break;
				case "3":
					result += "수요일,";
					break;
				case "4":
					result += "목요일,";
					break;
				case "5":
					result += "금요일,";
					break;
				case "6":
					result += "토요일,";
					break;
				case "0":
					result += "일요일,";
					break;
				default:
					break;
				}
			}
			info.setDayOff(result);
		}else {
			info.setDayOff("없음");
		}
		
		
		try { // list의 null은 무시
			info.setMenuList(mMapper.getMenu(sno));
			info.setImgList(iMapper.getImg(sno));
			info.setRevList(rMapper.storeReviewList(sno));
		} catch (NullPointerException e) {
		}
		return info;
	}
	@Override
	public List<StoreImgVO> getStoreImgs(int sno) {
		
		return iMapper.getImg(sno);
	}
	

	@Override
	public int storePermit(int sno) {
		
		return mapper.storePermit(sno);
	}


	@Override
	public List<StoreVO> searchStore(String input) {
		
		return mapper.searchStore(input);
	}
	
	@Override
	public int updateRate(int sno) {
		int result = mapper.updateRate(sno);
		
		
		return result;
	}
	@Override
	public List<StoreVO> searchStoreByUno(int uno) {
		return mapper.searchStoreByUno(uno);
	}
	@Override
	public int deleteStore(int sno) {
		
		return mapper.deleteStore(sno);
	}

	@Override
	public int removeImg(int sino) {
		return iMapper.removeImg(sino);
	}
	
	@Override
	@Transactional
	public int updateStore(StoreVO store) {
		
		int result = 0;
		//storeinfo
		if (mapper.updateStore(store) > 0) {
			
			//메뉴
			mMapper.deleteMenu(store.getSno());	//삭제
			
			if (store.getMenuList() != null && !store.getMenuList().isEmpty()) {
				for (MenuVO menu : store.getMenuList()) {
					menu.setSno(store.getSno());
					mMapper.addMenu(menu);
				}
			}
			//이미지
			if (store.getImgList() != null && !store.getImgList().isEmpty()) {
				for (StoreImgVO img : store.getImgList()) {
					img.setSno(store.getSno());
					iMapper.addImg(img);
				}
			}
			result = 1;
		}else {
		}
		return result;
	}
	
	//필터링 적용
	@Override
	public List<StoreVO> searchStoreWithFilter(Map<String, List<String>> map) {
		
		List<StoreVO> result = mapper.searchStoreByCate(map);
		
		
		
		return result;
	}
	
	//좋아요 적용
	@Override
	public int storeLike(int sno, int amount) {
		return mapper.storeLike(sno, amount);
	}
	
	// top10
	@Override
	public List<StoreVO> rank() {
		return mapper.rank();
	}
	
	
	//테스트용 유저코드
	@Override
	public UserVO getUserById(String id) {
		return uMapper.getUserByID(id);
	}
	@Override
	public int reportSubmit(ReportVO rvo) {
		return mapper.reportSubmit(rvo);
	}
	
	// 푸쉬용
	// 스토어 예약 신청 
	@Override
	public void addBook(BookVO vo) {
		log.info("register serv...");
		mapper.addbook(vo);
	}
	
}
