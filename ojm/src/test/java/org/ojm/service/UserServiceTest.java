package org.ojm.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ojm.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class UserServiceTest {
	
	@Setter(onMethod_= @Autowired)
	UserService service;
	
	@Test
	public void testGet() {
		UserVO vo = service.login("tmpID", "1");
		log.warn(vo);
		log.info(vo.getInfo().getNickname());
		
	}
}
