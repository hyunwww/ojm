package org.ojm.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ojm.domain.StoreVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class StoreMapperTest {
	
	@Autowired
	StoreMapper mapper;
	
//	@Test
//	public void filterTest() {
//		
//		log.info("filter!");
//		List<String> list = new ArrayList<String>();
//		list.add("한식");
//		list.add("일식");
//		Map<String, List<String>> map = new HashMap<String, List<String>>();
//		map.put("cateList", list);
//		log.info(map);
//		log.info(mapper.searchStoreByCate(map));
//		
//		
//		
//	}
	
//	@Test
//	public void rankTest() {
//		
//		log.info(mapper.rank());
//	}
//	
	
	
	@Test
	public void zeroTest() {
		
		StoreVO store = new StoreVO();
		
		store.setKd("1");
		store.setWd("0");
		store.setSaddress("nope");
		store.setSname("abc");
		store.setDayOff("0");
		store.setSdeli(0);
		store.setScrn("1");
		store.setSpermmit(0);
		store.setUno(43);
		
		log.info(mapper.storeRegister(store));
		
	}
}
