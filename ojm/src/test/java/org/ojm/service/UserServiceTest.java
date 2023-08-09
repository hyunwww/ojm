package org.ojm.service;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ojm.domain.AuthVO;
import org.ojm.domain.UserVO;
import org.ojm.mapper.UserMapper;
import org.ojm.security.CustomUserDetailService;
import org.ojm.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
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
	
	@Autowired
	UserMapper mapper;
//	@Test
//	public void testGet() {
//		UserVO vo = service.login("tmpID", "1");
//		log.warn(vo);
//		log.info(vo.getInfo().getNickname());
//		
//	}
	
	
	
	@Test
	public void constTest() {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser user = (CustomUser)auth.getPrincipal();
		
		
	}
}
