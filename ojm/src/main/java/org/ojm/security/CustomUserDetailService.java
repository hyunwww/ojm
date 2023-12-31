package org.ojm.security;

import org.ojm.domain.UserVO;
import org.ojm.mapper.UserMapper;
import org.ojm.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService{
	
	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("load user by userName : " + username); // username == id

		UserVO vo = mapper.getUserByID(username);
		CustomUser uvo = null;
		log.warn("user mapper : " + vo);
		if (vo != null) {
			uvo = new CustomUser(vo);
			log.warn(uvo);
		}
		return uvo;

	}
}
