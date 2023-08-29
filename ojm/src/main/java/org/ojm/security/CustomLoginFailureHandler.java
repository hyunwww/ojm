package org.ojm.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.*;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {
		
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
			
		log.warn("login fail");
		
		
		request.setAttribute("errorMessage", "아이디 및 비밀번호를 확인해주세요");
		request.getRequestDispatcher("/user/loginfail").forward(request, response);
	}
		
}
