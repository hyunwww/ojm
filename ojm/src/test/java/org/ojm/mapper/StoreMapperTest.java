package org.ojm.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
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
	
	@Test
	public void filterTest() {
		
		log.info("filter!");
		List<String> list = new ArrayList<String>();
		list.add("한식");
		list.add("일식");
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		map.put("cateList", list);
		log.info(map);
		log.info(mapper.searchStoreByCate(map));
		
		
		
	}
	
	
}
