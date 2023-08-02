package org.ojm.service;

import org.ojm.domain.InfoVO;
import org.ojm.domain.UserVO;

public interface UserService {
	public UserVO login(String id, String pw);
	public int regUser(UserVO uvo);				// 사업자
	public int regUser(UserVO uvo,InfoVO ivo);	// 일반 회원
	
	public int modifyUser(UserVO uvo);
	
	public String findID(String name,String email);
	
	// 메일인증
	public int newMailKey(String email,String mail_key);
	public int updateMailKey(String email,String mail_key);
	public int updateMailAuth(String email,String mail_key);
}
