package org.ojm.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler{
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("Access Denied Handler");
		System.out.println(request.getUserPrincipal());
		
		// myPage 분기처리
		if(request.isUserInRole("business")) {
			response.sendRedirect("/user/myPage/b/main");
			return;
		}else if(request.isUserInRole("user")) {
			response.sendRedirect("/user/myPage/main");
			return;
		}
		
		log.error("Redirect...");
		
		response.sendRedirect("/");
	}
}
