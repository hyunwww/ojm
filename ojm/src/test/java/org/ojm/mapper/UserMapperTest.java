package org.ojm.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class UserMapperTest {

	
	@Autowired
	UserMapper mapper;
	
	/*
	 * @Test public void getUserTest() {
	 * 
	 * 
	 * log.info(mapper.getUserByID("jyb00003")); }
	 */
	/*
	 * @Test public void addUserLikeTest() { log.info(mapper.addLikeStore("61",
	 * "144")); }
	 */
	
	/*
	 * @Test public void delUserLikeTest() { mapper.deleteLikeStore("61", "144");
	 * 
	 * }
	 */
	 
}
