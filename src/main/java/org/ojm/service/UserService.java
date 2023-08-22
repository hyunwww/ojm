package org.ojm.service;

import java.util.List;

import org.ojm.domain.BoardVO;
import org.ojm.domain.Criteria;
import org.ojm.domain.InfoVO;
import org.ojm.domain.QboardVO;
import org.ojm.domain.ReviewVO;
import org.ojm.domain.StoreVO;
import org.ojm.domain.UserVO;

public interface UserService {
	public UserVO login(String id, String pw);
	public int getUno(String userid);
	public int regUser(UserVO uvo);				// 사업자
	public int regUser(UserVO uvo,InfoVO ivo);	// 일반 회원
	
	public int modifyUser(UserVO uvo);
	
	public String findID(String name,String email);
	
	// 메일인증
	public int newMailKey(String email,String mail_key);
	public int updateMailKey(String email,String mail_key);
	public int updateMailAuth(String email,String mail_key);
	
	public int idCheck(String userid);
	public int pwChange(String userid,String userpw);
	
	
	
	
	// myPage 
	// user
	public List<BoardVO> getList(Criteria cri, int uno);
	public List<ReviewVO> getReviews(Criteria cri,int uno);
	public int getRvCnt(int uno);
	public List<QboardVO> getQlist(Criteria cri, int uno);
	
	
	// business
	public List<StoreVO> getStoreList(int uno);
}