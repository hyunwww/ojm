package org.ojm.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class StoreServiceTests {
	
	@Autowired
	private StoreService service;
	
	@Test
	public void likeTest() {
		int point = 2;
		log.info(service.allStores((point*3-2), (point*3)));
		
		
	}
}
